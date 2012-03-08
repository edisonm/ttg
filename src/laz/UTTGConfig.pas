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
    function GetNameAuthority: string;
    procedure SetNameAuthority(const Value: string);
    function GetComments: string;
    procedure SetComments(const Value: string);
    function GetUseCustomSeed: Boolean;
    procedure SetUseCustomSeed(Value: Boolean);
    function GetSeed: Integer;
    procedure SetSeed(Value: Integer);
    function GetRefreshInterval: Integer;
    procedure SetRefreshInterval(Value: Integer);
    function GetClashActivity: Integer;
    procedure SetClashActivity(Value: Integer);
    function GetBreakTimetableResource: Integer;
    procedure SetBreakTimetableResource(Value: Integer);
    function GetBrokenSession: Integer;
    procedure SetBrokenSession(Value: Integer);
    function GetNonScatteredActivity: Integer;
    procedure SetNonScatteredActivity(Value: Integer);
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
    property NameAuthority: string read GetNameAuthority write SetNameAuthority;
    property Comments: string read GetComments write SetComments;
    property UseCustomSeed: Boolean read GetUseCustomSeed write SetUseCustomSeed;
    property Seed: Integer read GetSeed write SetSeed;
    property RefreshInterval: Integer read GetRefreshInterval write SetRefreshInterval;
    property ClashActivity: Integer read GetClashActivity write SetClashActivity;
    property BreakTimetableResource: Integer read GetBreakTimetableResource write SetBreakTimetableResource;
    property BrokenSession: Integer read GetBrokenSession write SetBrokenSession;
    property NonScatteredActivity: Integer read GetNonScatteredActivity write SetNonScatteredActivity;
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

function TTTGConfig.GetNameAuthority: string;
begin
   Result := Values['NameAuthority'];
end;

procedure TTTGConfig.SetNameAuthority(const Value: string);
begin
   Values['NameAuthority'] := Value;
end;

function TTTGConfig.GetComments: string;
begin
   Result := Texts['Comments'];
end;

procedure TTTGConfig.SetComments(const Value: string);
begin
  Texts['Comments'] := Value;
end;

function TTTGConfig.GetUseCustomSeed: Boolean;
begin
   Result := Booleans['UseCustomSeed'];
end;

procedure TTTGConfig.SetUseCustomSeed(Value: Boolean);
begin
  Booleans['UseCustomSeed'] := Value;
end;

function TTTGConfig.GetSeed: Integer;
begin
  Result := Integers['Seed'];
end;

procedure TTTGConfig.SetSeed(Value: Integer);
begin
  Integers['Seed'] := Value;
end;

function TTTGConfig.GetRefreshInterval: Integer;
begin
  Result := Integers['NumIterations'];
end;

procedure TTTGConfig.SetRefreshInterval(Value: Integer);
begin
  Integers['NumIterations'] := Value;
end;

function TTTGConfig.GetClashActivity: Integer;
begin
  Result := Integers['ClashActivity'];
end;

procedure TTTGConfig.SetClashActivity(Value: Integer);
begin
  Integers['ClashActivity'] := Value;
end;

function TTTGConfig.GetBreakTimetableResource: Integer;
begin
  Result := Integers['BreakTimetableResource'];
end;

procedure TTTGConfig.SetBreakTimetableResource(Value: Integer);
begin
  Integers['BreakTimetableResource'] := Value;
end;

function TTTGConfig.GetBrokenSession: Integer;
begin
  Result := Integers['BrokenSession'];
end;

procedure TTTGConfig.SetBrokenSession(Value: Integer);
begin
  Integers['BrokenSession'] := Value;
end;

function TTTGConfig.GetNonScatteredActivity: Integer;
begin
  Result := Integers['NonScatteredActivity'];
end;

procedure TTTGConfig.SetNonScatteredActivity(Value: Integer);
begin
  Integers['NonScatteredActivity'] := Value;
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
  NameAuthority := '';
  Comments := '';
  UseCustomSeed := True;
  Self.Seed := 1;
  RefreshInterval := 1;
  ClashActivity := 200;
  BreakTimetableResource := 50;
  BrokenSession := 150;
  NonScatteredActivity := 5;
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
  if UseCustomSeed then
    RandSeed := Seed
  else
    System.Randomize;
end;

end.

