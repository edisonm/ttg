{ -*- mode: Delphi -*- }
unit FTimeTableRoomType;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Db,
  FCrossManyToManyEditor0, FCrossManyToManyEditor1, FCrossManyToManyEditor, DBGrids,
  DBCtrls, Variants, ZConnection, ZDataset;

type

  { TTimeTableRoomTypeForm }

  TTimeTableRoomTypeForm = class(TCrossManyToManyEditor1Form)
    QuTimeTableRoomType: TZQuery;
    cbVerRoomType: TComboBox;
    QuTimeTableRoomTypeIdSubject: TLongintField;
    QuTimeTableRoomTypeIdLevel: TLongintField;
    QuTimeTableRoomTypeIdSpecialization: TLongintField;
    QuTimeTableRoomTypeIdGroupId: TLongintField;
    QuTimeTableRoomTypeIdHour: TLongintField;
    QuTimeTableRoomTypeIdDay: TLongintField;
    QuTimeTableRoomTypeNaSubject: TStringField;
    QuTimeTableRoomTypeAbLevel: TStringField;
    QuTimeTableRoomTypeAbSpecialization: TStringField;
    QuTimeTableRoomTypeNaGroupId: TStringField;
    QuTimeTableRoomTypeName: TStringField;
    DSRoomType: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuRoomType: TZQuery;
    QuRoomTypeIdTimeTable: TLongintField;
    QuRoomTypeIdRoomType: TLongintField;
    QuRoomTypeAbRoomType: TStringField;
    QuTimeTableRoomTypeIdTimeTable: TLongintField;
    QuTimeTableRoomTypeIdRoomType: TLongintField;
    DBNavigator: TDBNavigator;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QuTimeTableRoomTypeCalcFields(DataSet: TDataSet);
    procedure DSRoomTypeDataChange(Sender: TObject; Field: TField);
    procedure BtnMostrarClick(Sender: TObject);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  DMaster, UTTGBasics, FConfiguracion, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimeTableRoomTypeForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      QuRoomType.FindField('IdTimeTable').AsInteger,
      QuRoomType.FindField('AbRoomType').AsString]);
    FName := StringsShowRoomType.Values[cbVerRoomType.Text];
    ShowEditor(TbDay, TbHour, QuTimeTableRoomType, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimeTableRoomTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuRoomType.Open;
  cbVerRoomType.Items.Clear;
  QuTimeTableRoomType.Open;
  LoadNames(MasterDataModule.StringsShowRoomType, cbVerRoomType.Items);
  cbVerRoomType.Text := cbVerRoomType.Items[0];
end;

procedure TTimeTableRoomTypeForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.BtnOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.BtnCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TTimeTableRoomTypeForm.QuTimeTableRoomTypeCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
end;

procedure TTimeTableRoomTypeForm.DSRoomTypeDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableroomtype.lrs}
{$ENDIF}

end.
