{ -*- mode: Delphi -*- }
unit FTimeTableClass;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FCrossManytoManyEditorR, StdCtrls, Buttons, ExtCtrls,
  Grids, Variants, FCrossManyToManyEditor1, DBCtrls, ZConnection, DBGrids, ZDataset, ComCtrls,
  FSelTimeSlot, DSource, DMaster;

type

  { TTimeTableClassForm }

  TTimeTableClassForm = class(TCrossManyToManyEditor1Form)
    QuTimeTableClass: TZQuery;
    BtnIntercambiarTimeSlots: TToolButton;
    cbVerClass: TComboBox;
    QuTimeTableGroupIdSubject: TLongintField;
    QuTimeTableGroupIdLevel: TLongintField;
    QuTimeTableGroupIdSpecialization: TLongintField;
    QuTimeTableGroupIdGroupId: TLongintField;
    QuTimeTableGroupIdHour: TLongintField;
    QuTimeTableGroupIdDay: TLongintField;
    QuTimeTableGroupIdTeacher: TLongintField;
    QuTimeTableClassName: TStringField;
    DSClass: TDataSource;
    QuTimeTableClassNaSubject: TStringField;
    QuClass: TZQuery;
    QuGroupIdTimeTable: TLongintField;
    QuGroupIdLevel: TLongintField;
    QuGroupIdSpecialization: TLongintField;
    QuGroupIdGroupId: TLongintField;
    QuClassAbLevel: TStringField;
    QuClassAbSpecialization: TStringField;
    QuClassNaGroupId: TStringField;
    QuTimeTableGroupIdTimeTable: TLongintField;
    QuTimeTableClassApeTeacher: TStringField;
    QuTimeTableClassNaTeacher: TStringField;
    DBGrid1: TDBGrid;
    QuClassNaClass: TStringField;
    Splitter1: TSplitter;
    DBNavigator: TDBNavigator;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnMostrarClick(Sender: TObject);
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
    procedure QuTimeTableClassCalcFields(DataSet: TDataSet);
    procedure DSClassDataChange(Sender: TObject; Field: TField);
    procedure QuClassCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FNombre: string;
    function GetIdDay: Integer;
    function GetIdHour: Integer;
  public
    { Public declarations }
    property IdDay: Integer read GetIdDay;
    property IdHour: Integer read GetIdHour;
  end;

implementation

uses
  UTTGBasics;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function TTimeTableClassForm.GetIdDay: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function TTimeTableClassForm.GetIdHour: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

procedure TTimeTableClassForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s %s', [SuperTitle,
    QuClass.FindField('IdTimeTable').AsInteger,
    QuClass.FindField('AbLevel').AsString,
    QuClass.FindField('AbSpecialization').AsString,
    QuClass.FindField('NaGroupId').AsString]);
  FNombre := MasterDataModule.StringsShowClass.Values[cbVerClass.Text];
  with SourceDataModule do
    ShowEditor(TbDay, TbHour, QuTimeTableClass, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Nombre');
end;

procedure TTimeTableClassForm.BtnCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableClassForm.BtnOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableClassForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TTimeTableClassForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimeTableClassForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TTimeTableClassForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
end;

procedure TTimeTableClassForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTimeTableClassForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TTimeTableClassForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuClass.Open;
  cbVerClass.Items.Clear;
  QuTimeTableClass.Open;
  LoadNames(MasterDataModule.StringsShowClass, cbVerClass.Items);
  cbVerClass.Text := cbVerClass.Items[0];
end;

procedure TTimeTableClassForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TTimeTableClassForm.IntercambiarTimeSlotsClick(Sender: TObject);
var
  iIdDay, iIdHour: Integer;
begin
  inherited;
  if TSelTimeSlotForm.SeleccionarTimeSlot(iIdDay, iIdHour) then
  begin
    with SourceDataModule do
      MasterDataModule.IntercambiarTimeSlots(
        TbTimeTable.FindField('IdTimeTable').AsInteger,
        QuClass.FindField('IdLevel').AsInteger,
        QuClass.FindField('IdSpecialization').AsInteger,
        QuClass.FindField('IdGroupId').AsInteger,
        IdDay, IdHour, iIdDay, iIdHour);
    QuTimeTableClass.Refresh;
    BtnMostrarClick(nil);
  end;
end;

procedure TTimeTableClassForm.QuTimeTableClassCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

procedure TTimeTableClassForm.QuClassCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NaClass'] := VarArrToStr(DataSet['AbLevel;AbSpecialization;NaGroupId'], ' ');
end;

procedure TTimeTableClassForm.DSClassDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i ftimetableclass.lrs}
{$ENDIF}

end.

