{ -*- mode: Delphi -*- }
unit UMakeTT;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, UTTModel, DMaster, USolver, UModel, UTTGBasics,
    UDownHill;

type

  { TMakeTimeTableThread }

  TMakeTimeTableThread = class(TThread)
  private
    FTimeTableModel: TTimeTableModel;
    FValidCodes: TDynamicIntegerArray;
    procedure Parallel(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
    function ProcessTimeTable(ACodHorario: Integer): Boolean;
  public
  procedure Execute; override;
  constructor Create(const AValidCodes: TDynamicIntegerArray; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

  { TImproveTimeTableThread }

  TImproveTimeTableThread = class(TThread)
  private
    FTimeTableModel: TTimeTableModel;
    FCodHorarioFuente, FCodHorario: Integer;
  public
  procedure Execute; override;
  constructor Create(ACodHorarioFuente, ACodHorario: Integer; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

implementation

uses UEvolElitist, FProgress;

type

  { TSyncSaver }

  TSyncSaver = class
  private
    FSolver: TSolver;
    FCodHorario: Integer;
    FExtraInfo: string;
    FMomentoInicial: TDateTime;
    FMomentoFinal: TDateTime;
  public
    constructor Create(ASolver: TSolver; ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime);
    procedure Execute;
  end;

{ TSyncSaver }

constructor TSyncSaver.Create(ASolver: TSolver; ACodHorario: Integer;
  const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime);
begin
  inherited Create;
  FSolver := ASolver;
  FCodHorario := ACodHorario;
  FExtraInfo := AExtraInfo;
  FMomentoInicial := AMomentoInicial;
  FMomentoFinal := AMomentoFinal;
end;

procedure TSyncSaver.Execute;
begin
  FSolver.SaveSolutionToDatabase(FCodHorario, FExtraInfo, FMomentoInicial,
    FMomentoFinal);
end;

const
  FBoolToStr: array [Boolean] of string = ('No', 'Si');

procedure LoadBookmarks(s: string; Individual: TIndividual;
    ParaleloCant: Integer; out Bookmarks: TBookmarkArray);
var
  Pos, d, i: Integer;
begin
  Pos := 1;
  SetLength(Bookmarks, Length(s));
  i := 0;
  while Pos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, Pos, ','));
    case d of
    1: Bookmarks[i] := TTTBookmark.Create(Individual, RandomIndexes(ParaleloCant));
    2: Bookmarks[i] := TTTBookmark2.Create(Individual, RandomIndexes(ParaleloCant));
    end;
    Inc(i);
  end;
  SetLength(Bookmarks, i);
end;

procedure ExecuteDownHill(DownHill: TDownHill; const Bookmarks: string;
    RefreshInterval: Integer);
var
  i: Integer;
  Individual: TIndividual;
  BookmarkArray: TBookmarkArray;
begin
  with TTimeTableModel(DownHill.Model) do
  begin
    Individual := DownHill.Model.NewIndividual;
    try
      Individual.Assign(DownHill.BestIndividual);
      LoadBookmarks(Bookmarks, Individual, ParaleloCant, BookmarkArray);
      try
        TDownHill.MultiDownHill(DownHill, Individual, BookmarkArray,
                                False, RefreshInterval);
      finally
        for i := 0 to High(BookmarkArray) do
          BookmarkArray[i].Free;
      end;
    finally
      Individual.Free;
    end;
  end;
end;

function TMakeTimeTableThread.ProcessTimeTable(ACodHorario: Integer): Boolean;
var
  VEvolElitist: TEvolElitist;
  DownHill: TDownHill;
  FMomentoInicial: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
  ExtraInfo: string;
begin
  Result := False;
  FMomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.Create(FTimeTableModel, SharedDirectory,
      PollinationProb, PopulationSize, MaxIteration, CrossProb, MutationProb,
      RepairProb, HorarioIni);
    try
      TThread.Synchronize(CurrentThread, VEvolElitist.Initialize);
      ProgressFormDrv := TProgressFormDrv.Create;
      try
        {VEvolElitist.OnRecordBest := MainForm.OnRegistrarMejor;}
        ProgressFormDrv.Caption := Format('Elaboracion en progreso [%d]', [ACodHorario]);
        VEvolElitist.OnProgress := ProgressFormDrv.OnProgress;
        VEvolElitist.Execute(RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Result := True;
          Exit;
        end;
        if ApplyDoubleDownHill then
        begin
          DownHill := TDownHill.Create(FTimeTableModel,
            SharedDirectory, PollinationProb);
          try
            DownHill.BestIndividual.Assign(VEvolElitist.BestIndividual);
            ProgressFormDrv.Caption := Format('Mejorando Horario [%d]', [ACodHorario]);
            DownHill.OnProgress := ProgressFormDrv.OnProgress;
            ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
            if ProgressFormDrv.CancelClick then
            begin
              Result := True;
              Exit;
            end;
            VEvolElitist.BestIndividual.Assign(DownHill.BestIndividual);
          finally
            DownHill.Free;
          end;
        end
        else
        begin
          VEvolElitist.DownHill;
        end;
      finally
        ProgressFormDrv.Free;
      end;
      VEvolElitist.BestIndividual.Update;
      ExtraInfo := Format('Aplicar Descenso: %23s',
        [FBoolToStr[ApplyDoubleDownHill]]);
      with TSyncSaver.Create(VEvolElitist, ACodHorario, ExtraInfo,
        FMomentoInicial, Now) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
    finally
      VEvolElitist.Free;
    end;
  end;
end;

{ TMakeTimeTableThread }

procedure TMakeTimeTableThread.Parallel(Index: PtrInt; Data: Pointer;
  Item: TMultiThreadProcItem);
begin
  MasterDataModule.ConfigStorage.InitRandom;
  if ProcessTimeTable(FValidCodes[Index]) then
    Terminate;
end;

procedure TMakeTimeTableThread.Execute;
begin
  ProcThreadPool.DoParallel(Parallel, 0, High(FValidCodes), nil);
end;

constructor TMakeTimeTableThread.Create(const AValidCodes: TDynamicIntegerArray;
  CreateSuspended: Boolean);
var
  i: Integer;
begin
  FreeOnTerminate := True;
  with MasterDataModule.ConfigStorage do
    FTimeTableModel := TTimeTableModel.Create(CruceProfesor,
      CruceMateria, CruceAulaTipo, ProfesorFraccionamiento, HoraHuecaDesubicada,
      SesionCortada, MateriaNoDispersa);
  SetLength(FValidCodes, Length(AValidCodes));
  // ProcThreadPool.MaxThreadCount := Length(AValidCodes);
  for i := 0 to High(AValidCodes) do
    FValidCodes[i] := AValidCodes[i];
  inherited Create(CreateSuspended);
end;

destructor TMakeTimeTableThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

type

  { TSyncLoader }

  TSyncLoader = class
  private
    FIndividual: TIndividual;
    FIndex: Integer;
  public
    constructor Create(AIndividual: TIndividual; AIndex: Integer);
    procedure Execute;
  end;

{ TSyncLoader }

constructor TSyncLoader.Create(AIndividual: TIndividual; AIndex: Integer);
begin
  inherited Create;
  FIndividual := AIndividual;
  FIndex := AIndex;
end;

procedure TSyncLoader.Execute;
begin
  FIndividual.LoadFromDataModule(FIndex);
end;

{ TImproveTimeTableThread }

procedure TImproveTimeTableThread.Execute;
var
  ProgressFormDrv: TProgressFormDrv;
  MomentoInicial: TDateTime;
  DownHill: TDownHill;
  ExtraInfo: string;
begin
  MomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    DownHill := TDownHill.Create(FTimeTableModel,
      SharedDirectory, PollinationProb);
    try
      {if s = '' then
        TimeTable.MakeRandom
      else}
      with TSyncLoader.Create(TTimeTable(DownHill.BestIndividual),
        FCodHorarioFuente) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
      TDownHill.DownHill(DownHill.BestIndividual);
      ProgressFormDrv := TProgressFormDrv.Create;
      try
        DownHill.OnProgress := ProgressFormDrv.OnProgress;
        ProgressFormDrv.Caption := Format('Mejorando Horario [%d] en [%d]',
          [FCodHorarioFuente, FCodHorario]);
        ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Terminate;
          Exit;
        end
        else
          ExtraInfo := Format('Horario base: %d', [FCodHorarioFuente]);
          with TSyncSaver.Create(DownHill, FCodHorario, ExtraInfo,
            MomentoInicial, Now) do
          try
            TThread.Synchronize(CurrentThread, Execute);
          finally
            Free;
          end;
      finally
        ProgressFormDrv.Free;
      end;
    finally
      DownHill.Free;
    end;
  end;
end;

constructor TImproveTimeTableThread.Create(ACodHorarioFuente, ACodHorario: Integer;
  CreateSuspended: Boolean);
begin
  FreeOnTerminate := True;
  FCodHorarioFuente := ACodHorarioFuente;
  FCodHorario := ACodHorario;
  with MasterDataModule.ConfigStorage do
    FTimeTableModel := TTimeTableModel.Create(CruceProfesor,
      CruceMateria, CruceAulaTipo, ProfesorFraccionamiento, HoraHuecaDesubicada,
      SesionCortada, MateriaNoDispersa);
  inherited Create(CreateSuspended);
end;

destructor TImproveTimeTableThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

end.

