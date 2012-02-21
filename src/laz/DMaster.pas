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
    QuResourceRestrictionCount: TZTable;
    QuResourceRestrictionCountIdResource: TLongintField;
    QuResourceRestrictionCountNumber: TLongintField;
    QuNewIdTimetable: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowResource: TStrings;
    FStringsShowCluster: TStrings;
    FConfigStorage: TTTGConfig;
    procedure FillResourceRestrictionCount;
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure IntercambiarPeriods(AIdTimetable, AIdCategory,
      AIdParallel, AIdDay1, AIdHour1, AIdDay2, AIdHour2: Integer);
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxResourceWorkLoad: Integer): Boolean;
    function NewIdTimetable: Integer;
    procedure SaveToStrings(AStrings: TStrings);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure SaveToTextDir(const ADirName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextFile(const AFileName: TFileName);
    property StringsShowResource: TStrings read FStringsShowResource;
    property StringsShowCluster: TStrings read FStringsShowCluster;
    property ConfigStorage: TTTGConfig read FConfigStorage;
    procedure NewDatabase;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  UTTGBasics, UTTGDBUtils, UTTGConsts, DSource, DSourceBaseConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

const
  pfhVersionNumber = 293;

procedure TMasterDataModule.FillResourceRestrictionCount;
var
  IdResource, IdResource1: Integer;
  s: string;
begin
  with SourceDataModule, QuResourceRestrictionCount do
  begin
    Close;
    Open;
    s := TbResourceRestriction.IndexFieldNames;
    TbResourceRestriction.IndexFieldNames := 'IdResource';
    TbResourceRestriction.First;
    IdResource := -$7FFFFFFF;
    while not TbResourceRestriction.Eof do
    begin
      IdResource1 := TbResourceRestriction.FindField('IdResource').AsInteger;
      if IdResource <> IdResource1 then
      begin
        Append;
        with QuResourceRestrictionCountNumber do
          Value := 1;
        IdResource := IdResource1;
      end
      else
      begin
        Edit;
        with QuResourceRestrictionCountNumber do
          Value := Value + 1;
      end;
      Post;
      TbResourceRestriction.Next;
    end;
    TbResourceRestriction.IndexFieldNames := s;
  end;
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxResourceWorkLoad: Integer): Boolean;
var
  HaveProblems: Boolean;
  iPeriodCount: Integer;
  procedure GetPeriodCount;
  begin
    iPeriodCount := SourceDataModule.TbPeriod.RecordCount;
  end;
  procedure GetResourceWorkLoad;
  var
    IdResource, IdResource1: Integer;
    s: string;
  begin
    (* ********************* THIS WILL ABORT **********************)
    with SourceDataModule, TbActivity do
    begin
      s := IndexFieldNames;
      IndexFieldNames := 'IdResource';
      First;
      TbTmpResourceWorkLoad.Open;
      IdResource := -$7FFFFFFF;
      while not Eof do
      begin
        IdResource1 := TbActivity.FindField('IdResource').AsInteger;
        if IdResource <> IdResource1 then
        begin
          TbTmpResourceWorkLoad.Append;
          TbTmpResourceWorkLoadIdResource.Value :=
            TbActivity.FindField('IdResource').AsInteger;
          TbTmpResourceWorkLoadWorkLoad.Value :=
            CompositionToDuration(TbActivity.FindField('Composition').AsString);
          IdResource := IdResource1;
        end
        else
        begin
          TbTmpResourceWorkLoad.Edit;
          with TbTmpResourceWorkLoadWorkLoad do
            Value := Value + CompositionToDuration(TbActivity.FindField('Composition').AsString);
        end;
        TbTmpResourceWorkLoad.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  // Comprueba que no hayan asignadas mas horas de materias a profesores de las
  // permitidas
  procedure CheckResourceRestrictionCount;
  var
    HaveInternalProblems: Boolean;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
  begin
    HaveInternalProblems := False;
    with QuResourceRestrictionCount do
    begin
      FillResourceRestrictionCount;
      if not IsEmpty then
      begin
        try
          ASubStrings.Add(SNumSoftResourceRestrictions);
          vSubMin := ASubStrings.Count;
          ASubStrings.Add(SResourceRestrictionsHead);
          while not Eof do
          begin
            if TbTmpResourceWorkLoad.Locate('IdResource',
              QuResourceRestrictionCountIdResource.AsInteger, []) then
            begin
              if QuResourceRestrictionCountNumber.AsInteger +
                TbTmpResourceWorkLoadWorkLoad.AsInteger > iPeriodCount then
              begin
                if not HaveInternalProblems then
                begin
                  AMainStrings.Add(SNumHardResourceRestrictions);
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add(SResourceRestrictionsHead);
                end;
                AMainStrings.Add(Format('%s %s; %d', [
                  TbTmpResourceWorkLoadNaResource.Value,
                  QuResourceRestrictionCountNumber.AsInteger]));
                HaveInternalProblems := True;
                HaveProblems := True;
              end
              else
                ASubStrings.Add(Format('%s %s; %d', [
                  TbTmpResourceWorkLoadNaResource.Value,
                  QuResourceRestrictionCountNumber.AsInteger]));
            end;
            Next;
          end;
        finally
          Close;
        end;
        if HaveInternalProblems then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      end;
    end;
  end;
  procedure CheckResourceWorkLoad;
  var
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    HaveInternalProblems: Boolean;
  begin
    with TbTmpResourceWorkLoad do
      if not IsEmpty then
      begin
        HaveInternalProblems := False;
        First;
        ASubStrings.Add(SResourcesWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(SResourceWorkLoadHead);
        while not Eof do
        begin
          if TbTmpResourceWorkLoadWorkLoad.Value > AMaxResourceWorkLoad then
          begin
            if not HaveInternalProblems then
            begin
              AMainStrings.Add(SResourcesWorkLoadWithProblems);
              vMainMin := AMainStrings.Count;
              AMainStrings.Add(SResourceWorkLoadHead);
            end;
            AMainStrings.Add(Format('%s; %d', [
              TbTmpResourceWorkLoadNaResource.Value,
                TbTmpResourceWorkLoadWorkLoad.Value]));
            HaveProblems := True;
            HaveInternalProblems := True;
          end
          else
          begin
            ASubStrings.Add(Format('%s; %d', [
              TbTmpResourceWorkLoadNaResource.Value,
                TbTmpResourceWorkLoadWorkLoad.Value]));
          end;
          Next;
        end;
        if HaveProblems then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      end;
  end;

  // Comprueba que no hayan asignadas mas horas de materias a Categories que periodos
  procedure CheckCategoryLoad;
  var
    t, vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    HaveInternalProblems: Boolean;
  begin
    with SourceDataModule, TbCluster do
    begin
      s := '%s %s; %d';
      HaveInternalProblems := False;
      try
        Open;
        TbActivity.First;
        TbPeriod.First;
        First;
        ASubStrings.Add(SClusterWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(SClusterWorkLoadHead);
        while not Eof do
        begin
          TbActivity.Filter :=
            Format('IdCategory=%d and IdParallel=%d', [
              TbCluster.FindField('IdCategory').AsInteger,
              TbCluster.FindField('IdParallel').AsInteger]);
          TbActivity.Filtered := true;
          TbActivity.First;
          t := 0;
          try
            while not TbActivity.Eof do
            begin
              Inc(t, CompositionToDuration(TbActivity.FindField('Composition').AsString));
              TbActivity.Next;
            end;
            if (t <= 0) or (t > TbPeriod.RecordCount) then
            begin
              if not HaveInternalProblems then
              begin
                AMainStrings.Add(SClusterWorkLoadWithProblems);
                vMainMin := AMainStrings.Count;
                AMainStrings.Add(SClusterWorkLoadHead);
              end;
              AMainStrings.Add(Format(s, [TbCluster.FindField('AbCategory').Value,
                TbCluster.FindField('NaParallel').Value, t]));
              HaveProblems := True;
              HaveInternalProblems := True;
            end
            else
              ASubStrings.Add(Format(s, [TbCluster.FindField('AbCategory').Value,
                TbCluster.FindField('NaParallel').Value, t]));
          except
            ASubStrings.Add(Format('%s: %s %s %s, %s %s',
              [SProblems, TbCluster.FindField('AbCategory').AsString,
              TbCluster.FindField('NaParallel').AsString,
              STbTheme,
              TbActivity.FindField('NaTheme').AsString]));
            HaveProblems := True;
          end;
          Next;
        end;
        if HaveInternalProblems then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      finally
        TbActivity.Filter := '';
        TbActivity.Filtered := false;
        First;
        TbActivity.First;
      end;
    end;
  end;
begin
  AMainStrings.Clear;
  ASubStrings.Clear;
  AMainStrings.BeginUpdate;
  ASubStrings.BeginUpdate;
  HaveProblems := False;
  try
    GetPeriodCount;
    GetResourceWorkLoad;
    CheckResourceWorkLoad;
    CheckResourceRestrictionCount;
    CheckCategoryLoad;
  finally
    AMainStrings.EndUpdate;
    ASubStrings.EndUpdate;
    TbTmpResourceWorkLoad.Close;
    Result := HaveProblems;
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

procedure TMasterDataModule.IntercambiarPeriods(AIdTimetable, AIdCategory,
  AIdParallel, AIdDay1, AIdHour1, AIdDay2, AIdHour2: Integer);
var
  Locate1, Locate2: Boolean;
  Bookmark1, Bookmark2: TBookmark;
  iIdTheme1, iSession1, iIdTheme2, iSession2: Integer;
begin
  with SourceDataModule do
  begin
    Locate1 := TbTimetableDetail.Locate(
      'IdTimetable;IdCategory;IdParallel;IdDay;IdHour',
      VarArrayOf([AIdTimetable, AIdCategory, AIdParallel, AIdDay1, AIdHour1]), []);
    Bookmark1 := TbTimetableDetail.GetBookmark;
    try
      Locate2 := TbTimetableDetail.Locate(
        'IdTimetable;IdCategory;IdParallel;IdDay;IdHour',
        VarArrayOf([AIdTimetable, AIdCategory, AIdParallel, AIdDay2, AIdHour2]), []);
      Bookmark2 := TbTimetableDetail.GetBookmark;
      try
        if Locate1 and Locate2 then
        begin
          TbTimetableDetail.GotoBookmark(Bookmark1);
          iIdTheme1 := TbTimetableDetail.FindField('IdTheme').AsInteger;
          iSession1 := TbTimetableDetail.FindField('Session').Value;
          TbTimetableDetail.GotoBookmark(Bookmark2);
          iIdTheme2 := TbTimetableDetail.FindField('IdTheme').AsInteger;
          iSession2 := TbTimetableDetail.FindField('Session').Value;
          TbTimetableDetail.Edit;
          TbTimetableDetail.FindField('IdTheme').AsInteger := iIdTheme1;
          TbTimetableDetail.FindField('Session').AsInteger := iSession1;
          TbTimetableDetail.Post;
          TbTimetableDetail.GotoBookmark(Bookmark1);
          TbTimetableDetail.Edit;
          TbTimetableDetail.FindField('IdTheme').AsInteger := iIdTheme2;
          TbTimetableDetail.FindField('Session').AsInteger := iSession2;
          TbTimetableDetail.Post;
        end
        else if Locate1 then
        begin
          TbTimetableDetail.GotoBookmark(Bookmark1);
          TbTimetableDetail.Edit;
          TbTimetableDetail.FindField('IdDay').AsInteger := AIdDay2;
          TbTimetableDetail.FindField('IdHour').AsInteger := AIdHour2;
          TbTimetableDetail.Post;
        end
        else if Locate2 then
        begin
          TbTimetableDetail.GotoBookmark(Bookmark2);
          TbTimetableDetail.Edit;
          TbTimetableDetail.FindField('IdDay').AsInteger := AIdDay1;
          TbTimetableDetail.FindField('IdHour').AsInteger := AIdHour1;
          TbTimetableDetail.Post;
        end;
      finally
        TbTimetableDetail.FreeBookmark(Bookmark2);
      end;
    finally
      TbTimetableDetail.FreeBookmark(Bookmark1);
    end;
  end;
end;

procedure TMasterDataModule.DataModuleCreate(Sender: TObject);
begin
  TbTmpResourceWorkLoadIdResource.DisplayLabel := SFlRequirement_IdResource;
  TbTmpResourceWorkLoadNaResource.DisplayLabel := SFlResource_NaResource;
  TbTmpResourceWorkLoadWorkLoad.DisplayLabel := SLoad;
  
  FStringsShowResource := TStringList.Create;
  FStringsShowCluster := TStringList.Create;
  FConfigStorage := TTTGConfig.Create(Self);
  with FStringsShowResource do
  begin
    add('Cluster=AbCategory;NaParallel');
    add('Cluster_Theme=AbCategory;NaParallel;NaTheme');
    add('Theme=NaTheme');
  end;
  with FStringsShowCluster do
  begin
    add('Theme=NaTheme');
    add('Resource=NaResource');
    add('Theme_Resource=NaTheme;NaResource');
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
      QuCluster.Open;
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
      QuCluster.Open;
      OpenTables;
    end;
    TbActivity.BeforePost := TbActivityBeforePost;
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowResource.Free;
  FStringsShowCluster.Free;
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

