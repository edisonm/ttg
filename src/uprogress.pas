unit UProgress;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, USolver;

type

  { TProgressViewer }

  TProgressViewer = class
  private
    FThread: TThread;
    FTimetable: Integer;
    FCaption: string;
  protected
    procedure SetTimetable(AValue: Integer); virtual;
    procedure SetCaption(const AValue: string); virtual;
    function GetCloseClick: Boolean; virtual; abstract;
    function GetCancelClick: Boolean; virtual; abstract;
  public
    property Caption: string read FCaption write SetCaption;
    procedure OnProgress(APosition, AMax: Integer; ASolver: TSolver;
      var Stop: Boolean); virtual; abstract;
    property CloseClick: Boolean read GetCloseClick;
    property CancelClick: Boolean read GetCancelClick;
    property Thread: TThread read FThread write FThread;
    property Timetable: Integer read FTimetable write SetTimetable;
  end;

implementation

{ TProgressViewer }

procedure TProgressViewer.SetTimetable(AValue: Integer);
begin
  if FTimetable = AValue then Exit;
  FTimetable := AValue;
end;

procedure TProgressViewer.SetCaption(const AValue: string);
begin
  FCaption := AValue;
end;

end.

