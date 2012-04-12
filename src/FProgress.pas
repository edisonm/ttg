{ -*- mode: Delphi -*- }
unit FProgress;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, UTTModel, USolver, UProgress;

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

  { TProgressViewerForm }

  TProgressViewerForm = class(TProgressViewer)
  private
    FProgressForm: TProgressForm;
    FMax: Integer;
    FPosition: Integer;
    FSolver: TSolver;
    procedure UpdateTimetable;
  protected
    procedure SetCaption(const AValue: string); override;
    procedure SetTimetable(AValue: Integer); override;
    function GetCloseClick: Boolean; override;
    function GetCancelClick: Boolean; override;
  public
    procedure UpdateCaption;
    constructor Create;
    destructor Destroy; override;
    procedure CreateForm;
    procedure OnProgress(APosition, AMax: Integer; ASolver: TSolver;
      var Stop: Boolean); override;
    procedure DestroyForm;
    procedure DoProgress;
  end;

implementation

uses
  FMain, DMaster, DSource, UTTGBasics;

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

{ TProgressViewerForm }

constructor TProgressViewerForm.Create;
begin
  inherited Create;
  // TThread.Synchronize(FThread, @CreateForm);
  CreateForm;
end;

procedure TProgressViewerForm.SetCaption(const AValue: string);
begin
  inherited;
  TThread.Synchronize(Thread, @UpdateCaption);
end;

function TProgressViewerForm.GetCloseClick: Boolean;
begin
  Result := FProgressForm.FCloseClick;
end;

function TProgressViewerForm.GetCancelClick: Boolean;
begin
  Result := FProgressForm.FCancelClick;
end;

procedure TProgressViewerForm.UpdateCaption;
begin
  FProgressForm.Caption := Caption;
end;

destructor TProgressViewerForm.Destroy;
begin
  TThread.Synchronize(Thread, @DestroyForm);
  inherited Destroy;
end;

procedure TProgressViewerForm.SetTimetable(AValue: Integer);
begin
  inherited;
  TThread.Synchronize(Thread, @UpdateTimetable);
end;

procedure TProgressViewerForm.UpdateTimetable;
begin
  FProgressForm.Top := FProgressForm.Top + 20 * Timetable;
  FProgressForm.Left := FProgressForm.Left + 20 * Timetable;
end;

procedure TProgressViewerForm.CreateForm;
begin
  FProgressForm := TProgressForm.Create(Application);
  FProgressForm.FUpdateIndex := MainForm.UpdateIndex;
end;

procedure TProgressViewerForm.DestroyForm;
begin
  FProgressForm.Free;
end;

procedure TProgressViewerForm.DoProgress;
begin
  FProgressForm.DoProgress(FPosition, FMax, FSolver);
  {$IFNDEF THREADED}
  Application.ProcessMessages;
  {$ENDIF}
end;

procedure TProgressViewerForm.OnProgress(APosition, AMax: Integer; ASolver: TSolver;
    var Stop: Boolean);
begin
  FPosition := APosition;
  FMax := AMax;
  FSolver := ASolver;
  TThread.Synchronize(Thread, @DoProgress);
  with FProgressForm do
    if (CloseClick or CancelClick) then
      Stop := True;
end;

initialization

{$I FProgress.lrs}

end.
