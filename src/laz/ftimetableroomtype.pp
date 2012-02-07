{ -*- mode: Delphi -*- }
unit FTimetableRoomType;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Db,
  FCrossManyToManyEditor0, FCrossManyToManyEditor1, FCrossManyToManyEditor, DBGrids,
  DBCtrls, Variants, ZConnection, ZDataset;

type

  { TTimetableRoomTypeForm }

  TTimetableRoomTypeForm = class(TCrossManyToManyEditor1Form)
    QuTimetableRoomType: TZQuery;
    cbxShowRoomType: TComboBox;
    QuTimetableRoomTypeIdSubject: TLongintField;
    QuTimetableRoomTypeIdLevel: TLongintField;
    QuTimetableRoomTypeIdSpecialization: TLongintField;
    QuTimetableRoomTypeIdGroupId: TLongintField;
    QuTimetableRoomTypeIdHour: TLongintField;
    QuTimetableRoomTypeIdDay: TLongintField;
    QuTimetableRoomTypeNaSubject: TStringField;
    QuTimetableRoomTypeAbLevel: TStringField;
    QuTimetableRoomTypeAbSpecialization: TStringField;
    QuTimetableRoomTypeNaGroupId: TStringField;
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
    procedure QuTimetableRoomTypeCalcFields(DataSet: TDataSet);
    procedure DSRoomTypeDataChange(Sender: TObject; Field: TField);
    procedure btnShowClick(Sender: TObject);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  DMaster, UTTGBasics, FConfig, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimetableRoomTypeForm.btnShowClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      QuRoomType.FindField('IdTimetable').AsInteger,
      QuRoomType.FindField('AbRoomType').AsString]);
    FName := StringsShowRoomType.Values[cbxShowRoomType.Text];
    ShowEditor(TbDay, TbHour, QuTimetableRoomType, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableRoomTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuRoomType.Open;
  cbxShowRoomType.Items.Clear;
  QuTimetableRoomType.Open;
  LoadNames(MasterDataModule.StringsShowRoomType, cbxShowRoomType.Items);
  cbxShowRoomType.Text := cbxShowRoomType.Items[0];
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

procedure TTimetableRoomTypeForm.BtnOkClick(Sender: TObject);
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

procedure TTimetableRoomTypeForm.BtnCancelClick(Sender: TObject);
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
  btnShowClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableroomtype.lrs}
{$ENDIF}

end.
