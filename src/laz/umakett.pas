unit UMakeTT;

{$i ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, KerModel, DMaster;

type

  { TMakeTTThread }

  TMakeTTThread = class(TThread)
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

implementation

uses KerEvolE, FProgres;

function ProcesarCodHorario(TimeTableModel: TTimeTableModel; ACodHorario: Integer): Boolean;
var
  i: Integer;
  VEvolElitist: TEvolElitist;
  DoubleDownHill: TDoubleDownHill;
  FMomentoInicial: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
begin
  Result := False;
  FMomentoInicial := Now;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.CreateFromModel(TimeTableModel,
      PopulationSize);
    try
      ProgressFormDrv := TProgressFormDrv.Create(MaxIteration, ACodHorario);
      try
        VEvolElitist.OnProgress := ProgressFormDrv.OnProgress;
        VEvolElitist.MaxIteration := MaxIteration;
        VEvolElitist.CrossProb := CrossProb;
        VEvolElitist.Mutation1Prob := Mutation1Prob;
        VEvolElitist.Mutation1Order := Mutation1Order;
        VEvolElitist.Mutation2Prob := Mutation2Prob;
        VEvolElitist.RepairProb := RepairProb;
        VEvolElitist.SharedDirectory := SharedDirectory;
        VEvolElitist.PollinationFreq := PollinationFreq;
        VEvolElitist.FixIndividuals(HorarioIni);
        {VEvolElitist.OnRecordBest := MainForm.OnRegistrarMejor;}
        VEvolElitist.Execute(MasterDataModule.ConfigStorage.RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Result := True;
          Exit;
        end;
      finally
        ProgressFormDrv.Free;
      end;
      if ApplyDoubleDownHill then
      begin
        DoubleDownHill := TDoubleDownHill.Create(VEvolElitist.BestIndividual);
        ProgressFormDrv := TProgressFormDrv.Create(
          TimeTableModel.SesionCantidadDoble, ACodHorario);
        DoubleDownHill.OnProgress := ProgressFormDrv.OnProgress;
        try
          DoubleDownHill.Execute(MasterDataModule.ConfigStorage.RefreshInterval);
          if ProgressFormDrv.CancelClick then
          begin
            Result := True;
            Exit;
          end;
        finally
          ProgressFormDrv.Free;
        end;
      end
      else
      begin
        VEvolElitist.DownHillForced;
      end;
      VEvolElitist.BestIndividual.UpdateValue;
      ProcThreadPool.EnterPoolCriticalSection;
      try
        VEvolElitist.SaveBestToDatabase(ACodHorario,
          MasterDataModule.ConfigStorage.ApplyDoubleDownHill,
          FMomentoInicial, Now);
      finally
        ProcThreadPool.LeavePoolCriticalSection;
      end;
    finally
      VEvolElitist.Free;
    end;
  end;
end;

{ TMakeTTThread }

procedure TMakeTTThread.Parallel(Index: PtrInt; Data: Pointer;
  Item: TMultiThreadProcItem);
begin
  MasterDataModule.ConfigStorage.InitRandom;
  if ProcesarCodHorario(FTimeTableModel, FValidCodes[Index]) then
    Terminate;
end;

procedure TMakeTTThread.Execute;
var
  i: Integer;
begin
  ProcThreadPool.DoParallel(Parallel, 0, High(FValidCodes), nil);
end;

constructor TMakeTTThread.Create(const AValidCodes: TDynamicIntegerArray;
  CreateSuspended: Boolean);
var
  i: Integer;
begin
  FreeOnTerminate := True;
  with MasterDataModule.ConfigStorage do
    FTimeTableModel := TTimeTableModel.CreateFromDataModule(CruceProfesor,
      ProfesorFraccionamiento, CruceAulaTipo, HoraHueca, SesionCortada,
      MateriaNoDispersa);
  SetLength(FValidCodes, Length(AValidCodes));
  for i := 0 to High(AValidCodes) do
    FValidCodes[i] := AValidCodes[i];
  inherited Create(CreateSuspended);
end;

destructor TMakeTTThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

end.

