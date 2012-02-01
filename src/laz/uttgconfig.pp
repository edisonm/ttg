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
    function GetNaInstitution: string;
    procedure SetBookmarks(const AValue: string);
    procedure SetNaInstitution(const Value: string);
    function GetAnioLectivo: string;
    procedure SetAnioLectivo(const Value: string);
    function GetNaAutoridad: string;
    procedure SetNaAutoridad(const Value: string);
    function GetCarAutoridad: string;
    procedure SetCarAutoridad(const Value: string);
    function GetNaResponsable: string;
    procedure SetNaResponsable(const Value: string);
    function GetCarResponsable: string;
    procedure SetCarResponsable(const Value: string);
    function GetMaxCargaTeacher: Integer;
    procedure SetMaxCargaTeacher(Value: Integer);
    function GetComentarios: string;
    procedure SetComentarios(const Value: string);
    function GetRandomize: Boolean;
    procedure SetRandomize(Value: Boolean);
    function GetSeed: Integer;
    procedure SetSeed(Value: Integer);
    function GetRefreshInterval: Integer;
    procedure SetRefreshInterval(Value: Integer);
    function GetClashTeacher: Integer;
    procedure SetClashTeacher(Value: Integer);
    function GetClashSubject: Integer;
    procedure SetClashSubject(Value: Integer);
    function GetTeacherFraccionamiento: Integer;
    procedure SetTeacherFraccionamiento(Value: Integer);
    function GetClashRoomType: Integer;
    procedure SetClashRoomType(Value: Integer);
    function GetOutOfPositionEmptyHour: Integer;
    procedure SetOutOfPositionEmptyHour(Value: Integer);
    function GetBrokenSession: Integer;
    procedure SetBrokenSession(Value: Integer);
    function GetNonScatteredSubject: Integer;
    procedure SetNonScatteredSubject(Value: Integer);
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
    function GetTimeTableIni: string;
    procedure SetTimeTableIni(const Value: string);
    function GetSharedDirectory: string;
    procedure SetSharedDirectory(const Value: string);
    function GetPollinationProb: Double;
    procedure SetPollinationProb(Value: Double);
    function GetApplyDoubleDownHill: Boolean;
    procedure SetApplyDoubleDownHill(Value: Boolean);
  public
    procedure SetDefaults;
    procedure InitRandom;
    property NaInstitution: string read GetNaInstitution write SetNaInstitution;
    property AnioLectivo: string read GetAnioLectivo write SetAnioLectivo;
    property NaAutoridad: string read GetNaAutoridad write SetNaAutoridad;
    property CarAutoridad: string read GetCarAutoridad write SetCarAutoridad;
    property NaResponsable: string read GetNaResponsable write SetNaResponsable;
    property CarResponsable: string read GetCarResponsable write SetCarResponsable;
    property MaxCargaTeacher: Integer read GetMaxCargaTeacher write SetMaxCargaTeacher;
    property Comentarios: string read GetComentarios write SetComentarios;
    property Randomize: Boolean read GetRandomize write SetRandomize;
    property Seed: Integer read GetSeed write SetSeed;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property ClashTeacher: Integer read GetClashTeacher write SetClashTeacher;
    property ClashSubject: Integer read GetClashSubject write SetClashSubject;
    property TeacherFraccionamiento: Integer read GetTeacherFraccionamiento write SetTeacherFraccionamiento;
    property ClashRoomType: Integer read GetClashRoomType write SetClashRoomType;
    property OutOfPositionEmptyHour: Integer read GetOutOfPositionEmptyHour write SetOutOfPositionEmptyHour;
    property BrokenSession: Integer read GetBrokenSession write SetBrokenSession;
    property NonScatteredSubject: Integer read GetNonScatteredSubject write SetNonScatteredSubject;
    property PopulationSize: Integer read GetPopulationSize write SetPopulationSize;
    property MaxIteration: Integer read GetMaxIteration write SetMaxIteration;
    property CrossProb: Double read GetProbCruzamiento write SetProbCruzamiento;
    property MutationProb: Double read GetMutation1Prob write SetMutation1Prob;
    property RepairProb: Double read GetRepairProb write SetRepairProb;
    property TimeTableIni: string read GetTimeTableIni write SetTimeTableIni;
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

function TTTGConfig.GetNaInstitution: string;
begin
   Result := Values['NaInstitution'];
end;

procedure TTTGConfig.SetBookmarks(const AValue: string);
begin
  Values['Bookmarks'] := AValue;
end;

procedure TTTGConfig.SetNaInstitution(const Value: string);
begin
   Values['NaInstitution'] := Value;
end;

function TTTGConfig.GetAnioLectivo: string;
begin
   Result := Values['AnioLectivo'];
end;

procedure TTTGConfig.SetAnioLectivo(const Value: string);
begin
   Values['AnioLectivo'] := Value;
end;

function TTTGConfig.GetNaAutoridad: string;
begin
   Result := Values['NaAutoridad'];
end;

procedure TTTGConfig.SetNaAutoridad(const Value: string);
begin
   Values['NaAutoridad'] := Value;
end;

function TTTGConfig.GetCarAutoridad: string;
begin
   Result := Values['CarAutoridad'];
end;

procedure TTTGConfig.SetCarAutoridad(const Value: string);
begin
   Values['CarAutoridad'] := Value;
end;

function TTTGConfig.GetNaResponsable: string;
begin
   Result := Values['NaResponsable'];
end;

procedure TTTGConfig.SetNaResponsable(const Value: string);
begin
   Values['NaResponsable'] := Value;
end;

function TTTGConfig.GetCarResponsable: string;
begin
   Result := Values['CarResponsable'];
end;

procedure TTTGConfig.SetCarResponsable(const Value: string);
begin
   Values['CarResponsable'] := Value;
end;

function TTTGConfig.GetMaxCargaTeacher: Integer;
begin
   Result := Integers['MaxCargaTeacher'];
end;

procedure TTTGConfig.SetMaxCargaTeacher(Value: Integer);
begin
   Integers['MaxCargaTeacher'] := Value;
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

function TTTGConfig.GetClashTeacher: Integer;
begin
  Result := Integers['ClashTeacher'];
end;

procedure TTTGConfig.SetClashTeacher(Value: Integer);
begin
  Integers['ClashTeacher'] := Value;
end;

function TTTGConfig.GetClashSubject: Integer;
begin
  Result := Integers['ClashSubject'];
end;

procedure TTTGConfig.SetClashSubject(Value: Integer);
begin
  Integers['ClashSubject'] := Value;
end;

function TTTGConfig.GetTeacherFraccionamiento: Integer;
begin
  Result := Integers['TeacherFraccionamiento'];
end;

procedure TTTGConfig.SetTeacherFraccionamiento(Value: Integer);
begin
  Integers['TeacherFraccionamiento'] := Value;
end;

function TTTGConfig.GetClashRoomType: Integer;
begin
  Result := Integers['ClashRoomType'];
end;

procedure TTTGConfig.SetClashRoomType(Value: Integer);
begin
  Integers['ClashRoomType'] := Value;
end;

function TTTGConfig.GetOutOfPositionEmptyHour: Integer;
begin
  Result := Integers['HourHueca'];
end;

procedure TTTGConfig.SetOutOfPositionEmptyHour(Value: Integer);
begin
  Integers['HourHueca'] := Value;
end;

function TTTGConfig.GetBrokenSession: Integer;
begin
  Result := Integers['BrokenSession'];
end;

procedure TTTGConfig.SetBrokenSession(Value: Integer);
begin
  Integers['BrokenSession'] := Value;
end;

function TTTGConfig.GetNonScatteredSubject: Integer;
begin
  Result := Integers['NonScatteredSubject'];
end;

procedure TTTGConfig.SetNonScatteredSubject(Value: Integer);
begin
  Integers['NonScatteredSubject'] := Value;
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

function TTTGConfig.GetTimeTableIni: string;
begin
  Result := Values['edtTimeTableIni_Text'];
end;

procedure TTTGConfig.SetTimeTableIni(const Value: string);
begin
  Values['edtTimeTableIni_Text'] := Value;
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
  NaInstitution := '';
  AnioLectivo := '';
  NaAutoridad := '';
  CarAutoridad := '';
  NaResponsable := '';
  CarResponsable := '';
  MaxCargaTeacher := 20;
  Comentarios := '';
  Randomize := True;
  Self.Seed := 1;
  RefreshInterval := 1;
  ClashTeacher := 200;
  ClashSubject := 200;
  TeacherFraccionamiento := 50;
  ClashRoomType := 200;
  OutOfPositionEmptyHour := 100;
  BrokenSession := 150;
  NonScatteredSubject := 5;
  PopulationSize := 10;
  MaxIteration := 10000;
  CrossProb := 0.3;
  MutationProb := 0.2;
  RepairProb := 0.2;
  Bookmarks := '1,2';
  ApplyDoubleDownHill := False;
  TimeTableIni := '';
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

