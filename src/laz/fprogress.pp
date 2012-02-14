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
    LbClashSubject: TLabel;
    LbClashSubjectValue: TLabel;
    LbExports: TLabel;
    LbImports: TLabel;
    PnCrashes: TPanel;
    PnImports: TPanel;
    PnExports: TPanel;
    PnPollination: TPanel;
    PnClashSubject: TPanel;
    PnClashSubjectNumber: TPanel;
    PnClashSubjectValue: TPanel;
    PnProgress: TPanel;
    BBClose: TBitBtn;
    PnTotalValue: TPanel;
    PnClashTeacher: TPanel;
    LbTotalValue: TLabel;
    PnClashTeacherValue: TPanel;
    LbClashTeacherValue: TLabel;
    PnClashRoomType: TPanel;
    PnClashRoomTypeValue: TPanel;
    LbClashRoomTypeValue: TLabel;
    PnClashTeacherNumber: TPanel;
    LbClashTeacher: TLabel;
    PnClashRoomTypeNumber: TPanel;
    LbClashRoomType: TLabel;
    PnOutOfPositionEmptyHour: TPanel;
    PnOutOfPositionEmptyHourNumber: TPanel;
    LbOutOfPositionEmptyHour: TLabel;
    PnOutOfPositionEmptyHourValue: TPanel;
    LbOutOfPositionEmptyHourValue: TLabel;
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
    PnSubjectRestriction: TPanel;
    PnSubjectRestrictionNumber: TPanel;
    LbSubjectRestriction: TLabel;
    PnSubjectRestrictionValue: TPanel;
    LbSubjectRestrictionValue: TLabel;
    PnTeacherRestriction: TPanel;
    PnTeacherRestrictionNumber: TPanel;
    LbTeacherRestriction: TLabel;
    PnTeacherRestrictionValue: TPanel;
    LbTeacherRestrictionValue: TLabel;
    PnNonScatteredSubject: TPanel;
    PnNonScatteredSubjectCount: TPanel;
    LbNonScatteredSubjectCount: TLabel;
    PnNonScatteredSubjectValue: TPanel;
    LbNonScatteredSubjectValue: TLabel;
    BBCancel: TBitBtn;
    PBProgress: TProgressBar;
    PnBreakTimetableTeacher: TPanel;
    PnBreakTimetableTeacherCount: TPanel;
    LbBreakTimetableTeacherCount: TLabel;
    PnBreakTimetableTeacherValue: TPanel;
    LbBreakTimetableTeacherValue: TLabel;
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
      TTimetableModel(ASolver.Model).Configure(ClashTeacher, ClashSubject,
        ClashRoomType, BreakTimetableTeacher, OutOfPositionEmptyHour,
        BrokenSession, NonScatteredSubject);
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
    LbClashTeacher.Caption := Format('%d ', [ClashTeacher]);
    LbClashSubject.Caption := Format('%d ', [ClashSubject]);
    LbClashRoomType.Caption := Format('%d ', [ClashRoomType]);
    LbBreakTimetableTeacherCount.Caption :=
      Format('%d ', [BreakTimetableTeacher]);
    LbOutOfPositionEmptyHour.Caption := Format('%d ', [OutOfPositionEmptyHour]);
    LbBrokenSession.Caption := Format('%d ', [BrokenSession]);
    LbSubjectRestriction.Caption :=
      Format('%s ', [VarArrToStr(SubjectRestrictionTypeToSubjectCount)]);
    LbTeacherRestriction.Caption :=
      Format('%s ', [VarArrToStr(TeacherRestrictionTypeATeacherCount)]);
    LbNonScatteredSubjectCount.Caption := Format('%d ', [NonScatteredSubject]);
    LbClashTeacherValue.Caption := Format('%d ', [ClashTeacherValue]);
    LbClashSubjectValue.Caption := Format('%d ', [ClashSubjectValue]);
    LbBreakTimetableTeacherValue.Caption :=
      Format('%d ', [BreakTimetableTeacherValue]);
    LbClashRoomTypeValue.Caption := Format('%d ', [ClashRoomTypeValue]);
    LbOutOfPositionEmptyHourValue.Caption := Format('%d ',
      [OutOfPositionEmptyHourValue]);
    LbBrokenSessionValue.Caption := Format('%d ', [BrokenSessionValue]);
    LbSubjectRestrictionValue.Caption := Format('%d ', [SubjectRestrictionValue]);
    LbTeacherRestrictionValue.Caption := Format('%d ', [TeacherRestrictionValue]);
    LbNonScatteredSubjectValue.Caption := Format('%d ', [NonScatteredSubjectValue]);
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
  {$i fprogress.lrs}
{$ENDIF}

end.
