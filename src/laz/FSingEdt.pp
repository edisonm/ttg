unit FSingEdt;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, StdCtrls, DBCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, ComCtrls, FEditor, ActnList, ZConnection, UConfig;

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
    procedure ActFindExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridCheckButton(Sender: TObject; ACol: Integer;
      Field: TField; var AEnabled: Boolean);
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
    class function ToggleSingleEditor(AOwner: TComponent;
                                      var AForm;
                                      AConfigStorage: TConfigStorage;
                                      AAction: TAction;
                                      ADataSet: TDataSet): Boolean;
  end;

implementation

uses
  HorColCm, DMaster;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

class function TSingleEditorForm.ToggleSingleEditor(AOwner: TComponent;
                                                    var AForm;
                                                    AConfigStorage: TConfigStorage;
                                                    AAction: TAction;
                                                    ADataSet: TDataSet): Boolean;
begin
  Result := ToggleEditor(AOwner, AForm, AConfigStorage, AAction);
  if Result then
    TSingleEditorForm(AForm).DataSet := ADataSet;
end;

procedure TSingleEditorForm.SetDataSet(ADataSet: TDataSet);
begin
  if DataSource.DataSet <> ADataSet then
    DataSource.DataSet := ADataSet;
end;

procedure TSingleEditorForm.ActFindExecute(Sender: TObject);
begin
  SearchInDBGrid(DBGrid);
end;

procedure TSingleEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  with DataSource do
    CanClose := not (Assigned(DataSet) and (DataSet.State in dsEditModes));
end;

procedure TSingleEditorForm.DBGridCheckButton(Sender: TObject;
  ACol: Integer; Field: TField; var AEnabled: Boolean);
begin
  inherited;
  {$IFNDEF FPC}
{
  Enabled := (TDBGrid(Sender).DataSource.DataSet is TZTable) and
    (Field <> nil) and not (Field is TBlobField)
    and (TZTable(TDBGrid(Sender).DataSource.DataSet).IndexDefs.Count > 0)
}
  {$ENDIF};
end;

procedure TSingleEditorForm.DBGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
  inherited;
  {if TDBGrid(Sender).DataSource.DataSet is TZTable then
    with TZTable(TDBGrid(Sender).DataSource.DataSet) do
    try
      if Field.FieldKind = fkLookup then
        IndexFieldNames :=IndexDefs.FindIndexForFields(FindField(Field.KeyFields).FieldName).Fields
      else
       IndexFieldNames := IndexDefs.FindIndexForFields(Field.FieldName).Fields;
    except
      IndexFieldNames := '';
    end;
    }
end;

procedure TSingleEditorForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
  {
  if TDBGrid(Sender).DataSource.DataSet is TZTable then
    with TZTable(TDBGrid(Sender).DataSource.DataSet) do
      IndexFieldNames := '';
  }
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
  if assigned(DataSource.DataSet) and (DataSource.DataSet.State = dsBrowse) then
    SLRecordNo.Caption := IntToStr(DataSource.DataSet.RecNo) + '/'
      + IntToStr(DataSource.DataSet.RecordCount)
  else
    SLRecordNo.Caption := '';
end;

initialization
{$IFDEF FPC}
  {$i FSingEdt.lrs}
{$ENDIF}

end.

