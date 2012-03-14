{ -*- mode: Delphi -*- }
unit UModel;

{$I ttg.inc}

interface

uses
  Classes, SysUtils; 

type

  TModel = class;
  TIndividual = class;

  { TBookmark }

  TBookmark = class
  private
    FIndividual: TIndividual;
  protected
    FPosition: Integer;
    FOffset: Integer;
    FMaxPosition: Integer;
    function GetProgress: Integer; virtual;
    function GetMax: Integer; virtual;
    function GetMaxPosition: Integer; virtual;
    property Individual: TIndividual read FIndividual;
  public
    constructor Create(AIndividual: TIndividual); overload;
    procedure First; virtual;
    procedure Next; virtual;
    procedure Rewind; virtual;
    function Move: Integer; virtual; abstract;
    function Undo: Integer; virtual; abstract;
    function Eof: Boolean; virtual;
    function Bof: Boolean; virtual; abstract;
    property Progress: Integer read GetProgress;
    property MaxPosition: Integer read FMaxPosition;
    property Max: Integer read GetMax;
  end;

  TBookmarkArray = array of TBookmark;

  { TIndividual }

  TIndividual = class
  protected
    FModel: TModel;
    function GetElitistValues(Index: Integer): Integer; virtual; abstract;
    function GetValue: Integer; virtual; abstract;
  public
    procedure ReportValues(AReport: TStrings); virtual; abstract;
    procedure Assign(AIndividual: TIndividual); virtual;
    procedure Cross(AIndividual: TIndividual); virtual; abstract;
    procedure LoadFromDataModule(Index: Integer); virtual; abstract;
    procedure Mutate; virtual; abstract;
    procedure Update; virtual; abstract;
    procedure MakeRandom; virtual; abstract;
    function NewBookmark: TBookmark; virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    procedure LoadFromStream(Stream: TStream); virtual; abstract;
    procedure SaveToDataModule(IdTimetable: Integer; TimeIni,
      TimeEnd: TDateTime; Summary: TStrings); virtual; abstract;
    property ElitistValues[Index: Integer]: Integer read GetElitistValues;
    property Model: TModel read FModel;
    property Value: Integer read GetValue;
  end;

  TIndividualArray = array of TIndividual;

  TModel = class
  protected
    function GetElitistCount: Integer; virtual; abstract;
  public
    function NewIndividual: TIndividual; virtual; abstract;
    property ElitistCount: Integer read GetElitistCount;
  end;

  { TMultiBookmark }

  TMultiBookmark = class(TBookmark)
  private
    FBookmark1: TBookmark;
    FBookmark2: TBookmark;
    FLevel: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(ABookmark1, ABookmark2: TBookmark); overload;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Bookmark1: TBookmark read FBookmark1;
    property Bookmark2: TBookmark read FBookmark2;
  end;

implementation

{ TBookmark }

constructor TBookmark.Create(AIndividual: TIndividual);
begin
  FIndividual := AIndividual;
  FMaxPosition := GetMaxPosition;
end;

procedure TBookmark.First;
begin
  FPosition := 0;
  FOffset := 0;
end;

procedure TBookmark.Next;
begin
  Inc(FPosition);
end;

function TBookmark.GetProgress: Integer;
begin
  Result := FOffset + FPosition;
end;

function TBookmark.GetMaxPosition: Integer;
begin
  Result := 0;
  First;
  repeat
    Next;
    Inc(Result);
  until Bof;
end;

procedure TBookmark.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TBookmark.Eof: Boolean;
begin
  Result := FPosition = FMaxPosition;
end;

function TBookmark.GetMax: Integer;
begin
  Result := FOffset + FMaxPosition;
end;

{ TIndividual }

procedure TIndividual.Assign(AIndividual: TIndividual);
begin
  FModel := AIndividual.FModel;
end;

{ TMultiBookmark }

function TMultiBookmark.GetProgress: Integer;
begin
  // Result := (FLevel + FBookmark1.Progress) * FBookmark2.Max + FBookmark2.Progress;
  Result := FLevel + FBookmark1.Progress;
end;

function TMultiBookmark.GetMax: Integer;
begin
  //Result := (FLevel + FBookmark1.Max) * FBookmark2.Max;
  Result := FLevel + FBookmark1.Max;
end;

constructor TMultiBookmark.Create(ABookmark1, ABookmark2: TBookmark);
begin
  inherited Create(ABookmark1.Individual);
  FBookmark1 := ABookmark1;
  FBookmark2 := ABookmark2;
end;

procedure TMultiBookmark.First;
begin
  FBookmark1.First;
  FBookmark2.First;
  FLevel := 0;
end;

procedure TMultiBookmark.Next;
begin
  FBookmark2.Next;
  if FBookmark2.Eof then
  begin
    FBookmark2.First;
    if FLevel = 0 then
    begin
      FBookmark1.First;
      Inc(FLevel);
    end
    else
    begin
      FBookmark1.Next;
    end;
  end;
end;

procedure TMultiBookmark.Rewind;
begin
  FBookmark1.Rewind;
  FBookmark2.Rewind;
  FLevel := 0;
end;

function TMultiBookmark.Move: Integer;
begin
  if FLevel = 0 then
    Result := FBookmark2.Move
  else
    Result := FBookmark1.Move + FBookmark2.Move;
end;

function TMultiBookmark.Undo: Integer;
begin
  if FLevel = 0 then
    Result := FBookmark2.Undo
  else
    Result := FBookmark2.Undo + FBookmark1.Undo;
end;

function TMultiBookmark.Eof: Boolean;
begin
  Result := FBookmark2.Eof;
end;

end.
