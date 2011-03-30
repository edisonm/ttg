{ -*- mode: Delphi -*- }
unit UTTGConfig;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, UConfigStorage;

type

  { TTTGConfig }

  TTTGConfig = class(TConfigStorage)
  private
    function GetBookmarks: string;
    function GetNomColegio: string;
    procedure SetBookmarks(const AValue: string);
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
    function GetSeed: Integer;
    procedure SetSeed(Value: Integer);
    function GetRefreshInterval: Integer;
    procedure SetRefreshInterval(Value: Integer);
    function GetCruceProfesor: Integer;
    procedure SetCruceProfesor(Value: Integer);
    function GetCruceMateria: Integer;
    procedure SetCruceMateria(Value: Integer);
    function GetProfesorFraccionamiento: Integer;
    procedure SetProfesorFraccionamiento(Value: Integer);
    function GetCruceAulaTipo: Integer;
    procedure SetCruceAulaTipo(Value: Integer);
    function GetHoraHuecaDesubicada: Integer;
    procedure SetHoraHuecaDesubicada(Value: Integer);
    function GetSesionCortada: Integer;
    procedure SetSesionCortada(Value: Integer);
    function GetMateriaNoDispersa: Integer;
    procedure SetMateriaNoDispersa(Value: Integer);
    function GetPopulationSize: Integer;
    procedure SetPopulationSize(Value: Integer);
    function GetMaxIteration: Integer;
    procedure SetMaxIteration(Value: Integer);
    function GetProbCruzamiento: Double;
    procedure SetProbCruzamiento(Value: Double);
    function GetMutation1Prob: Double;
    procedure SetMutation1Prob(Value: Double);
    function GetRepairProb: Double;
    procedure SetRepairProb(Value: Double);
    function GetHorarioIni: string;
    procedure SetHorarioIni(const Value: string);
    function GetSharedDirectory: string;
    procedure SetSharedDirectory(const Value: string);
    function GetPollinationProb: Double;
    procedure SetPollinationProb(Value: Double);
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
    property Seed: Integer read GetSeed write SetSeed;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property CruceProfesor: Integer read GetCruceProfesor write SetCruceProfesor;
    property CruceMateria: Integer read GetCruceMateria write SetCruceMateria;
    property ProfesorFraccionamiento: Integer read GetProfesorFraccionamiento write SetProfesorFraccionamiento;
    property CruceAulaTipo: Integer read GetCruceAulaTipo write SetCruceAulaTipo;
    property HoraHuecaDesubicada: Integer read GetHoraHuecaDesubicada write SetHoraHuecaDesubicada;
    property SesionCortada: Integer read GetSesionCortada write SetSesionCortada;
    property MateriaNoDispersa: Integer read GetMateriaNoDispersa write SetMateriaNoDispersa;
    property PopulationSize: Integer read GetPopulationSize write SetPopulationSize;
    property MaxIteration: Integer read GetMaxIteration write SetMaxIteration;
    property CrossProb: Double read GetProbCruzamiento write SetProbCruzamiento;
    property MutationProb: Double read GetMutation1Prob write SetMutation1Prob;
    property RepairProb: Double read GetRepairProb write SetRepairProb;
    property HorarioIni: string read GetHorarioIni write SetHorarioIni;
    property SharedDirectory: string read GetSharedDirectory write SetSharedDirectory;
    property PollinationProb: Double read GetPollinationProb write SetPollinationProb;
    property ApplyDoubleDownHill: Boolean read GetApplyDoubleDownHill write SetApplyDoubleDownHill;
    property Bookmarks: string read GetBookmarks write SetBookmarks;
  end;

implementation

function TTTGConfig.GetBookmarks: string;
begin
  Result := Values['Bookmarks'];
end;

function TTTGConfig.GetNomColegio: string;
begin
   Result := Values['NomColegio'];
end;

procedure TTTGConfig.SetBookmarks(const AValue: string);
begin
  Values['Bookmarks'] := AValue;
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

function TTTGConfig.GetSeed: Integer;
begin
  Result := Integers['Seed1'];
end;

procedure TTTGConfig.SetSeed(Value: Integer);
begin
  Integers['Seed1'] := Value;
end;

function TTTGConfig.GetRefreshInterval: Integer;
begin
  Result := Integers['NumIteraciones'];
end;

procedure TTTGConfig.SetRefreshInterval(Value: Integer);
begin
  Integers['NumIteraciones'] := Value;
end;

function TTTGConfig.GetCruceProfesor: Integer;
begin
  Result := Integers['CruceProfesor'];
end;

procedure TTTGConfig.SetCruceProfesor(Value: Integer);
begin
  Integers['CruceProfesor'] := Value;
end;

function TTTGConfig.GetCruceMateria: Integer;
begin
  Result := Integers['CruceMateria'];
end;

procedure TTTGConfig.SetCruceMateria(Value: Integer);
begin
  Integers['CruceMateria'] := Value;
end;

function TTTGConfig.GetProfesorFraccionamiento: Integer;
begin
  Result := Integers['ProfesorFraccionamiento'];
end;

procedure TTTGConfig.SetProfesorFraccionamiento(Value: Integer);
begin
  Integers['ProfesorFraccionamiento'] := Value;
end;

function TTTGConfig.GetCruceAulaTipo: Integer;
begin
  Result := Integers['CruceAulaTipo'];
end;

procedure TTTGConfig.SetCruceAulaTipo(Value: Integer);
begin
  Integers['CruceAulaTipo'] := Value;
end;

function TTTGConfig.GetHoraHuecaDesubicada: Integer;
begin
  Result := Integers['HoraHueca'];
end;

procedure TTTGConfig.SetHoraHuecaDesubicada(Value: Integer);
begin
  Integers['HoraHueca'] := Value;
end;

function TTTGConfig.GetSesionCortada: Integer;
begin
  Result := Integers['SesionCortada'];
end;

procedure TTTGConfig.SetSesionCortada(Value: Integer);
begin
  Integers['SesionCortada'] := Value;
end;

function TTTGConfig.GetMateriaNoDispersa: Integer;
begin
  Result := Integers['MateriaNoDispersa'];
end;

procedure TTTGConfig.SetMateriaNoDispersa(Value: Integer);
begin
  Integers['MateriaNoDispersa'] := Value;
end;

function TTTGConfig.GetPopulationSize: Integer;
begin
  Result := Integers['TamPoblacion'];
end;

procedure TTTGConfig.SetPopulationSize(Value: Integer);
begin
  Integers['TamPoblacion'] := Value;
end;

function TTTGConfig.GetMaxIteration: Integer;
begin
  Result := Integers['NumMaxGeneracion'];
end;

procedure TTTGConfig.SetMaxIteration(Value: Integer);
begin
  Integers['NumMaxGeneracion'] := Value;
end;

function TTTGConfig.GetProbCruzamiento: Double;
begin
  Result := Floats['ProbCruzamiento'];
end;

procedure TTTGConfig.SetProbCruzamiento(Value: Double);
begin
  Floats['ProbCruzamiento'] := Value;
end;

function TTTGConfig.GetMutation1Prob: Double;
begin
  Result := Floats['ProbMutacion1'];
end;

procedure TTTGConfig.SetMutation1Prob(Value: Double);
begin
  Floats['ProbMutacion1'] := Value;
end;

function TTTGConfig.GetRepairProb: Double;
begin
  Result := Floats['ProbReparacion'];
end;

procedure TTTGConfig.SetRepairProb(Value: Double);
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

function TTTGConfig.GetPollinationProb: Double;
begin
  Result := Floats['RangoPolinizacion'];
end;

procedure TTTGConfig.SetPollinationProb(Value: Double);
begin
  Floats['RangoPolinizacion'] := Value;
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
  Self.Seed := 1;
  RefreshInterval := 1;
  CruceProfesor := 200;
  CruceMateria := 200;
  ProfesorFraccionamiento := 50;
  CruceAulaTipo := 200;
  HoraHuecaDesubicada := 100;
  SesionCortada := 150;
  MateriaNoDispersa := 5;
  PopulationSize := 10;
  MaxIteration := 10000;
  CrossProb := 0.3;
  MutationProb := 0.2;
  RepairProb := 0.2;
  Bookmarks := '1,2';
  ApplyDoubleDownHill := False;
  HorarioIni := '';
  SharedDirectory := GetTempDir;
  PollinationProb := 0.1;
end;

procedure TTTGConfig.InitRandom;
begin
  if Randomize then
    System.Randomize
  else
    RandSeed := Seed;
end;

end.

