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
    TBSwapTimeSlots: TToolButton;
    CBShowClass: TComboBox;
    QuTimetableClassIdTheme: TLongintField;
    QuTimetableClassIdLevel: TLongintField;
    QuTimetableClassIdSpecialization: TLongintField;
    QuTimetableClassIdParallel: TLongintField;
    QuTimetableClassIsJoinedClass: TLongintField;
    QuTimetableClassIdHour: TLongintField;
    QuTimetableClassIdDay: TLongintField;
    QuTimetableClassIdTeacher: TLongintField;
    QuTimetableClassName: TStringField;
    DSClass: TDataSource;
    QuTimetableClassNaTheme: TStringField;
    QuClass: TZQuery;
    QuClassIdTimetable: TLongintField;
    QuClassIdLevel: TLongintField;
    QuClassIdSpecialization: TLongintField;
    QuClassIdParallel: TLongintField;
    QuClassAbLevel: TStringField;
    QuClassAbSpecialization: TStringField;
    QuClassNaParallel: TStringField;
    QuTimetableClassIdTimetable: TLongintField;
    QuTimetableClassLnTeacher: TStringField;
    QuTimetableClassNaTeacher: TStringField;
    DBGrid1: TDBGrid;
    QuClassNaClass: TStringField;
    Splitter1: TSplitter;
    DBNavigator: TDBNavigator;
    procedure BtCancelClick(Sender: TObject);
    procedure TBShowClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
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

procedure TTimetableClassForm.TBShowClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s %s', [SuperTitle,
    QuClass.FindField('IdTimetable').AsInteger,
    QuClass.FindField('AbLevel').AsString,
    QuClass.FindField('AbSpecialization').AsString,
    QuClass.FindField('NaParallel').AsString]);
  FName := MasterDataModule.StringsShowClass.Values[CBShowClass.Text];
  with SourceDataModule do
    ShowEditor(TbDay, TbHour, QuTimetableClass, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
end;

procedure TTimetableClassForm.BtCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClassForm.BtOkClick(Sender: TObject);
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
  CBShowClass.Items.Clear;
  QuTimetableClass.Open;
  QuTimetableClassName.DisplayLabel := SName;
  LoadNames(MasterDataModule.StringsShowClass, CBShowClass.Items);
  CBShowClass.Text := CBShowClass.Items[0];
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
        QuClass.FindField('IdParallel').AsInteger,
        IdDay, IdHour, iIdDay, iIdHour);
    QuTimetableClass.Refresh;
    TBShowClick(nil);
  end;
end;

procedure TTimetableClassForm.QuTimetableClassCalcFields(DataSet: TDataSet);
var
  IsJoinedClass: string;
begin
  inherited;
  if QuTimetableClassIsJoinedClass.Value = 1 then
    IsJoinedClass := '*'
  else
    IsJoinedClass := '';
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ') + ' ' + IsJoinedClass;
end;

procedure TTimetableClassForm.QuClassCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NaClass'] := VarArrToStr(DataSet['AbLevel;AbSpecialization;NaParallel'], ' ');
end;

procedure TTimetableClassForm.DSClassDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  TBShowClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i ftimetableclass.lrs}
{$ENDIF}

end.

