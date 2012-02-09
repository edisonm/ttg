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
    btnExecuteScript: TButton;
    btnShowMetadata: TButton;
    BtnSaveResults: TButton;
    BtnShowTable: TButton;
    BtnOpenQuery: TButton;
    BtnOpenScript: TButton;
    BtnSaveScript: TButton;
    CbxMetadataType: TComboBox;
    Datasource1: TDatasource;
    DSTables: TDatasource;
    DBGrid1: TDBGrid;
    CbxTable: TDBLookupComboBox;
    Memo1: TMemo;
    OpenScript: TOpenDialog;
    SaveScript: TSaveDialog;
    SaveResults: TSaveDialog;
    ZmdTablesREMARKS: TStringField;
    ZmdTablesTABLE_CAT: TStringField;
    ZmdTablesTABLE_NAME: TStringField;
    ZmdTablesTABLE_SCHEM: TStringField;
    ZmdTablesTABLE_TYPE: TStringField;
    ZQuery1: TZQuery;
    ZSQLMetadata1: TZSQLMetadata;
    ZmdTables: TZSQLMetadata;
    ZTable1: TZTable;
    procedure BtnOpenScriptClick(Sender: TObject);
    procedure BtnOpenQueryClick(Sender: TObject);
    procedure BtnSaveScriptClick(Sender: TObject);
    procedure btnShowMetadataClick(Sender: TObject);
    procedure btnExecuteScriptClick(Sender: TObject);
    procedure BtnSaveResultsClick(Sender: TObject);
    procedure BtnShowTableClick(Sender: TObject);
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
  ZmdTables.Open;
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

procedure TDBExplorerForm.btnShowMetadataClick(Sender: TObject);
begin
  ZSQLMetadata1.Close;
  ZSQLMetadata1.MetadataType := TZMetadataType(CbxMetadataType.ItemIndex);
  ZSQLMetadata1.Open;
  Datasource1.DataSet := ZSQLMetadata1;
end;

procedure TDBExplorerForm.BtnOpenQueryClick(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.AddStrings(Memo1.Lines);
  ZQuery1.Open;
  Datasource1.DataSet := ZQuery1;
end;

procedure TDBExplorerForm.BtnSaveScriptClick(Sender: TObject);
begin
  if SaveScript.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveScript.FileName);
  end;
end;

procedure TDBExplorerForm.BtnOpenScriptClick(Sender: TObject);
begin
  if OpenScript.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenScript.FileName);
  end;
end;

procedure TDBExplorerForm.btnExecuteScriptClick(Sender: TObject);
begin
  if not SourceDataModule.DbZConnection.ExecuteDirect(Memo1.Lines.Text) then
    MessageDlg('Error', 'Error executing SQL', mtError, [mbOk], 0);
  ZmdTables.Close;
  ZSQLMetadata1.Close;
  ZTable1.Close;
  ZQuery1.Close;
  ZmdTables.Open;
  ZmdTables.Refresh;
  CbxTable.Refresh;
  CbxMetadataType.Refresh;
end;

procedure TDBExplorerForm.BtnSaveResultsClick(Sender: TObject);
begin
  if SaveResults.Execute then
  begin
    SaveDataSetToCSVFile(Datasource1.DataSet, SaveResults.FileName);
  end;
end;

procedure TDBExplorerForm.BtnShowTableClick(Sender: TObject);
begin
  ZTable1.Close;
  ZTable1.TableName := CbxTable.Text;
  ZTable1.Open;
  Datasource1.DataSet := ZTable1;
end;

initialization

  {$I fdbexplorer.lrs}

end.
