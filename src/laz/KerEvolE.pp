unit KerEvolE;
{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}cthreads, cmem, {$ENDIF}MTProcs, Classes, SysUtils, Dialogs,
  KerModel, UIndivid;

type

  {
    Clase TEvolElitist
    Descripcion:
    Implementa el algoritmo evolutivo, utilizando el modelo elitista.
    Miembros privados:
    Los parametros de configuracion del algoritmo evolutivo, y las funciones
    de uso interno.
    Miembros protegidos:
    No los hay.
    Miembros publicos:
    propiedades que devuelven el valor de cada componente de la evaluacion
    de la funcion objetivo en la mejor solucion encontrada,
    el valor de la funcion objetivo, el constructor, funciones que
    permiten guardar el horario encontrado en una base de datos, metodos que
    consisten en los operadores geneticos aplicados sobre la poblacion, como
    son cruce, mutacion, etc., TimeTableModel al que se aplica el algoritmo
    evolutivo, metodo que permite ejecutar el algoritmo evolutivo, Eventos que
    se disparan cada cierto numero de generaciones y cuando mejora la solucion.
    }

  TSolver = class;

  TProgressEvent = procedure(Progress: Integer; Self: TSolver;
    var Stop: Boolean) of object;

  { TEvolElitist }

  TSolver = class
  private
    FOnProgress: TProgressEvent;
  protected
    function GetBestIndividual: TTimeTable; virtual; abstract;
    procedure DoProgress(Position, RefreshInterval: Integer; Solver: TSolver;
      var Stop: Boolean);
  public
    procedure Execute(RefreshInterval: Integer); virtual; abstract;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property BestIndividual: TTimeTable read GetBestIndividual;
  end;

  { TDoubleDownHill }

  TDoubleDownHill = class(TSolver)
  private
    FBestIndividual: TTimeTable;
    function DoubleDownHill(Step: Integer): Boolean;
  protected
    function GetBestIndividual: TTimeTable; override;
  public
    procedure Execute(RefreshInterval: Integer); override;
    constructor Create(TimeTable: TTimeTable);
  end;

  TEvolElitist = class(TSolver)
  private
    FModel: TTimeTableModel;
    FSharedDirectory: string;
    FSeed1, FSeed2, FSeed3, FSeed4, FPopulationSize, FMaxIteration, FNumImports,
      FNumExports, FClashes, FPollinationFreq, FMutation1Order: Longint;
    FCrossProb, FMutation1Prob, FMutation2Prob, FRepairProb: Double;
    FPopulation, FNewPopulation: TTimeTableArray;
    FAptitudeArray, FNewAptitudeArray: TDynamicDoubleArray;
    FFixedIndividuals: TDynamicLongintArray;
    FOnRecordBest: TNotifyEvent;
    function GetFileName: string;
    function GetSyncFileName: string;
    procedure DoParallelGetValue(Index: PtrInt; Data: Pointer;
      Item: TMultiThreadProcItem);
    procedure Initialize;
    procedure Evaluate;
    procedure MakeRandom;
    procedure SelectTheBest;
    procedure Elitist;
    procedure Select;
    procedure Cross;
    procedure Mutate;
    procedure Pollinate;
    procedure InternalCrossIndividuals(Individual1, Individual2: Integer);
    function GetAverageValue: Double;
    procedure CopyIndividual(Target, Source: Integer);
  protected
    function GetBestIndividual: TTimeTable; override;
  public
    procedure ReportParameters(AInforme: TStrings);
    constructor CreateFromModel(AModel: TTimeTableModel; APopulationSize: Longint);
    procedure FixIndividuals(const Individuals: string);
    procedure Configure(APopulationSize: Integer);
    destructor Destroy; override;
    procedure SaveBestToDatabase(CodHorario: Integer; MomentoInicial,
      MomentoFinal: TDateTime; Report: TStrings);
    procedure SaveBestToStream(AStream: TStream);
    procedure Execute(RefreshInterval: Integer); override;
    procedure ForcedDownHill;
    function DownHill: Boolean;
    procedure Repair;
    property OnRecordBest: TNotifyEvent read FOnRecordBest write FOnRecordBest;
    property MaxIteration: Longint read FMaxIteration write FMaxIteration;
    property CrossProb: Double read FCrossProb write FCrossProb;
    property Mutation1Prob: Double read FMutation1Prob write FMutation1Prob;
    property Mutation1Order: Integer read FMutation1Order write FMutation1Order;
    property Mutation2Prob: Double read FMutation2Prob write FMutation2Prob;
    property RepairProb: Double read FRepairProb write FRepairProb;
    property NumImports: Integer read FNumImports;
    property NumExports: Integer read FNumExports;
    property NumColision: Integer read FClashes;
    property AverageValue: Double read GetAverageValue;
    property BestIndividual: TTimeTable read GetBestIndividual;
    property Model: TTimeTableModel read FModel;
    property SharedDirectory: string read FSharedDirectory write FSharedDirectory;
    property FileName: string read GetFileName;
    property SyncFileName: string read GetSyncFileName;
    property PollinationFreq: Integer read FPollinationFreq write FPollinationFreq;
  end;

implementation

uses
  Rand, HorColCm;

procedure TEvolElitist.Configure(APopulationSize: Longint);
var
  Individual: Integer;
begin
  FPopulationSize := APopulationSize;
  SetLength(FPopulation, FPopulationSize + 1 + FModel.ElitistCount);
  SetLength(FNewPopulation, Length(FPopulation));
  SetLength(FAptitudeArray, Length(FPopulation));
  SetLength(FNewAptitudeArray, Length(FPopulation));
  for Individual := 0 to High(FPopulation) do
  begin
    if not Assigned(FPopulation[Individual]) then
      FPopulation[Individual] := TTimeTable.Create(FModel);
    if not Assigned(FNewPopulation[Individual]) then
      FNewPopulation[Individual] := TTimeTable.Create(FModel);
  end;
end;

constructor TEvolElitist.CreateFromModel(AModel: TTimeTableModel;
  APopulationSize: Longint);
begin
  inherited Create;
  FModel := AModel;
  Configure(APopulationSize);
end;

destructor TEvolElitist.Destroy;
var
  Individual: Integer;
begin
  for Individual := 0 to High(FPopulation) do
  begin
    FPopulation[Individual].Free;
    FNewPopulation[Individual].Free;
  end;
  FModel := nil;
  inherited Destroy;
end;

procedure TEvolElitist.Initialize;
var
  Individual: Integer;
begin
  for Individual := 0 to High(FFixedIndividuals) do
  begin
    FPopulation[Individual].LoadFromDataModule(FFixedIndividuals[Individual]);
  end;
end;

procedure TEvolElitist.MakeRandom;
var
  Individual: Integer;
begin
  for Individual := Length(FFixedIndividuals) to High(FPopulation) do
  begin
    FPopulation[Individual].MakeRandom;
  end;
end;

procedure TEvolElitist.Repair;
var
  Individual: Integer;
begin
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if randl < FRepairProb then
    begin
      FPopulation[Individual].DownHill;
    end;
  end;
end;

procedure TEvolElitist.DoParallelGetValue(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
begin
  FPopulation[Index].UpdateValue;
end;

procedure TEvolElitist.Evaluate;
var
  Individual: Integer;
  Value, MaxValue: Double;
begin
  MaxValue := -1.7E308;
  // ProcThreadPool.DoParallel(DoParallelGetValue, 0, High(FPopulation), nil);
  for Individual := 0 to High(FPopulation) do
  begin
    FPopulation[Individual].UpdateValue;
    // DoParallelGetValue(Individual, nil, nil);
    Value := FPopulation[Individual].Value;
    if MaxValue < Value then
      MaxValue := Value;
  end;
  for Individual := 0 to High(FPopulation) do
  begin
    FAptitudeArray[Individual] := 1 + MaxValue - FPopulation[Individual].Value;
  end;
end;

procedure TEvolElitist.SelectTheBest;
var
  Individual, EIndividual, Best: Integer;
  EBest: TDynamicIntegerArray;
  EValue: Double;
begin
  Best := 0;
  SetLength(EBest, FModel.ElitistCount);
  for EIndividual := 0 to FModel.ElitistCount - 1 do
    EBest[EIndividual] := 0;
  for Individual := 0 to FPopulationSize - 1 do
  with FPopulation[Individual] do
  begin
    if Value < FPopulation[Best].Value then
    begin
      Best := Individual;
    end;
    for EIndividual := 0 to FModel.ElitistCount - 1 do
    begin
      EValue := FPopulation[EBest[EIndividual]].ElitistValues[EIndividual];
      if (ElitistValues[EIndividual] < EValue) or
        ((ElitistValues[EIndividual] = EValue) and
        (Value < FPopulation[EBest[EIndividual]].Value)) then
        EBest[EIndividual] := Individual;
    end;
  end;
  CopyIndividual(FPopulationSize, Best);
  for EIndividual := 0 to FModel.ElitistCount - 1 do
    CopyIndividual(FPopulationSize + 1 + EIndividual, EBest[EIndividual]);
end;

procedure TEvolElitist.CopyIndividual(Target, Source: Integer);
begin
  FPopulation[Target].Assign(FPopulation[Source]);
  FAptitudeArray[Target] := FAptitudeArray[Source];
end;

procedure TEvolElitist.Elitist;
var
  BestValue, WorstValue, EValue: Double;
  Individual, EIndividual, Best, Worst: Longint;
  EBest: TDynamicIntegerArray;
  FindMejor: Boolean;
begin
  BestValue := FPopulation[0].Value;
  WorstValue := BestValue;
  Best := 0;
  Worst := 0;
  SetLength(EBest, FModel.ElitistCount);
  for EIndividual := 0 to FModel.ElitistCount - 1 do
  begin
    EBest[EIndividual] := FPopulationSize + 1 + EIndividual;
  end;
  for Individual := 0 to FPopulationSize - 1 do
  with FPopulation[Individual] do
  begin
    for EIndividual := 0 to FModel.ElitistCount - 1 do
    begin
      EValue := FPopulation[EBest[EIndividual]].ElitistValues[EIndividual];
      if (ElitistValues[EIndividual] < EValue) or
        ((ElitistValues[EIndividual] = EValue) and
         (Value <= FPopulation[EBest[EIndividual]].Value)) then
        EBest[EIndividual] := Individual;
    end;
    if Value <= BestValue then
    begin
      BestValue := Value;
      Best := Individual;
    end;
    if Value >= WorstValue then
    begin
      WorstValue := Value;
      Worst := Individual;
    end;
  end;
  for EIndividual := 0 to FModel.ElitistCount - 1 do
  begin
    if EBest[EIndividual] <> FPopulationSize + 1 + EIndividual then
      CopyIndividual(FPopulationSize + 1 + EIndividual, EBest[EIndividual]);
  end;
  if BestValue <= FPopulation[FPopulationSize].Value then
  begin
    FindMejor := BestValue < FPopulation[FPopulationSize].Value;
    CopyIndividual(FPopulationSize, Best);
    if FindMejor and Assigned(OnRecordBest) then
      OnRecordBest(Self);
  end
  else
  begin
    CopyIndividual(Worst, FPopulationSize + crand32 mod (1 + FModel.ElitistCount));
  end;
end;

procedure TEvolElitist.Pollinate;
  procedure ExportarInterno;
  var
    Stream: TStream;
  begin
    Stream := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
    try
      SaveBestToStream(Stream);
      Inc(FNumExports);
    finally
      Stream.Free;
    end;
  end;
  procedure Importar;
  var
    Stream: TStream;
  begin
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      FPopulation[FPopulationSize].LoadFromStream(Stream);
      Inc(FNumImports);
    finally
      Stream.Free;
    end;
  end;
  procedure Exportar;
  var
    SyncStream: TStream;
    Value: Double;
  begin
    SyncStream := TFileStream.Create
      (SyncFileName, fmCreate or fmShareExclusive);
    try
      Value := FPopulation[crand32 mod FPopulationSize].Value;
      SyncStream.write(Value, SizeOf(Double));
      ExportarInterno;
    finally
      SyncStream.Free;
    end;
  end;
var
  SyncStream: TStream;
  Value: Double;
begin
  try
    if FileExists(SyncFileName) then
    begin
      SyncStream := TFileStream.Create
        (SyncFileName, fmOpenRead or fmShareDenyWrite);
      try
        SyncStream.read(Value, SizeOf(Double));
      finally
        SyncStream.Free;
      end;
      if Value < FPopulation[FPopulationSize].Value then
        Importar
      else if Value > FPopulation[FPopulationSize].Value then
        Exportar;
    end
    else
    begin
      Exportar;
    end;
  except
    Inc(FClashes);
  end;
end;

procedure TEvolElitist.Select;
var
  Individual, Individual1, Individual2: Longint;
  Sum: Double;
  p: Extended;
  VTmpPoblacion: TTimeTableArray;
  VTmpAptitudArray, FCAptitudeArray, FRAptitudeArray: TDynamicDoubleArray;
begin
  SetLength(FCAptitudeArray, Length(FPopulation));
  SetLength(FRAptitudeArray, Length(FPopulation));
  Sum := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    Sum := Sum + FAptitudeArray[Individual];
  end;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    FRAptitudeArray[Individual] := FAptitudeArray[Individual] / Sum;
  end;
  FCAptitudeArray[0] := FRAptitudeArray[0];
  for Individual := 1 to FPopulationSize - 1 do
  begin
    FCAptitudeArray[Individual] := FCAptitudeArray[Individual - 1]
      + FRAptitudeArray[Individual];
  end;
  for Individual1 := 0 to FPopulationSize - 1 do
  begin
    p := randl;
    if p < FCAptitudeArray[0] then
    begin
      FNewPopulation[Individual1].Assign(FPopulation[0]);
      FNewAptitudeArray[Individual1] := FAptitudeArray[0];
    end
    else
    begin
      for Individual2 := 0 to FPopulationSize - 1 do
        if (p >= FCAptitudeArray[Individual2]) and (p < FCAptitudeArray[Individual2 + 1]) then
        begin
          FNewPopulation[Individual1].Assign(FPopulation[Individual2 + 1]);
          FNewAptitudeArray[Individual1] := FAptitudeArray[Individual2 + 1];
        end;
    end;
  end;
  VTmpPoblacion := FPopulation;
  FPopulation := FNewPopulation;
  FNewPopulation := VTmpPoblacion;

  VTmpAptitudArray := FAptitudeArray;
  FAptitudeArray := FNewAptitudeArray;
  FNewAptitudeArray := VTmpAptitudArray;

  for Individual1 := FPopulationSize to High(FPopulation) do
  begin
    FPopulation[Individual1].Assign(FNewPopulation[Individual1]);
    FAptitudeArray[Individual1] := FNewAptitudeArray[Individual1];
  end;
end;

procedure TEvolElitist.Cross;
var
  Individual, One, First: Longint;
  x: Double;
begin
  First := 0;
  One := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    x := randl;
    if x < FCrossProb then
    begin
      Inc(First);
      if First mod 2 = 0 then
        InternalCrossIndividuals(One, Individual)
      else
        One := Individual;
    end;
  end;
end;

procedure TEvolElitist.InternalCrossIndividuals(Individual1, Individual2: Integer);
begin
  CrossIndividuals(FPopulation[Individual1], FPopulation[Individual2]);
end;

procedure TEvolElitist.Mutate;
var
  Individual: Integer;
begin
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if randl < FMutation1Prob then
      FPopulation[Individual].Mutate(FMutation1Order);
    if randl < FMutation2Prob then
      FPopulation[Individual].MutateDia;
  end;
end;

procedure TEvolElitist.Execute(RefreshInterval: Integer);
var
  Stop: Boolean;
  Iteration: Integer;
begin
  getseeds(FSeed1, FSeed2, FSeed3, FSeed4);
  TThread.Synchronize(CurrentThread, Initialize);
  MakeRandom;
  Evaluate;
  SelectTheBest;
  FNumImports := 0;
  FNumExports := 0;
  FClashes := 0;
  Stop := False;
  Iteration := 0;
  try
    while (Iteration < FMaxIteration) and not Stop do
    begin
      DoProgress(Iteration, RefreshInterval, Self, Stop);
      Select;
      Cross;
      Mutate;
      Repair;
      if ((Iteration mod FPollinationFreq) = 0) and (FSharedDirectory <> '') then
        Pollinate;
      Evaluate;
      Elitist;
      Inc(Iteration);
    end;
  finally
    if (SharedDirectory <> '') then
    begin
      if FileExists(FileName) then DeleteFile(FileName);
      if FileExists(SyncFileName) then DeleteFile(SyncFileName);
    end;
  end;
  if Stop then FMaxIteration := Iteration; // Preserve the maximum in case of cancel
end;

procedure TEvolElitist.ForcedDownHill;
begin
  FPopulation[FPopulationSize].DownHillForced;
  if Assigned(OnRecordBest) then
    OnRecordBest(Self);
end;

function TEvolElitist.DownHill: Boolean;
begin
  Result := FPopulation[FPopulationSize].DownHill;
end;

procedure TEvolElitist.SaveBestToDatabase(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Report: TStrings);
begin
  BestIndividual.SaveToDataModule(CodHorario, MomentoInicial, MomentoFinal, Report);
end;

procedure TEvolElitist.SaveBestToStream(AStream: TStream);
begin
  BestIndividual.SaveToStream(AStream);
end;

function TEvolElitist.GetAverageValue: Double;
var
  Individual: Integer;
  sum: Double;
begin
  sum := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    sum := sum + FPopulation[Individual].Value;
  end;
  Result := sum / FPopulationSize;
end;

function TEvolElitist.GetBestIndividual: TTimeTable;
begin
  Result := FPopulation[FPopulationSize];
end;

procedure TEvolElitist.ReportParameters(AInforme: TStrings);
begin
  with AInforme do
  begin
    Add('Semillas del generador de numeros aleatorios:');
    Add(Format('  %d, %d, %d, %d', [FSeed1, FSeed2, FSeed3, FSeed4]));
    Add(Format('Numero de individuos:       %5.d', [FPopulationSize]));
    Add(Format('Maximo de generaciones:     %5.d', [FMaxIteration]));
    Add(Format('Probabilidad de cruce:      %1.3f', [FCrossProb]));
    Add(Format('Probabilidad de Mutacion 1: %1.3f', [FMutation1Prob]));
    Add(Format('Orden de la Mutacion 1:     %5.d', [FMutation1Order]));
    Add(Format('Probabilidad de Mutacion 1: %1.3f', [FMutation2Prob]));
    Add(Format('Probabilidad de Reparacion: %1.3f', [FRepairProb]));
    Add(Format('Rango de polinizacion:      %5.d', [FPollinationFreq]));
  end;
end;

procedure TEvolElitist.FixIndividuals(const Individuals: string);
var
  Position, Individual: Integer;
begin
  SetLength(FFixedIndividuals, Length(Individuals));
  Position := 1;
  Individual := 0;
  while Position <= Length(Individuals) do
  begin
    FFixedIndividuals[Individual] := StrToInt(ExtractString(Individuals, Position, ','));
    Inc(Individual);
  end;
  SetLength(FFixedIndividuals, Individual);
end;

function TEvolElitist.GetFileName: string;
begin
  Result := FSharedDirectory + '/ttable.dat';
end;

function TEvolElitist.GetSyncFileName: string;
begin
  Result := FSharedDirectory + '/ttsync.dat';
end;

procedure TSolver.DoProgress(Position, RefreshInterval: Integer;
  Solver: TSolver; var Stop: Boolean);
begin
  if Assigned(FOnProgress) and (Position mod RefreshInterval = 0) then
    FOnProgress(Position, Self, Stop);
end;

{ TDoubleDownHill }

function TDoubleDownHill.GetBestIndividual: TTimeTable;
begin
  Result := FBestIndividual;
end;

procedure TDoubleDownHill.Execute(RefreshInterval: Integer);
begin
  repeat
  until DoubleDownHill(RefreshInterval);
  FBestIndividual.RecalculateValue := True;
end;

function TDoubleDownHill.DoubleDownHill(Step: Integer): Boolean;
var
  Periodo1, Periodo2, Duracion1, Duracion2, Counter, Paralelo: Smallint;
  DValue, Value1: Double;
  Position: Integer;
  RandomOrders: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  PeriodoASesion: TDynamicSmallintArray;
  Stop: Boolean;
  { Continuar: Boolean; }
begin
  with FBestIndividual, TimeTableModel do
  begin
    Update;
    UpdateValue;
    for Counter := 0 to ParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := rand32;
    end;
    SortLongint(RandomValues, RandomOrders, 0, ParaleloCant - 1);
    Result := True;
    Counter := 0;
    Value1 := Value;
    Position := 0;
    while Counter < ParaleloCant do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[Counter];
      Periodo1 := 0;
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      while Periodo1 < PeriodoCant do
      begin
        Periodo2 := Periodo1 + SesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < PeriodoCant do
        begin
          Stop := False;
          DoProgress(Position, Step, Self, Stop);
          if Stop then
            Exit;
          Inc(Position);
          DValue := EvaluateInternalSwap(Paralelo, Periodo1, Periodo2);
          Duracion1 := SesionADuracion[PeriodoASesion[Periodo1]];
          Duracion2 := SesionADuracion[PeriodoASesion[Periodo2]];
          InternalSwap(Paralelo, Periodo1, Periodo2, True);
          if DValue < 0 then
          begin
            Result := False;
          end
          else
          begin
            if InternalDownHillEach(DValue) then
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              DValue := 0;
            end
            else
            begin
              Normalize(Paralelo, Periodo1);
              Result := False;
            end;
          end;
          Value1 := Value1 + DValue;
          Normalize(Paralelo, Periodo2);
          Inc(Periodo2, SesionADuracion[PeriodoASesion[Periodo2]]);
        end;
        Normalize(Paralelo, Periodo1);
        Inc(Periodo1, SesionADuracion[PeriodoASesion[Periodo1]]);
      end;
      { if Continuar then }
      Inc(Counter);
    end;
  end;
end;

constructor TDoubleDownHill.Create(TimeTable: TTimeTable);
begin
  FBestIndividual := TimeTable;
end;

end.
