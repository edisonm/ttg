unit QMaDeRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QSingRep, Qrctrls, QuickRpt, ExtCtrls, Db, DBTables, Printers;

type
  TMasterDetailReportQrp = class(TSingleReportQrp)
    GroupHeaderBand1: TQRBand;
    QRSubDetail1: TQRSubDetail;
    GroupFooterBand1: TQRBand;
    qreDetailSum: TQRExpr;
  private
    { Private declarations }
    procedure PreviewMasterDetailReport(AMasterDataSet, ADetailDataSet:
      TDataSet; const AMasterFields, ADetailFields, ASumField, ASuperTitle,
      ATitle: string; AOrientation: TPrinterOrientation; OnPrepare: TNotifyEvent);
    procedure PrepareMasterDetailReport(AMasterDataSet,
      ADetailDataSet: TDataSet; const AMasterFields, ADetailFields,
      ASumField, ASuperTitle, ATitle: string; AOrientation:
        TPrinterOrientation; OnPrepare: TNotifyEvent);
  public
    { Public declarations }
  end;

procedure PreviewMasterDetailReport(AMasterDataSet, ADetailDataSet: TDataSet;
  const AMasterFields, ADetailFields, ASumField, ASuperTitle, ATitle: string;
  AOrientation: TPrinterOrientation; OnPrepare: TNotifyEvent);

implementation

{$R *.DFM}

procedure PreviewMasterDetailReport(AMasterDataSet, ADetailDataSet: TDataSet;
  const AMasterFields, ADetailFields, ASumField, ASuperTitle, ATitle: string;
  AOrientation: TPrinterOrientation; OnPrepare: TNotifyEvent);
var
  MasterDetailReportQrp: TMasterDetailReportQrp;
begin
  MasterDetailReportQrp := TMasterDetailReportQrp.Create(Application);
  MasterDetailReportQrp.PreviewMasterDetailReport(AMasterDataSet,
    ADetailDataSet,
    AMasterFields, ADetailFields, ASumField, ASuperTitle, ATitle, AOrientation,
     OnPrepare);
end;

procedure TMasterDetailReportQrp.PrepareMasterDetailReport(AMasterDataSet,
  ADetailDataSet: TDataSet; const AMasterFields, ADetailFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation; OnPrepare: TNotifyEvent);
var
  i, x, y, iPos: Integer;
  QrExpr: TQrExpr;
  QrLabel: TQrLabel;
  procedure ProcessField(AField: TField);
  begin
    y := 1 + 7 * AField.DisplayWidth;
    QRLabel := TQRLabel.Create(Self);
    with QRLabel do
    begin
      Caption := AField.DisplayLabel;
      Parent := GroupHeaderBand1;
      Frame.DrawBottom := true;
      Left := x;
      Width := y;
    end;
    QrExpr := TQrExpr.Create(Self);
    with QrExpr do
    begin
      Expression := Format('[%s]', [AField.FieldName]);
      Parent := QRSubDetail1;
      Left := x;
      Width := y;
    end;
    x := x + y + 8;
  end;
begin
  PrepareSingleReport(AMasterDataSet, AMasterFields, ASumField, ASuperTitle,
    ATitle, AOrientation, OnPrepare);
  QRSubDetail1.DataSet := ADetailDataSet;
  if ASumField <> '' then
    qreDetailSum.Expression := qreSum.Expression
  else
    qreDetailSum.Mask := '';
  x := 70;
  if ADetailFields = '' then
  begin
    for i := 0 to ADetailDataSet.FieldCount - 1 do
    begin
      if ADetailDataSet.Fields[i].Visible then
        ProcessField(ADetailDataSet.Fields[i]);
    end;
  end
  else
  begin
    iPos := 1;
    while iPos <= Length(ADetailFields) do
      ProcessField(ADetailDataSet.FindField(ExtractFieldName(ADetailFields,
        iPos)));
  end;
end;

procedure TMasterDetailReportQrp.PreviewMasterDetailReport(AMasterDataSet,
  ADetailDataSet: TDataSet; const AMasterFields, ADetailFields, ASumField,
  ASuperTitle, ATitle: string; AOrientation: TPrinterOrientation; OnPrepare: TNotifyEvent);
begin
  PrepareMasterDetailReport(AMasterDataSet, ADetailDataSet, AMasterFields,
    ADetailFields, ASumField, ASuperTitle, ATitle, AOrientation, OnPrepare);
  qrpSingleReport.Preview;
end;

end.

 