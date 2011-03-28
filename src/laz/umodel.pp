{ -*- mode: Delphi -*- }
unit UModel;

{$I ttg.inc}

interface

uses
  Classes, SysUtils; 

type

  TModel = class;

  { TIndividual }

  TIndividual = class
  protected
    FModel: TModel;
    FValue: Integer;
    function GetElitistValues(Index: Integer): Integer; virtual; abstract;
  public
    procedure ReportValues(AReport: TStrings); virtual; abstract;
    procedure Assign(AIndividual: TIndividual); virtual;
    procedure Cross(AIndividual: TIndividual); virtual; abstract;
    procedure LoadFromDataModule(Index: Integer); virtual; abstract;
    procedure Mutate; virtual; abstract;
    procedure Update; virtual; abstract;
    procedure UpdateValue; virtual; abstract;
    procedure MakeRandom; virtual; abstract;
    function DownHill: Integer; overload; virtual; abstract;
    function DownHill(ExitOnFirstDown, Forced: Boolean;
                      Threshold: Integer): Integer; overload; virtual; abstract;
    function DownHillForced: Integer; virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    procedure LoadFromStream(Stream: TStream); virtual; abstract;
    procedure SaveToDataModule(CodHorario: Integer; MomentoInicial,
      MomentoFinal: TDateTime; Informe: TStrings); virtual; abstract;
    function DoMovement(Movement: Integer; out UndoMovement: Integer): Integer; overload virtual; abstract;
    function DoMovement(Movement: Integer): Integer; overload; virtual; abstract;
    property ElitistValues[Index: Integer]: Integer read GetElitistValues;
    property Model: TModel read FModel;
    property Value: Integer read FValue;
  end;

  TIndividualArray = array of TIndividual;

  TModel = class
  protected
    class function GetElitistCount: Integer; virtual; abstract;
  public
    function NewIndividual: TIndividual; virtual; abstract;
    property ElitistCount: Integer read GetElitistCount;
    {procedure DoProgress(Position, RefreshInterval: Integer;
      Individual: IIndividual; var Stop: Boolean);}
  end;

  { TMovements }

  TMovements = class
  end;

  { TBookmark }

  TBookmark = class
  private
    FIndividual: TIndividual;
    FMovements: TMovements;
  protected
    function GetProgress: Integer; virtual; abstract;
    function GetMax: Integer; virtual; abstract;
  public
    constructor Create(AIndividual: TIndividual; AMovements: TMovements); overload;
    procedure First; virtual; abstract;
    procedure Next; virtual; abstract;
    procedure Rewind; virtual; abstract;
    function Move: Integer; virtual; abstract;
    function Eof: Boolean; virtual; abstract;
    property Individual: TIndividual read FIndividual;
    property Movements: TMovements read FMovements;
    property Progress: Integer read GetProgress;
    property Max: Integer read GetMax;
  end;

implementation

{ TIndividual }

procedure TIndividual.Assign(AIndividual: TIndividual);
begin
  FValue := AIndividual.FValue;
end;

{ TBookmark }

constructor TBookmark.Create(AIndividual: TIndividual; AMovements: TMovements);
begin
  inherited Create;
  FIndividual := AIndividual;
  FMovements := AMovements;
end;

end.

