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
    procedure Cross(AIndividual: TIndividual); virtual;
    procedure LoadFromDataModule(Index: Integer); virtual; abstract;
    procedure Mutate; virtual; abstract;
    procedure Update; virtual; abstract;
    procedure MakeRandom; virtual; abstract;
    function DownHill: Integer; virtual; abstract;
    function DownHillForced: Integer; virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    procedure LoadFromStream(Stream: TStream); virtual; abstract;
    procedure SaveToDataModule(CodHorario: Integer;
      MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings); virtual; abstract;
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

implementation

{ TIndividual }

procedure TIndividual.Assign(AIndividual: TIndividual);
begin
  FValue := AIndividual.FValue;
end;

procedure TIndividual.Cross(AIndividual: TIndividual);
begin

end;

end.

