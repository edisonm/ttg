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
    function GetNaAuthority: string;
    procedure SetNaAuthority(const Value: string);
    function GetPosAuthority: string;
    procedure SetPosAuthority(const Value: string);
    function GetNaResponsible: string;
    procedure SetNaResponsible(const Value: string);
    function GetPosResponsible: string;
    procedure SetPosResponsible(const Value: string);
    function GetMaxTeacherWorkLoad: Integer;
    procedure SetMaxTeacherWorkLoad(Value: Integer);
    function GetComments: string;
    procedure SetComments(const Value: string);
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
    function GetBreakTimeTableTeacher: Integer;
    procedure SetBreakTimeTableTeacher(Value: Integer);
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
    function GetCrossProb: Double;
    procedure SetCrossProb(Value: Double);
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
    property NaAuthority: string read GetNaAuthority write SetNaAuthority;
    property PosAuthority: string read GetPosAuthority write SetPosAuthority;
    property NaResponsible: string read GetNaResponsible write SetNaResponsible;
    property PosResponsible: string read GetPosResponsible write SetPosResponsible;
    property MaxTeacherWorkLoad: Integer read GetMaxTeacherWorkLoad write SetMaxTeacherWorkLoad;
    property Comments: string read GetComments write SetComments;
    property Randomize: Boolean read GetRandomize write SetRandomize;
    property Seed: Integer read GetSeed write SetSeed;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property ClashTeacher: Integer read GetClashTeacher write SetClashTeacher;
    property ClashSubject: Integer read GetClashSubject write SetClashSubject;
    property BreakTimeTableTeacher: Integer read GetBreakTimeTableTeacher write SetBreakTimeTableTeacher;
    property ClashRoomType: Integer read GetClashRoomType write SetClashRoomType;
    property OutOfPositionEmptyHour: Integer read GetOutOfPositionEmptyHour write SetOutOfPositionEmptyHour;
    property BrokenSession: Integer read GetBrokenSession write SetBrokenSession;
    property NonScatteredSubject: Integer read GetNonScatteredSubject write SetNonScatteredSubject;
    property PopulationSize: Integer read GetPopulationSize write SetPopulationSize;
    property MaxIteration: Integer read GetMaxIteration write SetMaxIteration;
    property CrossProb: Double read GetCrossProb write SetCrossProb;
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

function TTTGConfig.GetNaAuthority: string;
begin
   Result := Values['NaAuthority'];
end;

procedure TTTGConfig.SetNaAuthority(const Value: string);
begin
   Values['NaAuthority'] := Value;
end;

function TTTGConfig.GetPosAuthority: string;
begin
   Result := Values['PosAuthority'];
end;

procedure TTTGConfig.SetPosAuthority(const Value: string);
begin
   Values['PosAuthority'] := Value;
end;

function TTTGConfig.GetNaResponsible: string;
begin
   Result := Values['NaResponsible'];
end;

procedure TTTGConfig.SetNaResponsible(const Value: string);
begin
   Values['NaResponsible'] := Value;
end;

function TTTGConfig.GetPosResponsible: string;
begin
   Result := Values['PosResponsible'];
end;

procedure TTTGConfig.SetPosResponsible(const Value: string);
begin
   Values['PosResponsible'] := Value;
end;

function TTTGConfig.GetMaxTeacherWorkLoad: Integer;
begin
   Result := Integers['MaxTeacherWorkLoad'];
end;

procedure TTTGConfig.SetMaxTeacherWorkLoad(Value: Integer);
begin
   Integers['MaxTeacherWorkLoad'] := Value;
end;

function TTTGConfig.GetComments: string;
begin
   Result := Texts['Comments'];
end;

procedure TTTGConfig.SetComments(const Value: string);
begin
  Texts['Comments'] := Value;
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
  Result := Integers['NumIterations'];
end;

procedure TTTGConfig.SetRefreshInterval(Value: Integer);
begin
  Integers['NumIterations'] := Value;
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

function TTTGConfig.GetBreakTimeTableTeacher: Integer;
begin
  Result := Integers['BreakTimeTableTeacher'];
end;

procedure TTTGConfig.SetBreakTimeTableTeacher(Value: Integer);
begin
  Integers['BreakTimeTableTeacher'] := Value;
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
  Result := Integers['EmptyHour'];
end;

procedure TTTGConfig.SetOutOfPositionEmptyHour(Value: Integer);
begin
  Integers['EmptyHour'] := Value;
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
  Result := Integers['PopulationSize'];
end;

procedure TTTGConfig.SetPopulationSize(Value: Integer);
begin
  Integers['PopulationSize'] := Value;
end;

function TTTGConfig.GetMaxIteration: Integer;
begin
  Result := Integers['MaxIteration'];
end;

procedure TTTGConfig.SetMaxIteration(Value: Integer);
begin
  Integers['MaxIteration'] := Value;
end;

function TTTGConfig.GetCrossProb: Double;
begin
  Result := Floats['CrossProb'];
end;

procedure TTTGConfig.SetCrossProb(Value: Double);
begin
  Floats['CrossProb'] := Value;
end;

function TTTGConfig.GetMutation1Prob: Double;
begin
  Result := Floats['MutationProb1'];
end;

procedure TTTGConfig.SetMutation1Prob(Value: Double);
begin
  Floats['MutationProb1'] := Value;
end;

function TTTGConfig.GetRepairProb: Double;
begin
  Result := Floats['RepairProb'];
end;

procedure TTTGConfig.SetRepairProb(Value: Double);
begin
  Floats['RepairProb'] := Value;
end;

function TTTGConfig.GetTimeTableIni: string;
begin
  Result := Values['TimeTableIni'];
end;

procedure TTTGConfig.SetTimeTableIni(const Value: string);
begin
  Values['TimeTableIni'] := Value;
end;

function TTTGConfig.GetSharedDirectory: string;
begin
  Result := Values['SharedDirectory'];
end;

procedure TTTGConfig.SetSharedDirectory(const Value: string);
begin
  Values['SharedDirectory'] := Value;
end;

function TTTGConfig.GetPollinationProb: Double;
begin
  Result := Floats['PollinationProb'];
end;

procedure TTTGConfig.SetPollinationProb(Value: Double);
begin
  Floats['PollinationProb'] := Value;
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
  NaAuthority := '';
  PosAuthority := '';
  NaResponsible := '';
  PosResponsible := '';
  MaxTeacherWorkLoad := 20;
  Comments := '';
  Randomize := True;
  Self.Seed := 1;
  RefreshInterval := 1;
  ClashTeacher := 200;
  ClashSubject := 200;
  BreakTimeTableTeacher := 50;
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

