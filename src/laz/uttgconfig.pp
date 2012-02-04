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
    function GetSchoolYear: string;
    procedure SetSchoolYear(const Value: string);
    function GetNameAuthority: string;
    procedure SetNameAuthority(const Value: string);
    function GetPositionAuthority: string;
    procedure SetPositionAuthority(const Value: string);
    function GetNameResponsible: string;
    procedure SetNameResponsible(const Value: string);
    function GetPositionResponsible: string;
    procedure SetPositionResponsible(const Value: string);
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
    function GetBreakTimetableTeacher: Integer;
    procedure SetBreakTimetableTeacher(Value: Integer);
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
    function GetCrossProbability: Double;
    procedure SetCrossProbability(Value: Double);
    function GetMutationProbability: Double;
    procedure SetMutationProbability(Value: Double);
    function GetReparationProbability: Double;
    procedure SetReparationProbability(Value: Double);
    function GetInitialTimetables: string;
    procedure SetInitialTimetables(const Value: string);
    function GetSharedDirectory: string;
    procedure SetSharedDirectory(const Value: string);
    function GetPollinationProbability: Double;
    procedure SetPollinationProbability(Value: Double);
    function GetApplyDoubleDownHill: Boolean;
    procedure SetApplyDoubleDownHill(Value: Boolean);
  public
    procedure SetDefaults;
    procedure InitRandom;
    property NaInstitution: string read GetNaInstitution write SetNaInstitution;
    property SchoolYear: string read GetSchoolYear write SetSchoolYear;
    property NameAuthority: string read GetNameAuthority write SetNameAuthority;
    property PositionAuthority: string read GetPositionAuthority write SetPositionAuthority;
    property NameResponsible: string read GetNameResponsible write SetNameResponsible;
    property PositionResponsible: string read GetPositionResponsible write SetPositionResponsible;
    property MaxTeacherWorkLoad: Integer read GetMaxTeacherWorkLoad write SetMaxTeacherWorkLoad;
    property Comments: string read GetComments write SetComments;
    property Randomize: Boolean read GetRandomize write SetRandomize;
    property Seed: Integer read GetSeed write SetSeed;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property ClashTeacher: Integer read GetClashTeacher write SetClashTeacher;
    property ClashSubject: Integer read GetClashSubject write SetClashSubject;
    property BreakTimetableTeacher: Integer read GetBreakTimetableTeacher write SetBreakTimetableTeacher;
    property ClashRoomType: Integer read GetClashRoomType write SetClashRoomType;
    property OutOfPositionEmptyHour: Integer read GetOutOfPositionEmptyHour write SetOutOfPositionEmptyHour;
    property BrokenSession: Integer read GetBrokenSession write SetBrokenSession;
    property NonScatteredSubject: Integer read GetNonScatteredSubject write SetNonScatteredSubject;
    property PopulationSize: Integer read GetPopulationSize write SetPopulationSize;
    property MaxIteration: Integer read GetMaxIteration write SetMaxIteration;
    property CrossProbability: Double read GetCrossProbability write SetCrossProbability;
    property MutationProbability: Double read GetMutationProbability write SetMutationProbability;
    property ReparationProbability: Double read GetReparationProbability write SetReparationProbability;
    property InitialTimetables: string read GetInitialTimetables write SetInitialTimetables;
    property SharedDirectory: string read GetSharedDirectory write SetSharedDirectory;
    property PollinationProbability: Double read GetPollinationProbability write SetPollinationProbability;
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

function TTTGConfig.GetSchoolYear: string;
begin
   Result := Values['SchoolYear'];
end;

procedure TTTGConfig.SetSchoolYear(const Value: string);
begin
   Values['SchoolYear'] := Value;
end;

function TTTGConfig.GetNameAuthority: string;
begin
   Result := Values['NameAuthority'];
end;

procedure TTTGConfig.SetNameAuthority(const Value: string);
begin
   Values['NameAuthority'] := Value;
end;

function TTTGConfig.GetPositionAuthority: string;
begin
   Result := Values['PositionAuthority'];
end;

procedure TTTGConfig.SetPositionAuthority(const Value: string);
begin
   Values['PositionAuthority'] := Value;
end;

function TTTGConfig.GetNameResponsible: string;
begin
   Result := Values['NameResponsible'];
end;

procedure TTTGConfig.SetNameResponsible(const Value: string);
begin
   Values['NameResponsible'] := Value;
end;

function TTTGConfig.GetPositionResponsible: string;
begin
   Result := Values['PositionResponsible'];
end;

procedure TTTGConfig.SetPositionResponsible(const Value: string);
begin
   Values['PositionResponsible'] := Value;
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

function TTTGConfig.GetBreakTimetableTeacher: Integer;
begin
  Result := Integers['BreakTimetableTeacher'];
end;

procedure TTTGConfig.SetBreakTimetableTeacher(Value: Integer);
begin
  Integers['BreakTimetableTeacher'] := Value;
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

function TTTGConfig.GetCrossProbability: Double;
begin
  Result := Floats['CrossProbability'];
end;

procedure TTTGConfig.SetCrossProbability(Value: Double);
begin
  Floats['CrossProbability'] := Value;
end;

function TTTGConfig.GetMutationProbability: Double;
begin
  Result := Floats['MutationProbability1'];
end;

procedure TTTGConfig.SetMutationProbability(Value: Double);
begin
  Floats['MutationProbability1'] := Value;
end;

function TTTGConfig.GetReparationProbability: Double;
begin
  Result := Floats['ReparationProbability'];
end;

procedure TTTGConfig.SetReparationProbability(Value: Double);
begin
  Floats['ReparationProbability'] := Value;
end;

function TTTGConfig.GetInitialTimetables: string;
begin
  Result := Values['InitialTimetables'];
end;

procedure TTTGConfig.SetInitialTimetables(const Value: string);
begin
  Values['InitialTimetables'] := Value;
end;

function TTTGConfig.GetSharedDirectory: string;
begin
  Result := Values['SharedDirectory'];
end;

procedure TTTGConfig.SetSharedDirectory(const Value: string);
begin
  Values['SharedDirectory'] := Value;
end;

function TTTGConfig.GetPollinationProbability: Double;
begin
  Result := Floats['PollinationProbability'];
end;

procedure TTTGConfig.SetPollinationProbability(Value: Double);
begin
  Floats['PollinationProbability'] := Value;
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
  SchoolYear := '';
  NameAuthority := '';
  PositionAuthority := '';
  NameResponsible := '';
  PositionResponsible := '';
  MaxTeacherWorkLoad := 20;
  Comments := '';
  Randomize := True;
  Self.Seed := 1;
  RefreshInterval := 1;
  ClashTeacher := 200;
  ClashSubject := 200;
  BreakTimetableTeacher := 50;
  ClashRoomType := 200;
  OutOfPositionEmptyHour := 100;
  BrokenSession := 150;
  NonScatteredSubject := 5;
  PopulationSize := 10;
  MaxIteration := 10000;
  CrossProbability := 0.3;
  MutationProbability := 0.2;
  ReparationProbability := 0.2;
  Bookmarks := '1,2';
  ApplyDoubleDownHill := False;
  InitialTimetables := '';
  SharedDirectory := GetTempDir;
  PollinationProbability := 0.1;
end;

procedure TTTGConfig.InitRandom;
begin
  if Randomize then
    System.Randomize
  else
    RandSeed := Seed;
end;

end.

