unit DBase;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  kbmMemTable;

type
  TDataSetArray = array of TDataSet;
  
  TMasterRel = record
    DetailDataSet: TkbmMemTable;
    MasterFields: string;
    DetailFields: string;
    Cascade: Boolean;
  end;
  
  TDetailRel = record
    MasterDataSet: TDataSet;
    MasterFields: string;
    DetailFields: string;
  end;

  TBaseDataModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataSetBeforePost(DataSet: TDataSet);
    procedure DataSetBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FDataSetNameList: TStrings;
    FDataSetDescList: TStrings;
    FCheckRelations: Boolean;
    function GetDescription(ADataSet: TDataSet): string;
    function GetNameDataSet(ADataSet: TDataSet): string;
  protected
    FTables: TDataSetArray;
    FBeforePostLocks: array of Boolean;
    FMasterRels: array of array of TMasterRel;
    FDetailRels: array of array of TDetailRel;
    property DataSetNameList: TStrings read FDataSetNameList;
    property DataSetDescList: TStrings read FDataSetDescList;
    procedure SaveToStrings(AStrings: TStrings); virtual;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); virtual;
  public
    procedure OpenTables;
    procedure CloseTables;
    procedure EmptyTables;
//    procedure ExecuteAction(DoAction: procedure of object);
    procedure LoadFromTextDir(const ADirName: string);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextDir(const ADirName: TFileName); virtual;
    procedure SaveToTextFile(const AFileName: TFileName);

    property CheckRelations: Boolean read FCheckRelations write FCheckRelations;
    property Tables: TDataSetArray read FTables write FTables;
    property Description[ADataSet: TDataSet]: string read GetDescription;
    property NameDataSet[ADataSet: TDataSet]: string read GetNameDataSet;
    { Public declarations }
  end;

var
  BaseDataModule: TBaseDataModule;

implementation

{$R *.DFM}

uses
  RelUtils;

procedure TBaseDataModule.OpenTables;
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    FTables[i].Open;
end;

procedure TBaseDataModule.CloseTables;
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    FTables[i].Close;
end;

procedure TBaseDataModule.SaveToTextDir(const ADirName: TFileName);
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    SaveDataSetToCSVFile(Tables[i], ADirName + '\' + NameDataSet[Tables[i]] + '.csv');
end;

procedure TBaseDataModule.LoadFromTextDir(const ADirName: string);
var
  i: Integer;
begin
  FCheckRelations := False;
  try
    for i := Low(FTables) to High(FTables) do
      LoadDataSetFromCSVFile(Tables[i], ADirName + '\' + NameDataSet[Tables[i]] + '.csv');
  finally
    FCheckRelations := True;
  end;
end;


procedure TBaseDataModule.EmptyTables;
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    (FTables[i] as TkbmMemTable).EmptyTable;
end;

procedure TBaseDataModule.DataModuleCreate(Sender: TObject);
begin
  FDataSetNameList := TStringList.Create;
  FDataSetDescList := TStringList.Create;
  FCheckRelations := True;
end;

procedure TBaseDataModule.DataModuleDestroy(Sender: TObject);
begin
  CloseTables;
  FDataSetNameList.Free;
  FDataSetDescList.Free;
end;

procedure TBaseDataModule.SaveToStrings(AStrings: TStrings);
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    SaveDataSetToStrings(FTables[i], AStrings);
end;

procedure TBaseDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
var
  i: Integer;
begin
  FCheckRelations := False;
  try
    for i := Low(FTables) to High(FTables) do
      LoadDataSetFromStrings(Tables[i], AStrings, APosition);
  finally
    FCheckRelations := True;
  end;
end;

procedure TBaseDataModule.SaveToTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
begin
  AStrings := TStringList.Create;
  try
    SaveToStrings(AStrings);
    AStrings.SaveToFile(AFileName);
  finally
    AStrings.Free;
  end;
end;

procedure TBaseDataModule.LoadFromTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
  APosition: Integer;
begin
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromFile(AFileName);
    APosition := 0;
    LoadFromStrings(AStrings, APosition);
  finally
    AStrings.Free;
  end;
end;

function TBaseDataModule.GetDescription(ADataSet: TDataSet): string;
begin
  Result := DataSetDescList.Values[ADataSet.Name];
  if Result = '' then
    Result := ADataSet.Name;
end;

function TBaseDataModule.GetNameDataSet(ADataSet: TDataSet): string;
begin
  Result := DataSetNameList.Values[ADataSet.Name];
  if Result = '' then
    Result := ADataSet.Name;
end;

procedure TBaseDataModule.DataSetBeforePost(DataSet: TDataSet);
var
   i, j: Integer;
begin
  i := DataSet.Tag;
  if CheckRelations and not FBeforePostLocks[i] then
  begin
    FBeforePostLocks[i] := True;
    try
      for j := Low(FDetailRels[i]) to High(FDetailRels[i]) do
        with FDetailRels[i, j] do
          CheckDetailRelation(MasterDataSet, DataSet as TkbmMemTable, MasterFields, DetailFields);
      if DataSet.State = dsEdit then
      begin
	      for j := Low(FMasterRels[i]) to High(FMasterRels[i]) do
          with FMasterRels[i, j] do
            CheckMasterRelationUpdate(DataSet, DetailDataSet, MasterFields,
                                      DetailFields, Cascade);
      end;
    finally
      FBeforePostLocks[i] := False
    end;
  end;
end;

procedure TBaseDataModule.DataSetBeforeDelete(DataSet: TDataSet);
var
   i, j: Integer;
begin
  i := DataSet.Tag;
  if CheckRelations then
  begin
    for j := Low(FMasterRels[i]) to High(FMasterRels[i]) do
      with FMasterRels[i, j] do
        CheckMasterRelationUpdate(DataSet, DetailDataSet, MasterFields,
                                  DetailFields, Cascade);
  end;
end;

end.
