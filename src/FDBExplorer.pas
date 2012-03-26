{ -*- mode: Delphi -*- }
unit FDBExplorer;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterSQL, SynMemo, LResources, Forms,
  Controls, Graphics, Dialogs, db, StdCtrls, Menus, DbCtrls,
  ExtCtrls, ActnList, ZDataset, ZSqlMetadata, DSource, FSingleEditor;

type

  { TDBExplorerForm }

  TDBExplorerForm = class(TSingleEditorForm)
    BtExecuteScript: TButton;
    BtOpenQuery: TButton;
    BtOpenScript: TButton;
    BtSaveResults: TButton;
    BtSaveScript: TButton;
    CBMetadataType: TComboBox;
    CBTable: TDBLookupComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    DSTables: TDatasource;
    OpenScript: TOpenDialog;
    Panel3: TPanel;
    SaveScript: TSaveDialog;
    SaveResults: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Memo1: TSynMemo;
    SynSQLSyn1: TSynSQLSyn;
    TBShowMetadata: TButton;
    TBShowTable: TButton;
    ZQuery1: TZQuery;
    ZTables: TZQuery;
    ZSQLMetadata1: TZSQLMetadata;
    ZTable1: TZTable;
    procedure BtOpenScriptClick(Sender: TObject);
    procedure BtOpenQueryClick(Sender: TObject);
    procedure BtSaveScriptClick(Sender: TObject);
    procedure TBShowMetadataClick(Sender: TObject);
    procedure BtExecuteScriptClick(Sender: TObject);
    procedure BtSaveResultsClick(Sender: TObject);
    procedure TBShowTableClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DBExplorerForm: TDBExplorerForm;

implementation

uses
  UDataSetToStrings;

{ TDBExplorerForm }

procedure TDBExplorerForm.FormCreate(Sender: TObject);
begin
  ZTables.Open;
  CBTable.ListSource := DSTables;
  with CBMetadataType.Items do
  begin
    Clear;
    Add('mdProcedures');
    Add('mdProcedureColumns');
    Add('mdTables');
    Add('mdSchemas');
    Add('mdCatalogs');
    Add('mdTableTypes');
    Add('mdColumns');
    Add('mdColumnPrivileges');
    Add('mdTablePrivileges');
    Add('mdBestRowIdentifier');
    Add('mdVersionColumns');
    Add('mdPrimaryKeys');
    Add('mdImportedKeys');
    Add('mdExportedKeys');
    Add('mdCrossReference');
    Add('mdTypeInfo');
    Add('mdIndexInfo');
    Add('mdSequences');
    Add('mdUserDefinedTypes');
  end;
  with SynSQLSyn1.TableNames do
  begin
    ZTables.First;
    Clear;
    while not ZTables.EOF do
    begin
      Add(ZTables.FindField('Name').AsString);
      ZTables.Next;
    end;
    ZTables.First;
  end;
end;

procedure TDBExplorerForm.TBShowMetadataClick(Sender: TObject);
begin
  ZSQLMetadata1.Close;
  ZSQLMetadata1.MetadataType := TZMetadataType(CBMetadataType.ItemIndex);
  ZSQLMetadata1.Open;
  DataSource.DataSet := ZSQLMetadata1;
end;

procedure TDBExplorerForm.BtOpenQueryClick(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.AddStrings(Memo1.Lines);
  ZQuery1.Open;
  DataSource.DataSet := ZQuery1;
end;

procedure TDBExplorerForm.BtSaveScriptClick(Sender: TObject);
begin
  if SaveScript.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveScript.FileName);
  end;
end;

procedure TDBExplorerForm.BtOpenScriptClick(Sender: TObject);
begin
  if OpenScript.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenScript.FileName);
  end;
end;

procedure TDBExplorerForm.BtExecuteScriptClick(Sender: TObject);
begin
  if not SourceDataModule.DbZConnection.ExecuteDirect(Memo1.Lines.GetText) then
    MessageDlg('Error', 'Error executing SQL', mtError, [mbOk], 0);
  ZTables.Close;
  ZSQLMetadata1.Close;
  ZTable1.Close;
  ZQuery1.Close;
  ZTables.Open;
  // SourceDataModule.RefreshTables;
end;

procedure TDBExplorerForm.BtSaveResultsClick(Sender: TObject);
begin
  if SaveResults.Execute then
  begin
    SaveDataSetToCSVFile(DataSource.DataSet, SaveResults.FileName);
  end;
end;

procedure TDBExplorerForm.TBShowTableClick(Sender: TObject);
begin
  ZTable1.Close;
  ZTable1.TableName := CBTable.Text;
  ZTable1.Open;
  DataSource.DataSet := ZTable1;
end;

procedure TDBExplorerForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

initialization

  {$I FDBExplorer.lrs}

end.
