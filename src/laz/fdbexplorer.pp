{ -*- mode: Delphi -*- }
unit fdbexplorer;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, Menus, DbCtrls, ZDataset, ZSqlMetadata, DSource, db;

type

  { TDBExplorerForm }

  TDBExplorerForm = class(TForm)
    BtExecuteScript: TButton;
    BtShowMetadata: TButton;
    BtSaveResults: TButton;
    BtShowTable: TButton;
    BtOpenQuery: TButton;
    BtOpenScript: TButton;
    BtSaveScript: TButton;
    CbxMetadataType: TComboBox;
    Datasource1: TDatasource;
    DSTables: TDatasource;
    DBGrid1: TDBGrid;
    CbxTable: TDBLookupComboBox;
    Memo1: TMemo;
    OpenScript: TOpenDialog;
    SaveScript: TSaveDialog;
    SaveResults: TSaveDialog;
    ZQuery1: TZQuery;
    ZTables: TZQuery;
    ZSQLMetadata1: TZSQLMetadata;
    ZTable1: TZTable;
    procedure BtOpenScriptClick(Sender: TObject);
    procedure BtOpenQueryClick(Sender: TObject);
    procedure BtSaveScriptClick(Sender: TObject);
    procedure BtShowMetadataClick(Sender: TObject);
    procedure BtExecuteScriptClick(Sender: TObject);
    procedure BtSaveResultsClick(Sender: TObject);
    procedure BtShowTableClick(Sender: TObject);
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
  URelUtils;

{ TDBExplorerForm }

procedure TDBExplorerForm.FormCreate(Sender: TObject);
begin
  ZTables.Open;
  CbxTable.ListSource := DSTables;
  with CbxMetadataType.Items do
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
end;

procedure TDBExplorerForm.BtShowMetadataClick(Sender: TObject);
begin
  ZSQLMetadata1.Close;
  ZSQLMetadata1.MetadataType := TZMetadataType(CbxMetadataType.ItemIndex);
  ZSQLMetadata1.Open;
  Datasource1.DataSet := ZSQLMetadata1;
end;

procedure TDBExplorerForm.BtOpenQueryClick(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.AddStrings(Memo1.Lines);
  ZQuery1.Open;
  Datasource1.DataSet := ZQuery1;
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
end;

procedure TDBExplorerForm.BtSaveResultsClick(Sender: TObject);
begin
  if SaveResults.Execute then
  begin
    SaveDataSetToCSVFile(Datasource1.DataSet, SaveResults.FileName);
  end;
end;

procedure TDBExplorerForm.BtShowTableClick(Sender: TObject);
begin
  ZTable1.Close;
  ZTable1.TableName := CbxTable.Text;
  ZTable1.Open;
  Datasource1.DataSet := ZTable1;
end;

procedure TDBExplorerForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

initialization

  {$I fdbexplorer.lrs}

end.
