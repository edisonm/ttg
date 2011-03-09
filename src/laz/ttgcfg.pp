unit TTGCfg;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, UConfig;

type

  { TTTGConfig }

  TTTGConfig = class(TConfigStorage)
  private
    function GetNomColegio: string;
    procedure SetNomColegio(const Value: string);
    function GetAnioLectivo: string;
    procedure SetAnioLectivo(const Value: string);
    function GetNomAutoridad: string;
    procedure SetNomAutoridad(const Value: string);
    function GetCarAutoridad: string;
    procedure SetCarAutoridad(const Value: string);
    function GetNomResponsable: string;
    procedure SetNomResponsable(const Value: string);
    function GetCarResponsable: string;
    procedure SetCarResponsable(const Value: string);
    function GetMaxCargaProfesor: Integer;
    procedure SetMaxCargaProfesor(Value: Integer);
    function GetComentarios: string;
    procedure SetComentarios(const Value: string);
    function GetRandomize: Boolean;
    procedure SetRandomize(Value: Boolean);
    function GetSeed1: Integer;
    procedure SetSeed1(Value: Integer);
    function GetSeed2: Integer;
    procedure SetSeed2(Value: Integer);
    function GetSeed3: Integer;
    procedure SetSeed3(Value: Integer);
    function GetSeed4: Integer;
    procedure SetSeed4(Value: Integer);
    function GetRefreshInterval: Integer;
    procedure SetRefreshInterval(Value: Integer);
    function GetCruceProfesor: Extended;
    procedure SetCruceProfesor(Value: Extended);
    function GetProfesorFraccionamiento: Extended;
    procedure SetProfesorFraccionamiento(Value: Extended);
    function GetCruceAulaTipo: Extended;
    procedure SetCruceAulaTipo(Value: Extended);
    function GetHoraHueca: Extended;
    procedure SetHoraHueca(Value: Extended);
    function GetSesionCortada: Extended;
    procedure SetSesionCortada(Value: Extended);
    function GetMateriaNoDispersa: Extended;
    procedure SetMateriaNoDispersa(Value: Extended);
    function GetPopulationSize: Integer;
    procedure SetPopulationSize(Value: Integer);
    function GetNumMaxGeneracion: Integer;
    procedure SetNumMaxGeneracion(Value: Integer);
    function GetProbCruzamiento: Extended;
    procedure SetProbCruzamiento(Value: Extended);
    function GetMutation1Prob: Extended;
    procedure SetMutation1Prob(Value: Extended);
    function GetMutation1Order: Integer;
    procedure SetMutation1Order(Value: Integer);
    function GetMutation2Prob: Extended;
    procedure SetMutation2Prob(Value: Extended);
    function GetRepairProb: Extended;
    procedure SetRepairProb(Value: Extended);
    function GetHorarioIni: string;
    procedure SetHorarioIni(const Value: string);
    function GetSharedDirectory: string;
    procedure SetSharedDirectory(const Value: string);
    function SetPollinationFreq: Integer;
    procedure SetRangoPolinizacion(Value: Integer);
    function GetApplyDoubleDownHill: Boolean;
    procedure SetApplyDoubleDownHill(Value: Boolean);
  public
    procedure SetDefaults;
    procedure InitRandom;
    property NomColegio: string read GetNomColegio write SetNomColegio;
    property AnioLectivo: string read GetAnioLectivo write SetAnioLectivo;
    property NomAutoridad: string read GetNomAutoridad write SetNomAutoridad;
    property CarAutoridad: string read GetCarAutoridad write SetCarAutoridad;
    property NomResponsable: string read GetNomResponsable write SetNomResponsable;
    property CarResponsable: string read GetCarResponsable write SetCarResponsable;
    property MaxCargaProfesor: Integer read GetMaxCargaProfesor write SetMaxCargaProfesor;
    property Comentarios: string read GetComentarios write SetComentarios;
    property Randomize: Boolean read GetRandomize write SetRandomize;
    property Seed1: Integer read GetSeed1 write SetSeed1;
    property Seed2: Integer read GetSeed2 write SetSeed2;
    property Seed3: Integer read GetSeed3 write SetSeed3;
    property Seed4: Integer read GetSeed4 write SetSeed4;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property CruceProfesor: Extended read GetCruceProfesor write SetCruceProfesor;
    property ProfesorFraccionamiento: Extended read GetProfesorFraccionamiento write SetProfesorFraccionamiento;
    property CruceAulaTipo: Extended read GetCruceAulaTipo write SetCruceAulaTipo;
    property HoraHueca: Extended read GetHoraHueca write SetHoraHueca;
    property SesionCortada: Extended read GetSesionCortada write SetSesionCortada;
    property MateriaNoDispersa: Extended read GetMateriaNoDispersa write SetMateriaNoDispersa;
    property PopulationSize: Integer read GetPopulationSize write SetPopulationSize;
    property MaxIteration: Integer read GetNumMaxGeneracion write SetNumMaxGeneracion;
    property CrossProb: Extended read GetProbCruzamiento write SetProbCruzamiento;
    property Mutation1Prob: Extended read GetMutation1Prob write SetMutation1Prob;
    property Mutation1Order: Integer read GetMutation1Order write SetMutation1Order;
    property Mutation2Prob: Extended read GetMutation2Prob write SetMutation2Prob;
    property RepairProb: Extended read GetRepairProb write SetRepairProb;
    property HorarioIni: string read GetHorarioIni write SetHorarioIni;
    property SharedDirectory: string read GetSharedDirectory write SetSharedDirectory;
    property PollinationFreq: Integer read SetPollinationFreq write SetRangoPolinizacion;
    property ApplyDoubleDownHill: Boolean read GetApplyDoubleDownHill write SetApplyDoubleDownHill;
  end;

implementation

uses
  Rand;

function TTTGConfig.GetNomColegio: string;
begin
   Result := Values['NomColegio'];
end;

procedure TTTGConfig.SetNomColegio(const Value: string);
begin
   Values['NomColegio'] := Value;
end;

function TTTGConfig.GetAnioLectivo: string;
begin
   Result := Values['AnioLectivo'];
end;

procedure TTTGConfig.SetAnioLectivo(const Value: string);
begin
   Values['AnioLectivo'] := Value;
end;

function TTTGConfig.GetNomAutoridad: string;
begin
   Result := Values['NomAutoridad'];
end;

procedure TTTGConfig.SetNomAutoridad(const Value: string);
begin
   Values['NomAutoridad'] := Value;
end;

function TTTGConfig.GetCarAutoridad: string;
begin
   Result := Values['CarAutoridad'];
end;

procedure TTTGConfig.SetCarAutoridad(const Value: string);
begin
   Values['CarAutoridad'] := Value;
end;

function TTTGConfig.GetNomResponsable: string;
begin
   Result := Values['NomResponsable'];
end;

procedure TTTGConfig.SetNomResponsable(const Value: string);
begin
   Values['NomResponsable'] := Value;
end;

function TTTGConfig.GetCarResponsable: string;
begin
   Result := Values['CarResponsable'];
end;

procedure TTTGConfig.SetCarResponsable(const Value: string);
begin
   Values['CarResponsable'] := Value;
end;

function TTTGConfig.GetMaxCargaProfesor: Integer;
begin
   Result := Integers['MaxCargaProfesor'];
end;

procedure TTTGConfig.SetMaxCargaProfesor(Value: Integer);
begin
   Integers['MaxCargaProfesor'] := Value;
end;

function TTTGConfig.GetComentarios: string;
begin
   Result := Texts['Comentarios'];
end;

procedure TTTGConfig.SetComentarios(const Value: string);
begin
  Texts['Comentarios'] := Value;
end;

function TTTGConfig.GetRandomize: Boolean;
begin
   Result := Booleans['Randomize'];
end;

procedure TTTGConfig.SetRandomize(Value: Boolean);
begin
  Booleans['Randomize'] := Value;
end;

function TTTGConfig.GetSeed1: Integer;
begin
  Result := Integers['Seed1'];
end;

procedure TTTGConfig.SetSeed1(Value: Integer);
begin
  Integers['Seed1'] := Value;
end;

function TTTGConfig.GetSeed2: Integer;
begin
  Result := Integers['Seed2'];
end;

procedure TTTGConfig.SetSeed2(Value: Integer);
begin
  Integers['Seed2'] := Value;
end;

function TTTGConfig.GetSeed3: Integer;
begin
  Result := Integers['Seed3'];
end;

procedure TTTGConfig.SetSeed3(Value: Integer);
begin
  Integers['Seed3'] := Value;
end;

function TTTGConfig.GetSeed4: Integer;
begin
  Result := Integers['Seed4'];
end;

procedure TTTGConfig.SetSeed4(Value: Integer);
begin
  Integers['Seed4'] := Value;
end;

function TTTGConfig.GetRefreshInterval: Integer;
begin
  Result := Integers['NumIteraciones'];
end;

procedure TTTGConfig.SetRefreshInterval(Value: Integer);
begin
  Integers['NumIteraciones'] := Value;
end;

function TTTGConfig.GetCruceProfesor: Extended;
begin
  Result := Floats['CruceProfesor'];
end;

procedure TTTGConfig.SetCruceProfesor(Value: Extended);
begin
  Floats['CruceProfesor'] := Value;
end;

function TTTGConfig.GetProfesorFraccionamiento: Extended;
begin
  Result := Floats['ProfesorFraccionamiento'];
end;

procedure TTTGConfig.SetProfesorFraccionamiento(Value: Extended);
begin
  Floats['ProfesorFraccionamiento'] := Value;
end;

function TTTGConfig.GetCruceAulaTipo: Extended;
begin
  Result := Floats['CruceAulaTipo'];
end;

procedure TTTGConfig.SetCruceAulaTipo(Value: Extended);
begin
  Floats['CruceAulaTipo'] := Value;
end;

function TTTGConfig.GetHoraHueca: Extended;
begin
  Result := Floats['HoraHueca'];
end;

procedure TTTGConfig.SetHoraHueca(Value: Extended);
begin
  Floats['HoraHueca'] := Value;
end;

function TTTGConfig.GetSesionCortada: Extended;
begin
  Result := Floats['SesionCortada'];
end;

procedure TTTGConfig.SetSesionCortada(Value: Extended);
begin
  Floats['SesionCortada'] := Value;
end;

function TTTGConfig.GetMateriaNoDispersa: Extended;
begin
  Result := Floats['MateriaNoDispersa'];
end;

procedure TTTGConfig.SetMateriaNoDispersa(Value: Extended);
begin
  Floats['MateriaNoDispersa'] := Value;
end;

function TTTGConfig.GetPopulationSize: Integer;
begin
  Result := Integers['TamPoblacion'];
end;

procedure TTTGConfig.SetPopulationSize(Value: Integer);
begin
  Integers['TamPoblacion'] := Value;
end;

function TTTGConfig.GetNumMaxGeneracion: Integer;
begin
  Result := Integers['NumMaxGeneracion'];
end;

procedure TTTGConfig.SetNumMaxGeneracion(Value: Integer);
begin
  Integers['NumMaxGeneracion'] := Value;
end;

function TTTGConfig.GetProbCruzamiento: Extended;
begin
  Result := Floats['ProbCruzamiento'];
end;

procedure TTTGConfig.SetProbCruzamiento(Value: Extended);
begin
  Floats['ProbCruzamiento'] := Value;
end;

function TTTGConfig.GetMutation1Prob: Extended;
begin
  Result := Floats['ProbMutacion1'];
end;

procedure TTTGConfig.SetMutation1Prob(Value: Extended);
begin
  Floats['ProbMutacion1'] := Value;
end;

function TTTGConfig.GetMutation1Order: Integer;
begin
  Result := Integers['OrdenMutacion1'];
end;

procedure TTTGConfig.SetMutation1Order(Value: Integer);
begin
  Integers['OrdenMutacion1'] := Value;
end;

function TTTGConfig.GetMutation2Prob: Extended;
begin
  Result := Floats['ProbMutacion2'];
end;

procedure TTTGConfig.SetMutation2Prob(Value: Extended);
begin
  Floats['ProbMutacion2'] := Value;
end;

function TTTGConfig.GetRepairProb: Extended;
begin
  Result := Floats['ProbReparacion'];
end;

procedure TTTGConfig.SetRepairProb(Value: Extended);
begin
  Floats['ProbReparacion'] := Value;
end;

function TTTGConfig.GetHorarioIni: string;
begin
  Result := Values['edtHorarioIni_Text'];
end;

procedure TTTGConfig.SetHorarioIni(const Value: string);
begin
  Values['edtHorarioIni_Text'] := Value;
end;

function TTTGConfig.GetSharedDirectory: string;
begin
  Result := Values['dedCompartir_Text'];
end;

procedure TTTGConfig.SetSharedDirectory(const Value: string);
begin
  Values['dedCompartir_Text'] := Value;
end;

function TTTGConfig.SetPollinationFreq: Integer;
begin
  Result := Integers['RangoPolinizacion'];
end;

procedure TTTGConfig.SetRangoPolinizacion(Value: Integer);
begin
  Integers['RangoPolinizacion'] := Value;
end;

function TTTGConfig.GetApplyDoubleDownHill: Boolean;
begin
  Result := Booleans['ApplyDoubleDownHill'];
end;

procedure TTTGConfig.SetApplyDoubleDownHill(Value: Boolean);
begin
  Booleans['ApplyDoubleDownHill'] := Value;
end;

procedure TTTGConfig.SetDefaults;
begin
  // Default configuration
  NomColegio := '';
  AnioLectivo := '';
  NomAutoridad := '';
  CarAutoridad := '';
  NomResponsable := '';
  CarResponsable := '';
  MaxCargaProfesor := 20;
  Comentarios := '';
  Randomize := True;
  Seed1 := 1;
  Seed2 := 1;
  Seed3 := 1;
  Seed4 := 1;
  RefreshInterval := 1;
  CruceProfesor := 200;
  ProfesorFraccionamiento := 50;
  CruceAulaTipo := 200;
  HoraHueca := 100;
  SesionCortada := 150;
  MateriaNoDispersa := 5;
  PopulationSize := 10;
  MaxIteration := 10000;
  CrossProb := 0.3;
  Mutation1Prob := 0.2;
  Mutation1Order := 3;
  Mutation2Prob := 0.2;
  RepairProb := 0.2;
  ApplyDoubleDownHill := False;
  HorarioIni := '';
  SharedDirectory := '';
  PollinationFreq := 1;
end;

procedure TTTGConfig.InitRandom;
begin
  if Randomize then
    srandom
  else
    setseeds(Seed1, Seed2, Seed3, Seed4);
end;

end.

