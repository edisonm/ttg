{ -*- mode: Delphi -*- }
unit FTimetableRoomType;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Db,
  FCrossManyToManyEditor0, FCrossManyToManyEditor1, FCrossManyToManyEditor, DBGrids,
  DBCtrls, Variants, ZDataset;

type

  { TTimetableRoomTypeForm }

  TTimetableRoomTypeForm = class(TCrossManyToManyEditor1Form)
    QuTimetableRoomType: TZQuery;
    CBShowRoomType: TComboBox;
    QuTimetableRoomTypeIdTheme: TLongintField;
    QuTimetableRoomTypeIdCategory: TLongintField;
    QuTimetableRoomTypeIdParallel: TLongintField;
    QuTimetableRoomTypeIdHour: TLongintField;
    QuTimetableRoomTypeIdDay: TLongintField;
    QuTimetableRoomTypeNaTheme: TStringField;
    QuTimetableRoomTypeAbCategory: TStringField;
    QuTimetableRoomTypeNaParallel: TStringField;
    QuTimetableRoomTypeName: TStringField;
    DSRoomType: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuRoomType: TZQuery;
    QuRoomTypeIdTimetable: TLongintField;
    QuRoomTypeIdRoomType: TLongintField;
    QuRoomTypeAbRoomType: TStringField;
    QuTimetableRoomTypeIdTimetable: TLongintField;
    QuTimetableRoomTypeIdRoomType: TLongintField;
    DBNavigator: TDBNavigator;
    procedure BtCancelClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
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
    procedure QuTimetableRoomTypeCalcFields(DataSet: TDataSet);
    procedure DSRoomTypeDataChange(Sender: TObject; Field: TField);
    procedure TBShowClick(Sender: TObject);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  DMaster, UTTGBasics, FConfig, DSource, dsourcebaseconsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimetableRoomTypeForm.TBShowClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      QuRoomType.FindField('IdTimetable').AsInteger,
      QuRoomType.FindField('AbRoomType').AsString]);
    FName := StringsShowRoomType.Values[CBShowRoomType.Text];
    ShowEditor(TbDay, TbHour, QuTimetableRoomType, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableRoomTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuTimetableRoomTypeNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuTimetableRoomTypeAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuTimetableRoomTypeNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuTimetableRoomTypeName.DisplayLabel := SFlRoomType_NaRoomType;
  QuRoomTypeAbRoomType.DisplayLabel := SFlDistribution_IdRoomType;
  QuRoomType.Open;
  CBShowRoomType.Items.Clear;
  QuTimetableRoomType.Open;
  LoadNames(MasterDataModule.StringsShowRoomType, CBShowRoomType.Items);
  CBShowRoomType.Text := CBShowRoomType.Items[0];
end;

procedure TTimetableRoomTypeForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.BtOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.BtCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TTimetableRoomTypeForm.QuTimetableRoomTypeCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
end;

procedure TTimetableRoomTypeForm.DSRoomTypeDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  TBShowClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableroomtype.lrs}
{$ENDIF}

end.
