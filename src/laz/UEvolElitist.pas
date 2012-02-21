{ -*- mode: Delphi -*- }
unit UEvolElitist;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, UModel, USolver, UTTGBasics, UDownHill;

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
    son cruce, mutacion, etc., TimetableModel al que se aplica el algoritmo
    evolutivo, metodo que permite ejecutar el algoritmo evolutivo, Eventos que
    se disparan cada cierto numero de generaciones y cuando mejora la solucion.
    }

  { TEvolElitist }

  TEvolElitist = class(TSolver)
  private
    FRandSeed: Cardinal;
    FPopulationSize, FMaxIteration: Integer;
    FCrossProbability, FMutationProbability, FReparationProbability: Double;
    FPopulation, FElitists: TIndividualArray;
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
    procedure ReportParameters(ASummary: TStrings);
    constructor Create(AModel: TModel; const ASharedDirectory: string;
      APollinationProbability: Double; APopulationSize, AMaxIteration: Integer;
      ACrossProbability, AMutationProbability, AReparationProbability: Double; const AInitialTimetables: string);
    procedure FixIndividuals(const Individuals: string);
    destructor Destroy; override;
    procedure SaveSolutionToDatabase(IdTimetable: Integer;
      const AExtraInfo: string; TimeIni, TimeEnd: TDateTime); override;
    procedure SaveBestToStream(AStream: TStream);
    procedure Execute(RefreshInterval: Integer); override;
    function DownHill: Integer;
    procedure Repair;
    procedure Update; override;
    procedure UpdateValue; override;
    property PopulationSize: Integer read FPopulationSize write SetPopulationSize;
    property OnRecordBest: TNotifyEvent read FOnRecordBest write FOnRecordBest;
    property MaxIteration: Integer read FMaxIteration write FMaxIteration;
    property CrossProbability: Double read FCrossProbability write FCrossProbability;
    property MutationProbability: Double read FMutationProbability write FMutationProbability;
    property ReparationProbability: Double read FReparationProbability write FReparationProbability;
    property AverageValue: Double read GetAverageValue;
  end;

implementation

uses
  UTTGConsts;

procedure TEvolElitist.SetPopulationSize(APopulationSize: Integer);
var
  Individual: Integer;
begin
  FPopulationSize := APopulationSize;
  SetLength(FPopulation, FPopulationSize);
  SetLength(FElitists, Model.ElitistCount);
  for Individual := 0 to High(FPopulation) do
  begin
    if not Assigned(FPopulation[Individual]) then
      FPopulation[Individual] := Model.NewIndividual;
  end;
  for Individual := 0 to Model.ElitistCount - 1 do
  begin
    FElitists[Individual] := Model.NewIndividual;
  end;
end;

constructor TEvolElitist.Create(AModel: TModel; const ASharedDirectory: string;
  APollinationProbability: Double; APopulationSize, AMaxIteration: Integer; ACrossProbability,
  AMutationProbability, AReparationProbability: Double; const AInitialTimetables: string);
begin
  inherited Create(AModel, ASharedDirectory, APollinationProbability);
  SetPopulationSize(APopulationSize);
  FMaxIteration := AMaxIteration;
  FCrossProbability := ACrossProbability;
  FMutationProbability := AMutationProbability;
  FReparationProbability := AReparationProbability;
  FixIndividuals(AInitialTimetables);
end;

destructor TEvolElitist.Destroy;
var
  Individual: Integer;
begin
  for Individual := 0 to High(FPopulation) do
  begin
    FPopulation[Individual].Free;
  end;
  for Individual := 0 to high(FElitists) do
    FElitists[Individual].Free;
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
  for Individual := Length(FFixedIndividuals) to FPopulationSize - 1 do
  begin
    FPopulation[Individual].MakeRandom;
  end;
  for Individual := 0 to Model.ElitistCount - 1 do
  begin
    FElitists[Individual].MakeRandom;
  end;
  BestIndividual.MakeRandom;
end;

procedure TEvolElitist.Repair;
var
  Individual: Integer;
begin
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Random < FReparationProbability then
    begin
      TDownHill.DownHill(FPopulation[Individual]);
    end;
  end;
end;

procedure TEvolElitist.Update;
var
  Individual, EIndivitual: Integer;
begin
  inherited Update;
  for Individual := 0 to FPopulationSize - 1 do
    FPopulation[Individual].Update;
  for EIndivitual := 0 to Model.ElitistCount - 1 do
    FElitists[EIndivitual].Update;
end;

procedure TEvolElitist.UpdateValue;
var
  Individual, EIndivitual: Integer;
begin
  inherited UpdateValue;
  for Individual := 0 to FPopulationSize - 1 do
    FPopulation[Individual].UpdateValue;
  for EIndivitual := 0 to Model.ElitistCount - 1 do
    FElitists[EIndivitual].UpdateValue
end;


procedure TEvolElitist.Elitist;
var
  ElitistValue: Double;
  Individual, EIndividual, Best, Worst, Number: Integer;
  ElitistBests: TDynamicIntegerArray;
begin
  Best := 0;
  Worst := 0;
  SetLength(ElitistBests, Model.ElitistCount);
  for EIndividual := 0 to Model.ElitistCount - 1 do
    ElitistBests[EIndividual] := 0;
  for Individual := 1 to FPopulationSize - 1 do
    with FPopulation[Individual] do
    begin
      for EIndividual := 0 to Model.ElitistCount - 1 do
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
  for EIndividual := 0 to Model.ElitistCount - 1 do
    if FPopulation[ElitistBests[EIndividual]].Value < FElitists[EIndividual].Value then
      FElitists[EIndividual].Assign(FPopulation[ElitistBests[EIndividual]]);
  if FPopulation[Best].Value < BestIndividual.Value then
  begin
    BestIndividual.Assign(FPopulation[Best]);
    if Assigned(OnRecordBest) then
      OnRecordBest(Self);
  end
  else if FPopulation[Best].Value > BestIndividual.Value then
  begin
    Number := Random(Model.ElitistCount + 1);
    if Number >= Model.ElitistCount then
      FPopulation[Worst].Assign(BestIndividual)
    else
      FPopulation[Worst].Assign(FElitists[Random(Model.ElitistCount)]);
  end;
end;

procedure TEvolElitist.Select;
var
  Individual, Individual1, Value, MinValue, MaxValue, Offset, Sum,
    p, Selected, Discarted, Counter: Integer;
  Selecteds, Discarteds, Aptitudes, Cummulated: TDynamicIntegerArray;
begin
  MaxValue := -1;
  MinValue := MaxInt;
  for Individual := 0 to High(FPopulation) do
  begin
    Value := FPopulation[Individual].Value;
    if MaxValue < Value then
      MaxValue := Value;
    if MinValue > Value then
      MinValue := Value;
  end;
  SetLength(Aptitudes, FPopulationSize);
  SetLength(Cummulated, FPopulationSize);
  SetLength(Selecteds, FPopulationSize);
  Offset := MaxValue;
  //Offset := (MaxValue - MinValue) * FPopulationSize + 1;
  Offset := 1;
  for Individual := 0 to High(FPopulation) do
  begin
    Selecteds[Individual] := 0;
    Aptitudes[Individual] := Offset + MaxValue - FPopulation[Individual].Value;
  end;
  Cummulated[0] := Aptitudes[0];
  for Individual := 1 to FPopulationSize - 1 do
  begin
    Cummulated[Individual] := Cummulated[Individual - 1]
      + Aptitudes[Individual];
  end;
  Sum := Cummulated[Individual];
  for Individual1 := 0 to FPopulationSize - 1 do
  begin
    p := Random(Sum);
    Selected := 0;
    while Cummulated[Selected] < p do
    begin
      Inc(Selected);
    end;
    Inc(Selecteds[Selected]);
  end;
  Discarted := 0;
  SetLength(Discarteds, FPopulationSize);
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Selecteds[Individual] = 0 then
    begin
      Discarteds[Discarted] := Individual;
      Inc(Discarted);
    end;
  end;
  Discarted := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Selecteds[Individual] > 1 then
      for Counter := 1 to Selecteds[Individual] - 1 do
      begin
        FPopulation[Discarteds[Discarted]].Assign(FPopulation[Individual]);
        Inc(Discarted);
      end;
  end;
end;

procedure TEvolElitist.Cross;
var
  Individual, One, First: Integer;
begin
  First := 0;
  One := 0;
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Random < FCrossProbability then
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
  FPopulation[Individual1].Cross(FPopulation[Individual2]);
end;

procedure TEvolElitist.Mutate;
var
  Individual: Integer;
begin
  for Individual := 0 to FPopulationSize - 1 do
  begin
    if Random < FMutationProbability then
      FPopulation[Individual].Mutate;
  end;
end;

procedure TEvolElitist.Execute(RefreshInterval: Integer);
var
  Stop: Boolean;
  Iteration: Integer;
begin
  inherited;
  FRandSeed := RandSeed;
  MakeRandom;
  Elitist;
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

function TEvolElitist.DownHill: Integer;
begin
  Result := TDownHill.DownHill(BestIndividual);
  {if Assigned(OnRecordBest) then
    OnRecordBest(Self);}
end;

procedure TEvolElitist.SaveSolutionToDatabase(IdTimetable: Integer;
  const AExtraInfo: string; TimeIni, TimeEnd: TDateTime);
var
  Report: TStrings;
begin
  Report := TStringList.Create;
  with Report do
  try
    Add(SEvolutiveElitistAlgorithm);
    Add('============================');
    if AExtraInfo <> '' then
      Add(AExtraInfo);
    ReportParameters(Report);
    BestIndividual.ReportValues(Report);
    BestIndividual.SaveToDataModule(IdTimetable, TimeIni, TimeEnd, Report);
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

procedure TEvolElitist.ReportParameters(ASummary: TStrings);
begin
  with ASummary do
  begin
    Add(Format('%0:-28s %12.u', [SRandSeed               + ':', FRandSeed]));
    Add(Format('%0:-28s %12.d', [SPopulationSize         + ':', FPopulationSize]));
    Add(Format('%0:-28s %12.d', [SMaxIteration           + ':', FMaxIteration]));
    Add(Format('%0:-34s %1.4f', [SCrossProbability       + ':', FCrossProbability]));
    Add(Format('%0:-34s %1.4f', [SMutationProbability    + ':', FMutationProbability]));
    Add(Format('%0:-34s %1.4f', [SReparationProbability  + ':', FReparationProbability]));
    Add(Format('%0:-34s %1.4f', [SPollinationProbability + ':', PollinationProbability]));
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

end.

