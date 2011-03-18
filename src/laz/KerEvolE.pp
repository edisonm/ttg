unit KerEvolE;
{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}cthreads, cmem, {$ENDIF}MTProcs, Classes, Forms, SysUtils, Dialogs,
  KerModel;

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

  TProgressEvent = procedure(Position, Max: Integer; Solver: TSolver;
    var Stop: Boolean) of object;

  { TEvolElitist }

  { TSolver }

  TSolver = class
  private
    FModel: TTimeTableModel;
    FBestIndividual: TTimeTable;
    FOnProgress: TProgressEvent;
    FSharedDirectory: string;
    FPollinationProb: Double;
    FNumImports, FNumExports, FColision: Integer;
    function GetFileName: string;
  protected
    procedure DoProgress(Position, Max, RefreshInterval: Integer; Solver: TSolver;
      var Stop: Boolean);
  public
    constructor Create(AModel: TTimeTableModel; const ASharedDirectory: string;
      APollinationProb: Double);
    procedure Execute(RefreshInterval: Integer); virtual; abstract;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); virtual; abstract;
    function Pollinate: Boolean;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property BestIndividual: TTimeTable read FBestIndividual;
    property SharedDirectory: string read FSharedDirectory write FSharedDirectory;
    property FileName: string read GetFileName;
    property PollinationProb: Double read FPollinationProb write FPollinationProb;
    property NumImports: Integer read FNumImports;
    property NumExports: Integer read FNumExports;
    property NumColision: Integer read FColision;
  end;

  { TDoubleDownHill }

  TDoubleDownHill = class(TSolver)
  private
    function DoubleDownHill(RefreshInterval: Integer): Double;
  protected
  public
    procedure Execute(RefreshInterval: Integer); override;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); override;
  end;

  TEvolElitist = class(TSolver)
  private
    FRandSeed: Cardinal;
    FPopulationSize, FMaxIteration, FMutation1Order: Integer;
    FCrossProb, FMutation1Prob, FMutation2Prob, FRepairProb: Double;
    FPopulation, FNewPopulation: TTimeTableArray;
    FFixedIndividuals: TDynamicIntegerArray;
    FOnRecordBest: TNotifyEvent;
    procedure MakeRandom;
    procedure Elitist;
    procedure Select;
    procedure Cross;
    procedure Mutate;
    procedure InternalCrossIndividuals(Individual1, Individual2: Integer);
    function GetAverageValue: Double;
    procedure SetPopulationSize(APopulationSize: Integer);
  protected
  public
    procedure Initialize;
    procedure ReportParameters(AInforme: TStrings);
    constructor Create(AModel: TTimeTableModel; const ASharedDirectory: string;
      APollinationProb: Double; APopulationSize, AMaxIteration: Integer;
      ACrossProb, AMutation1Prob: Double; AMutation1Order: Integer;
      AMutation2Prob, ARepairProb: Double; const AHorarioIni: string);
    procedure FixIndividuals(const Individuals: string);
    destructor Destroy; override;
    procedure SaveSolutionToDatabase(CodHorario: Integer;
      const AExtraInfo: string; MomentoInicial, MomentoFinal: TDateTime); override;
    procedure SaveBestToStream(AStream: TStream);
    procedure Execute(RefreshInterval: Integer); override;
    function DownHillForced: Double;
    function DownHill: Double;
    procedure Repair;
    property PopulationSize: Integer read FPopulationSize write SetPopulationSize;
    property OnRecordBest: TNotifyEvent read FOnRecordBest write FOnRecordBest;
    property MaxIteration: Integer read FMaxIteration write FMaxIteration;
    property CrossProb: Double read FCrossProb write FCrossProb;
    property Mutation1Prob: Double read FMutation1Prob write FMutation1Prob;
    property Mutation1Order: Integer read FMutation1Order write FMutation1Order;
    property Mutation2Prob: Double read FMutation2Prob write FMutation2Prob;
    property RepairProb: Double read FRepairProb write FRepairProb;
    property AverageValue: Double read GetAverageValue;
    property Model: TTimeTableModel read FModel;
  end;

implementation

uses
  HorColCm;

procedure TEvolElitist.SetPopulationSize(APopulationSize: Integer);
var
  Individual: Integer;
begin
  FPopulationSize := APopulationSize;
  SetLength(FPopulation, FPopulationSize + FModel.ElitistCount);
  SetLength(FNewPopulation, Length(FPopulation));
  for Individual := 0 to High(FPopulation) do
  begin
    if not Assigned(FPopulation[Individual]) then
      FPopulation[Individual] := TTimeTable.Create(FModel);
    if not Assigned(FNewPopulation[Individual]) then
      FNewPopulation[Individual] := TTimeTable.Create(FModel);
  end;
end;

constructor TEvolElitist.Create(AModel: TTimeTableModel; const ASharedDirectory: string;
  APollinationProb: Double; APopulationSize, AMaxIteration: Integer; ACrossProb,
  AMutation1Prob: Double; AMutation1Order: Integer; AMutation2Prob,
  ARepairProb: Double; const AHorarioIni: string);
begin
  inherited Create(AModel, ASharedDirectory, APollinationProb);
  PopulationSize := APopulationSize;
  FMaxIteration := AMaxIteration;
  FCrossProb := ACrossProb;
  FMutation1Prob := AMutation1Prob;
  FMutation1Order := AMutation1Order;
  FMutation2Prob := AMutation2Prob;
  FRepairProb := ARepairProb;
  FixIndividuals(AHorarioIni);
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
  BestIndividual.MakeRandom;
end;

procedure TEvolElitist.Repair;
var
  Individual: Integer;
begin
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Random < FRepairProb then
    begin
      FPopulation[Individual].DownHill;
    end;
  end;
end;


procedure TEvolElitist.Elitist;
var
  ElitistValue: Double;
  Individual, EIndividual, Best, Worst: Integer;
  ElitistBests: TDynamicIntegerArray;
begin
  Best := 0;
  Worst := 0;
  SetLength(ElitistBests, FModel.ElitistCount);
  for EIndividual := 0 to FModel.ElitistCount - 1 do
    ElitistBests[EIndividual] := FPopulationSize + EIndividual;
  for Individual := 0 to FPopulationSize - 1 do
  with FPopulation[Individual] do
  begin
    for EIndividual := 0 to FModel.ElitistCount - 1 do
    begin
      ElitistValue := FPopulation[ElitistBests[EIndividual]].ElitistValues[EIndividual];
      if (ElitistValues[EIndividual] < ElitistValue) or
        ((ElitistValues[EIndividual] = ElitistValue) and
         (Value <= FPopulation[ElitistBests[EIndividual]].Value)) then
        ElitistBests[EIndividual] := Individual;
    end;
    if Value <= FPopulation[Best].Value then
      Best := Individual;
    if Value >= FPopulation[Worst].Value then
      Worst := Individual;
  end;
  for EIndividual := 0 to FModel.ElitistCount - 1 do
    if ElitistBests[EIndividual] <> FPopulationSize + EIndividual then
      FPopulation[FPopulationSize + EIndividual].Assign(FPopulation[EIndividual]);
  if FPopulation[Best].Value < BestIndividual.Value then
  begin
    BestIndividual.Assign(FPopulation[Best]);
    if Assigned(OnRecordBest) then
      OnRecordBest(Self);
  end;
end;

function TSolver.Pollinate: Boolean;
  procedure Exportar;
  var
    Stream: TStream;
    Value: Double;
  begin
    Stream := TFileStream.Create
      (FileName, fmCreate or fmShareExclusive);
    try
      Value := BestIndividual.Value;
      Stream.write(Value, SizeOf(Double));
      BestIndividual.SaveToStream(Stream);
      Inc(FNumExports);
    finally
      Stream.Free;
    end;
  end;
var
  Stream: TStream;
  Value: Double;
begin
  Result := False;
  if (FSharedDirectory <> '') and (Random < FPollinationProb) then
  try
    if FileExists(FileName) then
    begin
      Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      try
        Stream.read(Value, SizeOf(Double));
        if Value < BestIndividual.Value then
        begin
          BestIndividual.LoadFromStream(Stream);
          Inc(FNumImports);
          Result := True;
        end;
      finally
        Stream.Free;
      end;
      if Value > BestIndividual.Value then
        Exportar;
    end
    else
    begin
      Exportar;
    end;
  except
    Inc(FColision);
  end;
end;

procedure TEvolElitist.Select;
var
  Individual, Individual1, Individual2: Integer;
  Value, MaxValue: Double;
  Sum: Double;
  p: Extended;
  TmpPopulation: TTimeTableArray;
  Aptitudes, CummulatedAptitudes, RelativeAptitudes: TDynamicDoubleArray;
begin
  MaxValue := BestIndividual.Value;
  for Individual := 0 to High(FPopulation) do
  begin
    Value := FPopulation[Individual].Value;
    if MaxValue < Value then
      MaxValue := Value;
  end;
  SetLength(Aptitudes, Length(FPopulation));
  SetLength(CummulatedAptitudes, Length(FPopulation));
  SetLength(RelativeAptitudes, Length(FPopulation));
  for Individual := 0 to High(FPopulation) do
  begin
    Aptitudes[Individual] := 1 + MaxValue - FPopulation[Individual].Value;
  end;
  Sum := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    Sum := Sum + Aptitudes[Individual];
  end;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    RelativeAptitudes[Individual] := Aptitudes[Individual] / Sum;
  end;
  CummulatedAptitudes[0] := RelativeAptitudes[0];
  for Individual := 1 to FPopulationSize - 1 do
  begin
    CummulatedAptitudes[Individual] := CummulatedAptitudes[Individual - 1]
      + RelativeAptitudes[Individual];
  end;
  for Individual1 := 0 to FPopulationSize - 1 do
  begin
    p := Random;
    if p < CummulatedAptitudes[0] then
    begin
      FNewPopulation[Individual1].Assign(FPopulation[0]);
    end
    else
    begin
      for Individual2 := 0 to FPopulationSize - 1 do
        if (p >= CummulatedAptitudes[Individual2]) and (p < CummulatedAptitudes[Individual2 + 1]) then
          FNewPopulation[Individual1].Assign(FPopulation[Individual2 + 1]);
    end;
  end;
  TmpPopulation := FPopulation;
  FPopulation := FNewPopulation;
  FNewPopulation := TmpPopulation;
  for Individual1 := FPopulationSize to High(FPopulation) do
    FPopulation[Individual1].Assign(FNewPopulation[Individual1]);
end;

procedure TEvolElitist.Cross;
var
  Individual, One, First: Integer;
  x: Double;
begin
  First := 0;
  One := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    x := Random;
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
    if Random < FMutation1Prob then
      FPopulation[Individual].Mutate(FMutation1Order);
    if Random < FMutation2Prob then
      FPopulation[Individual].MutateDia;
  end;
end;

procedure TEvolElitist.Execute(RefreshInterval: Integer);
var
  Stop: Boolean;
  Iteration: Integer;
begin
  FRandSeed := RandSeed;
  MakeRandom;
  FNumImports := 0;
  FNumExports := 0;
  FColision := 0;
  Stop := False;
  Iteration := 0;
  try
    while (Iteration < FMaxIteration) and not Stop do
    begin
      DoProgress(Iteration, FMaxIteration, RefreshInterval, Self, Stop);
      Cross;
      Mutate;
      Repair;
      Pollinate;
      Elitist;
      Select;
      Inc(Iteration);
    end;
  finally
    if (SharedDirectory <> '') and FileExists(FileName) then
      DeleteFile(FileName);
  end;
  if Stop then FMaxIteration := Iteration; // Preserve the maximum in case of stop
end;

function TEvolElitist.DownHillForced: Double;
begin
  Result := BestIndividual.DownHillForced;
  if Assigned(OnRecordBest) then
    OnRecordBest(Self);
end;

function TEvolElitist.DownHill: Double;
begin
  Result := BestIndividual.DownHill;
end;

procedure TEvolElitist.SaveSolutionToDatabase(CodHorario: Integer;
  const AExtraInfo: string; MomentoInicial, MomentoFinal: TDateTime);
var
  Report: TStrings;
begin
  Report := TStringList.Create;
  with Report do
  try
    Add('Algoritmo Evolutivo Elitista');
    Add('============================');
    if AExtraInfo <> '' then
      Add(AExtraInfo);
    ReportParameters(Report);
    BestIndividual.ReportValues(Report);
    BestIndividual.SaveToDataModule(CodHorario, MomentoInicial, MomentoFinal, Report);
  finally
    Free;
  end;
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

procedure TEvolElitist.ReportParameters(AInforme: TStrings);
begin
  with AInforme do
  begin
    Add(Format('Semilla Numeros aleatorios:   %7.u', [FRandSeed]));
    Add(Format('Numero de individuos:         %7.d', [FPopulationSize]));
    Add(Format('Maximo de generaciones:       %7.d', [FMaxIteration]));
    Add(Format('Probabilidad de cruce:        %1.5f', [FCrossProb]));
    Add(Format('Probabilidad de Mutacion 1:   %1.5f', [FMutation1Prob]));
    Add(Format('Orden de la Mutacion 1:       %7.d', [FMutation1Order]));
    Add(Format('Probabilidad de Mutacion 1:   %1.5f', [FMutation2Prob]));
    Add(Format('Probabilidad de Reparacion:   %1.5f', [FRepairProb]));
    Add(Format('Probabilidad de polinizacion: %1.5f', [FPollinationProb]));
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

function TSolver.GetFileName: string;
begin
  Result := FSharedDirectory + 'ttable.dat';
end;

procedure TSolver.DoProgress(Position, Max, RefreshInterval: Integer;
  Solver: TSolver; var Stop: Boolean);
begin
  if Assigned(FOnProgress) and (Position mod RefreshInterval = 0) then
    FOnProgress(Position, Max, Solver, Stop);
end;

constructor TSolver.Create(AModel: TTimeTableModel; const ASharedDirectory: string;
  APollinationProb: Double);
begin
  inherited Create;
  FModel := AModel;
  FBestIndividual := TTimeTable.Create(FModel);
  FSharedDirectory := ASharedDirectory;
  FPollinationProb := APollinationProb;
end;

{ TDoubleDownHill }

procedure TDoubleDownHill.Execute(RefreshInterval: Integer);
begin
  try
    DoubleDownHill(RefreshInterval);
  finally
    if (SharedDirectory <> '') and FileExists(FileName) then
      DeleteFile(FileName);
  end;
end;

function TDoubleDownHill.DoubleDownHill(RefreshInterval: Integer): Double;
var
  Paralelo, Periodo1, Periodo2, Sesion, Duracion1, Duracion2, Counter: Integer;
  Delta1, Delta2, Value1{$IFDEF DEBUG}, Value2{$ENDIF}: Double;
  Position, Offset, Max: Integer;
  RandomOrders: array [0 .. 4095] of Integer;
  RandomValues: array [0 .. 4095] of Integer;
  PeriodoASesion: TDynamicIntegerArray;
  Stop, Down: Boolean;
  { Continuar: Boolean; }
begin
  with BestIndividual, Model do
  begin
    Update;
    for Counter := 0 to ParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := Random($7FFFFFFF);
    end;
    SortInteger(RandomValues, RandomOrders, 0, ParaleloCant - 1);
    Counter := 0;
    Offset := 0;
    Position := 0;
    Max := SesionCantidadDoble;
    Result := 0;
    while Counter < ParaleloCant do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[(Offset + Counter) mod ParaleloCant];
      Periodo1 := 0;
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      Down := False;
      while Periodo1 < PeriodoCant do
      begin
        Periodo2 := Periodo1 + SesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < PeriodoCant do
        begin
          Stop := False;
          DoProgress(Position, Max, RefreshInterval, Self, Stop);
          if Stop then
            Exit;
          Inc(Position);
          Duracion1 := SesionADuracion[PeriodoASesion[Periodo1]];
          Duracion2 := SesionADuracion[PeriodoASesion[Periodo2]];
          Delta1 := InternalSwap(Paralelo, Periodo1, Periodo2);
          if Delta1 < 0 then
          begin
            Result := Result + Delta1;
            Down := True;
            Inc(Periodo2, Duracion2);
          end
          else
          begin
            {$IFDEF DEBUG}
            Value1 := Value;
            {$ENDIF}
            Delta2 := DownHill(True, False, -Delta1);
            {$IFDEF DEBUG}
            Value2 := Value;
            if Abs(Value2 - Value1 - Delta2) >= 0.00001 then
              WriteLn(Format('%f <> %f'#13#10, [Value2 - Value1, Delta2]));
            {$ENDIF}
            if Delta2 < 0 then
            begin
              if Periodo1 > 0 then
              begin
                Dec(Periodo1);
                Sesion := PeriodoASesion[Periodo1];
                if Sesion < 0 then
                  Inc(Periodo1)
                else
                  repeat
                    Inc(Periodo1);
                  until (Periodo1 >= PeriodoCant)
                    or (PeriodoASesion[Periodo1] <> Sesion);
              end;
              Result := Result + Delta2;
              Down := True;
              if Periodo2 <= Periodo1 then
                Periodo2 := Periodo1 + SesionADuracion[PeriodoASesion[Periodo1]]
              else
              begin
                Sesion := PeriodoASesion[Periodo2];
                if Sesion < 0 then
                  Inc(Periodo1)
                else
                  repeat
                    Inc(Periodo2);
                  until (Periodo2 >= PeriodoCant)
                    or (PeriodoASesion[Periodo2] <> Sesion);
              end;
            end
            else
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              Inc(Periodo2, Duracion2);
            end;
          end;
        end;
        Value1 := Value;
        if Pollinate then
          Result := Result + Value - Value1;
        Sesion := PeriodoASesion[Periodo1];
        if Sesion < 0 then
          Inc(Periodo1)
        else
          repeat
            Inc(Periodo1);
          until (Periodo1 >= PeriodoCant)
            or (PeriodoASesion[Periodo1] <> Sesion);
      end;
      Inc(Counter);
      if Down then
      begin
        Max := Position + SesionCantidadDoble;
        Offset := (Offset + Counter) mod ParaleloCant;
        Counter := 0;
      end;
    end;
  end;
end;

procedure TDoubleDownHill.SaveSolutionToDatabase(ACodHorario: Integer;
  const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime);
var
  Report: TStrings;
begin
  Report := TStringList.Create;
  try
    Report.Add('Algoritmo de Descenso Rapido Doble');
    Report.Add('==================================');
    if AExtraInfo <> '' then
      Report.Add(AExtraInfo);
    BestIndividual.ReportValues(Report);
    BestIndividual.SaveToDataModule(ACodHorario, AMomentoInicial, AMomentoFinal, Report);
  finally
    Report.Free;
  end;
end;

end.
