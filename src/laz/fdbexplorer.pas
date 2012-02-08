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
    btnExecuteQuery: TButton;
    btnShowMetadata: TButton;
    BtnSaveResults: TButton;
    BtnShowTable: TButton;
    BtnOpenQuery: TButton;
    CbxMetadataType: TComboBox;
    Datasource1: TDatasource;
    DSTables: TDatasource;
    DBGrid1: TDBGrid;
    CbxTable: TDBLookupComboBox;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    ZmdTablesREMARKS: TStringField;
    ZmdTablesTABLE_CAT: TStringField;
    ZmdTablesTABLE_NAME: TStringField;
    ZmdTablesTABLE_SCHEM: TStringField;
    ZmdTablesTABLE_TYPE: TStringField;
    ZQuery1: TZQuery;
    ZSQLMetadata1: TZSQLMetadata;
    ZmdTables: TZSQLMetadata;
    ZTable1: TZTable;
    procedure BtnOpenQueryClick(Sender: TObject);
    procedure btnShowMetadataClick(Sender: TObject);
    procedure btnExecuteQueryClick(Sender: TObject);
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

procedure TDBExplorerForm.btnExecuteQueryClick(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.AddStrings(Memo1.Lines);
  ZQuery1.ExecSQL;
end;

procedure TDBExplorerForm.BtnSaveResultsClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveDataSetToCSVFile(Datasource1.DataSet, SaveDialog1.FileName);
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
