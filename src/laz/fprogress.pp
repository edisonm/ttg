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
    lblClashSubjectValor: TLabel;
    lblExports: TLabel;
    lblImports: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    pnlClashSubject: TPanel;
    pnlClashSubjectNumber: TPanel;
    pnlClashSubjectValor: TPanel;
    pnlProgress: TPanel;
    bbtnClose: TBitBtn;
    pnlValorTotal: TPanel;
    pnlClashTeacher: TPanel;
    lblValorTotal: TLabel;
    pnlClashTeacherValor: TPanel;
    lblClashTeacherValor: TLabel;
    pnlClashRoomType: TPanel;
    pnlClashRoomTypeValor: TPanel;
    lblClashRoomTypeValor: TLabel;
    pnlClashTeacherNumber: TPanel;
    lblClashTeacher: TLabel;
    pnlClashRoomTypeNumber: TPanel;
    lblClashRoomType: TLabel;
    pnlHourHuecaDesubicada: TPanel;
    pnlHourHuecaDesubicadaNumber: TPanel;
    lblHourHuecaDesubicada: TLabel;
    pnlHourHuecaDesubicadaValor: TPanel;
    lblHourHuecaDesubicadaValor: TLabel;
    pnlSessionCortada: TPanel;
    pnlSessionCortadaNumber: TPanel;
    lblSessionCortada: TLabel;
    pnlSessionCortadaValor: TPanel;
    lblSessionCortadaValor: TLabel;
    pnlInitDateTime: TPanel;
    lblInit: TLabel;
    pnlElapsedTime: TPanel;
    lblElapsedTime: TLabel;
    pnlEstimatedTime: TPanel;
    lblRemainingTime: TLabel;
    pnlSubjectRestriction: TPanel;
    pnlSubjectRestrictionNumber: TPanel;
    lblSubjectRestriction: TLabel;
    pnlSubjectRestrictionValor: TPanel;
    lblSubjectRestrictionValor: TLabel;
    pnlTeacherRestriction: TPanel;
    pnlTeacherRestrictionNumber: TPanel;
    lblTeacherRestriction: TLabel;
    Panel26: TPanel;
    lblTeacherRestrictionValor: TLabel;
    pnlSubjectNoDispersa: TPanel;
    Panel28: TPanel;
    lblSubjectNoDispersa: TLabel;
    Panel29: TPanel;
    lblSubjectNoDispersaValor: TLabel;
    bbtnCancel: TBitBtn;
    PBProgress: TProgressBar;
    Panel1: TPanel;
    Panel2: TPanel;
    lblTeacherFraccionamiento: TLabel;
    Panel3: TPanel;
    lblTeacherFraccionamientoValor: TLabel;
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
        ClashRoomType, TeacherFraccionamiento, HourHuecaDesubicada,
        SessionCortada, SubjectNoDispersa);
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
    lblHourHuecaDesubicada.Caption := Format('%d ', [HourHuecaDesubicada]);
    lblSessionCortada.Caption := Format('%d ', [SessionCortada]);
    lblSubjectRestriction.Caption :=
      Format('%s ', [VarArrToStr(SubjectRestrictionTypeASubjectCant)]);
    lblTeacherRestriction.Caption :=
      Format('%s ', [VarArrToStr(TeacherRestrictionTypeATeacherCant)]);
    lblSubjectNoDispersa.Caption := Format('%d ', [SubjectNoDispersa]);
    lblClashTeacherValor.Caption := Format('%d ', [ClashTeacherValor]);
    lblClashSubjectValor.Caption := Format('%d ', [ClashSubjectValor]);
    lblTeacherFraccionamientoValor.Caption :=
      Format('%d ', [TeacherFraccionamientoValor]);
    lblClashRoomTypeValor.Caption := Format('%d ', [ClashRoomTypeValor]);
    lblHourHuecaDesubicadaValor.Caption := Format('%d ',
      [HourHuecaDesubicadaValor]);
    lblSessionCortadaValor.Caption := Format('%d ', [SessionCortadaValor]);
    lblSubjectRestrictionValor.Caption := Format('%d ', [SubjectRestrictionValor]);
    lblTeacherRestrictionValor.Caption := Format('%d ', [TeacherRestrictionValor]);
    lblSubjectNoDispersaValor.Caption := Format('%d ', [SubjectNoDispersaValor]);
    lblValorTotal.Caption := Format('%d ', [Value]);
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
