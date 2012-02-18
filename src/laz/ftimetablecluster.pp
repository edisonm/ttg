{ -*- mode: Delphi -*- }
unit FTimetableCluster;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FCrossManytoManyEditorR, StdCtrls, Buttons, ExtCtrls,
  Grids, Variants, FCrossManyToManyEditor1, DBCtrls, DBGrids, ZDataset, ComCtrls,
  FSelTimeSlot, DSource, DMaster;

type

  { TTimetableClusterForm }

  TTimetableClusterForm = class(TCrossManyToManyEditor1Form)
    QuTimetableCluster: TZQuery;
    TBSwapTimeSlots: TToolButton;
    CBShowCluster: TComboBox;
    QuTimetableClusterIdTheme: TLongintField;
    QuTimetableClusterIdCategory: TLongintField;
    QuTimetableClusterIdParallel: TLongintField;
    QuTimetableClusterIsJoinedCluster: TLongintField;
    QuTimetableClusterIdHour: TLongintField;
    QuTimetableClusterIdDay: TLongintField;
    QuTimetableClusterIdResource: TLongintField;
    QuTimetableClusterName: TStringField;
    DSCluster: TDataSource;
    QuTimetableClusterNaTheme: TStringField;
    QuCluster: TZQuery;
    QuClusterIdTimetable: TLongintField;
    QuClusterIdCategory: TLongintField;
    QuClusterIdParallel: TLongintField;
    QuClusterAbCategory: TStringField;
    QuClusterNaParallel: TStringField;
    QuTimetableClusterIdTimetable: TLongintField;
    QuTimetableClusterNaResource: TStringField;
    DBGrid1: TDBGrid;
    QuClusterNaCluster: TStringField;
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
    procedure QuTimetableClusterCalcFields(DataSet: TDataSet);
    procedure DSClusterDataChange(Sender: TObject; Field: TField);
    procedure QuClusterCalcFields(DataSet: TDataSet);
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

function TTimetableClusterForm.GetIdDay: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function TTimetableClusterForm.GetIdHour: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

procedure TTimetableClusterForm.TBShowClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s', [SuperTitle,
    QuCluster.FindField('IdTimetable').AsInteger,
    QuCluster.FindField('AbCategory').AsString,
    QuCluster.FindField('NaParallel').AsString]);
  FName := MasterDataModule.StringsShowCluster.Values[CBShowCluster.Text];
  with SourceDataModule do
    ShowEditor(TbDay, TbHour, QuTimetableCluster, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
end;

procedure TTimetableClusterForm.BtCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClusterForm.BtOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClusterForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TTimetableClusterForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure TTimetableClusterForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TTimetableClusterForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
end;

procedure TTimetableClusterForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTimetableClusterForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TTimetableClusterForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuCluster.Open;
  CBShowCluster.Items.Clear;
  QuTimetableCluster.Open;
  QuTimetableClusterName.DisplayLabel := SName;
  LoadNames(MasterDataModule.StringsShowCluster, CBShowCluster.Items);
  CBShowCluster.Text := CBShowCluster.Items[0];
end;

procedure TTimetableClusterForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TTimetableClusterForm.IntercambiarTimeSlotsClick(Sender: TObject);
var
  iIdDay, iIdHour: Integer;
begin
  inherited;
  if TSelTimeSlotForm.SeleccionarTimeSlot(iIdDay, iIdHour) then
  begin
    with SourceDataModule do
      MasterDataModule.IntercambiarTimeSlots(
        TbTimetable.FindField('IdTimetable').AsInteger,
        QuCluster.FindField('IdCategory').AsInteger,
        QuCluster.FindField('IdParallel').AsInteger,
        IdDay, IdHour, iIdDay, iIdHour);
    QuTimetableCluster.Refresh;
    TBShowClick(nil);
  end;
end;

procedure TTimetableClusterForm.QuTimetableClusterCalcFields(DataSet: TDataSet);
var
  IsJoinedCluster: string;
begin
  inherited;
  if QuTimetableClusterIsJoinedCluster.Value = 1 then
    IsJoinedCluster := '*'
  else
    IsJoinedCluster := '';
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ') + ' ' + IsJoinedCluster;
end;

procedure TTimetableClusterForm.QuClusterCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NaCluster'] := VarArrToStr(DataSet['AbCategory;NaParallel'], ' ');
end;

procedure TTimetableClusterForm.DSClusterDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  TBShowClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i ftimetablecluster.lrs}
{$ENDIF}

end.

