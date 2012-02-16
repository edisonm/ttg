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
    TbTmpTeacherWorkLoad: TZTable;
    TbTmpTeacherWorkLoadIdTeacher: TLongintField;
    TbTmpTeacherWorkLoadNaTeacher: TStringField;
    TbTmpTeacherWorkLoadLnTeacher: TStringField;
    TbTmpTeacherWorkLoadWorkLoad: TLongintField;
    QuTeacherRestrictionCount: TZTable;
    QuTeacherRestrictionCountIdTeacher: TLongintField;
    QuTeacherRestrictionCountNumber: TLongintField;
    TbTmpRoomTypeLoad: TZTable;
    TbTmpRoomTypeLoadIdRoomType: TLongintField;
    TbTmpRoomTypeLoadAbRoomType: TStringField;
    TbTmpRoomTypeLoadLoad: TLongintField;
    QuNewIdTimetable: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowRoomType: TStrings;
    FStringsShowTeacher: TStrings;
    FStringsShowCluster: TStrings;
    FConfigStorage: TTTGConfig;
    procedure FillTeacherRestrictionCount;
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure IntercambiarTimeSlots(AIdTimetable, AIdCategory,
      AIdParallel, AIdDay1, AIdHour1, AIdDay2, AIdHour2: Integer);
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxTeacherWorkLoad: Integer): Boolean;
    function NewIdTimetable: Integer;
    procedure SaveToStrings(AStrings: TStrings);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure SaveToTextDir(const ADirName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextFile(const AFileName: TFileName);
    property StringsShowRoomType: TStrings read FStringsShowRoomType;
    property StringsShowTeacher: TStrings read FStringsShowTeacher;
    property StringsShowCluster: TStrings read FStringsShowCluster;
    property ConfigStorage: TTTGConfig read FConfigStorage;
    procedure NewDatabase;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  UTTGBasics, UTTGDBUtils, UTTGConsts, DSource, dsourcebaseconsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

const
  pfhVersionNumber = 293;

procedure TMasterDataModule.FillTeacherRestrictionCount;
var
  IdTeacher, IdTeacher1: Integer;
  s: string;
begin
  with SourceDataModule, QuTeacherRestrictionCount do
  begin
    Close;
    Open;
    s := TbTeacherRestriction.IndexFieldNames;
    TbTeacherRestriction.IndexFieldNames := 'IdTeacher';
    TbTeacherRestriction.First;
    IdTeacher := -$7FFFFFFF;
    while not TbTeacherRestriction.Eof do
    begin
      IdTeacher1 := TbTeacherRestriction.FindField('IdTeacher').AsInteger;
      if IdTeacher <> IdTeacher1 then
      begin
        Append;
        with QuTeacherRestrictionCountNumber do
          Value := 1;
        IdTeacher := IdTeacher1;
      end
      else
      begin
        Edit;
        with QuTeacherRestrictionCountNumber do
          Value := Value + 1;
      end;
      Post;
      TbTeacherRestriction.Next;
    end;
    TbTeacherRestriction.IndexFieldNames := s;
  end;
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxTeacherWorkLoad: Integer): Boolean;
var
  HaveProblems: Boolean;
  iTimeSlotCount: Integer;
  procedure ObtenerTimeSlotCount;
  begin
    iTimeSlotCount := SourceDataModule.TbTimeSlot.RecordCount;
  end;
  procedure ObtenerTeacherWorkLoad;
  var
    IdTeacher, IdTeacher1: Integer;
    s: string;
  begin
    with SourceDataModule, TbDistribution do
    begin
      s := IndexFieldNames;
      IndexFieldNames := 'IdTeacher';
      First;
      TbTmpTeacherWorkLoad.Open;
      IdTeacher := -$7FFFFFFF;
      while not Eof do
      begin
        IdTeacher1 := TbDistribution.FindField('IdTeacher').AsInteger;
        if IdTeacher <> IdTeacher1 then
        begin
          TbTmpTeacherWorkLoad.Append;
          TbTmpTeacherWorkLoadIdTeacher.Value :=
            TbDistribution.FindField('IdTeacher').AsInteger;
          TbTmpTeacherWorkLoadWorkLoad.Value :=
            CompositionToDuration(TbDistribution.FindField('Composition').AsString);
          IdTeacher := IdTeacher1;
        end
        else
        begin
          TbTmpTeacherWorkLoad.Edit;
          with TbTmpTeacherWorkLoadWorkLoad do
            Value := Value + CompositionToDuration(TbDistribution.FindField('Composition').AsString);
        end;
        TbTmpTeacherWorkLoad.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  procedure ObtenerRoomTypeLoad;
  var
    IdRoomType, IdRoomType1: Integer;
    s: string;  
  begin
    with SourceDataModule, TbDistribution do
    begin
      TbTmpRoomTypeLoad.Open;
      s := IndexFieldNames;
      IndexFieldNames := 'IdRoomType';
      First;
      IdRoomType := -$7FFFFFFF;
      while not Eof do
      begin
        IdRoomType1 := TbDistribution.FindField('IdRoomType').AsInteger;
        if IdRoomType <> IdRoomType1 then
        begin
          TbTmpRoomTypeLoad.Append;
          TbTmpRoomTypeLoadIdRoomType.Value := TbDistribution.FindField('IdRoomType').AsInteger;
          TbTmpRoomTypeLoadLoad.Value := CompositionToDuration(TbDistribution.FindField('Composition').AsString);
          IdRoomType := IdRoomType1;
        end
        else
        begin
          TbTmpRoomTypeLoad.Edit;
          with TbTmpRoomTypeLoadLoad do
            Value := Value + CompositionToDuration(TbDistribution.FindField('Composition').AsString);
        end;
        TbTmpRoomTypeLoad.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  // Comprueba que no hayan asignadas mas horas de materias a profesores de las
  // permitidas
  procedure CheckTeacherRestrictionCount;
  var
    s: string;
    HaveInternalProblems: Boolean;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
  begin
    HaveInternalProblems := False;
    s := '%s %s; %d';
    with QuTeacherRestrictionCount do
    begin
      FillTeacherRestrictionCount;
      if not IsEmpty then
      begin
        try
          ASubStrings.Add(SNumSoftTeacherRestrictions);
          vSubMin := ASubStrings.Count;
          ASubStrings.Add(STeacherRestrictionsHead);
          while not Eof do
          begin
            if TbTmpTeacherWorkLoad.Locate('IdTeacher',
              QuTeacherRestrictionCountIdTeacher.AsInteger, []) then
            begin
              if QuTeacherRestrictionCountNumber.AsInteger +
                TbTmpTeacherWorkLoadWorkLoad.AsInteger > iTimeSlotCount then
              begin
                if not HaveInternalProblems then
                begin
                  AMainStrings.Add(SNumHardTeacherRestrictions);
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add(STeacherRestrictionsHead);
                end;
                AMainStrings.Add(Format(s, [TbTmpTeacherWorkLoadLnTeacher.Value,
                  TbTmpTeacherWorkLoadNaTeacher.Value,
                    QuTeacherRestrictionCountNumber.AsInteger]));
                HaveInternalProblems := True;
                HaveProblems := True;
              end
              else
                ASubStrings.Add(Format(s, [TbTmpTeacherWorkLoadLnTeacher.Value,
                  TbTmpTeacherWorkLoadNaTeacher.Value,
                    QuTeacherRestrictionCountNumber.AsInteger]));
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
  procedure CheckTeacherWorkLoad;
  var
    s: string;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    HaveInternalProblems: Boolean;
  begin
    with TbTmpTeacherWorkLoad do
      if not IsEmpty then
      begin
        HaveInternalProblems := False;
        First;
        s := '%s %s; %d';
        ASubStrings.Add(STeachersWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(STeacherWorkLoadHead);
        while not Eof do
        begin
          if TbTmpTeacherWorkLoadWorkLoad.Value > AMaxTeacherWorkLoad then
          begin
            if not HaveInternalProblems then
            begin
              AMainStrings.Add(STeachersWorkLoadWithProblems);
              vMainMin := AMainStrings.Count;
              AMainStrings.Add(STeacherWorkLoadHead);
            end;
            AMainStrings.Add(Format(s, [TbTmpTeacherWorkLoadLnTeacher.Value,
              TbTmpTeacherWorkLoadNaTeacher.Value,
                TbTmpTeacherWorkLoadWorkLoad.Value]));
            HaveProblems := True;
            HaveInternalProblems := True;
          end
          else
          begin
            ASubStrings.Add(Format(s, [TbTmpTeacherWorkLoadLnTeacher.Value,
              TbTmpTeacherWorkLoadNaTeacher.Value,
                TbTmpTeacherWorkLoadWorkLoad.Value]));
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

  // Chequea que existan las aulas suficientes para una materia dada
  procedure CheckRoomTypeLoad;
  var
    c: Integer;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    bRoomTypeActive, HaveInternalProblems: Boolean;
  begin
    with SourceDataModule, TbTmpRoomTypeLoad do
      if not IsEmpty then
      begin
        HaveInternalProblems := False;
        bRoomTypeActive := TbRoomType.Active;
        try
          TbRoomType.First;
          First;
          s := '%s; %d; %d';
          ASubStrings.Add(SRoomTypesWithoutProblems);
          vSubMin := ASubStrings.Count;
          ASubStrings.Add(SRoomTypesLoadHead);
          while not Eof do
          begin
            if TbRoomType.Locate('IdRoomType', TbTmpRoomTypeLoadIdRoomType.AsInteger, []) then
            begin
              c := iTimeSlotCount * TbRoomType.FindField('Number').AsInteger;
              if TbTmpRoomTypeLoadLoad.Value > c then
              begin
                if not HaveInternalProblems then
                begin
                  AMainStrings.Add(SRoomTypesWithProblems);
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add(SRoomTypesLoadHead);
                end;
                AMainStrings.Add(Format(s, [TbTmpRoomTypeLoadAbRoomType.Value,
                  c, TbTmpRoomTypeLoadLoad.Value]));
                HaveProblems := True;
                HaveInternalProblems := True;
              end
              else
              begin
                ASubStrings.Add(Format(s, [TbTmpRoomTypeLoadAbRoomType.Value,
                  c, TbTmpRoomTypeLoadLoad.Value]));
              end;
            end;
            Next;
          end;
        finally
          TbRoomType.Active := bRoomTypeActive;
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
        TbDistribution.First;
        TbTimeSlot.First;
        First;
        ASubStrings.Add(SClusterWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(SClusterWorkLoadHead);
        while not Eof do
        begin
          TbDistribution.Filter :=
            Format('IdCategory=%d and IdParallel=%d', [
              TbCluster.FindField('IdCategory').AsInteger,
              TbCluster.FindField('IdParallel').AsInteger]);
          TbDistribution.Filtered := true;
          TbDistribution.First;
          t := 0;
          try
            while not TbDistribution.Eof do
            begin
              Inc(t, CompositionToDuration(TbDistribution.FindField('Composition').AsString));
              TbDistribution.Next;
            end;
            if (t <= 0) or (t > TbTimeSlot.RecordCount) then
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
              TbDistribution.FindField('NaTheme').AsString]));
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
        TbDistribution.Filter := '';
        TbDistribution.Filtered := false;
        First;
        TbDistribution.First;
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
    ObtenerTimeSlotCount;
    ObtenerTeacherWorkLoad;
    ObtenerRoomTypeLoad;
    CheckTeacherWorkLoad;
    CheckTeacherRestrictionCount;
    CheckRoomTypeLoad;
    CheckCategoryLoad;
  finally
    AMainStrings.EndUpdate;
    ASubStrings.EndUpdate;
    TbTmpTeacherWorkLoad.Close;
    TbTmpRoomTypeLoad.Close;
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

procedure TMasterDataModule.IntercambiarTimeSlots(AIdTimetable, AIdCategory,
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
  TbTmpTeacherWorkLoadIdTeacher.DisplayLabel := SFlDistribution_IdTeacher;
  TbTmpTeacherWorkLoadLnTeacher.DisplayLabel := SFlTeacher_LnTeacher;
  TbTmpTeacherWorkLoadNaTeacher.DisplayLabel := SFlTeacher_NaTeacher;
  TbTmpTeacherWorkLoadWorkLoad.DisplayLabel := SLoad;
  TbTmpRoomTypeLoadIdRoomType.DisplayLabel := SFlDistribution_IdRoomType;
  TbTmpRoomTypeLoadAbRoomType.DisplayLabel := SFlRoomType_NaRoomType;
  TbTmpRoomTypeLoadLoad.DisplayLabel := SLoad;
  
  FStringsShowRoomType := TStringList.Create;
  FStringsShowTeacher := TStringList.Create;
  FStringsShowCluster := TStringList.Create;
  FConfigStorage := TTTGConfig.Create(Self);
  with FStringsShowRoomType do
  begin
    add('Cluster=AbCategory;NaParallel');
    add('Cluster_Theme=AbCategory;NaParallel;NaTheme');
    add('Theme=NaTheme');
  end;
  with FStringsShowTeacher do
  begin
    add('Cluster=AbCategory;NaParallel');
    add('Cluster_Theme=AbCategory;NaParallel;NaTheme');
    add('Theme=NaTheme');
  end;
  with FStringsShowCluster do
  begin
    add('Theme=NaTheme');
    add('Teacher=LnTeacher;NaTeacher');
    add('Theme_Teacher=NaTheme;LnTeacher;NaTeacher');
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
      QuTeacher.Open;
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
      QuTeacher.Open;
      QuCluster.Open;
      OpenTables;
    end;
    TbDistribution.BeforePost := TbDistributionBeforePost;
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowRoomType.Free;
  FStringsShowTeacher.Free;
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
  {$i dmaster.lrs}
{$ENDIF}
  
{$i ttgsql.lrs}

end.

