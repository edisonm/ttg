unit UMakeTT;

{$i ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, KerModel, DMaster;

type

  { TMakeTimeTableThread }

  TMakeTimeTableThread = class(TThread)
  private
    FTimeTableModel: TTimeTableModel;
    FValidCodes: TDynamicIntegerArray;
    procedure Parallel(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
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

function ProcesarCodHorario(TimeTableModel: TTimeTableModel; ACodHorario: Integer): Boolean;
var
  VEvolElitist: TEvolElitist;
  DoubleDownHill: TDoubleDownHill;
  FMomentoInicial: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
begin
  Result := False;
  FMomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.CreateFromModel(TimeTableModel, PopulationSize);
    try
      VEvolElitist.MaxIteration := MaxIteration;
      VEvolElitist.CrossProb := CrossProb;
      VEvolElitist.Mutation1Prob := Mutation1Prob;
      VEvolElitist.Mutation1Order := Mutation1Order;
      VEvolElitist.Mutation2Prob := Mutation2Prob;
      VEvolElitist.RepairProb := RepairProb;
      VEvolElitist.SharedDirectory := SharedDirectory;
      VEvolElitist.PollinationFreq := PollinationFreq;
      VEvolElitist.FixIndividuals(HorarioIni);
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
          DoubleDownHill := TDoubleDownHill.Create(VEvolElitist.BestIndividual);
          try
            ProgressFormDrv.Caption := Format('Mejorando Horario [%d]', [ACodHorario]);
            DoubleDownHill.OnProgress := ProgressFormDrv.OnProgress;
            DoubleDownHill.Execute(RefreshInterval);
            if ProgressFormDrv.CancelClick then
            begin
              Result := True;
              Exit;
            end;
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
      ProcThreadPool.EnterPoolCriticalSection;
      try
        VEvolElitist.SaveBestToDatabase(ACodHorario, ApplyDoubleDownHill,
          FMomentoInicial, Now);
      finally
        ProcThreadPool.LeavePoolCriticalSection;
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
  if ProcesarCodHorario(FTimeTableModel, FValidCodes[Index]) then
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

function ImproveTimeTable(ATimeTableModel: TTimeTableModel;
  ACodHorarioFuente, ACodHorario: Integer): Boolean;
var
  ProgressFormDrv: TProgressFormDrv;
  TimeTable: TTimeTable;
  MomentoInicial: TDateTime;
  DoubleDownHill: TDoubleDownHill;
begin
  MomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    TimeTable := TTimeTable.Create(ATimeTableModel);
    try
      TimeTable.LoadFromDataModule(ACodHorarioFuente);
      TimeTable.DownHillForced;
      DoubleDownHill := TDoubleDownHill.Create(TimeTable);
      try
      {if s = '' then
        TimeTable.MakeRandom
      else}
        ProgressFormDrv := TProgressFormDrv.Create;
        DoubleDownHill.OnProgress := ProgressFormDrv.OnProgress;
        try
          ProgressFormDrv.Caption :=
            Format('Mejorando Horario [%d] en [%d]',
              [ACodHorarioFuente, ACodHorario]);
          DoubleDownHill.Execute(RefreshInterval);
          if ProgressFormDrv.CancelClick then
          begin
            Result := True;
            Exit;
          end
          else
            DoubleDownHill.SaveSolutionToDatabase(ACodHorarioFuente,
              ACodHorario, MomentoInicial, Now);
        finally
          ProgressFormDrv.Free;
        end;
      finally
        DoubleDownHill.Free;
      end;
    finally
      TimeTable.Free;
    end;
  end;
end;

{ TImproveTimeTableThread }

procedure TImproveTimeTableThread.Execute;
begin
  if ImproveTimeTable(FTimeTableModel, FCodHorarioFuente, FCodHorario) then
    Terminate;
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

