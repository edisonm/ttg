{ -*- mode: Delphi -*- }
unit DMaster;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics, DB,
  Controls, Forms, Dialogs, ZDataset, Variants, UTTGConfig;

type

  { TMasterDataModule }

  TMasterDataModule = class(TDataModule)
    TbTmpResourceWorkLoad: TZTable;
    TbTmpResourceWorkLoadIdResource: TLongintField;
    TbTmpResourceWorkLoadNaResource: TStringField;
    TbTmpResourceWorkLoadWorkLoad: TLongintField;
    QuRestrictionCount: TZTable;
    QuRestrictionCountIdResource: TLongintField;
    QuRestrictionCountNumber: TLongintField;
    QuNewIdTimetable: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowResource: TStrings;
    FConfigStorage: TTTGConfig;
    procedure FillRestrictionCount;
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    function NewIdTimetable: Integer;
    procedure SaveToStrings(AStrings: TStrings);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure SaveToTextDir(const ADirName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextFile(const AFileName: TFileName);
    property StringsShowResource: TStrings read FStringsShowResource;
    property ConfigStorage: TTTGConfig read FConfigStorage;
    procedure NewDatabase;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  UTTGConsts, DSource, DSourceBaseConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

const
  pfhVersionNumber = 293;

procedure TMasterDataModule.FillRestrictionCount;
var
  IdResource, IdResource1: Integer;
  s: string;
begin
  with SourceDataModule, QuRestrictionCount do
  begin
    Close;
    Open;
    s := TbRestriction.IndexFieldNames;
    TbRestriction.IndexFieldNames := 'IdResource';
    TbRestriction.First;
    IdResource := -$7FFFFFFF;
    while not TbRestriction.Eof do
    begin
      IdResource1 := TbRestriction.FindField('IdResource').AsInteger;
      if IdResource <> IdResource1 then
      begin
        Append;
        with QuRestrictionCountNumber do
          Value := 1;
        IdResource := IdResource1;
      end
      else
      begin
        Edit;
        with QuRestrictionCountNumber do
          Value := Value + 1;
      end;
      Post;
      TbRestriction.Next;
    end;
    TbRestriction.IndexFieldNames := s;
  end;
end;

function TMasterDataModule.NewIdTimetable: Integer;
begin
  with QuNewIdTimetable do
  begin
    Open;
    try
      if Eof and Bof then
        Result := 1
      else
        Result := QuNewIdTimetable.Fields[0].AsInteger;
    finally
      Close;
    end;
  end;
end;

procedure TMasterDataModule.SaveToStrings(AStrings: TStrings);
begin
  AStrings.Add('TTD ' + IntToStr(pfhVersionNumber));
  SourceDataModule.SaveToStrings(AStrings);
  SaveIniStrings(AStrings);
end;

procedure TMasterDataModule.SaveIniStrings(AStrings: TStrings);
begin
  AStrings.Add(IntToStr(FConfigStorage.ConfigStrings.Count));
  AStrings.AddStrings(FConfigStorage.ConfigStrings);
end;

procedure TMasterDataModule.SaveToTextDir(const ADirName: TFileName);
begin
  SourceDataModule.SaveToTextDir(ADirName);
  FConfigStorage.ConfigStrings.SaveToFile(ADirName + '/config.ini');
end;

procedure TMasterDataModule.LoadIniStrings(AStrings: TStrings; var APosition: Integer);
var
  Count, Limit: Integer;
begin
  Count := StrToInt(AStrings.Strings[APosition]);
  Inc(APosition);
  Limit := APosition + Count;
  FConfigStorage.ConfigStrings.Clear;
  FConfigStorage.ConfigStrings.Capacity := Count;
  while APosition < Limit do
  begin
    FConfigStorage.ConfigStrings.Add(AStrings[APosition]);
    Inc(APosition);
  end;
end;

procedure TMasterDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
begin
  // version stored in AStrings.Strings[APosition];
  Inc(APosition);
  SourceDataModule.LoadFromStrings(AStrings, APosition);
  LoadIniStrings(AStrings, APosition);
end;

procedure TMasterDataModule.DataModuleCreate(Sender: TObject);
begin
  TbTmpResourceWorkLoadIdResource.DisplayLabel := SFlParticipant_IdResource;
  TbTmpResourceWorkLoadNaResource.DisplayLabel := SFlResource_NaResource;
  TbTmpResourceWorkLoadWorkLoad.DisplayLabel := SLoad;
  
  FStringsShowResource := TStringList.Create;
  FConfigStorage := TTTGConfig.Create(Self);
  with FStringsShowResource do
  begin
    Add('Theme=NaTheme');
    Add('Activity=NaActivity');
    Add('Theme_Activity=NaTheme;NaActivity');
  end;
  with SourceDataModule do
  begin
    DbZConnection.Connect;
    DbZConnection.ExecuteDirect('pragma journal_mode=off');
    DbZConnection.ExecuteDirect('pragma foreign_keys=on');
    if DbZConnection.Database = ':memory:' then
    begin
      DbZConnection.ExecuteDirect(LazarusResources.Find('ttg', 'SQL').Value);
      PrepareTables;
      QuResource.Open;
      OpenTables;
      if Paramcount <> 1 then
      begin
        NewDatabase;
        ConfigStorage.SetDefaults;
      end;
    end
    else
    begin
      PrepareTables;
      QuResource.Open;
      OpenTables;
    end;
    TbTheme.BeforePost := TbThemeBeforePost;
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowResource.Free;
end;

procedure TMasterDataModule.NewDatabase;
begin
  SourceDataModule.EmptyTables;
  ConfigStorage.ConfigStrings.Clear;
  SourceDataModule.FillDefaultData;
end;

procedure TMasterDataModule.LoadFromTextFile(const AFileName: TFileName);
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

procedure TMasterDataModule.SaveToTextFile(const AFileName: TFileName);
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

initialization
{$IFDEF FPC}
  {$i DMaster.lrs}
{$ENDIF}
  
{$i ttgsql.lrs}

end.

