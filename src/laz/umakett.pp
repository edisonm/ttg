unit UMakeTT;

{$i ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, KerModel, DMaster, USolver, UIndivid, UTTGBasics,
    UDoubleDownHill;

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
  constructor Create(const AValidCodes: TDynamicIntegerArray;
    CreateSuspended: Boolean);
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

uses KerEvolE, FProgres;

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

function TMakeTimeTableThread.ProcessTimeTable(ACodHorario: Integer): Boolean;
var
  VEvolElitist: TEvolElitist;
  DoubleDownHill: TDoubleDownHill;
  FMomentoInicial: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
  ExtraInfo: string;
begin
  Result := False;
  FMomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.Create(FTimeTableModel, SharedDirectory,
      PollinationProb, PopulationSize, MaxIteration, CrossProb, Mutation1Prob,
      Mutation1Order, Mutation2Prob, RepairProb, HorarioIni);
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
          DoubleDownHill := TDoubleDownHill.Create(FTimeTableModel,
            SharedDirectory, PollinationProb);
          try
            DoubleDownHill.BestIndividual.Assign(VEvolElitist.BestIndividual);
            ProgressFormDrv.Caption := Format('Mejorando Horario [%d]', [ACodHorario]);
            DoubleDownHill.OnProgress := ProgressFormDrv.OnProgress;
            DoubleDownHill.Execute(RefreshInterval);
            if ProgressFormDrv.CancelClick then
            begin
              Result := True;
              Exit;
            end;
            VEvolElitist.BestIndividual.Assign(DoubleDownHill.BestIndividual);
          finally
            DoubleDownHill.Free;
          end;
        end
        else
        begin
          VEvolElitist.DownHillForced;
        end;
      finally
        ProgressFormDrv.Free;
      end;
      VEvolElitist.BestIndividual.Update;
      ExtraInfo := Format('Descenso rapido doble: %14s',
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
    FTimeTableModel := TTimeTableModel.CreateFromDataModule(CruceProfesor,
      CruceMateria, CruceAulaTipo, ProfesorFraccionamiento, HoraHueca,
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
  DoubleDownHill: TDoubleDownHill;
  ExtraInfo: string;
begin
  MomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    DoubleDownHill := TDoubleDownHill.Create(FTimeTableModel,
      SharedDirectory, PollinationProb);
    try
      {if s = '' then
        TimeTable.MakeRandom
      else}
      with TSyncLoader.Create(TTimeTable(DoubleDownHill.BestIndividual),
        FCodHorarioFuente) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
      DoubleDownHill.BestIndividual.DownHillForced;
      ProgressFormDrv := TProgressFormDrv.Create;
      try
        DoubleDownHill.OnProgress := ProgressFormDrv.OnProgress;
        ProgressFormDrv.Caption := Format('Mejorando Horario [%d] en [%d]',
          [FCodHorarioFuente, FCodHorario]);
        DoubleDownHill.Execute(RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Terminate;
          Exit;
        end
        else
          ExtraInfo := Format('Horario base: %d', [FCodHorarioFuente]);
          with TSyncSaver.Create(DoubleDownHill, FCodHorario, ExtraInfo,
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
      DoubleDownHill.Free;
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
    FTimeTableModel := TTimeTableModel.CreateFromDataModule(CruceProfesor,
      CruceMateria, CruceAulaTipo, ProfesorFraccionamiento, HoraHueca,
      SesionCortada, MateriaNoDispersa);
  inherited Create(CreateSuspended);
end;

destructor TImproveTimeTableThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

end.

