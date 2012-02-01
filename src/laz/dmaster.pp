{ -*- mode: Delphi -*- }
unit DMaster;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics, DB,
  Controls, Forms, Dialogs, ZConnection, ZDataset, Variants, UTTGConfig;

type

  { TMasterDataModule }

  TMasterDataModule = class(TDataModule)
    TbTmpTeacherCarga: TZTable;
    TbTmpTeacherCargaIdTeacher: TLongintField;
    TbTmpTeacherCargaNaTeacher: TStringField;
    TbTmpTeacherCargaLnTeacher: TStringField;
    TbTmpTeacherCargaCarga: TLongintField;
    QuDistributionTeacher: TZTable;
    QuDistributionTeacherIdSubject: TLongintField;
    QuDistributionTeacherIdLevel: TLongintField;
    QuDistributionTeacherIdGroupId: TLongintField;
    QuDistributionTeacherNaSubject: TStringField;
    QuDistributionTeacherAbLevel: TStringField;
    QuDistributionTeacherNaGroupId: TStringField;
    QuDistributionTeacherIdTeacher: TLongintField;
    QuDistributionTeacherApeNaTeacher: TStringField;
    QuDistributionTeacherIdSpecialization: TLongintField;
    QuDistributionTeacherAbSpecialization: TStringField;
    QuTeacherRestrictionCant: TZTable;
    QuTeacherRestrictionCantIdTeacher: TLongintField;
    QuTeacherRestrictionCantNumber: TLongintField;
    TbTmpRoomTypeCarga: TZTable;
    TbTmpRoomTypeCargaIdRoomType: TLongintField;
    TbTmpRoomTypeCargaAbRoomType: TStringField;
    TbTmpRoomTypeCargaCarga: TLongintField;
    QuNewIdTimeTable: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowRoomType: TStrings;
    FStringsShowTeacher: TStrings;
    FStringsShowClass: TStrings;
    FConfigStorage: TTTGConfig;
    procedure FillTeacherRestrictionCant;
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure IntercambiarTimeSlots(AIdTimeTable, AIdLevel, AIdSpecialization,
      AIdGroupId, AIdDay1, AIdHour1, AIdDay2, AIdHour2: Integer);
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxCargaTeacher: Integer): Boolean;
    function NewIdTimeTable: Integer;
    procedure SaveToStrings(AStrings: TStrings);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure SaveToTextDir(const ADirName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextFile(const AFileName: TFileName);
    property StringsShowRoomType: TStrings read FStringsShowRoomType;
    property StringsShowTeacher: TStrings read FStringsShowTeacher;
    property StringsShowClass: TStrings read FStringsShowClass;
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
  pfhVersionNumber = 292;

procedure TMasterDataModule.FillTeacherRestrictionCant;
var
  IdTeacher, IdTeacher1: Integer;
  s: string;
begin
  with SourceDataModule, QuTeacherRestrictionCant do
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
        with QuTeacherRestrictionCantNumber do
          Value := 1;
        IdTeacher := IdTeacher1;
      end
      else
      begin
        Edit;
        with QuTeacherRestrictionCantNumber do
          Value := Value + 1;
      end;
      Post;
      TbTeacherRestriction.Next;
    end;
    TbTeacherRestriction.IndexFieldNames := s;
  end;
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxCargaTeacher: Integer): Boolean;
var
  HuboProblemas: Boolean;
  iTimeSlotCant: Integer;
  procedure ObtenerTimeSlotCant;
  begin
    iTimeSlotCant := SourceDataModule.TbTimeSlot.RecordCount;
  end;
  procedure ObtenerTeacherCarga;
  var
    IdTeacher, IdTeacher1: Integer;
    s: string;
  begin
    with SourceDataModule, TbDistribution do
    begin
      s := IndexFieldNames;
      IndexFieldNames := 'IdTeacher';
      First;
      TbTmpTeacherCarga.Open;
      IdTeacher := -$7FFFFFFF;
      while not Eof do
      begin
        IdTeacher1 := TbDistribution.FindField('IdTeacher').AsInteger;
        if IdTeacher <> IdTeacher1 then
        begin
          TbTmpTeacherCarga.Append;
          TbTmpTeacherCargaIdTeacher.Value :=
            TbDistribution.FindField('IdTeacher').AsInteger;
          TbTmpTeacherCargaCarga.Value :=
            CompositionADuracion(TbDistribution.FindField('Composition').AsString);
          IdTeacher := IdTeacher1;
        end
        else
        begin
          TbTmpTeacherCarga.Edit;
          with TbTmpTeacherCargaCarga do
            Value := Value + CompositionADuracion(TbDistribution.FindField('Composition').AsString);
        end;
        TbTmpTeacherCarga.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  procedure ObtenerRoomTypeCarga;
  var
    IdRoomType, IdRoomType1: Integer;
    s: string;  
  begin
    with SourceDataModule, TbDistribution do
    begin
      TbTmpRoomTypeCarga.Open;
      s := IndexFieldNames;
      IndexFieldNames := 'IdRoomType';
      First;
      IdRoomType := -$7FFFFFFF;
      while not Eof do
      begin
        IdRoomType1 := TbDistribution.FindField('IdRoomType').AsInteger;
        if IdRoomType <> IdRoomType1 then
        begin
          TbTmpRoomTypeCarga.Append;
          TbTmpRoomTypeCargaIdRoomType.Value := TbDistribution.FindField('IdRoomType').AsInteger;
          TbTmpRoomTypeCargaCarga.Value := CompositionADuracion(TbDistribution.FindField('Composition').AsString);
          IdRoomType := IdRoomType1;
        end
        else
        begin
          TbTmpRoomTypeCarga.Edit;
          with TbTmpRoomTypeCargaCarga do
            Value := Value + CompositionADuracion(TbDistribution.FindField('Composition').AsString);
        end;
        TbTmpRoomTypeCarga.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  // Comprueba que no hayan asignadas mas horas de materias a profesores de las
  // permitidas
  procedure CheckTeacherRestrictionCant;
  var
    s: string;
    HuboProblemasInterno: Boolean;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
  begin
    HuboProblemasInterno := False;
    s := '%s %s; %d';
    with QuTeacherRestrictionCant do
    begin
      FillTeacherRestrictionCant;
      if not IsEmpty then
      begin
        try
          ASubStrings.Add(SNumSoftTeacherRestrictions);
          vSubMin := ASubStrings.Count;
          ASubStrings.Add(STeacherRestrictionsHead);
          while not Eof do
          begin
            if TbTmpTeacherCarga.Locate('IdTeacher',
              QuTeacherRestrictionCantIdTeacher.AsInteger, []) then
            begin
              if QuTeacherRestrictionCantNumber.AsInteger +
                TbTmpTeacherCargaCarga.AsInteger > iTimeSlotCant then
              begin
                if not HuboProblemasInterno then
                begin
                  AMainStrings.Add(SNumHardTeacherRestrictions);
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add(STeacherRestrictionsHead);
                end;
                AMainStrings.Add(Format(s, [TbTmpTeacherCargaLnTeacher.Value,
                  TbTmpTeacherCargaNaTeacher.Value,
                    QuTeacherRestrictionCantNumber.AsInteger]));
                HuboProblemasInterno := True;
                HuboProblemas := True;
              end
              else
                ASubStrings.Add(Format(s, [TbTmpTeacherCargaLnTeacher.Value,
                  TbTmpTeacherCargaNaTeacher.Value,
                    QuTeacherRestrictionCantNumber.AsInteger]));
            end;
            Next;
          end;
        finally
          Close;
        end;
        if HuboProblemasInterno then
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
  procedure CheckTeacherCarga;
  var
    s: string;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    HuboProblemasInterno: Boolean;
  begin
    with TbTmpTeacherCarga do
      if not IsEmpty then
      begin
        HuboProblemasInterno := False;
        First;
        s := '%s %s; %d';
        ASubStrings.Add(STeachersWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(STeacherWorkLoadHead);
        while not Eof do
        begin
          if TbTmpTeacherCargaCarga.Value > AMaxCargaTeacher then
          begin
            if not HuboProblemasInterno then
            begin
              AMainStrings.Add(STeachersWorkLoadWithProblems);
              vMainMin := AMainStrings.Count;
              AMainStrings.Add(STeacherWorkLoadHead);
            end;
            AMainStrings.Add(Format(s, [TbTmpTeacherCargaLnTeacher.Value,
              TbTmpTeacherCargaNaTeacher.Value,
                TbTmpTeacherCargaCarga.Value]));
            HuboProblemas := True;
            HuboProblemasInterno := True;
          end
          else
          begin
            ASubStrings.Add(Format(s, [TbTmpTeacherCargaLnTeacher.Value,
              TbTmpTeacherCargaNaTeacher.Value,
                TbTmpTeacherCargaCarga.Value]));
          end;
          Next;
        end;
        if HuboProblemas then
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
  procedure CheckRoomTypeCarga;
  var
    c: Integer;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    bRoomTypeActive, HuboProblemasInterno: Boolean;
  begin
    with SourceDataModule, TbTmpRoomTypeCarga do
      if not IsEmpty then
      begin
        HuboProblemasInterno := False;
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
            if TbRoomType.Locate('IdRoomType', TbTmpRoomTypeCargaIdRoomType.AsInteger, []) then
            begin
              c := iTimeSlotCant * TbRoomType.FindField('Number').AsInteger;
              if TbTmpRoomTypeCargaCarga.Value > c then
              begin
                if not HuboProblemasInterno then
                begin
                  AMainStrings.Add(SRoomTypesWithProblems);
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add(SRoomTypesLoadHead);
                end;
                AMainStrings.Add(Format(s, [TbTmpRoomTypeCargaAbRoomType.Value,
                  c, TbTmpRoomTypeCargaCarga.Value]));
                HuboProblemas := True;
                HuboProblemasInterno := True;
              end
              else
              begin
                ASubStrings.Add(Format(s, [TbTmpRoomTypeCargaAbRoomType.Value,
                  c, TbTmpRoomTypeCargaCarga.Value]));
              end;
            end;
            Next;
          end;
        finally
          TbRoomType.Active := bRoomTypeActive;
        end;
        if HuboProblemas then
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
  // Comprueba que no hayan asignadas mas horas de materias a Courses que periodos
  procedure CheckCourseCarga;
  var
    t, vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    HuboProblemasInterno: Boolean;
  begin
    with SourceDataModule, TbClass do
    begin
      s := '%s %s %s; %d';
      HuboProblemasInterno := False;
      try
        Open;
        TbDistribution.First;
        TbTimeSlot.First;
        First;
        ASubStrings.Add(SClassWorkLoadWithoutProblems);
        vSubMin := ASubStrings.Count;
        ASubStrings.Add(SClassWorkLoadHead);
        while not Eof do
        begin
          TbDistribution.Filter :=
            Format('IdLevel=%d and IdSpecialization=%d and IdGroupId=%d', [
            TbClass.FindField('IdLevel').AsInteger,
              TbClass.FindField('IdSpecialization').AsInteger,
              TbClass.FindField('IdGroupId').AsInteger]);
          TbDistribution.Filtered := true;
          TbDistribution.First;
          t := 0;
          try
            while not TbDistribution.Eof do
            begin
              Inc(t, CompositionADuracion(TbDistribution.FindField('Composition').AsString));
              TbDistribution.Next;
            end;
            if (t <= 0) or (t > TbTimeSlot.RecordCount) then
            begin
              if not HuboProblemasInterno then
              begin
                AMainStrings.Add(SClassWorkLoadWithProblems);
                vMainMin := AMainStrings.Count;
                AMainStrings.Add(SClassWorkLoadHead);
              end;
              AMainStrings.Add(Format(s, [TbClass.FindField('AbLevel').Value,
                TbClass.FindField('AbSpecialization').Value,
                TbClass.FindField('NaGroupId').Value, t]));
              HuboProblemas := True;
              HuboProblemasInterno := True;
            end
            else
              ASubStrings.Add(Format(s, [TbClass.FindField('AbLevel').Value,
                TbClass.FindField('AbSpecialization').Value,
                TbClass.FindField('NaGroupId').Value, t]));
          except
            ASubStrings.Add(Format('%s: %s %s %s, %s %s',
              [SProblems, TbClass.FindField('AbLevel').AsString,
              TbClass.FindField('AbSpecialization').AsString,
              TbClass.FindField('NaGroupId').AsString,
              STbSubject,
              TbDistribution.FindField('NaSubject').AsString]));
            HuboProblemas := True;
          end;
          Next;
        end;
        if HuboProblemasInterno then
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
  HuboProblemas := False;
  try
    ObtenerTimeSlotCant;
    ObtenerTeacherCarga;
    ObtenerRoomTypeCarga;
    CheckTeacherCarga;
    CheckTeacherRestrictionCant;
    CheckRoomTypeCarga;
    CheckCourseCarga;
  finally
    AMainStrings.EndUpdate;
    ASubStrings.EndUpdate;
    TbTmpTeacherCarga.Close;
    TbTmpRoomTypeCarga.Close;
    Result := HuboProblemas;
  end;
end;

function TMasterDataModule.NewIdTimeTable: Integer;
begin
  with QuNewIdTimeTable do
  begin
    Open;
    try
      if Eof and Bof then
        Result := 1
      else
        Result := QuNewIdTimeTable.Fields[0].AsInteger;
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

procedure TMasterDataModule.IntercambiarTimeSlots(AIdTimeTable, AIdLevel,
  AIdSpecialization, AIdGroupId, AIdDay1, AIdHour1, AIdDay2,
  AIdHour2: Integer);
var
  Locate1, Locate2: Boolean;
  Bookmark1, Bookmark2: TBookmark;
  iIdSubject1, iSession1, iIdSubject2, iSession2: Integer;
begin
  with SourceDataModule do
  begin
    Locate1 := TbTimeTableDetail.Locate(
      'IdTimeTable;IdLevel;IdSpecialization;IdGroupId;IdDay;IdHour',
      VarArrayOf([AIdTimeTable, AIdLevel, AIdSpecialization, AIdGroupId,
      AIdDay1, AIdHour1]), []);
    Bookmark1 := TbTimeTableDetail.GetBookmark;
    try
      Locate2 := TbTimeTableDetail.Locate(
        'IdTimeTable;IdLevel;IdSpecialization;IdGroupId;IdDay;IdHour',
        VarArrayOf([AIdTimeTable, AIdLevel, AIdSpecialization, AIdGroupId,
        AIdDay2, AIdHour2]), []);
      Bookmark2 := TbTimeTableDetail.GetBookmark;
      try
        if Locate1 and Locate2 then
        begin
          TbTimeTableDetail.GotoBookmark(Bookmark1);
          iIdSubject1 := TbTimeTableDetail.FindField('IdSubject').AsInteger;
          iSession1 := TbTimeTableDetail.FindField('Session').Value;
          TbTimeTableDetail.GotoBookmark(Bookmark2);
          iIdSubject2 := TbTimeTableDetail.FindField('IdSubject').AsInteger;
          iSession2 := TbTimeTableDetail.FindField('Session').Value;
          TbTimeTableDetail.Edit;
          TbTimeTableDetail.FindField('IdSubject').AsInteger := iIdSubject1;
          TbTimeTableDetail.FindField('Session').AsInteger := iSession1;
          TbTimeTableDetail.Post;
          TbTimeTableDetail.GotoBookmark(Bookmark1);
          TbTimeTableDetail.Edit;
          TbTimeTableDetail.FindField('IdSubject').AsInteger := iIdSubject2;
          TbTimeTableDetail.FindField('Session').AsInteger := iSession2;
          TbTimeTableDetail.Post;
        end
        else if Locate1 then
        begin
          TbTimeTableDetail.GotoBookmark(Bookmark1);
          TbTimeTableDetail.Edit;
          TbTimeTableDetail.FindField('IdDay').AsInteger := AIdDay2;
          TbTimeTableDetail.FindField('IdHour').AsInteger := AIdHour2;
          TbTimeTableDetail.Post;
        end
        else if Locate2 then
        begin
          TbTimeTableDetail.GotoBookmark(Bookmark2);
          TbTimeTableDetail.Edit;
          TbTimeTableDetail.FindField('IdDay').AsInteger := AIdDay1;
          TbTimeTableDetail.FindField('IdHour').AsInteger := AIdHour1;
          TbTimeTableDetail.Post;
        end;
      finally
        TbTimeTableDetail.FreeBookmark(Bookmark2);
      end;
    finally
      TbTimeTableDetail.FreeBookmark(Bookmark1);
    end;
  end;
end;

procedure TMasterDataModule.DataModuleCreate(Sender: TObject);
var
  LResource: TLResource;
begin
  FStringsShowRoomType := TStringList.Create;
  FStringsShowTeacher := TStringList.Create;
  FStringsShowClass := TStringList.Create;
  FConfigStorage := TTTGConfig.Create(Self);
  with FStringsShowRoomType do
  begin
    add('Level_Class=AbLevel;NaGroupId');
    add('Level_Class_Subject=AbLevel;NaGroupId;NaSubject');
    add('Level_Class_Specialization=AbLevel;NaGroupId;AbSpecialization');
    add('Level_Class_Specialization_Subject=AbLevel;NaGroupId;AbSpecialization;NaSubject');
    add('Level_Specialization_Class=AbLevel;AbSpecialization;NaGroupId');
    add('Level_Specialization_Class_Subject=AbLevel;AbSpecialization;NaGroupId;NaSubject');
    add('Subject=NaSubject');
  end;
  with FStringsShowTeacher do
  begin
    add('Level_Class=AbLevel;NaGroupId');
    add('Level_Class_Subject=AbLevel;NaGroupId;NaSubject');
    add('Level_Class_Specialization=AbLevel;NaGroupId;AbSpecialization');
    add('Level_Class_Specialization_Subject=AbLevel;NaGroupId;AbSpecialization;NaSubject');
    add('Level_Specialization_Class=AbLevel;AbSpecialization;NaGroupId');
    add('Level_Specialization_Class_Subject=AbLevel;AbSpecialization;NaGroupId;NaSubject');
    add('Subject=NaSubject');
  end;
  with FStringsShowClass do
  begin
    add('Subject=NaSubject');
    add('Teacher=LnTeacher;NaTeacher');
    add('Subject_Teacher=NaSubject;LnTeacher;NaTeacher');
  end;
  with SourceDataModule do
  begin
    DbZConnection.Connect;
    if DbZConnection.Database = ':memory:' then
    begin
      DbZConnection.ExecuteDirect('pragma journal_mode=off');
      with LazarusResources.Find('ttg', 'SQL') do
        DbZConnection.ExecuteDirect(Value);
      PrepareTables;
      OpenTables;
      NewDatabase;
      ConfigStorage.SetDefaults;
    end
    else
    begin
      DbZConnection.ExecuteDirect('pragma journal_mode=off');
      PrepareTables;
      OpenTables;
    end;
    TbDistribution.BeforePost := TbDistributionBeforePost;
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowRoomType.Free;
  FStringsShowTeacher.Free;
  FStringsShowClass.Free;
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

