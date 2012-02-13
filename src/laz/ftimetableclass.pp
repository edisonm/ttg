{ -*- mode: Delphi -*- }
unit FTimetableClass;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FCrossManytoManyEditorR, StdCtrls, Buttons, ExtCtrls,
  Grids, Variants, FCrossManyToManyEditor1, DBCtrls, DBGrids, ZDataset, ComCtrls,
  FSelTimeSlot, DSource, DMaster;

type

  { TTimetableClassForm }

  TTimetableClassForm = class(TCrossManyToManyEditor1Form)
    QuTimetableClass: TZQuery;
    BtnIntercambiarTimeSlots: TToolButton;
    cbxShowClass: TComboBox;
    QuTimetableClassIdSubject: TLongintField;
    QuTimetableClassIdLevel: TLongintField;
    QuTimetableClassIdSpecialization: TLongintField;
    QuTimetableClassIdGroup: TLongintField;
    QuTimetableClassIdHour: TLongintField;
    QuTimetableClassIdDay: TLongintField;
    QuTimetableClassIdTeacher: TLongintField;
    QuTimetableClassName: TStringField;
    DSClass: TDataSource;
    QuTimetableClassNaSubject: TStringField;
    QuClass: TZQuery;
    QuClassIdTimetable: TLongintField;
    QuClassIdLevel: TLongintField;
    QuClassIdSpecialization: TLongintField;
    QuClassIdGroup: TLongintField;
    QuClassAbLevel: TStringField;
    QuClassAbSpecialization: TStringField;
    QuClassNaGroupId: TStringField;
    QuTimetableClassIdTimetable: TLongintField;
    QuTimetableClassLnTeacher: TStringField;
    QuTimetableClassNaTeacher: TStringField;
    DBGrid1: TDBGrid;
    QuClassNaClass: TStringField;
    Splitter1: TSplitter;
    DBNavigator: TDBNavigator;
    procedure BtnCancelClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure DrawGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IntercambiarTimeSlotsClick(Sender: TObject);
    procedure QuTimetableClassCalcFields(DataSet: TDataSet);
    procedure DSClassDataChange(Sender: TObject; Field: TField);
    procedure QuClassCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FName: string;
    function GetIdDay: Integer;
    function GetIdHour: Integer;
  public
    { Public declarations }
    property IdDay: Integer read GetIdDay;
    property IdHour: Integer read GetIdHour;
  end;

implementation

uses
  UTTGBasics, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function TTimetableClassForm.GetIdDay: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function TTimetableClassForm.GetIdHour: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

procedure TTimetableClassForm.btnShowClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s %s', [SuperTitle,
    QuClass.FindField('IdTimetable').AsInteger,
    QuClass.FindField('AbLevel').AsString,
    QuClass.FindField('AbSpecialization').AsString,
    QuClass.FindField('NaGroupId').AsString]);
  FName := MasterDataModule.StringsShowClass.Values[cbxShowClass.Text];
  with SourceDataModule do
    ShowEditor(TbDay, TbHour, QuTimetableClass, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
end;

procedure TTimetableClassForm.BtnCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClassForm.BtnOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClassForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TTimetableClassForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimetableClassForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TTimetableClassForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
end;

procedure TTimetableClassForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTimetableClassForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TTimetableClassForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuClass.Open;
  cbxShowClass.Items.Clear;
  QuTimetableClass.Open;
  QuTimetableClassName.DisplayLabel := SName;
  LoadNames(MasterDataModule.StringsShowClass, cbxShowClass.Items);
  cbxShowClass.Text := cbxShowClass.Items[0];
end;

procedure TTimetableClassForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClassForm.IntercambiarTimeSlotsClick(Sender: TObject);
var
  iIdDay, iIdHour: Integer;
begin
  inherited;
  if TSelTimeSlotForm.SeleccionarTimeSlot(iIdDay, iIdHour) then
  begin
    with SourceDataModule do
      MasterDataModule.IntercambiarTimeSlots(
        TbTimetable.FindField('IdTimetable').AsInteger,
        QuClass.FindField('IdLevel').AsInteger,
        QuClass.FindField('IdSpecialization').AsInteger,
        QuClass.FindField('IdGroup').AsInteger,
        IdDay, IdHour, iIdDay, iIdHour);
    QuTimetableClass.Refresh;
    btnShowClick(nil);
  end;
end;

procedure TTimetableClassForm.QuTimetableClassCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
end;

procedure TTimetableClassForm.QuClassCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NaClass'] := VarArrToStr(DataSet['AbLevel;AbSpecialization;NaGroupId'], ' ');
end;

procedure TTimetableClassForm.DSClassDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btnShowClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i ftimetableclass.lrs}
{$ENDIF}

end.

