{ -*- mode: Delphi -*- }
unit FProgress;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
    Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
    UTTModel, USolver;

type

  { TProgressForm }

  TProgressForm = class(TForm)
    LbColision: TLabel;
    LbClashActivity: TLabel;
    LbClashActivityValue: TLabel;
    LbExports: TLabel;
    LbImports: TLabel;
    PnCrashes: TPanel;
    PnImports: TPanel;
    PnExports: TPanel;
    PnPollination: TPanel;
    PnClashActivity: TPanel;
    PnClashActivityNumber: TPanel;
    PnClashActivityValue: TPanel;
    PnProgress: TPanel;
    BBClose: TBitBtn;
    PnTotalValue: TPanel;
    PnClashResource: TPanel;
    LbTotalValue: TLabel;
    PnClashResourceValue: TPanel;
    LbClashResourceValue: TLabel;
    PnClashResourceNumber: TPanel;
    LbClashResource: TLabel;
    PnBrokenSession: TPanel;
    PnBrokenSessionNumber: TPanel;
    LbBrokenSession: TLabel;
    PnBrokenSessionValue: TPanel;
    LbBrokenSessionValue: TLabel;
    PnInitDateTime: TPanel;
    LbInit: TLabel;
    PnElapsedTime: TPanel;
    LbElapsedTime: TLabel;
    PnEstimatedTime: TPanel;
    LbRemainingTime: TLabel;
    PnDescription: TPanel;
    PnNumber: TPanel;
    PnValue: TPanel;
    PnRestriction: TPanel;
    PnRestrictionNumber: TPanel;
    LbRestriction: TLabel;
    PnRestrictionValue: TPanel;
    LbRestrictionValue: TLabel;
    PnNonScatteredActivity: TPanel;
    PnNonScatteredActivityCount: TPanel;
    LbNonScatteredActivityCount: TLabel;
    PnNonScatteredActivityValue: TPanel;
    LbNonScatteredActivityValue: TLabel;
    BBCancel: TBitBtn;
    PBProgress: TProgressBar;
    PnBreakTimetableResource: TPanel;
    PnBreakTimetableResourceCount: TPanel;
    LbBreakTimetableResourceCount: TLabel;
    PnBreakTimetableResourceValue: TPanel;
    LbBreakTimetableResourceValue: TLabel;
    PnPosition: TPanel;
    LbPosition: TLabel;
    procedure BBCancelClick(Sender: TObject);
    procedure BBCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FUpdateIndex: Integer;
    FInit, FTimePosition0: TDateTime;
    FCloseClick:Boolean;
    FCancelClick: Boolean;
    function GetProgressMax: Integer;
    procedure SetProgressMax(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property CloseClick: Boolean read FCloseClick write FCloseClick;
    property CancelClick: Boolean read FCancelClick write FCancelClick;
    property ProgressMax: Integer read GetProgressMax write SetProgressMax;
    procedure DoProgress(APosition, AMax: Integer; ASolver: TSolver);
  end;

  { TProgressFormDrv }

  TProgressFormDrv = class
  private
    FProgressForm: TProgressForm;
    FMax: Integer;
    FPosition: Integer;
    FTimetable: Integer;
    FSolver: TSolver;
    FCaption: string;
    procedure SetCaption(const AValue: string);
    procedure UpdateCaption;
  public
    constructor Create(Timetable: Integer);
    destructor Destroy; override;
    procedure CreateForm;
    procedure DestroyForm;
    procedure DoProgress;
    procedure OnProgress(APosition, AMax: Integer; ASolver: TSolver;
      var Stop: Boolean);
    property CancelClick: Boolean read FProgressForm.FCancelClick;
    property Caption: string read FCaption write SetCaption;
  end;

implementation

uses
  FMain, DMaster, DSource, MTProcs, UTTGBasics;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFProgress }

function TProgressForm.GetProgressMax: Integer;
begin
  Result := PBProgress.Max;
end;

procedure TProgressForm.DoProgress(APosition, AMax: Integer; ASolver: TSolver);
var
  t: TDateTime;
begin
  if MainForm.UpdateIndex <> FUpdateIndex then
  begin
    with MasterDataModule.ConfigStorage do
      TTimetableModel(ASolver.Model).Configure(ClashActivity,
                                               BreakTimetableResource,
                                               BrokenSession,
                                               NonScatteredActivity);
    //ASolver.Update;
    ASolver.UpdateValue;
    FUpdateIndex := MainForm.UpdateIndex;
  end;
  with ASolver, TTimetable(BestIndividual) do
  begin
    t := Now;
    LbElapsedTime.Caption := FormatDateTime('hh:nn:ss ', t - FInit);
    PBProgress.Max := AMax;
    if APosition <> 0 then
      LbRemainingTime.Caption := FormatDateTime('hh:nn:ss ',
        (t - FTimePosition0) * (AMax - APosition) / APosition)
    else
      FTimePosition0 := t;
    LbPosition.Caption := Format('%d/%d', [APosition, AMax]);
    PBProgress.Position := APosition;
    LbClashActivity.Caption := Format('%d ', [ClashActivity]);
    LbBreakTimetableResourceCount.Caption :=
      Format('%d ', [BreakTimetableResource]);
    LbBrokenSession.Caption := Format('%d ', [BrokenSession]);
    LbClashResource.Caption :=
      Format('%s ', [VarArrToStr(ClashResourceType)]);
    LbRestriction.Caption :=
      Format('%s ', [VarArrToStr(RestrictionTypeToResourceCount)]);
    LbNonScatteredActivityCount.Caption := Format('%d ', [NonScatteredActivity]);
    LbClashActivityValue.Caption := Format('%d ', [ClashActivityValue]);
    LbBreakTimetableResourceValue.Caption :=
      Format('%d ', [BreakTimetableResourceValue]);
    LbBrokenSessionValue.Caption := Format('%d ', [BrokenSessionValue]);
    LbClashResourceValue.Caption := Format('%d ', [ClashResourceValue]);
    LbRestrictionValue.Caption := Format('%d ', [RestrictionValue]);
    LbNonScatteredActivityValue.Caption := Format('%d ', [NonScatteredActivityValue]);
    LbTotalValue.Caption := Format('%d ', [Value]);
  end;
  with ASolver do
  begin
    LbImports.Caption := Format('%d ', [NumImports]);
    LbExports.Caption := Format('%d ', [NumExports]);
    LbColision.Caption := Format('%d ', [NumColision]);
  end;
end;

procedure TProgressForm.SetProgressMax(const Value: Integer);
begin
  PBProgress.Max := Value;
end;

procedure TProgressForm.BBCancelClick(Sender: TObject);
begin
  FCancelClick := True;
  Close;
end;

procedure TProgressForm.BBCloseClick(Sender: TObject);
begin
  FCloseClick := True;
  Close;
end;

procedure TProgressForm.FormCreate(Sender: TObject);
begin
  // HelpContext := ActMakeTimetable.HelpContext;
  FInit := Now;
  FTimePosition0 := FInit;
  LbInit.Caption := FormatDateTime(Format('%s %s ', [ShortDateFormat,
    LongTimeFormat]), FInit);
  FCloseClick := False;
  FCancelClick := False;
  Show;
end;

{ TProgressFormDrv }

procedure TProgressFormDrv.SetCaption(const AValue: string);
begin
  FCaption := AValue;
  TThread.Synchronize(CurrentThread, UpdateCaption);
end;

procedure TProgressFormDrv.UpdateCaption;
begin
  FProgressForm.Caption := FCaption;
end;

constructor TProgressFormDrv.Create(Timetable: Integer);
begin
  inherited Create;
  FTimetable := Timetable;
  TThread.Synchronize(CurrentThread, CreateForm);
end;

destructor TProgressFormDrv.Destroy;
begin
  TThread.Synchronize(CurrentThread, DestroyForm);
  inherited Destroy;
end;

procedure TProgressFormDrv.CreateForm;
begin
  FProgressForm := TProgressForm.Create(Application);
  FProgressForm.FUpdateIndex := MainForm.UpdateIndex;
  FProgressForm.Top := FProgressForm.Top + 20 * FTimetable;
  FProgressForm.Left := FProgressForm.Left + 20 * FTimetable;
end;

procedure TProgressFormDrv.DestroyForm;
begin
  FProgressForm.Free;
end;

procedure TProgressFormDrv.DoProgress;
begin
  FProgressForm.DoProgress(FPosition, FMax, FSolver);
  {$IFNDEF THREADED}
  Application.ProcessMessages;
  {$ENDIF}
end;

procedure TProgressFormDrv.OnProgress(APosition, AMax: Integer; ASolver: TSolver;
    var Stop: Boolean);
begin
  FPosition := APosition;
  FMax := AMax;
  FSolver := ASolver;
  TThread.Synchronize(CurrentThread, DoProgress);
  with FProgressForm do
    if (CloseClick or CancelClick) then
      Stop := True;
end;

initialization
{$IFDEF FPC}
  {$i FProgress.lrs}
{$ENDIF}

end.
