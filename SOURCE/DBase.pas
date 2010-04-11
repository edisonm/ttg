unit DBase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  kbmMemTable;

type
  TDataSetArray = array of TDataSet;
  TBaseDataModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDataSetNameList: TStrings;
    FDataSetDescList: TStrings;
    FCheckRelations: Boolean;
    function GetDescription(ADataSet: TDataSet): string;
    function GetName(ADataSet: TDataSet): string;
  protected
    FTables: TDataSetArray;
    FBeforePostLocks: array of Boolean;
    property DataSetNameList: TStrings read FDataSetNameList;
    property DataSetDescList: TStrings read FDataSetDescList;
    procedure SaveToStrings(AStrings: TStrings); virtual;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); virtual;
    procedure LoadFromBinaryStream(AStream: TStream);
    procedure SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
  public
    procedure OpenTables;
    procedure CloseTables;
    procedure EmptyTables;
    procedure LoadFromBinaryFile(const AFileName: string);
    procedure LoadFromTextDir(const ADirName: string);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToBinaryFile(const AFileName: TFileName; flags:TkbmMemTableSaveFlags);
    procedure SaveToTextDir(const ADirName: TFileName); virtual;
    procedure SaveToTextFile(const AFileName: TFileName);
    
    property CheckRelations: Boolean read FCheckRelations write FCheckRelations;
    property Tables: TDataSetArray read FTables write FTables;
    property Description[ADataSet: TDataSet]: string read GetDescription;
    property Name[ADataSet: TDataSet]: string read GetName;
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
    SaveDataSetToCSVFile(Tables[i], ADirName + '\' + Name[Tables[i]] + '.csv');
end;

procedure TBaseDataModule.LoadFromTextDir(const ADirName: string);
var
  i: Integer;
begin
  FCheckRelations := False;
  try
    for i := Low(FTables) to High(FTables) do
      LoadDataSetFromCSVFile(Tables[i], ADirName + '\' + Name[Tables[i]] + '.csv');
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

procedure TBaseDataModule.LoadFromBinaryFile(const AFileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead + fmShareDenyNone);
  try
    LoadFromBinaryStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TBaseDataModule.LoadFromBinaryStream(AStream: TStream);
var
  i: Integer;
begin
  FCheckRelations := False;
  try
    for i := Low(FTables) to High(FTables) do
      (FTables[i] as TkbmMemTable).LoadFromBinaryStream(AStream);
  finally
    FCheckRelations := True;
  end;
end;

procedure TBaseDataModule.SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
var
  i: Integer;
begin
  for i := Low(FTables) to High(FTables) do
    (FTables[i] as TkbmMemTable).SaveToBinaryStream(AStream, flags);
end;

procedure TBaseDataModule.SaveToBinaryFile(const AFileName: TFileName; flags:TkbmMemTableSaveFlags);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToBinaryStream(Stream, flags);
  finally
    Stream.Free;
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
  result := DataSetDescList.Values[ADataSet.Name];
end;

function TBaseDataModule.GetName(ADataSet: TDataSet): string;
begin
  result := DataSetNameList.Values[ADataSet.Name];
end;

end.
