unit FSingEdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons, ExtCtrls, Placemnt, DBIndex,
  ComCtrls, FEditor, ImgList, ToolWin, kbmMemTable, ActnList;

type

TSingleEditorForm = class(TEditorForm)
    DBNavigator: TDBNavigator;
    DataSource: TDataSource;
    SLRecordNo: TLabel;
    SLState: TLabel;
    DBGrid: TDBGrid;
    BtnFind: TToolButton;
    ActionList: TActionList;
    ActShow: TAction;
    ActFind: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActFindExecute(Sender: TObject);
    procedure ActShowExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridCheckButton(Sender: TObject; ACol: Integer;
      Field: TField; var Enabled: Boolean);
    procedure DBGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    procedure SetDataSet(ADataSet: TDataSet);
  public
    { Public declarations }
    property DataSet: TDataSet write SetDataSet;
    class function ToggleSingleEditor(var AForm;
                                      AConfigStrings: TStrings;
                                      AAction: TAction;
                                      ADataSet: TDataSet): Boolean;
  end;

implementation

uses
  HorColCm, QSingRep, Printers, FMain, DMaster;
{$R *.DFM}

class function TSingleEditorForm.ToggleSingleEditor(var AForm;
                                                    AConfigStrings: TStrings;
                                                    AAction: TAction;
                                                    ADataSet: TDataSet): Boolean;
begin
  Result := ToggleEditor(AForm, AConfigStrings, AAction);
  if Result then
    TSingleEditorForm(AForm).DataSet := ADataSet;
end;

procedure TSingleEditorForm.SetDataSet(ADataSet: TDataSet);
begin
  DataSource.DataSet := ADataSet;
end;

procedure TSingleEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DataSource.DataSet := nil;
  inherited;
end;

procedure TSingleEditorForm.ActFindExecute(Sender: TObject);
begin
  SearchInDBGrid(DBGrid);
end;

procedure TSingleEditorForm.ActShowExecute(Sender: TObject);
begin
  PreviewSingleReport(DataSource.DataSet, '', '', SuperTitle, Caption,
    poPortrait, MainForm.PrepareReport);
end;

procedure TSingleEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  with DataSource do
    CanClose := not (Assigned(DataSet) and (DataSet.State in dsEditModes));
end;

procedure TSingleEditorForm.DBGridCheckButton(Sender: TObject;
  ACol: Integer; Field: TField; var Enabled: Boolean);
begin
  inherited;
  Enabled := (TCustomDBGrid(Sender).DataSource.DataSet is TKbmMemTable) and
    (Field <> nil) and not (Field is TBlobField) and
    (TKbmMemTable(TCustomDBGrid(Sender).DataSource.DataSet).IndexDefs.Count > 0);
end;

procedure TSingleEditorForm.DBGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
  inherited;
  if TCustomDBGrid(Sender).DataSource.DataSet is TKbmMemTable then
    with TKbmMemTable(TCustomDBGrid(Sender).DataSource.DataSet) do
    try
      if Field.FieldKind = fkLookup then
        IndexFieldNames :=IndexDefs.FindIndexForFields(FindField(Field.KeyFields).FieldName).Fields
      else
       IndexFieldNames := IndexDefs.FindIndexForFields(Field.FieldName).Fields;
    except
      IndexFieldNames := '';
    end;
end;

procedure TSingleEditorForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
  if TCustomDBGrid(Sender).DataSource.DataSet is TKbmMemTable then
    with TKbmMemTable(TDBGrid(Sender).DataSource.DataSet) do
      IndexFieldNames := '';
end;

const
  TextState: array[TDataSetState] of string =('dsInactive', 'dsBrowse',
    'dsEdit', 'dsInsert', 'dsSetKey', 'dsCalcFields', 'dsFilter', 'dsNewValue',
    'dsOldValue', 'dsCurValue', 'dsBlockRead', 'dsInternalCalc', 'dsOpening');

procedure TSingleEditorForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
  if assigned(DataSource.DataSet) then
    SLState.Caption := DataSource.DataSet.Name + ':'
      + TextState[DataSource.State];
end;

procedure TSingleEditorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if assigned(DataSource.DataSet) then
    SLRecordNo.Caption := IntToStr(DataSource.DataSet.RecNo) + '/'
      + IntToStr(DataSource.DataSet.RecordCount)
  else
    SLRecordNo.Caption := '';
end;

end.

