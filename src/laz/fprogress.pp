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
    lblColision: TLabel;
    lblClashSubject: TLabel;
    lblClashSubjectValue: TLabel;
    lblExports: TLabel;
    lblImports: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    pnlClashSubject: TPanel;
    pnlClashSubjectNumber: TPanel;
    pnlClashSubjectValue: TPanel;
    pnlProgress: TPanel;
    bbtnClose: TBitBtn;
    pnlTotalValue: TPanel;
    pnlClashTeacher: TPanel;
    lblTotalValue: TLabel;
    pnlClashTeacherValue: TPanel;
    lblClashTeacherValue: TLabel;
    pnlClashRoomType: TPanel;
    pnlClashRoomTypeValue: TPanel;
    lblClashRoomTypeValue: TLabel;
    pnlClashTeacherNumber: TPanel;
    lblClashTeacher: TLabel;
    pnlClashRoomTypeNumber: TPanel;
    lblClashRoomType: TLabel;
    pnlOutOfPositionEmptyHour: TPanel;
    pnlOutOfPositionEmptyHourNumber: TPanel;
    lblOutOfPositionEmptyHour: TLabel;
    pnlOutOfPositionEmptyHourValue: TPanel;
    lblOutOfPositionEmptyHourValue: TLabel;
    pnlBrokenSession: TPanel;
    pnlBrokenSessionNumber: TPanel;
    lblBrokenSession: TLabel;
    pnlBrokenSessionValue: TPanel;
    lblBrokenSessionValue: TLabel;
    pnlInitDateTime: TPanel;
    lblInit: TLabel;
    pnlElapsedTime: TPanel;
    lblElapsedTime: TLabel;
    pnlEstimatedTime: TPanel;
    lblRemainingTime: TLabel;
    pnlSubjectRestriction: TPanel;
    pnlSubjectRestrictionNumber: TPanel;
    lblSubjectRestriction: TLabel;
    pnlSubjectRestrictionValue: TPanel;
    lblSubjectRestrictionValue: TLabel;
    pnlTeacherRestriction: TPanel;
    pnlTeacherRestrictionNumber: TPanel;
    lblTeacherRestriction: TLabel;
    Panel26: TPanel;
    lblTeacherRestrictionValue: TLabel;
    pnlNonScatteredSubject: TPanel;
    Panel28: TPanel;
    lblNonScatteredSubject: TLabel;
    Panel29: TPanel;
    lblNonScatteredSubjectValue: TLabel;
    bbtnCancel: TBitBtn;
    PBProgress: TProgressBar;
    Panel1: TPanel;
    Panel2: TPanel;
    lblTeacherFraccionamiento: TLabel;
    Panel3: TPanel;
    lblBrokenTeacherValue: TLabel;
    pnlPosition: TPanel;
    lblPosition: TLabel;
    procedure bbtnCancelClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
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
    FSolver: TSolver;
    FCaption: string;
    procedure SetCaption(const AValue: string);
    procedure UpdateCaption;
  public
    constructor Create;
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
      TTimeTableModel(ASolver.Model).Configure(ClashTeacher, ClashSubject,
        ClashRoomType, TeacherFraccionamiento, OutOfPositionEmptyHour,
        BrokenSession, NonScatteredSubject);
    //ASolver.Update;
    ASolver.UpdateValue;
    FUpdateIndex := MainForm.UpdateIndex;
  end;
  with ASolver, TTimeTable(BestIndividual) do
  begin
    t := Now;
    lblElapsedTime.Caption := FormatDateTime('hh:nn:ss ', t - FInit);
    PBProgress.Max := AMax;
    if APosition <> 0 then
      lblRemainingTime.Caption := FormatDateTime('hh:nn:ss ',
        (t - FTimePosition0) * (AMax - APosition) / APosition)
    else
      FTimePosition0 := t;
    lblPosition.Caption := Format('%d/%d', [APosition, AMax]);
    PBProgress.Position := APosition;
    lblClashTeacher.Caption := Format('%d ', [ClashTeacher]);
    lblClashSubject.Caption := Format('%d ', [ClashSubject]);
    lblClashRoomType.Caption := Format('%d ', [ClashRoomType]);
    lblTeacherFraccionamiento.Caption :=
      Format('%d ', [TeacherFraccionamiento]);
    lblOutOfPositionEmptyHour.Caption := Format('%d ', [OutOfPositionEmptyHour]);
    lblBrokenSession.Caption := Format('%d ', [BrokenSession]);
    lblSubjectRestriction.Caption :=
      Format('%s ', [VarArrToStr(SubjectRestrictionTypeASubjectCant)]);
    lblTeacherRestriction.Caption :=
      Format('%s ', [VarArrToStr(TeacherRestrictionTypeATeacherCant)]);
    lblNonScatteredSubject.Caption := Format('%d ', [NonScatteredSubject]);
    lblClashTeacherValue.Caption := Format('%d ', [ClashTeacherValue]);
    lblClashSubjectValue.Caption := Format('%d ', [ClashSubjectValue]);
    lblBrokenTeacherValue.Caption :=
      Format('%d ', [BrokenTeacherValue]);
    lblClashRoomTypeValue.Caption := Format('%d ', [ClashRoomTypeValue]);
    lblOutOfPositionEmptyHourValue.Caption := Format('%d ',
      [OutOfPositionEmptyHourValue]);
    lblBrokenSessionValue.Caption := Format('%d ', [BrokenSessionValue]);
    lblSubjectRestrictionValue.Caption := Format('%d ', [SubjectRestrictionValue]);
    lblTeacherRestrictionValue.Caption := Format('%d ', [TeacherRestrictionValue]);
    lblNonScatteredSubjectValue.Caption := Format('%d ', [NonScatteredSubjectValue]);
    lblTotalValue.Caption := Format('%d ', [Value]);
  end;
  with ASolver do
  begin
    lblImports.Caption := Format('%d ', [NumImports]);
    lblExports.Caption := Format('%d ', [NumExports]);
    lblColision.Caption := Format('%d ', [NumColision]);
  end;
end;

procedure TProgressForm.SetProgressMax(const Value: Integer);
begin
  PBProgress.Max := Value;
end;

procedure TProgressForm.bbtnCancelClick(Sender: TObject);
begin
  FCancelClick := True;
  Close;
end;

procedure TProgressForm.bbtnCloseClick(Sender: TObject);
begin
  FCloseClick := True;
  Close;
end;

procedure TProgressForm.FormCreate(Sender: TObject);
begin
  // HelpContext := ActElaborarTimeTable.HelpContext;
  FInit := Now;
  FTimePosition0 := FInit;
  lblInit.Caption := FormatDateTime(Format('%s %s ', [ShortDateFormat,
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

constructor TProgressFormDrv.Create;
begin
  inherited Create;
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
