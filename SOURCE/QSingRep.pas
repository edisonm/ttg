unit QSingRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls, db, Printers;

type
  TSingleReportQrp = class(TForm)
    qrpSingleReport: TQuickRep;
    TitleBand1: TQRBand;
    qrlTitle: TQRLabel;
    QRSysData2: TQRSysData;
    qrlSuperTitle: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    QRBand1: TQRBand;
    qreSum: TQRExpr;
    qrlPosition1: TQRLabel;
    qrlName1: TQRLabel;
    qrlFirm1: TQRLabel;
    qrlFirm2: TQRLabel;
    qrlName2: TQRLabel;
    qrlPosition2: TQRLabel;
    qrlAnioLectivo: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure PrintSingleReport(ADataSet: TDataSet; const AFields, ASumField,
      ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation;
      OnPrepare: TNotifyEvent);
    procedure PreviewSingleReport(ADataSet: TDataSet; const AFields, ASumField,
      ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation;
      OnPrepare: TNotifyEvent);
  protected
    procedure PrepareSingleReport(ADataSet: TDataSet; const AFields, ASumField,
      ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation;
      OnPrepare: TNotifyEvent);
  public
    { Public declarations }
  end;

procedure PreviewSingleReport(ADataSet: TDataSet; const AFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation; OnPrepare:
  TNotifyEvent);
procedure PrintSingleReport(ADataSet: TDataSet; const AFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation; OnPrepare:
  TNotifyEvent);

implementation

{$R *.DFM}

procedure PreviewSingleReport(ADataSet: TDataSet; const AFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation;
  OnPrepare: TNotifyEvent);
var
  SingleQrp: TSingleReportQrp;
begin
  SingleQrp := TSingleReportQrp.Create(Application);
  SingleQrp.PreviewSingleReport(ADataSet, AFields, ASumField, ASuperTitle,
    ATitle, AOrientation, OnPrepare);
end;

procedure PrintSingleReport(ADataSet: TDataSet; const AFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation; OnPrepare:
  TNotifyEvent);
var
  SingleQrp: TSingleReportQrp;
begin
  SingleQrp := TSingleReportQrp.Create(Application);
  SingleQrp.PrintSingleReport(ADataSet, AFields, ASumField, ASuperTitle,
    ATitle, AOrientation, OnPrepare);
end;

procedure TSingleReportQrp.PrepareSingleReport(ADataSet: TDataSet; const
  AFields, ASumField, ASuperTitle, ATitle: string; AOrientation:
  TPrinterOrientation; OnPrepare: TNotifyEvent);
var
  i, x, y, iPos: Integer;
  QRLabel: TQRLabel;
  QRExpr: TQRExpr;
  procedure ProcessField(AField: TField);
  begin
    y := 1 + 7 * AField.DisplayWidth;
    QRLabel := TQRLabel.Create(Self);
    with QRLabel do
    begin
      Caption := AField.DisplayLabel;
      Parent := ColumnHeaderBand1;
      Frame.DrawBottom := true;
      Left := x;
      Width := y;
    end;
    QRExpr := TQRExpr.Create(Self);
    with QRExpr do
    begin
      Expression := Format('[%s]', [AField.FieldName]);
      Parent := DetailBand1;
      Left := x;
      Width := y;
    end;
    x := x + y + 8;
  end;
begin
  qrpSingleReport.DataSet := ADataSet;
  qrlSuperTitle.Caption := ASuperTitle;
  qrlTitle.Caption := ATitle;
  qrpsingleReport.Page.Orientation := AOrientation;
  if ASumField <> '' then
    qreSum.Expression := Format('sum(%s)', [ASumField])
  else
    qreSum.Mask := '';
  x := 0;
  if AFields = '' then
  begin
    for i := 0 to ADataSet.FieldCount - 1 do
    begin
      if ADataSet.Fields[i].Visible then
        ProcessField(ADataSet.Fields[i]);
    end;
  end
  else
  begin
    iPos := 1;
    while iPos <= Length(AFields) do
    begin
      ProcessField(ADataSet.FindField(ExtractFieldName(AFields, iPos)));
    end;
  end;
  if Assigned(OnPrepare) then
    OnPrepare(Self);
end;

procedure TSingleReportQrp.PreviewSingleReport(ADataSet: TDataSet; const
  AFields, ASumField, ASuperTitle, ATitle: string; AOrientation:
  TPrinterOrientation; OnPrepare: TNotifyEvent);
begin
  PrepareSingleReport(ADataSet, AFields, ASumField, ASuperTitle, ATitle,
    AOrientation, OnPrepare);
  qrpSingleReport.Preview;
end;

procedure TSingleReportQrp.PrintSingleReport(ADataSet: TDataSet; const AFields,
  ASumField, ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation;
  OnPrepare: TNotifyEvent);
begin
  PrepareSingleReport(ADataSet, AFields, ASumField, ASuperTitle, ATitle,
    AOrientation, OnPrepare);
  Print;
end;

procedure TSingleReportQrp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

