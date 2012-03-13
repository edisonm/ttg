{ -*- mode: Delphi -*- }
unit UTTModel;

{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}CThreads, CMem, {$ENDIF}Classes, DB, Dialogs, Forms, UModel,
  UTTGBasics;

type
  TTimetable = class;
  TTimetableArray = array of TTimetable;

  { TTimetableModel }


  TTimetableModel = class(TModel)
    (* Class TTimetableModel: Implements the load of the DataBase to
       the RAM memory.
       
       IMPORTANT NOTE: We are using BubbleSort instead of QuickSort
       because we need to ensure equal sort order when de Keys are not
       unique.  Note that QuickSort takes a random position as pivot. *)
  private
    FClashActivityValue: Integer;
    FBrokenSessionValue: Integer;
    FBreakTimetableResourceValue: Integer;
    FNonScatteredActivityValue: Integer;
    FThemeCount: Integer;
    FResourceTypeCount: Integer;
    FRestrictionTypeCount: Integer;
    FDayCount: Integer;
    FHourCount: Integer;
    FPeriodCount: Integer;
    FResourceCount: Integer;
    FActivityCount: Integer;
    FSessionCount: Integer;
    FMinIdActivity: Integer;
    FMinIdDay: Integer;
    FMinIdHour: Integer;
    FMinIdResource: Integer;
    
    FPeriodToDay: TDynamicIntegerArray;
    FPeriodToHour: TDynamicIntegerArray;
    FDayToMaxPeriod: TDynamicIntegerArray;
    FSessionToActivity: TDynamicIntegerArray;
    FSessionToTheme: TDynamicIntegerArray;
    FResourceToNumResource: TDynamicIntegerArray;
    FResourceToName: TDynamicStringArray;
    FResourceSorted: TDynamicIntegerArray;
    FActivitySorted: TDynamicIntegerArray;
    FSessionSorted: TDynamicIntegerArray;
    FResourceToResourceType: TDynamicIntegerArray;
    FRestrictionTypeToValue: TDynamicIntegerArray;
    FRestrictionTypeToName: TDynamicStringArray;
    FResourceTypeToValue: TDynamicIntegerArray;
    FResourceTypeToName: TDynamicStringArray;
    FResourceTypeToNumResourceLimit: TDynamicIntegerArray;
    FThemeToIdTheme: TDynamicIntegerArray;
    FThemeToName: TDynamicStringArray;
    FDayToIdDay: TDynamicIntegerArray;
    FHourToIdHour: TDynamicIntegerArray;
    FActivityToIdActivity: TDynamicIntegerArray;
    FIdActivityToActivity: TDynamicIntegerArray;
    FResourceToIdResource: TDynamicIntegerArray;
    FIdResourceToResource: TDynamicIntegerArray;
    FActivityToTheme: TDynamicIntegerArray;
    FActivityToName: TDynamicStringArray;
    FIdDayToDay: TDynamicIntegerArray;
    FIdHourToHour: TDynamicIntegerArray;

    // Sessions are grouped to facilitate mutations.
    // Swap of sessions only have sense in elements of the same group
    // FLastResourceWithNewActivities: Integer;
    // GroupCount == Last Resource with New Activities
    // FResourceSorted[Group] == Resource with New Activities
    FGroupCount: Integer;
    FGroupSessions: TDynamicIntegerArrayArray;

    FSessionToDuration: TDynamicIntegerArray;
    FDayHourToPeriod: TDynamicIntegerArrayArray;
    // Tmpl means: structures that are copied as is to TTimetable
    // and can be modified during the optimization
    FActivityParticipantToResource: TDynamicIntegerArrayArray;
    FTmplActivityParticipantToNumResource: TDynamicIntegerArrayArray;
    FTmplActivityResourceTypeToNumber: TDynamicIntegerArrayArray;
    FThemeWithMobileResources: TDynamicIntegerArray;
    FActivityToNumFixeds: TDynamicIntegerArray;
    FResourceToActivities: TDynamicIntegerArrayArray;
    FThemeResourceTypeToLimit: TDynamicIntegerArrayArray;
    FThemeToActivities: TDynamicIntegerArrayArray;
    FThemeToDuration: TDynamicIntegerArray;
    FResourceToThemes: TDynamicIntegerArrayArray;
    FActivityToSessions: TDynamicIntegerArrayArray;
    FResourcePeriodToRestrictionType: TDynamicIntegerArrayArray;

    function GetDayToMaxPeriod(Day: Integer): Integer;
  protected
    //property TimetableDetailPattern: TDynamicIntegerArrayArray read FTimetableDetailPattern;
    function GetElitistCount: Integer; override;
  public
    procedure Configure(AClashActivityValue, ABreakTimetableResourceValue,
                        ABrokenSessionValue, ANonScatteredActivityValue: Integer);
    constructor Create(AClashActivityValue, ABreakTimetableResourceValue,
                       ABrokenSessionValue, ANonScatteredActivityValue: Integer);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TIndividual; override;
    property PeriodCount: Integer read FPeriodCount;
    property SessionCount: Integer read FSessionCount;
    property ClashActivityValue: Integer read FClashActivityValue;
    property BreakTimetableResourceValue: Integer read FBreakTimetableResourceValue;
    property BrokenSessionValue: Integer read FBrokenSessionValue;
    property NonScatteredActivityValue: Integer read FNonScatteredActivityValue;
    property SessionToDuration: TDynamicIntegerArray read FSessionToDuration;
    property ElitistCount: Integer read GetElitistCount;
  end;

  // type
  // TCountFunc = procedure(Count, Cant: Integer) of object;
  {
    Clase TTimetable
    Descripcion:
    Implementa una solucion del problema.
    Miembros privados:
    Todos los arreglos dinamicos que contienen la informacion consistentes en
    el horario, las claves aleatorias y datos temporales que aceleran la
    evaluacion de la funcion objetivo, los campos que contienen los valores
    de cada parte de la funcion objetivo y las funciones de uso interno.
    Miembros protegidos:
    Propiedad que forza a que se reevalue toda la funcion objetivo.
    Miembros publicos:
    propiedades que devuelven el valor de cada componente de la funcion
    objetivo, el valor de la funcion objetivo, el constructor, funciones que
    permiten guardar el horario en una base de datos, metodos que consisten
    en los operadores geneticos, como son cruce, mutacion, etc., TimetableModel
    al que pertenece esta solucion.
  }

  { Manual Tabling:
    Here we have information that can be returned recalculating Values of the
    TTimetable object, but that are preserved here in order to optimize
    computations.
  }
  { TTimetableTablingInfo }
  TTimetableTablingInfo = class
  protected
    FClashActivity: Integer;
    FBreakTimetableResource: Integer;
    FNonScatteredActivity: Integer;
    FBrokenSession: Integer;
    
    FClashResourceType: TDynamicIntegerArray;
    FRestrictionTypeToResourceCount: TDynamicIntegerArray;
    FPriorityActivity: TDynamicIntegerArray;
    
    FActivityResourceTypeToNumber: TDynamicIntegerArrayArray;
    FDayActivityAccumulated: TDynamicIntegerArrayArray;
    FDayActivityCount: TDynamicIntegerArrayArray;
    FDayResourceEmptyHourCount: TDynamicIntegerArrayArray;
    FDayResourceMaxHour: TDynamicIntegerArrayArray;
    FDayResourceMinHour: TDynamicIntegerArrayArray;
    FResourcePeriodNumber: TDynamicIntegerArrayArray;
  public
    procedure Assign(ATimetableTablingInfo: TTimetableTablingInfo);
  end;

  { TTimetable }

  TTimetable = class(TIndividual)
  private
    FTablingInfo: TTimetableTablingInfo;
    FTTSessionToPeriod: TDynamicIntegerArray;
    FTTActivityToNumResources: TDynamicIntegerArrayArray;
    procedure CrossGroup(Timetable2: TTimetable; AGroup: Integer);
    procedure DeltaActivityParticipantValue(Activity, Participant, DeltaNumResource: Integer);
    procedure DeltaResourceValue(Period1, Period2, Resource, NumResource: Integer);
    procedure DeltaResourcesValue(Sign, Period1, Period2: Integer;
                                  Resources, NumResources: TDynamicIntegerArray);
    procedure DeltaPeriodsValue(Sign, Period1, Period2, Activity: Integer);
    procedure DeltaValue(Sign, Session: Integer);
    function GetClashActivityValue: Integer;
    function GetNonScatteredActivityValue: Integer;
    function GetClashResourceValue: Integer;
    function GetRestrictionValue: Integer;
    function GetBreakTimetableResourceValue: Integer;
    function GetBrokenSessionValue: Integer;
    function GetValue: Integer;
    procedure Reset;
    {$IFDEF DEBUG}
    procedure CheckIntegrity(const ALabel: string);
    {$ENDIF}
  protected
    function GetElitistValues(Index: Integer): Integer; override;
  public
    constructor Create(ATimetableModel: TTimetableModel);
    destructor Destroy; override;
    {Implements abstract class TIndividual:}
    procedure Update; override;
    procedure UpdateValue; override;
    procedure DoUpdateValue; inline;
    function NewBookmark: TBookmark; override;
    procedure SaveToDataModule(IdTimetable: Integer;
      TimeIni, TimeEnd: TDateTime; Summary: TStrings); override;
    procedure LoadFromDataModule(IdTimetable: Integer); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure MakeRandom; override;
    procedure Mutate; override;
    procedure ReportValues(AReport: TStrings); override;
    procedure Assign(AIndividual: TIndividual); override;
    procedure Cross(AIndividual: TIndividual); override;

    function Swap(Session1, Session2: Integer): Integer;
    procedure DoSwap(Session1, Session2: Integer);
    function MoveSession(Session, Period: Integer): Integer;
    procedure DoMoveSession(Session, Period: Integer);
    {procedure SaveToFile(const AFileName: string);}
    property RestrictionTypeToResourceCount: TDynamicIntegerArray
      read FTablingInfo.FRestrictionTypeToResourceCount;
    property ClashResourceType: TDynamicIntegerArray read FTablingInfo.FClashResourceType;
    property NonScatteredActivity: Integer read FTablingInfo.FNonScatteredActivity;
    property BrokenSession: Integer read FTablingInfo.FBrokenSession;
    property ClashActivity: Integer read FTablingInfo.FClashActivity;
    property ClashResourceValue: Integer read GetClashResourceValue;
    property ClashActivityValue: Integer read GetClashActivityValue;
    property BreakTimetableResourceValue: Integer read GetBreakTimetableResourceValue;
    property BrokenSessionValue: Integer read GetBrokenSessionValue;
    property NonScatteredActivityValue: Integer read GetNonScatteredActivityValue;
    property RestrictionValue: Integer read GetRestrictionValue;
    property TTSessionToPeriod: TDynamicIntegerArray
                                  read FTTSessionToPeriod;
    property TTActivityToNumResources: TDynamicIntegerArrayArray
                                          read FTTActivityToNumResources;
    property ActivityResourceTypeToNumber: TDynamicIntegerArrayArray
                                                 read FTablingInfo.FActivityResourceTypeToNumber;

    property BreakTimetableResource: Integer read FTablingInfo.FBreakTimetableResource;
    property TablingInfo: TTimetableTablingInfo read FTablingInfo;
  end;
  
  { TTTBookmark }
  TTTBookmark = class(TBookmark)
  private
    function GetTimetable: TTimetable; inline;
    function GetTimetableModel: TTimetableModel; inline;
  public
    constructor Create(ATimetable: TTimetable);
    function Eof: Boolean; override;
    property Timetable: TTimetable read GetTimetable;
    property TimetableModel: TTimetableModel read GetTimetableModel;
  end;
   
  { TTTBookmark1 }

  // Move one Session to one Period
  TTTBookmark1 = class(TTTBookmark)
  private
    FSession: Integer;
    FPeriod: Integer;
    FPreviousPeriod: Integer;
  protected
  public
    procedure First; override;
    procedure Next; override;
    function Bof: Boolean; override;
    function Move: Integer; override;
    function Undo: Integer; override;
  end;

  { TTTBookmark2 }

  TTTBookmark2 = class(TTTBookmark)
  private
    FGroup: Integer;
    FGroupSession1: Integer;
    FGroupSession2: Integer;
    FPreviousPeriod1: Integer;
    FPreviousPeriod2: Integer;
  protected
    function GetMaxPosition: Integer; override;
  public
    procedure First; override;
    procedure Next; override;
    function Bof: Boolean; override;
    function Move: Integer; override;
    function Undo: Integer; override;
  end;

  { TTTBookmark3 }

  TTTBookmark3 = class(TTTBookmark)
  private
    FGroup: Integer;
    FGroupSession1: Integer;
    FGroupSession2: Integer;
    FGroupSession3: Integer;
    FPreviousPeriod1: Integer;
    FPreviousPeriod2: Integer;
    FPreviousPeriod3: Integer;
  protected
    function GetMaxPosition: Integer; override;
  public
    procedure First; override;
    procedure Next; override;
    function Bof: Boolean; override;
    function Move: Integer; override;
    function Undo: Integer; override;
  end;
  
  TTTBookmarkTheme = class(TTTBookmark)
  private
    FThemeIndex: Integer;
    FThemeActivity1: Integer;
    FThemeActivity2: Integer;
    FParticipant11: Integer;
    FParticipant12: Integer;
    FPreviousDeltaNumResource1: Integer;
    FPreviousDeltaNumResource2: Integer;
    FDeltaNumResource1: Integer;
    FDeltaNumResource2: Integer;
    function GetActivity1: Integer; inline;
    function GetActivity2: Integer; inline;
    function GetResource1: Integer; inline;
    function GetResource2: Integer; inline;
    function GetNumFixeds1: Integer; inline;
    function GetNumFixeds2: Integer; inline;
    function GetParticipant21: Integer; inline;
    function GetParticipant22: Integer; inline;
    function GetNumResource11: Integer; inline;
    function GetNumResource21: Integer; inline;
    function GetNumResource12: Integer; {$IFNDEF DEBUG}inline;{$ENDIF}
    function GetNumResource22: Integer; {$IFNDEF DEBUG}inline;{$ENDIF}
    function GetFree11: Integer; inline;
    function GetFree21: Integer; inline;
    function GetFree12: Integer; inline;
    function GetFree22: Integer; inline;
    function GetTheme: Integer; inline;
    function GetLimit: Integer; inline;
    function GetResourceType1: Integer; inline;
    function GetResourceType2: Integer; inline;
  protected
    function GetMaxPosition: Integer; override;
  public
    procedure First; override;
    procedure Next; override;
    function Bof: Boolean; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    property Offset: Integer read FOffset write FOffset;
    property Activity1: Integer read GetActivity1;
    property Activity2: Integer read GetActivity2;
    property Resource1: Integer read GetResource1;
    property Resource2: Integer read GetResource2;
    property NumFixeds1: Integer read GetNumFixeds1;
    property NumFixeds2: Integer read GetNumFixeds2;
    property ResourceType1: Integer read GetResourceType1;
    property ResourceType2: Integer read GetResourceType2;
    property Participant11: Integer read FParticipant11;
    property Participant12: Integer read FParticipant12;
    property Participant21: Integer read GetParticipant21;
    property Participant22: Integer read GetParticipant22;
    property NumResource11: Integer read GetNumResource11;
    property NumResource21: Integer read GetNumResource21;
    property NumResource12: Integer read GetNumResource12;
    property NumResource22: Integer read GetNumResource22;
    property Free11: Integer read GetFree11;
    property Free21: Integer read GetFree21;
    property Free12: Integer read GetFree12;
    property Free22: Integer read GetFree22;
    property Limit: Integer read GetLimit;
    property Theme: Integer read GetTheme;
  end;
  
implementation

uses
  SysUtils, ZSysUtils, MTProcs, DSource, UTTGConsts, DSourceBaseConsts, USortAlgs, Math;

type
  TSortInteger = specialize TSortAlgorithm<Integer,Integer>;

constructor TTimetableModel.Create(AClashActivityValue,
                                   ABreakTimetableResourceValue,
                                   ABrokenSessionValue,
                                   ANonScatteredActivityValue: Integer);
var
  FThemeToLimits: TDynamicIntegerArrayArray;
  FThemeToResources: TDynamicIntegerArrayArray;
  FThemeToNumResources: TDynamicIntegerArrayArray;
  FActivityToResources: TDynamicIntegerArrayArray;
  FActivityToNumResources: TDynamicIntegerArrayArray;
  FResourceThemeToNumResources: TDynamicIntegerArrayArray;
  FThemeToComposition: TDynamicIntegerArrayArray;
  FMinIdRestrictionType, FMinIdTheme, FMinIdResourceType: Integer;
  FIdThemeToTheme, FIdResourceTypeToResourceType,
    FResourceTypeToIdResourceType,
    FIdRestrictionTypeToRestrictionType,
    FRestrictionTypeToIdRestrictionType: TDynamicIntegerArray;
  SErrors: String;
  procedure Load(ATable: TDataSet; const AListName: string; out FMinIdList: Integer;
    out FIdListToList: TDynamicIntegerArray;
    out FListToIdList: TDynamicIntegerArray);
  var
    Field: TField;
    Index, Value, MaxIdList: Integer;
  begin
    with ATable do
    begin
      First;
      Field := FindField(AListName);
      FMinIdList := Field.AsInteger;
      MaxIdList := Field.AsInteger;
      SetLength(FListToIdList, RecordCount);
      for Index := 0 to RecordCount - 1 do
      begin
        Value := Field.AsInteger;
        if MaxIdList < Value then
          MaxIdList := Value;
        if FMinIdList > Value then
          FMinIdList := Value;
        FListToIdList[Index] := Value;
        Next;
      end;
      First;
      SetLength(FIdListToList, MaxIdList - FMinIdList + 1);
      for Index := 0 to RecordCount - 1 do
      begin
        FIdListToList[Field.AsInteger - FMinIdList] := Index;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadPeriod;
  var
    Period, Day, Hour: Integer;
    FieldDay, FieldHour: TField;
  begin
    with SourceDataModule.TbPeriod do
    begin
      IndexFieldNames := 'IdDay;IdHour';
      First;
      FPeriodCount := RecordCount;
      SetLength(FPeriodToDay, FPeriodCount);
      SetLength(FDayToMaxPeriod, FDayCount);
      SetLength(FPeriodToHour, FPeriodCount);
      SetLength(FDayHourToPeriod, FDayCount, FHourCount);
      for Day := 0 to FDayCount - 1 do
        for Hour := 0 to FHourCount - 1 do
          FDayHourToPeriod[Day, Hour] := -1;
      FieldDay := FindField('IdDay');
      FieldHour := FindField('IdHour');
      for Period := 0 to FPeriodCount - 1 do
      begin
        Day := FIdDayToDay[FieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[FieldHour.AsInteger - FMinIdHour];
        FPeriodToDay[Period] := Day;
        FPeriodToHour[Period] := Hour;
        FDayHourToPeriod[Day, Hour] := Period;
        Next;
      end;
      for Day := 0 to FDayCount - 1 do
      begin
        FDayToMaxPeriod[Day] := GetDayToMaxPeriod(Day);
      end;
      First;
    end;
  end;
  procedure LoadResourceType;
  var
    ResourceType: Integer;
    FieldValue, FieldName, FieldNumResourceLimit: TField;
  begin
    with SourceDataModule.TbResourceType do
    begin
      IndexFieldNames := 'IdResourceType';
      First;
      FieldName := FindField('NaResourceType');
      FieldValue := FindField('ValResourceType');
      FieldNumResourceLimit := FindField('NumResourceLimit');
      SetLength(FResourceTypeToName, FResourceTypeCount);
      SetLength(FResourceTypeToValue, FResourceTypeCount);
      SetLength(FResourceTypeToNumResourceLimit, FResourceTypeCount);
      for ResourceType := 0 to FResourceTypeCount - 1 do
      begin
        FResourceTypeToName[ResourceType] := FieldName.AsString;
        FResourceTypeToValue[ResourceType] := FieldValue.AsInteger;
        FResourceTypeToNumResourceLimit[ResourceType] := FieldNumResourceLimit.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResource;
  var
    Resource: Integer;
    FieldResourceType, FieldResourceNumber, FieldResourceName: TField;
  begin
    with SourceDataModule.TbResource do
    begin
      IndexFieldNames := 'IdResource';
      First;
      FieldResourceType := FindField('IdResourceType');
      FieldResourceNumber := FindField('NumResource');
      FieldResourceName := FindField('NaResource');
      SetLength(FResourceToResourceType, FResourceCount);
      SetLength(FResourceToNumResource, FResourceCount);
      SetLength(FResourceToName, FResourceCount);
      for Resource := 0 to FResourceCount - 1 do
      begin
        FResourceToResourceType[Resource] :=
          FIdResourceTypeToResourceType[FieldResourceType.AsInteger - FMinIdResourceType];
        FResourceToNumResource[Resource] := FieldResourceNumber.AsInteger;
        FResourceToName[Resource] := FieldResourceName.AsString;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadRestrictionType;
  var
    RestrictionType: Integer;
    FieldValue, FieldName: TField;
  begin
    with SourceDataModule.TbRestrictionType do
    begin
      IndexFieldNames := 'IdRestrictionType';
      First;
      FieldValue := FindField('ValRestrictionType');
      FieldName := FindField('NaRestrictionType');
      SetLength(FRestrictionTypeToValue, RecordCount);
      SetLength(FRestrictionTypeToName, RecordCount);
      for RestrictionType := 0 to RecordCount - 1 do
      begin
        FRestrictionTypeToValue[RestrictionType] := FieldValue.AsInteger;
        FRestrictionTypeToName[RestrictionType] := FieldName.AsString;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadRestriction;
  var
    Restriction, Resource, Period, Day, Hour,
      RestrictionType: Integer;
    FieldResource, FieldDay, FieldHour,
      FieldRestrictionType: TField;
  begin
    with SourceDataModule.TbRestriction do
    begin
      IndexFieldNames := 'IdResource;IdDay;IdHour;IdRestrictionType';
      First;
      SetLength(FResourcePeriodToRestrictionType, FResourceCount, FPeriodCount);
      for Resource := 0 to FResourceCount - 1 do
        for Period := 0 to FPeriodCount - 1 do
          FResourcePeriodToRestrictionType[Resource, Period] := -1;
      FieldResource := FindField('IdResource');
      FieldHour := FindField('IdHour');
      FieldDay := FindField('IdDay');
      FieldRestrictionType := FindField('IdRestrictionType');
      for Restriction := 0 to RecordCount - 1 do
      begin
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        Day := FIdDayToDay[FieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[FieldHour.AsInteger - FMinIdHour];
        Period := FDayHourToPeriod[Day, Hour];
        RestrictionType := FIdRestrictionTypeToRestrictionType
          [FieldRestrictionType.AsInteger - FMinIdRestrictionType];
        FResourcePeriodToRestrictionType[Resource, Period] := RestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure LoadTheme;
  var
    Theme, CompositionCount, VPos, Duration: Integer;
    FieldComposition, FieldName: TField;
    Composition: string;
  begin
    with SourceDataModule.TbTheme do
    begin
      IndexFieldNames := 'IdTheme';
      First;
      FieldComposition := FindField('Composition');
      FieldName := FindField('NaTheme');
      SetLength(FThemeToComposition, FThemeCount, 0);
      SetLength(FThemeToName, FThemeCount);
      SetLength(FThemeToDuration, FThemeCount);
      for Theme := 0 to FThemeCount - 1 do
      begin
        Composition := FieldComposition.AsString;
        FThemeToName[Theme] := FieldName.AsString;
        VPos := 1;
        CompositionCount := 0;
        FThemeToDuration[Theme] := 0;
        while VPos <= Length(Composition) do
        begin
          SetLength(FThemeToComposition[Theme], CompositionCount + 1);
          Duration := StrToInt(ExtractString(Composition, VPos, '.'));
          FThemeToComposition[Theme, CompositionCount] := Duration;
          Inc(FThemeToDuration[Theme], Duration);
          Inc(CompositionCount);
        end;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadActivity;
  var
    Count, Theme, Session1, Activity, Session2, Session: Integer;
    FieldTheme, FieldName: TField;
  begin
    with SourceDataModule.TbActivity do
    begin
      IndexFieldNames := 'IdActivity';
      First;
      FieldTheme := FindField('IdTheme');
      FieldName := FindField('NaActivity');
      FActivityCount := RecordCount;
      SetLength(FActivityToSessions, FActivityCount);
      SetLength(FActivityToTheme, FActivityCount);
      SetLength(FThemeToActivities, FThemeCount, 0);
      Session2 := 0;
      SetLength(FActivityToName, FActivityCount);
      for Activity := 0 to FActivityCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        FActivityToTheme[Activity] := Theme;
        FActivityToName[Activity] := FieldName.AsString;
        Count := Length(FThemeToActivities[Theme]);
        SetLength(FThemeToActivities[Theme], Count + 1);
        FThemeToActivities[Theme, Count] := Activity;
        Session1 := Session2;
        SetLength(FSessionToDuration, Session1 + Length(FThemeToComposition[Theme]));
        while Session2 < Length(FSessionToDuration) do
        begin
          FSessionToDuration[Session2] := FThemeToComposition[Theme, Session2 - Session1];
          Inc(Session2);
        end;
        SetLength(FSessionToActivity, Session2);
        SetLength(FActivityToSessions[Activity], Session2 - Session1);
        for Session := Session1 to Session2 - 1 do
        begin
          FSessionToActivity[Session] := Activity;
          FActivityToSessions[Activity, Session - Session1] := Session;
        end;
        Next;
      end;
      FSessionCount := Session2;
      SetLength(FSessionToTheme, FSessionCount);
      for Session := 0 to FSessionCount - 1 do
      begin
        Activity := FSessionToActivity[Session];
        FSessionToTheme[Session] := FActivityToTheme[Activity];
      end;
    end;
  end;
  procedure LoadParticipant;
  var
    Participant, Count, ParticipantCount, Activity, Resource, Number,
      ResourceType: Integer;
    FieldActivity, FieldResource, FieldNumResource: TField;
  begin
    with SourceDataModule.TbParticipant do
    begin
      IndexFieldNames := 'IdActivity;IdResource';
      First;
      ParticipantCount := RecordCount;
      SetLength(FActivityToResources, FActivityCount, 0);
      SetLength(FActivityToNumResources, FActivityCount, 0);
      SetLength(FTmplActivityResourceTypeToNumber, FActivityCount, FResourceTypeCount);
      for Activity := 0 to FActivityCount - 1 do
        for ResourceType := 0 to FResourceTypeCount - 1 do
          FTmplActivityResourceTypeToNumber[Activity, ResourceType] := 0;
      FieldActivity := FindField('IdActivity');
      FieldResource := FindField('IdResource');
      FieldNumResource := FindField('NumResource');
      for Participant := 0 to ParticipantCount - 1 do
      begin
        Activity := FIdActivityToActivity[FieldActivity.AsInteger - FMinIdActivity];
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        Count := Length(FActivityToResources[Activity]);
        SetLength(FActivityToResources[Activity], Count + 1);
        SetLength(FActivityToNumResources[Activity], Count + 1);
        FActivityToResources[Activity, Count] := Resource;
        Number := FieldNumResource.AsInteger;
        FActivityToNumResources[Activity, Count] := Number;
        Inc(FTmplActivityResourceTypeToNumber[Activity, FResourceToResourceType[Resource]], Number);
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceTypeLimit;
  var
    ResourceTypeLimit, ResourceTypeLimitCount, Theme, ResourceType: Integer;
    FieldTheme, FieldResourceType, FieldNumResourceLimit: TField;
  begin
    with SourceDataModule.TbResourceTypeLimit do
    begin
      IndexFieldNames := 'IdTheme;IdResourceType';
      First;
      ResourceTypeLimitCount := RecordCount;
      SetLength(FThemeResourceTypeToLimit, FThemeCount, FResourceTypeCount);
      FieldTheme := FindField('IdTheme');
      FieldResourceType := FindField('IdResourceType');
      FieldNumResourceLimit := FindField('NumResourceLimit');
      for Theme := 0 to FThemeCount - 1 do
        for ResourceType := 0 to FResourceTypeCount - 1 do
        begin
          FThemeResourceTypeToLimit[Theme, ResourceType] := FResourceTypeToNumResourceLimit[ResourceType];
        end;
      for ResourceTypeLimit := 0 to ResourceTypeLimitCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        ResourceType := FIdResourceTypeToResourceType[FieldResourceType.AsInteger - FMinIdResourceType];
        FThemeResourceTypeToLimit[Theme, ResourceType] := FieldNumResourceLimit.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadAvailability;
  var
    NumResource, Availability, Count, AvailabilityCount, Resource,
      Theme, ResourceType: Integer;
    FieldTheme, FieldResource, FieldNumResource: TField;
  begin
    with SourceDataModule.TbAvailability do
    begin
      IndexFieldNames := 'IdTheme;IdResource';
      First;
      AvailabilityCount := RecordCount;
      SetLength(FThemeToResources, FThemeCount, 0);
      SetLength(FThemeToNumResources, FThemeCount, 0);
      SetLength(FThemeToLimits, FThemeCount, 0);
      SetLength(FResourceToThemes, FResourceCount, 0);
      SetLength(FResourceThemeToNumResources, FResourceCount, 0);
      FieldTheme := FindField('IdTheme');
      FieldResource := FindField('IdResource');
      FieldNumResource := FindField('NumResource');
      for Availability := 0 to AvailabilityCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        ResourceType := FResourceToResourceType[Resource];
        NumResource := FieldNumResource.AsInteger;
        Count := Length(FThemeToResources[Theme]);
        SetLength(FThemeToResources[Theme], Count + 1);
        SetLength(FThemeToNumResources[Theme], Count + 1);
        SetLength(FThemeToLimits[Theme], Count + 1);
        FThemeToResources[Theme, Count] := Resource;
        FThemeToNumResources[Theme, Count] := NumResource;
        FThemeToLimits[Theme, Count] := FThemeResourceTypeToLimit[Theme, ResourceType];
        Count := Length(FResourceToThemes[Resource]);
        SetLength(FResourceToThemes[Resource], Count + 1);
        FResourceToThemes[Resource, Count] := Theme;
        SetLength(FResourceThemeToNumResources[Resource], Count + 1);
        FResourceThemeToNumResources[Resource, Count] := NumResource;
        Next;
      end;
      First;
    end;
  end;
var
  ActivityToNumResources, ResourceToNumResources: TDynamicIntegerArrayArray;
  ThemeResourceIsFixed: TDynamicBooleanArrayArray;
  procedure GenerateTemplateData;
  var
    Activity, Availability, ResourceType, ThemeActivity, Resource, Limit,
      Theme, NumResource, NumAssigned, Remaining, Number: Integer;
    ResourceTypeToNumber: TDynamicIntegerArray;
    ThemeToRemainings: TDynamicIntegerArrayArray;
  begin
    SetLength(ActivityToNumResources, FActivityCount);
    SetLength(ThemeToRemainings, FThemeCount);
    SetLength(ThemeResourceIsFixed, FThemeCount);
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(ActivityToNumResources[Activity],
                Length(FThemeToResources[FActivityToTheme[Activity]]));
    end;
    for Theme := 0 to FThemeCount - 1 do
    begin
      SetLength(ThemeToRemainings[Theme], Length(FThemeToResources[Theme]));
      for Availability := 0 to High(ThemeToRemainings[Theme]) do
        ThemeToRemainings[Theme, Availability]
          := FThemeToNumResources[Theme, Availability];
    end;
    for Activity := 0 to FActivityCount - 1 do
    begin
      Theme := FActivityToTheme[Activity];
      for Availability := 0 to High(FThemeToResources[Theme]) do
      begin
        ActivityToNumResources[Activity, Availability] := 0;
      end;
    end;
    SetLength(ResourceTypeToNumber, FResourceTypeCount);
    for Theme := 0 to FThemeCount - 1 do
    begin
      for ResourceType := 0 to FResourceTypeCount - 1 do
      begin
        Number := 0;
        for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
        begin
          Activity := FThemeToActivities[Theme, ThemeActivity];
          Inc(Number, FTmplActivityResourceTypeToNumber[Activity, ResourceType]);
        end;
        ResourceTypeToNumber[ResourceType] := Number;
      end;
      SetLength(ThemeResourceIsFixed[Theme], Length(FThemeToResources[Theme]));
      for Availability := 0 to High(FThemeToResources[Theme]) do
      begin
        Remaining := ThemeToRemainings[Theme, Availability];
        Resource := FThemeToResources[Theme, Availability];
        ResourceType := FResourceToResourceType[Resource];
        Limit := FThemeToLimits[Theme, Availability];
        ThemeResourceIsFixed[Theme, Availability] :=
          (Length(FThemeToActivities[Theme]) <= 1) or (Limit * Length(FThemeToActivities[Theme])
           = FThemeToNumResources[Theme, Availability] + ResourceTypeToNumber[ResourceType]);
      end;
    end;
    for Theme := 0 to FThemeCount - 1 do
    begin
      for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
      begin
        Activity := FThemeToActivities[Theme, ThemeActivity];
        for Availability := 0 to High(FThemeToResources[Theme]) do
        begin
          Resource := FThemeToResources[Theme, Availability];
          ResourceType := FResourceToResourceType[Resource];
          Limit := FThemeToLimits[Theme, Availability];
          Remaining := ThemeToRemainings[Theme, Availability];
          NumResource := FTmplActivityResourceTypeToNumber[Activity, ResourceType];
          if (Remaining > 0) and (NumResource < Limit) then
          begin
            NumAssigned := Min(Remaining, Limit - NumResource);
            Dec(ThemeToRemainings[Theme, Availability], NumAssigned);
            Inc(FTmplActivityResourceTypeToNumber[Activity, ResourceType], NumAssigned);
            Inc(ActivityToNumResources[Activity, Availability], NumAssigned);
          end
        end;
      end;
      for Availability := 0 to High(FThemeToResources[Theme]) do
      begin
        Remaining := ThemeToRemainings[Theme, Availability];
        Resource := FThemeToResources[Theme, Availability];
        ResourceType := FResourceToResourceType[Resource];
        Limit := FThemeToLimits[Theme, Availability];
        if Remaining <> 0 then // Sanity Check
        begin
          SErrors := SErrors
            + Format(SThemeOverflow,
                     [FThemeToName[Theme],
                      FResourceTypeToName[ResourceType] + ' (for example ' + FResourceToName[Resource] + ')',
                      Limit, Remaining]) + #13#10;
        end;
      end;
    end;
  end;
  procedure FillTemplateData;
  var
    Theme, Activity, ThemeActivity, Count, Resource, NumResource, Participant,
    Offset, Availability: Integer;
    DoAdd, DoDrop: Boolean;
  begin
    SetLength(FActivityParticipantToResource, FActivityCount);
    SetLength(FTmplActivityParticipantToNumResource, FActivityCount);
    SetLength(FActivityToNumFixeds, FActivityCount);
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(FActivityParticipantToResource[Activity],
                Length(FActivityToResources[Activity])
                + Length(FThemeToResources[FActivityToTheme[Activity]]));
      SetLength(FTmplActivityParticipantToNumResource[Activity],
                Length(FActivityToResources[Activity])
                + Length(ActivityToNumResources[Activity]));
      for Participant := 0 to High(FActivityToResources[Activity]) do
      begin
        FActivityParticipantToResource[Activity, Participant]
          := FActivityToResources[Activity, Participant];
        FTmplActivityParticipantToNumResource[Activity, Participant]
          := FActivityToNumResources[Activity, Participant];
      end;
      FActivityToNumFixeds[Activity] := Length(FActivityToResources[Activity]);
    end;
    for Theme := 0 to FThemeCount - 1 do
    begin
      for Availability := 0 to High(FThemeToResources[Theme]) do
      begin
        if ThemeResourceIsFixed[Theme, Availability] then
        begin
          DoAdd := True;
          DoDrop := True;
          Resource := FThemeToResources[Theme, Availability];
          for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
          begin
            Activity := FThemeToActivities[Theme, ThemeActivity];
            if ActivityToNumResources[Activity, Availability] <> 0 then
              DoDrop := False;
            Participant := TIntegerArrayHandler.IndexOf(FActivityToResources[Activity], Resource);
            if Participant < 0 then
              DoAdd := False;
          end;
          if not DoDrop then
          begin
            if DoAdd then
              for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
              begin
                Activity := FThemeToActivities[Theme, ThemeActivity];
                Participant := TIntegerArrayHandler.IndexOf(FActivityToResources[Activity], Resource);
                Inc(FTmplActivityParticipantToNumResource[Activity, Participant],
                    ActivityToNumResources[Activity, Availability]);
              end
            else
              for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
              begin
                Activity := FThemeToActivities[Theme, ThemeActivity];
                FActivityParticipantToResource[Activity, FActivityToNumFixeds[Activity]]
                  := FThemeToResources[Theme, Availability];
                FTmplActivityParticipantToNumResource[Activity, FActivityToNumFixeds[Activity]]
                  := ActivityToNumResources[Activity, Availability];
                Inc(FActivityToNumFixeds[Activity]);
              end;
          end;
        end;
      end;
      for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
      begin
        Activity := FThemeToActivities[Theme, ThemeActivity];
        Offset := FActivityToNumFixeds[Activity];
        for Availability := 0 to High(FThemeToResources[Theme]) do
        begin
          if not ThemeResourceIsFixed[Theme, Availability] then
          begin
            FActivityParticipantToResource[Activity, Offset]
              := FThemeToResources[Theme, Availability];
            FTmplActivityParticipantToNumResource[Activity, Offset] :=
              ActivityToNumResources[Activity, Availability];
            Inc(Offset);
          end;
        end;
        SetLength(FActivityParticipantToResource[Activity], Offset);
        SetLength(FTmplActivityParticipantToNumResource[Activity], Offset);
      end;
    end;
    SetLength(FResourceToActivities, FResourceCount, 0);
    SetLength(ResourceToNumResources, FResourceCount, 0); 
    for Activity := 0 to FActivityCount - 1 do
    begin
      for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
      begin
        Resource := FActivityParticipantToResource[Activity, Participant];
        NumResource := FTmplActivityParticipantToNumResource[Activity, Participant];
        Count := Length(FResourceToActivities[Resource]);
        SetLength(FResourceToActivities[Resource], Count + 1);
        FResourceToActivities[Resource, Count] := Activity;
        SetLength(ResourceToNumResources[Resource], Count + 1);
        ResourceToNumResources[Resource, Count] := NumResource;
      end;
    end;
    SetLength(FThemeWithMobileResources, 0);
    for Theme := 0 to FThemeCount - 1 do
    begin
      Activity := FThemeToActivities[Theme, 0];
      if FActivityToNumFixeds[Activity] < Length(FActivityParticipantToResource[Activity]) then
      begin
        Count := Length(FThemeWithMobileResources);
        SetLength(FThemeWithMobileResources, Count + 1);
        FThemeWithMobileResources[Count] := Theme;
      end;
    end;
  end;
  procedure LoadGreedyData;
  var
    Session: Integer;
    HighActivitySorted, HighSessionSorted: Integer;
    ActivityIsPlaced: TDynamicBooleanArray;
    procedure PushSessionsToGroup(Group, Activity: Integer);
    var
      Count, ActivitySession: Integer;
    begin
      if not ActivityIsPlaced[Activity] then
      begin
        FActivitySorted[HighActivitySorted] := Activity;
        Inc(HighActivitySorted);
        ActivityIsPlaced[Activity] := True;
        Count := Length(FGroupSessions[Group]);
        SetLength(FGroupSessions[Group], Count + Length(FActivityToSessions[Activity]));
        for ActivitySession := 0 to High(FActivityToSessions[Activity]) do
        begin
          Session := FActivityToSessions[Activity, ActivitySession];
          FSessionSorted[HighSessionSorted] := Session;
          Inc(HighSessionSorted);
          FGroupSessions[Group, Count + ActivitySession] := Session;
        end;
      end;
    end;
  var
    FreePeriods: Integer;
    Group, Number, Duration,
      Activity, ResourceActivity,
      Participant, Count, Resource: Integer;
      ActivityToKeySort, ResourceToFreePeriods,
      ResourceToKeySort: TDynamicIntegerArray;
  begin
    SetLength(ResourceToFreePeriods, FResourceCount);
    SetLength(FResourceSorted, FResourceCount);
    SetLength(ResourceToKeySort, FResourceCount);
    for Resource := 0 to FResourceCount - 1 do
    begin
      ResourceToFreePeriods[Resource] := 0;
    end;
    for Activity := 0 to FActivityCount - 1 do
    begin
      for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
      begin
        Resource := FActivityParticipantToResource[Activity, Participant];
        Inc(ResourceToFreePeriods[Resource],
            FTmplActivityParticipantToNumResource[Activity, Participant]
            * FThemeToDuration[FActivityToTheme[Activity]]);
        
      end;
    end;
    for Resource := 0 to FResourceCount - 1 do
    begin
      // Upper bound, better approximation is FPeriodCount - GetHardRestrictions(...)
      Number := FResourceToNumResource[Resource] * FPeriodCount;
      Duration := ResourceToFreePeriods[Resource];
      FreePeriods := Number - Duration;
      if FreePeriods < 0 then
        SErrors := SErrors
          + Format(SResourceOverflow, [FResourceToName[Resource], Duration, Number]) + #13#10;
      ResourceToFreePeriods[Resource] := FreePeriods;
      ResourceToKeySort[Resource] := FreePeriods * FActivityCount + Length(FResourceToActivities[Resource]);
      FResourceSorted[Resource] := Resource;
    end;
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(ActivityToKeySort, Length(FActivityParticipantToResource[Activity]));
      for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
        ActivityToKeySort[Participant] := ResourceToKeySort[FActivityParticipantToResource[Activity, Participant]];
      TSortInteger.BubbleSort(ActivityToKeySort, FActivityParticipantToResource[Activity], 0, FActivityToNumFixeds[Activity] - 1);
      for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
        ActivityToKeySort[Participant] := ResourceToKeySort[FActivityParticipantToResource[Activity, Participant]];
      TSortInteger.BubbleSort(ActivityToKeySort, FTmplActivityParticipantToNumResource[Activity], 0, FActivityToNumFixeds[Activity] - 1);
    end;
    TSortInteger.BubbleSort(ResourceToKeySort, FResourceSorted, 0, FResourceCount - 1);
    SetLength(ActivityIsPlaced, FActivityCount);
    for Activity := 0 to FActivityCount - 1 do
    begin
      ActivityIsPlaced[Activity] := False;
    end;
    SetLength(FActivitySorted, FActivityCount);
    SetLength(FSessionSorted, FSessionCount);
    HighActivitySorted := 0;
    HighSessionSorted := 0;
    SetLength(FGroupSessions, FActivityCount, 0); // Upper Bound
    Group := 0;
    for Count := 0 to FResourceCount -1 do
    begin
      Resource := FResourceSorted[Count];
      FreePeriods := ResourceToFreePeriods[Resource];
      Number := FResourceToNumResource[Resource] * FPeriodCount;
      Duration := Number - FreePeriods;
      {$IFDEF DEBUG}
      WriteLn(Format('Resource %s/%d/%d, Activities=%d, Number=%d, Duration=%d, FreePeriods=%d',
                     [FResourceToName[Resource],
                      FResourceToIdResource[Resource],
                      Resource,
                      Length(FResourceToActivities[Resource]),
                      Number,
                      Duration,
                      FreePeriods]));
      {$ENDIF}
      for ResourceActivity := 0 to High(FResourceToActivities[Resource]) do
      begin
        Activity := FResourceToActivities[Resource, ResourceActivity];
        if ResourceToNumResources[Resource, ResourceActivity] > 0 then
          PushSessionsToGroup(Group, Activity);
      end;
      if Length(FGroupSessions[Group]) > 0 then
      begin
        Inc(Group);
      end;
    end;
    FGroupCount := Group;
    SetLength(FGroupSessions, FGroupCount);
    WriteLn(Format('Length(FGroupSessions)=%d', [Length(FGroupSessions)]));
    {WriteLn(Format('FGroupSessions=%s', [TIntArrayArrayToString.ValueToString(FGroupSessions)]));
    WriteLn(Format('FResourceToActivities=%s', [TIntArrayArrayToString.ValueToString(FResourceToActivities)]));}
    for Activity := 0 to FActivityCount - 1 do
    begin
      if not ActivityIsPlaced[Activity] then
      begin
        SErrors := SErrors + Format(SActivityWithoutResources,
                             [FThemeToName[FActivityToTheme[Activity]]
                              + ' ' + FActivityToName[Activity]]) + #13#10;
      end;
    end;
  end;
begin
  inherited Create;
  with SourceDataModule do
  begin
    SErrors := '';
    Configure(AClashActivityValue, ABreakTimetableResourceValue,
      ABrokenSessionValue, ANonScatteredActivityValue);
    Load(TbResourceType, 'IdResourceType', FMinIdResourceType,
         FIdResourceTypeToResourceType, FResourceTypeToIdResourceType);
    FResourceTypeCount := Length(FResourceTypeToIdResourceType);
    Load(TbResource, 'IdResource', FMinIdResource, FIdResourceToResource,
         FResourceToIdResource);
    FResourceCount := Length(FResourceToIdResource);
    Load(TbTheme, 'IdTheme', FMinIdTheme, FIdThemeToTheme, FThemeToIdTheme);
    FThemeCount := Length(FThemeToIdTheme);
    Load(TbActivity, 'IdActivity', FMinIdActivity, FIdActivityToActivity,
         FActivityToIdActivity);
    FActivityCount := Length(FActivityToIdActivity);
    Load(TbDay, 'IdDay', FMinIdDay, FIdDayToDay, FDayToIdDay);
    FDayCount := Length(FDayToIdDay);
    Load(TbHour, 'IdHour', FMinIdHour, FIdHourToHour, FHourToIdHour);
    FHourCount := Length(FHourToIdHour);
    Load(TbRestrictionType, 'IdRestrictionType',
      FMinIdRestrictionType,
      FIdRestrictionTypeToRestrictionType,
      FRestrictionTypeToIdRestrictionType);
  end;
  FRestrictionTypeCount := Length(FRestrictionTypeToIdRestrictionType);
  LoadPeriod;
  LoadResourceType;
  LoadResource;
  LoadRestrictionType;
  LoadRestriction;
  LoadTheme;
  LoadActivity;
  LoadParticipant;
  LoadResourceTypeLimit;
  LoadAvailability;
  GenerateTemplateData;
  FillTemplateData;
  LoadGreedyData;
  if SErrors <> '' then
    raise Exception.Create(SErrors);
  WriteLn(Format('FThemeToResources=%s', [TIntegerArrayArrayHandler.ValueToString(FThemeToResources)]));
  WriteLn(Format('FThemeToNumResources=%s', [TIntegerArrayArrayHandler.ValueToString(FThemeToNumResources)]));
end;

procedure TTimetableModel.Configure(AClashActivityValue,
                                    ABreakTimetableResourceValue,
                                    ABrokenSessionValue,
                                    ANonScatteredActivityValue: Integer);
begin
  FClashActivityValue := AClashActivityValue;
  FBreakTimetableResourceValue := ABreakTimetableResourceValue;
  FBrokenSessionValue := ABrokenSessionValue;
  FNonScatteredActivityValue := ANonScatteredActivityValue;
end;

function TTimetableModel.GetDayToMaxPeriod(Day: Integer): Integer;
begin
  if Day = FDayCount - 1 then
    Result := FPeriodCount - 1
  else
    Result := FDayHourToPeriod[Day + 1, 0] - 1;
end;

procedure TTimetableModel.ReportParameters(AReport: TStrings);
begin
  AReport.Add(Format('%s:'#13#10 +
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f', [SWeights,
          SClashActivity              + ':', ClashActivityValue,
          SBreakTimetableResource  + ':', BreakTimetableResourceValue,
          SBrokenSession           + ':', BrokenSessionValue,
          SNonScatteredActivity       + ':', NonScatteredActivityValue]));
end;

function TTimetableModel.NewIndividual: TIndividual;
begin
  Result := TTimetable.Create(Self);
end;

procedure TTimetable.CrossGroup(Timetable2: TTimetable; AGroup: Integer);
var
  Session, Session1, Session2, Count, GroupSessionsCount: Integer;
  Sessions1, Sessions2, SortKey1, SortKey2: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    GroupSessionsCount := Length(FGroupSessions[AGroup]);
    SetLength(SortKey1, GroupSessionsCount);
    SetLength(SortKey2, GroupSessionsCount);
    SetLength(Sessions1, GroupSessionsCount);
    SetLength(Sessions2, GroupSessionsCount);
    for Count := 0 to GroupSessionsCount - 1 do
    begin
      Session := FGroupSessions[AGroup, Count];
      SortKey1[Count] := FSessionToDuration[Session] * $10000
        + FTTSessionToPeriod[Session];
      Sessions1[Count] := Session;
      SortKey2[Count] := FSessionToDuration[Session] * $10000
        + Timetable2.FTTSessionToPeriod[Session];
      Sessions2[Count] := Session;
    end;
    TSortInteger.QuickSort(SortKey1, Sessions1, 0, GroupSessionsCount - 1);
    TSortInteger.QuickSort(SortKey2, Sessions2, 0, GroupSessionsCount - 1);
    for Count := 0 to GroupSessionsCount - 1 do
    begin
      Session1 := Sessions1[Count];
      Session2 := Sessions2[Count];
      FTTSessionToPeriod[Session2] := SortKey1[Count] and $FFFF;
      Timetable2.FTTSessionToPeriod[Session1] := SortKey2[Count] and $FFFF;
    end;
  end;
end;

procedure TTimetable.Cross(AIndividual: TIndividual);
var
  Group, MobileTheme, Theme, ResourceType, Activity, ThemeActivity, Tmp,
  Participant: Integer;
  SwapResourceType: TDynamicBooleanArray;
begin
  with TTimetableModel(Model) do
  begin
    for Group := 0 to FGroupCount - 1 do
    begin
      CrossGroup(TTimetable(AIndividual), Group);
    end;
    // Note: [Theme * ResourceType] are swapables:
    SetLength(SwapResourceType, FResourceTypeCount);
    for MobileTheme := 0 to High(FThemeWithMobileResources) do
    begin
      Theme := FThemeWithMobileResources[MobileTheme];
      for ResourceType := 0 to FResourceTypeCount - 1 do
      begin
        SwapResourceType[ResourceType] := (Random(2) = 0);
      end;
      for ThemeActivity := 0 to High(FThemeToActivities[Theme]) do
      begin
        Activity := FThemeToActivities[Theme, ThemeActivity];
        for ResourceType := 0 to FResourceTypeCount - 1 do
        begin
          if SwapResourceType[ResourceType] then
          begin
            with TablingInfo do
            begin
              Tmp := TTimetable(AIndividual).TablingInfo.FActivityResourceTypeToNumber[Activity, ResourceType];
              TTimetable(AIndividual).TablingInfo.FActivityResourceTypeToNumber[Activity, ResourceType]
                := FActivityResourceTypeToNumber[Activity, ResourceType];
              FActivityResourceTypeToNumber[Activity, ResourceType] := Tmp;
            end;
          end;
        end;
        for Participant := FActivityToNumFixeds[Activity] to High(FTTActivityToNumResources[Activity]) do
        begin
          ResourceType := FResourceToResourceType[FActivityParticipantToResource[Activity, Participant]];
          if SwapResourceType[ResourceType] then
          begin
            Tmp := TTimetable(AIndividual).FTTActivityToNumResources[Activity, Participant];
            TTimetable(AIndividual).FTTActivityToNumResources[Activity, Participant]
              := FTTActivityToNumResources[Activity, Participant];
            FTTActivityToNumResources[Activity, Participant] := Tmp;
          end;
        end;
      end;
    end;
    Update;
    TTimetable(AIndividual).Update;
  end;
  {$IFDEF DEBUG}
  CheckIntegrity('After Cross');
  TTimetable(AIndividual).CheckIntegrity('After AIndividual.Cross');
  {$ENDIF}
end;

constructor TTimetable.Create(ATimetableModel: TTimetableModel);
begin
  inherited Create;
  FModel := ATimetableModel;
  with TTimetableModel(Model) do
  begin
    SetLength(FTTSessionToPeriod, FSessionCount);
    FTTActivityToNumResources := TIntegerArrayArrayHandler.Clone(FTmplActivityParticipantToNumResource);
    FTablingInfo := TTimetableTablingInfo.Create;
    with TablingInfo do
    begin
      FActivityResourceTypeToNumber := TIntegerArrayArrayHandler.Clone(FTmplActivityResourceTypeToNumber);
      //SetLength(FActivityResourceTypeToNumber, FActivityCount, FResourceTypeCount);
      SetLength(FResourcePeriodNumber, FResourceCount, FPeriodCount);
      SetLength(FDayActivityCount, FDayCount, FActivityCount);
      SetLength(FDayActivityAccumulated, FDayCount, FActivityCount);
      SetLength(FDayResourceMinHour, FDayCount, FResourceCount);
      SetLength(FDayResourceMaxHour, FDayCount, FResourceCount);
      SetLength(FDayResourceEmptyHourCount, FDayCount, FResourceCount);
      SetLength(FClashResourceType, FResourceTypeCount);
      SetLength(FRestrictionTypeToResourceCount, FRestrictionTypeCount);
      SetLength(FPriorityActivity, FActivityCount);
    end;
  end;
end;

function TTimetable.GetElitistValues(Index: Integer): Integer;
begin
  case Index of
    0:
      Result := BrokenSession;
    else
      Result := ClashResourceType[Index - 1];
  end;
end;


procedure TTimetable.MakeRandom;
var
  Count, Period, ActivitySession, Duration, SelectedPeriodCount,
    Activity, Session, MinValue: Integer;
  SelectedPeriod: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    Reset;
    SetLength(SelectedPeriod, FPeriodCount);
    for Count := 0 to FActivityCount - 1 do
    begin
      Activity := FActivitySorted[Count];
      for ActivitySession := 0 to High(FActivityToSessions[Activity]) do
      begin
        Session := FActivityToSessions[Activity, ActivitySession];
        MinValue := MaxInt;
        SelectedPeriodCount := 0;
        Duration := FSessionToDuration[Session];
        for Period := 0 to FPeriodCount - Duration do
        begin
          FTTSessionToPeriod[Session] := Period;
          DeltaValue(1, Session);
          DoUpdateValue;
          if MinValue > Value then
          begin
            SelectedPeriodCount := 1;
            SelectedPeriod[0] := Period;
            MinValue := Value;
          end
          else if MinValue = Value then
          begin
            SelectedPeriod[SelectedPeriodCount] := Period;
            Inc(SelectedPeriodCount);
          end;
          DeltaValue(-1, Session);
        end;
        FTTSessionToPeriod[Session] := SelectedPeriod[Random(SelectedPeriodCount)];
        DeltaValue(1, Session);
      end;
    end;
  end;
  DoUpdateValue;
  {$IFDEF DEBUG}
  CheckIntegrity('After MakeRandom');
  {$ENDIF}
end;


procedure TTimetable.DeltaActivityParticipantValue(Activity, Participant, DeltaNumResource: Integer);
var
  Session, ActivitySession, Resource, Duration, Period1, Period2: Integer;
begin
  if DeltaNumResource <> 0 then
  begin
    with TTimetableModel(Model) do
    begin
      Resource := FActivityParticipantToResource[Activity, Participant];
      for ActivitySession := 0 to High(FActivityToSessions[Activity]) do
      begin
        Session := FActivityToSessions[Activity, ActivitySession];
        Period1 := FTTSessionToPeriod[Session];
        Duration := FSessionToDuration[Session];
        Period2 := Period1 + Duration - 1;
        DeltaResourceValue(Period1, Period2, Resource, DeltaNumResource);
      end;
      Inc(FTTActivityToNumResources[Activity, Participant], DeltaNumResource);
      {Assert(FTTActivityToNumResources[Activity, Participant]>=0,
             Format('FTTActivityToNumResources[Activity, Participant]=%d', [FTTActivityToNumResources[Activity, Participant]]));}
      Inc(FTablingInfo.FActivityResourceTypeToNumber[Activity, FResourceToResourceType[Resource]], DeltaNumResource);
    end
  end;
end;

procedure TTimetable.DeltaResourceValue(Period1, Period2, Resource, NumResource: Integer);
var
  DeltaClashResource, DeltaBreakTimetableResource, RestrictionType,
  Day, Hour, Period, Period0, MinPeriod, MaxPeriod: Integer;
begin
  if NumResource <> 0 then
  with TTimetableModel(Model), TablingInfo do
  begin
    for Period := Period1 to Period2 do
    begin
      RestrictionType := FResourcePeriodToRestrictionType[Resource, Period];
      if RestrictionType >= 0 then
      begin
        Inc(FRestrictionTypeToResourceCount[RestrictionType], NumResource);
      end;
      Day := FPeriodToDay[Period];
      Hour := FPeriodToHour[Period];
      if NumResource > 0 then
      begin
        if FResourcePeriodNumber[Resource, Period] = 0 then
        begin
          if FDayResourceMinHour[Day, Resource] > FDayResourceMaxHour[Day, Resource] then
          begin
            FDayResourceMinHour[Day, Resource] := Hour;
            FDayResourceMaxHour[Day, Resource] := Hour;
          end
          else
          begin
            if Hour < FDayResourceMinHour[Day, Resource] then
            begin
              DeltaBreakTimetableResource := FDayResourceMinHour[Day, Resource] - Hour - 1;
              FDayResourceMinHour[Day, Resource] := Hour;
            end
            else if (FDayResourceMinHour[Day, Resource] < Hour)
                    and (Hour < FDayResourceMaxHour[Day, Resource]) then
              DeltaBreakTimetableResource := -1
            else if FDayResourceMaxHour[Day, Resource] < Hour then
            begin
              DeltaBreakTimetableResource := Hour - FDayResourceMaxHour[Day, Resource] - 1;
              FDayResourceMaxHour[Day, Resource] := Hour;
            end;
            Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
            Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
          end;
        end;
        Inc(FResourcePeriodNumber[Resource, Period], NumResource);
        DeltaClashResource := Max(0, Min(NumResource, FResourcePeriodNumber[Resource, Period]
                                                      - FResourceToNumResource[Resource]));
        Inc(FClashResourceType[FResourceToResourceType[Resource]], DeltaClashResource);
      end
      else if NumResource < 0 then
      begin
        DeltaClashResource := Max(0, Min(-NumResource, FResourcePeriodNumber[Resource, Period]
                                                       - FResourceToNumResource[Resource]));
        Dec(FClashResourceType[FResourceToResourceType[Resource]], DeltaClashResource);
        Inc(FResourcePeriodNumber[Resource, Period], NumResource);
        if FResourcePeriodNumber[Resource, Period] = 0 then
        begin
          if FDayResourceMinHour[Day, Resource] = FDayResourceMaxHour[Day, Resource] then
          begin
            FDayResourceMinHour[Day, Resource] := 1;
            FDayResourceMaxHour[Day, Resource] := 0;
          end
          else
          begin
            if Hour = FDayResourceMinHour[Day, Resource] then
            begin
              Period0 := Period;
              MaxPeriod := FDayHourToPeriod[Day, FDayResourceMaxHour[Day, Resource]];
              while (Period0 < MaxPeriod)
                    and (FResourcePeriodNumber[Resource, Period0] = 0) do
              begin
                Inc(Period0);
              end;
              Assert(Period0 < FPeriodCount);
              DeltaBreakTimetableResource := Hour - FPeriodToHour[Period0] + 1;
              FDayResourceMinHour[Day, Resource] := FPeriodToHour[Period0];
            end
            else if (FDayResourceMinHour[Day, Resource] < Hour)
                    and (Hour < FDayResourceMaxHour[Day, Resource]) then
            begin
              DeltaBreakTimetableResource := 1;
            end
            else if Hour = FDayResourceMaxHour[Day, Resource] then
            begin
              Period0 := Period;
              MinPeriod := FDayHourToPeriod[Day, FDayResourceMinHour[Day, Resource]];
              while (Period0 > MinPeriod)
                    and (FResourcePeriodNumber[Resource, Period0] = 0) do
              begin
                Dec(Period0);
              end;
              Assert(Period0 >= 0);
              DeltaBreakTimetableResource := FPeriodToHour[Period0] - Hour + 1;
              FDayResourceMaxHour[Day, Resource] := FPeriodToHour[Period0];
            end;
            Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
            Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
          end;
        end;
      end;
    end;
  end;
end;

procedure TTimetable.DeltaPeriodsValue(Sign, Period1, Period2, Activity: Integer);
var
  IsNegative, Day, DDay, Day1, Day2, Hour1, Hour2, DeltaBrokenSession: Integer;
begin
  if Sign > 0 then
    IsNegative := 0
  else
    IsNegative := 1;
  with TTimetableModel(Model), TablingInfo do
  begin
    Day1 := FPeriodToDay[Period1];
    Day2 := FPeriodToDay[Period2];
    Hour1 := FPeriodToHour[Period1];
    Hour2 := FPeriodToHour[Period2];
    DeltaBrokenSession := (Day2 - Day1) * (FHourCount + 1)
      + Hour2 - Hour1 + Period1 - Period2;
    Inc(FBrokenSession, Sign * DeltaBrokenSession);
    for Day := Day1 to Day2 do
    begin
      if FDayActivityCount[Day, Activity] > IsNegative then
      begin
        Inc(FClashActivity, Sign);
      end;
      Inc(FDayActivityCount[Day, Activity], Sign);
    end;
    DDay := FDayCount div Length(FActivityToSessions[Activity]);
    for Day2 := Day1 to Day1 + DDay - 1 do
    begin
      Day := Day2 mod (FDayCount + 1);
      if Day <> FDayCount then
      begin
        if FDayActivityAccumulated[Day, Activity] > IsNegative then
        begin
          Inc(FNonScatteredActivity, Sign);
        end;
        Inc(FDayActivityAccumulated[Day, Activity], Sign);
      end;
    end;
  end;
end;

procedure TTimetable.DeltaResourcesValue(Sign, Period1, Period2: Integer;
                                         Resources, NumResources: TDynamicIntegerArray);
var
  Participant,  Resource, NumResource: Integer;
begin
  for Participant := 0 to High(Resources) do
  begin
    Resource := Resources[Participant];
    NumResource := NumResources[Participant];
    DeltaResourceValue(Period1, Period2, Resource, Sign * NumResource);
  end
end;

procedure TTimetable.DeltaValue(Sign, Session: Integer);
var
  Participant,  Resource, NumResource, Period1, Period2,
  Activity, Duration: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Duration := FSessionToDuration[Session];
    Period1 := FTTSessionToPeriod[Session];
    Period2 := Period1 + Duration - 1;
    Activity := FSessionToActivity[Session];
    for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
    begin
      Resource := FActivityParticipantToResource[Activity, Participant];
      NumResource := FTTActivityToNumResources[Activity, Participant];
      DeltaResourceValue(Period1, Period2, Resource, Sign * NumResource);
    end;
    DeltaPeriodsValue(Sign, Period1, Period2, Activity);
  end;
end;

procedure TTimetable.ReportValues(AReport: TStrings);
var
  ResourceType, RestrictionType: Integer;
  SRowFormat: string = '%0:-28s %12d %12d %12d';
begin
  with AReport, TablingInfo do
  begin
    Add('___________________________________________________________________');
    Add(Format('%0:-28s %12s %12s %12s', [SDetail, SCount, SWeight, SValue]));
    Add('___________________________________________________________________');
    Add(Format('%0:-28s %12s %12s %12s)', [SClashResource + ':', '', '',
                                           '(' + IntToStr(ClashResourceValue)]));
    for ResourceType := 0 to TTimetableModel(Model).FResourceTypeCount - 1 do
    begin
      Add(Format('%0:-28s %12d %12d %12d',
                 ['  ' + TTimetableModel(Model).FResourceTypeToName[ResourceType] + ':',
                  FClashResourceType[ResourceType],
                  TTimetableModel(Model).FResourceTypeToValue[ResourceType],
                  FClashResourceType[ResourceType]
                  * TTimetableModel(Model).FResourceTypeToValue[ResourceType]]));
    end;
    Add('-------------------------------------------------------------------');
    Add(Format(SRowFormat, [SClashActivity + ':', FClashActivity,
      TTimetableModel(Model).ClashActivityValue, ClashActivityValue]));
    Add(Format(SRowFormat, [SBreakTimetableResource + ':', BreakTimetableResource,
      TTimetableModel(Model).BreakTimetableResourceValue, BreakTimetableResourceValue]));
    Add(Format(SRowFormat, [SBrokenSession + ':', BrokenSession,
      TTimetableModel(Model).BrokenSessionValue, BrokenSessionValue]));
    Add(Format(SRowFormat, [SNonScatteredActivity + ':', NonScatteredActivity,
        TTimetableModel(Model).NonScatteredActivityValue, NonScatteredActivityValue]));
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-28s %12s %12s %12s)', [STbRestriction + ':', '', '',
                                          '(' + IntToStr(RestrictionValue)]));
    for RestrictionType := 0 to TTimetableModel(Model).FRestrictionTypeCount - 1 do
    begin
      Add(Format('%0:-28s %12d %12d %12d',
                 ['  ' + TTimetableModel(Model).FRestrictionTypeToName[RestrictionType] + ':',
                  FRestrictionTypeToResourceCount[RestrictionType],
                  TTimetableModel(Model).FRestrictionTypeToValue[RestrictionType],
                  FRestrictionTypeToResourceCount[RestrictionType]
                  * TTimetableModel(Model).FRestrictionTypeToValue[RestrictionType]]));
    end;
    Add('___________________________________________________________________');
    Add(Format('%0:-54s %12d', [STotalValue, Value]));
  end;
end;

procedure TTimetable.Mutate;
  procedure SwapRandomSessions;
  var
    ResourceActivity, ResourceActivities, Session1, Session2, Activity1,
    Activity2, Participant, Resource: Integer;
  begin
    with TTimetableModel(Model) do
    begin
      if (Random(1) = 0) then
      begin
        Activity1 := RandomTable(TablingInfo.FPriorityActivity);
        Session1 := FActivityToSessions[Activity1, Random(Length(FActivityToSessions[Activity1]))];
      end
      else
      begin
        Session1 := Random(FSessionCount);
        Activity1 := FSessionToActivity[Session1];
      end;
      // repeat
      Participant := Random(Length(FActivityParticipantToResource[Activity1]));
      Resource := FActivityParticipantToResource[Activity1, Participant];
      //   NumResource := FTTActivityToNumResources[Activity1, Participant];
      // until NumResource > 0;
      ResourceActivities := Length(FResourceToActivities[Resource]);
      Activity2 := 0;
      ResourceActivity := Random(ResourceActivities);
      Activity2 := FResourceToActivities[Resource, ResourceActivity];
      Session2 := FActivityToSessions[Activity2, Random(Length(FActivityToSessions[Activity2]))];
      if Session1 <> Session2 then
        DoSwap(Session1, Session2);
    end;
  end;
  procedure MoveRandomSession;
  var
    Session, Period: Integer;
  begin
    with TTimetableModel(Model) do
    begin
      Session := Random(FSessionCount);
      Period := Round(PeriodCount - FSessionToDuration[Session]);
      if Period <> FTTSessionToPeriod[Session] then
        DoMoveSession(Session, Period);
    end;
  end;
  procedure SwapRandomResources;
  var
    Themes, Theme, Free11, Free21, Free12, Free22, NumFixeds1, NumFixeds2,
    Activities, Resource1, Resource2, ResourceType1, Activity1, Activity2,
    DeltaNumResource1, DeltaNumResource2, Participant11, Participant21,
    Participant12, Participant22, Offset1, Offset2, Limit,
    NumResource11, NumResource21, NumResource12, NumResource22: Integer;
    ThemeActivities: TDynamicIntegerArray;
  begin
    with TTimetableModel(Model) do
    begin
      Themes := Length(FThemeWithMobileResources);
      if Themes > 0 then
      begin
        Theme := FThemeWithMobileResources[Random(Themes)];
        Activities := Length(FThemeToActivities[Theme]);
        ThemeActivities := RandomIndexes(2, Activities);
        Activity1 := FThemeToActivities[Theme, ThemeActivities[0]];
        Activity2 := FThemeToActivities[Theme, ThemeActivities[1]];
        Assert(Activity1<>Activity2);
        NumFixeds1 := FActivityToNumFixeds[Activity1];
        Offset1 := Random(Length(FActivityParticipantToResource[Activity1]) - NumFixeds1);
        Participant11 := NumFixeds1 + Offset1;
        Resource1 := FActivityParticipantToResource[Activity1, Participant11];
        ResourceType1 := FResourceToResourceType[Resource1];
        repeat
          Offset2 := Random(Length(FActivityParticipantToResource[Activity1]) - NumFixeds1);
          Participant12 := NumFixeds1 + Offset2;
          Resource2 := FActivityParticipantToResource[Activity1, Participant12];
        until ResourceType1 = FResourceToResourceType[Resource2];
        Limit := FThemeResourceTypeToLimit[Theme, ResourceType1];
        NumResource12 := FTTActivityToNumResources[Activity1, Participant12];
        NumFixeds2 := FActivityToNumFixeds[Activity2];
        Participant22 := NumFixeds2 + Offset2;
        NumResource22 := FTTActivityToNumResources[Activity2, Participant22];
        Free11 := Limit - FTablingInfo.FActivityResourceTypeToNumber[Activity1, ResourceType1] + NumResource12;
        Free21 := Limit - FTablingInfo.FActivityResourceTypeToNumber[Activity2, ResourceType1] + NumResource22;
        Participant21 := NumFixeds2 + Offset1;
        NumResource11 := FTTActivityToNumResources[Activity1, Participant11];
        NumResource21 := FTTActivityToNumResources[Activity2, Participant21];
        DeltaNumResource1 := RandomUniform(-Min(NumResource11, Free21), Min(NumResource21, Free11));
        Free12 := Free11 - NumResource12 - DeltaNumResource1;
        Free22 := Free21 - NumResource22 + DeltaNumResource1;
        DeltaNumResource2 := RandomUniform(-Min(NumResource12, Free22), Min(NumResource22, Free12));
        DeltaActivityParticipantValue(Activity1, Participant11, +DeltaNumResource1);
        DeltaActivityParticipantValue(Activity2, Participant21, -DeltaNumResource1);
        DeltaActivityParticipantValue(Activity1, Participant12, +DeltaNumResource2);
        DeltaActivityParticipantValue(Activity2, Participant22, -DeltaNumResource2);
      end;
    end;
   end;
begin
  {$IFDEF DEBUG}
  CheckIntegrity('Before Mutate');
  {$ENDIF}
  case Random(3) of
    0: SwapRandomSessions;
    1: MoveRandomSession;
    2: SwapRandomResources;
  end;
  DoUpdateValue;
  {$IFDEF DEBUG}
  CheckIntegrity('After Mutate');
  {$ENDIF}
end;

function TTimetable.MoveSession(Session, Period: Integer): Integer;
begin
  Result := FValue;
  DoMoveSession(Session, Period);
  DoUpdateValue;
  Result := FValue - Result;
end;

procedure TTimetable.DoMoveSession(Session, Period: Integer);
begin
  with TTimetableModel(Model) do
  begin
    if Period <> FTTSessionToPeriod[Session] then
    begin
      DeltaValue(-1, Session);
      FTTSessionToPeriod[Session] := Period;
      DeltaValue(1, Session);
    end;
  end;
end;

function TTimetable.Swap(Session1, Session2: Integer): Integer;
begin
  Result := FValue;
  DoSwap(Session1, Session2);
  DoUpdateValue;
  Result := FValue - Result;
end;

procedure TTimetable.DoSwap(Session1, Session2: Integer);
var
  Period1, Period2, Duration1, Duration2: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Period1 := FTTSessionToPeriod[Session1];
    Period2 := FTTSessionToPeriod[Session2];
    if Period1 <> Period2 then
    begin
      Duration1 := FSessionToDuration[Session1];
      Duration2 := FSessionToDuration[Session2];
      DeltaValue(-1, Session1);
      DeltaValue(-1, Session2);
      if (Period1 < Period2)
              and (Duration1 <= Period2 + Duration2)
              and (Period2 + Duration2 < FPeriodCount)
              and (Period1 + Duration2 < FPeriodCount) then
      begin
        FTTSessionToPeriod[Session1] := Period2 - Duration1 + Duration2;
        FTTSessionToPeriod[Session2] := Period1;
      end
      else if (Period1 > Period2)
              and (Duration1 <= Period1 + Duration1)
              and (Period1 + Duration1 < FPeriodCount)
              and (Period2 + Duration1 < FPeriodCount) then
      begin
        FTTSessionToPeriod[Session1] := Period2;
        FTTSessionToPeriod[Session2] := Period1 - Duration2 + Duration1;
      end;
      DeltaValue(1, Session2);
      DeltaValue(1, Session1);
    end
  end;
end;

function TTimetable.GetClashResourceValue: Integer;
begin
  Result := TIntegerArrayHandler.Product(TablingInfo.FClashResourceType,
                                    TTimetableModel(Model).FResourceTypeToValue);
end;

function TTimetable.GetRestrictionValue: Integer;
begin
  Result := TIntegerArrayHandler.Product(TablingInfo.FRestrictionTypeToResourceCount,
                                   TTimetableModel(Model).FRestrictionTypeToValue);
end;

function TTimetable.GetBrokenSessionValue: Integer;
begin
  Result := TTimetableModel(Model).BrokenSessionValue * BrokenSession;
end;

function TTimetable.GetNonScatteredActivityValue: Integer;
begin
  Result := TTimetableModel(Model).NonScatteredActivityValue * NonScatteredActivity;
end;

function TTimetable.GetClashActivityValue: Integer;
begin
  Result := TTimetableModel(Model).ClashActivityValue * TablingInfo.FClashActivity;
end;


function TTimetable.GetBreakTimetableResourceValue: Integer;
begin
  Result := TTimetableModel(Model).BreakTimetableResourceValue *
    TablingInfo.FBreakTimetableResource;
end;

function TTimetable.GetValue: Integer;
begin
  Result :=
    ClashResourceValue +
    RestrictionValue +
    ClashActivityValue +
    NonScatteredActivityValue +
    BreakTimetableResourceValue +
    BrokenSessionValue;
end;

function TTimetable.NewBookmark: TBookmark;
begin
  case Random(3) of
    0: Result := TTTBookmark1.Create(Self);
    1: Result := TTTBookmark2.Create(Self);
    2: Result := TTTBookmarkTheme.Create(Self);
  end;
end;

destructor TTimetable.Destroy;
begin
  TablingInfo.Free;
  inherited Destroy;
end;

procedure TTimetableTablingInfo.Assign(ATimetableTablingInfo: TTimetableTablingInfo);
begin
  FClashActivity := ATimetableTablingInfo.FClashActivity;
  FBreakTimetableResource := ATimetableTablingInfo.FBreakTimetableResource;
  FNonScatteredActivity := ATimetableTablingInfo.FNonScatteredActivity;
  FBrokenSession := ATimetableTablingInfo.FBrokenSession;
  with TIntegerArrayHandler do
  begin
    Copy(ATimetableTablingInfo.FClashResourceType, FClashResourceType);
    Copy(ATimetableTablingInfo.FRestrictionTypeToResourceCount, FRestrictionTypeToResourceCount);
    Copy(ATimetableTablingInfo.FPriorityActivity, FPriorityActivity);
  end;
  with TIntegerArrayArrayHandler do
  begin
    Copy(ATimetableTablingInfo.FActivityResourceTypeToNumber, FActivityResourceTypeToNumber);
    Copy(ATimetableTablingInfo.FDayActivityAccumulated, FDayActivityAccumulated);
    Copy(ATimetableTablingInfo.FDayActivityCount, FDayActivityCount);
    Copy(ATimetableTablingInfo.FDayResourceEmptyHourCount, FDayResourceEmptyHourCount);
    Copy(ATimetableTablingInfo.FDayResourceMaxHour, FDayResourceMaxHour);
    Copy(ATimetableTablingInfo.FDayResourceMinHour, FDayResourceMinHour);
    Copy(ATimetableTablingInfo.FResourcePeriodNumber, FResourcePeriodNumber);
  end;
end;

procedure TTimetable.Assign(AIndividual: TIndividual);
var
  ATimetable: TTimetable;
begin
  inherited;
  ATimetable := TTimetable(AIndividual);
  FValue := ATimetable.FValue;
  TablingInfo.Assign(ATimetable.TablingInfo);
  FTTSessionToPeriod := TIntegerArrayHandler.Clone(ATimetable.FTTSessionToPeriod);
  TIntegerArrayArrayHandler.Copy(ATimetable.FTTActivityToNumResources, FTTActivityToNumResources);
end;

procedure TTimetable.SaveToStream(Stream: TStream);
var
  Activity: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Stream.Write(FTTSessionToPeriod[0], FSessionCount * SizeOf(Integer));
    for Activity := 0 to FActivityCount - 1 do
      Stream.Write(FTTActivityToNumResources[Activity, 0], Length(FTTActivityToNumResources[Activity]) * SizeOf(Integer));
    for Activity := 0 to FActivityCount - 1 do
      Stream.Write(TablingInfo.FActivityResourceTypeToNumber[Activity, 0],
                   Length(TablingInfo.FActivityResourceTypeToNumber[Activity]) * SizeOf(Integer));
  end;
end;

procedure TTimetable.LoadFromStream(Stream: TStream);
var
  Activity: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Stream.Read(FTTSessionToPeriod[0], FSessionCount * SizeOf(Integer));
    for Activity := 0 to FActivityCount - 1 do
      Stream.Read(FTTActivityToNumResources[Activity, 0], Length(FTTActivityToNumResources[Activity]) * SizeOf(Integer));
    for Activity := 0 to FActivityCount - 1 do
      Stream.Read(TablingInfo.FActivityResourceTypeToNumber[Activity, 0],
                   Length(TablingInfo.FActivityResourceTypeToNumber[Activity]) * SizeOf(Integer));
  end;
  Update;
end;

procedure TTimetable.SaveToDataModule(IdTimetable: Integer;
  TimeIni, TimeEnd: TDateTime; Summary: TStrings);
  {$IFDEF USE_SQL}
var
  SQL: TStrings;
  {$ENDIF}
  procedure SaveTimetable;
  {$IFNDEF USE_SQL}
  var
    Stream: TStream;
  {$ENDIF}
  begin
    {$IFDEF USE_SQL}
    SQL.Add(Format('INSERT INTO Timetable(IdTimetable,TimeIni,TimeEnd,Summary) ' +
      'VALUES (%d,"%s","%s","%s");', [
      IdTimetable,
      DateTimeToAnsiSQLDate(TimeIni),
      DateTimeToAnsiSQLDate(TimeEnd),
      Summary.Text]));
    {$ELSE}
    with SourceDataModule, TbTimetable do
    begin
      DisableControls;
      try
        IndexFieldNames := 'IdTimetable';
        Append;
        TbTimetable.FindField('IdTimetable').AsInteger := IdTimetable;
        TbTimetable.FindField('TimeIni').AsDateTime := TimeIni;
        TbTimetable.FindField('TimeEnd').AsDateTime := TimeEnd;
        Stream := TMemoryStream.Create;
        try
          Summary.SaveToStream(Stream);
          Stream.Position := 0;
          TBlobField(TbTimetable.FindField('Summary')).LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
        Post;
      finally
        EnableControls;
      end;
    end;
    {$ENDIF}
  end;
  procedure SaveTimetableDetail;
  var
    Activity, Period1, Period2, Period, IdActivity, Session: Integer;
    {$IFNDEF USE_SQL}
    FieldTimetable, FieldActivity, FieldDay, FieldHour, FieldSession: TField;
    {$ENDIF}
  begin
    {$IFNDEF USE_SQL}
    with SourceDataModule.TbTimetableDetail do
    begin
      DisableControls;
      try
        Last;
        FieldTimetable := FindField('IdTimetable');
        FieldActivity := FindField('IdActivity');
        FieldDay := FindField('IdDay');
        FieldHour := FindField('IdHour');
        FieldSession := FindField('Session');
    {$ENDIF}
        with TTimetableModel(Model) do
        for Session := 0 to FSessionCount - 1 do
        begin
          Activity := FSessionToActivity[Session];
          IdActivity := FActivityToIdActivity[Activity];
          Period1 := FTTSessionToPeriod[Session];
          Period2 := Period1 + FSessionToDuration[Session] - 1;
          for Period := Period1 to Period2 do
          begin
            {$IFDEF USE_SQL}
            SQL.Add(Format(
                      'INSERT INTO TimetableDetail' +
                        '(IdTimetable,IdActivity,IdDay,IdHour,Session) VALUES (%d,%d,%d,%d,%d);',
                      [IdTimetable, IdActivity, FDayToIdDay[FPeriodToDay[Period]],
                       FHourToIdHour[FPeriodToHour[Period]], Session]));
            {$ELSE}
            Append;
            FieldTimetable.AsInteger := IdTimetable;
            FieldActivity.AsInteger := IdActivity;
            FieldDay.AsInteger := FDayAIdDay[FPeriodADay[Period]];
            FieldHour.AsInteger := FHourAIdHour[FPeriodAHour[Period]];
            FieldSession.AsInteger := Session;
            Post;
            {$ENDIF}
          end;
        end;
    {$IFNDEF USE_SQL}
      finally
        EnableControls;
      end;
    end;
    {$ENDIF}
  end;
  procedure SaveTimetableResource;
  var
    Activity, IdActivity, Resource, IdResource, NumResource, Participant: Integer;
    ActivityResourceToNumResource: TDynamicIntegerArrayArray;
  begin
    with TTimetableModel(Model) do
    begin
      SetLength(ActivityResourceToNumResource, FActivityCount, FResourceCount);
      for Activity := 0 to FActivityCount - 1 do
        for Resource := 0 to FResourceCount - 1 do
          ActivityResourceToNumResource[Activity, Resource] := 0;
      for Activity := 0 to FActivityCount - 1 do
        for Participant := 0 to High(FActivityParticipantToResource[Activity]) do
        begin
          Resource := FActivityParticipantToResource[Activity, Participant];
          NumResource := FTTActivityToNumResources[Activity, Participant];
          Inc(ActivityResourceToNumResource[Activity, Resource], NumResource);
        end;
      for Activity := 0 to FActivityCount - 1 do
      begin
        IdActivity := FActivityToIdActivity[Activity];
        for Resource := 0 to FResourceCount - 1 do
        begin
          NumResource := ActivityResourceToNumResource[Activity, Resource];
          if NumResource > 0 then
          begin
          IdResource := FResourceToIdResource[Resource];
          SQL.Add(Format('INSERT INTO TimetableResource' +
                           '(IdTimetable,IdActivity,IdResource,NumResource) VALUES (%d,%d,%d,%d);',
                         [IdTimetable,IdActivity,IdResource,NumResource]));
          end;
        end;
      end;
    end;
  end;
begin
  {$IFDEF USE_SQL}
  SQL := TStringList.Create;
  {$ELSE}
  SourceDataModule.CheckRelations := False;
  {$ENDIF}
  try
    SaveTimetable;
    SaveTimetableDetail;
    SaveTimetableResource;
    {$IFDEF USE_SQL}
    with SourceDataModule do
    begin
      DbZConnection.ExecuteDirect(SQL.Text);
      TbTimetable.Refresh;
      TbTimetableDetail.Refresh;
      TbTimetableResource.Refresh;
    end;
    {$ENDIF}
  finally
    {$IFDEF USE_SQL}
    SQL.Free;
    {$ELSE}
    SourceDataModule.CheckRelations := True;
    {$ENDIF};
  end;
end;

procedure TTimetable.LoadFromDataModule(IdTimetable: Integer);
var
  Session, Period, Activity, Resource, ResourceType, NumResource,
  Participant: Integer;
  FieldActivity, FieldResource, FieldNumResource,
  FieldDay, FieldHour, FieldSession: TField;
  ActivityResourceToNumResource: TDynamicIntegerArrayArray;
begin
  with SourceDataModule, TTimetableModel(Model) do
  begin
    TbTimetable.Locate('IdTimetable', IdTimetable, []);
    for Session := 0 to FSessionCount - 1 do
      FTTSessionToPeriod[Session] := MaxInt;
    with TbTimetableDetail do
    begin
      LinkedFields := 'IdTimetable';
      MasterFields := 'IdTimetable';
      MasterSource := DSTimetable;
      try
        FieldDay := FindField('IdDay');
        FieldHour := FindField('IdHour');
        FieldSession := FindField('Session');
        First;
        while not Eof do
        begin
          Session := FieldSession.AsInteger;
          Period := FDayHourToPeriod[FIdDayToDay[FieldDay.AsInteger - FMinIdDay],
                                     FIdHourToHour[FieldHour.AsInteger - FMinIdHour]];
          if Period < FTTSessionToPeriod[Session] then
            FTTSessionToPeriod[Session] := Period;
          Next;
        end;
      finally
        MasterSource := nil;
        MasterFields := '';
        LinkedFields := '';
      end;
    end;
    SetLength(ActivityResourceToNumResource, FActivityCount, FResourceCount);
    for Activity := 0 to FActivityCount - 1 do
      for Resource := 0 to FResourceCount - 1 do
        ActivityResourceToNumResource[Activity, Resource] := 0;
    with TbTimetableResource do
    begin
      LinkedFields := 'IdTimetable';
      MasterFields := 'IdTimetable';
      MasterSource := DSTimetable;
      try
        FieldActivity := FindField('IdActivity');
        FieldResource := FindField('IdResource');
        FieldNumResource := FindField('NumResource');
        First;
        while not Eof do
        begin
          Activity := FIdActivityToActivity[FieldActivity.AsInteger - FMinIdActivity];
          Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
          NumResource := FieldNumResource.AsInteger;
          ActivityResourceToNumResource[Activity, Resource] := NumResource;
          Next;
        end;
      finally
        MasterSource := nil;
        MasterFields := '';
        LinkedFields := '';
      end;
      for Activity := 0 to FActivityCount - 1 do
      begin
        for Participant := 0 to FActivityToNumFixeds[Activity] - 1 do
        begin
          Resource := FActivityParticipantToResource[Activity, Participant];
          Dec(ActivityResourceToNumResource[Activity, Resource],
              FTmplActivityParticipantToNumResource[Activity, Participant]);
        end;
        for Participant := FActivityToNumFixeds[Activity] to High(FActivityParticipantToResource[Activity]) do
        begin
          Resource := FActivityParticipantToResource[Activity, Participant];
          ResourceType := FResourceToResourceType[Resource];
          Dec(TablingInfo.FActivityResourceTypeToNumber[Activity, ResourceType],
              FTTActivityToNumResources[Activity, Participant]);
          FTTActivityToNumResources[Activity, Participant] :=
            ActivityResourceToNumResource[Activity, Resource];
          Inc(TablingInfo.FActivityResourceTypeToNumber[Activity, ResourceType],
              FTTActivityToNumResources[Activity, Participant]);
        end;
      end;
    end;
  end;
  Update;
  {$IFDEF DEBUG}
  CheckIntegrity('After LoadFromDataModule');
  {$ENDIF}
end;

procedure TTimetable.Reset;
var
  Resource, ResourceType, Period, RestrictionType, Day, Activity: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    FClashActivity := 0;
    FBreakTimetableResource := 0;
    FBrokenSession := 0;
    FNonScatteredActivity := 0;
    for Day := 0 to FDayCount - 1 do
      for Resource := 0 to FResourceCount - 1 do
      begin
        FDayResourceEmptyHourCount[Day, Resource] := 0;
        FDayResourceMinHour[Day, Resource] := 1;
        FDayResourceMaxHour[Day, Resource] := 0;
      end;
    for ResourceType := 0 to FResourceTypeCount - 1 do
      FClashResourceType[ResourceType] := 0;
    for RestrictionType := 0 to FRestrictionTypeCount - 1 do
      FRestrictionTypeToResourceCount[RestrictionType] := 0;
    for Period := 0 to FPeriodCount - 1 do
    begin
      for Resource := 0 to FResourceCount - 1 do
        FResourcePeriodNumber[Resource, Period] := 0;
    end;
    for Day := 0 to FDayCount - 1 do
    begin
      for Activity := 0 to FActivityCount - 1 do
      begin
        FDayActivityAccumulated[Day, Activity] := 0;
        FDayActivityCount[Day, Activity] := 0;
      end;
    end;
    SetLength(FPriorityActivity, FActivityCount);
    for Activity := 0 to FActivityCount - 1 do
      FPriorityActivity[Activity] := 0;
    FValue := 0;
  end;
end;

procedure TTimetable.Update;
var
  Activity, Session, ActivitySession, Delta, Value1: Integer;
  function PartialValue: Integer;
  begin
    Result := ClashResourceValue + ClashActivityValue + BrokenSessionValue;
  end;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Reset;
    {DoUpdateValue;}
    {MinValue := MaxInt;}
    for Activity := 0 to FActivityCount - 1 do
    begin
      Value1 := PartialValue;
      for ActivitySession := 0 to High(FActivityToSessions[Activity]) do
      begin
        Session := FActivityToSessions[Activity, ActivitySession];
        DeltaValue(1, Session);
      end;
      DoUpdateValue;
      Delta := PartialValue - Value1;
      TablingInfo.FPriorityActivity[Activity] := Max(0, Delta);
      {if MinValue > Delta then
        MinValue := Delta;}
    end;
    {for Activity := 0 to FActivityCount - 1 do
    begin
      Dec(TablingInfo.FPriorityActivity[Activity], MinValue);
    end;}
  end;
  {WriteLn(Format('Priority List: %s', [TIntegerArrayHandler.ValueToString(TablingInfo.FPriorityActivity)]));}
end;

{$IFDEF DEBUG}
procedure TTimetable.CheckIntegrity(const ALabel: string);
var
  Value1, Value2: Integer;
  ClashResourceValue1, ClashActivity1, NonScatteredActivity1,
  BreakTimetableResource1, RestrictionValue1, BrokenSession1: Integer;
  ClashResourceValue2, ClashActivity2, NonScatteredActivity2,
  BreakTimetableResource2, RestrictionValue2, BrokenSession2: Integer;
begin
  Value2 := Value;
  UpdateValue;
  Value1 := Value;
  if Value1 <> Value2 then
    WriteLn(Format('%s: Out of date Value: %d<>%d', [ALabel, Value2, Value1]));
  
  ClashResourceValue1 := ClashResourceValue;
  ClashActivity1 := ClashActivity;
  NonScatteredActivity1 := NonScatteredActivity;
  BreakTimetableResource1 := BreakTimetableResource;
  RestrictionValue1 := RestrictionValue;
  BrokenSession1 := BrokenSession;
  Update;
  Value2 := Value;
  ClashResourceValue2 := ClashResourceValue;
  ClashActivity2 := ClashActivity;
  NonScatteredActivity2 := NonScatteredActivity;
  BreakTimetableResource2 := BreakTimetableResource;
  RestrictionValue2 := RestrictionValue;
  BrokenSession2 := BrokenSession;
  
  if Value1 <> Value2 then
    WriteLn(Format('%s: Incorrect Value: %d<>%d', [ALabel, Value1, Value2]))
  else if Value2 < 0 then
    WriteLn(Format('%s: Incorrect Value: %d<0', [ALabel, Value2]));
  if ClashResourceValue1 <> ClashResourceValue2 then
    WriteLn(Format('  Incorrect ClashResourceValue: %d<>%d',
                   [ClashResourceValue1, ClashResourceValue2]))
  else if ClashResourceValue2 < 0 then
    WriteLn(Format('  Incorrect ClashResourceValue: %d<0', [ClashResourceValue2]));
  if ClashActivity1 <> ClashActivity2 then
    WriteLn(Format('  Incorrect ClashActivity: %d<>%d',
                   [ClashActivity1, ClashActivity2]))
  else if ClashActivity2 < 0 then
    WriteLn(Format('  Incorrect ClashActivity: %d<0', [ClashActivity2]));
  if NonScatteredActivity1 <> NonScatteredActivity2 then
    WriteLn(Format('  Incorrect NonScatteredActivity: %d<>%d',
                   [NonScatteredActivity1, NonScatteredActivity2]))
  else if NonScatteredActivity2 < 0 then
    WriteLn(Format('  Incorrect NonScatteredActivity: %d<0', [NonScatteredActivity2]));
  if BreakTimetableResource1 <> BreakTimetableResource2 then
    WriteLn(Format('  Incorrect BreakTimetableResource: %d<>%d',
                   [BreakTimetableResource1, BreakTimetableResource2]))
  else if BreakTimetableResource2 < 0 then
    WriteLn(Format('  Incorrect BreakTimetableResource: %d<0', [BreakTimetableResource2]));
  if RestrictionValue1 <> RestrictionValue2 then
    WriteLn(Format('  Incorrect RestrictionValue: %d<>%d',
                   [RestrictionValue1, RestrictionValue2]))
  else if RestrictionValue2 < 0 then
    WriteLn(Format('  Incorrect RestrictionValue: %s*%s=%d<0',
                   [TIntegerArrayHandler.ValueToString(RestrictionTypeToResourceCount),
                    TIntegerArrayHandler.ValueToString(TTimetableModel(Model).FRestrictionTypeToValue),
                 RestrictionValue2]));
  if BrokenSession1 <> BrokenSession2 then
    WriteLn(Format('  Incorrect BrokenSession: %d<>%d', [BrokenSession1, BrokenSession2]))
  else if BrokenSession2 < 0 then
    WriteLn(Format('  Incorrect BrokenSession: %d<>%d', [BrokenSession2]));
end;
{$ENDIF}

procedure TTimetable.UpdateValue;
begin
  DoUpdateValue;
end;

procedure TTimetable.DoUpdateValue;
begin
  FValue := GetValue;
end;

destructor TTimetableModel.Destroy;
begin
  inherited Destroy;
end;

function TTimetableModel.GetElitistCount: Integer;
begin
  Result := 1 + FResourceTypeCount;
end;

{ TTTBookmark }

constructor TTTBookmark.Create(ATimetable: TTimetable);
begin
  inherited Create(ATimetable);
end;

function TTTBookmark.GetTimetable: TTimetable;
begin
  Result := TTimetable(Individual);
end;
function TTTBookmark.GetTimetableModel: TTimetableModel;
begin
  Result := TTimetableModel(Individual.Model);
end;

function TTTBookmark.Eof: Boolean;
begin
  Result := inherited Eof or (Timetable.Value <= 0);
end;

{ TTTBookmark1 }

function TTTBookmark1.Bof: Boolean;
begin
  Result := (FSession = 0) and (FPeriod = 0);
end;

procedure TTTBookmark1.First;
begin
  inherited;
  FSession := 0;
  FPeriod := 0;
end;

procedure TTTBookmark1.Next;
begin
  inherited;
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Inc(FPeriod);
    if FPeriod = PeriodCount - FSessionToDuration[FSession] + 1 then
    begin
      Inc(FSession);
      if FSession = SessionCount then
        FSession := 0;
      FPeriod := 0;
    end;
  end;
end;

function TTTBookmark1.GetMaxPosition: Integer;
var
  Session: Integer;
begin
  Result := 0;
  with TimetableModel do
    for Session := 0 to SessionCount - 1 do
      Inc(Result, PeriodCount - FSessionToDuration[Session] + 1);
  {$IFDEF DEBUG}
  Assert(Result = inherited GetMaxPosition,
    Format('%d<>%d', [Result, inherited GetMaxPosition]));
  {$ENDIF}
end;

function TTTBookmark1.Move: Integer;
begin
  FPreviousPeriod := TTimetable(Individual).FTTSessionToPeriod[FSession];
  Result := TTimetable(Individual).MoveSession(FSession, FPeriod);
end;

function TTTBookmark1.Undo: Integer;
begin
  Result := TTimetable(Individual).MoveSession(FSession, FPreviousPeriod);
end;

{ TTTBookmark2 }

function TTTBookmark2.Bof: Boolean;
begin
  Result := (FGroup = 0) and (FGroupSession1 = 0) and (FGroupSession2 = 1);
end;

procedure TTTBookmark2.First;
begin
  inherited;
  FGroup := 0;
  FGroupSession1 := 0;
  FGroupSession2 := 1;
end;

procedure TTTBookmark2.Next;
begin
  inherited;
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Inc(FGroupSession2);
    if FGroupSession2 = Length(FGroupSessions[FGroup]) then
    begin
      Inc(FGroupSession1);
      if FGroupSession1 = Length(FGroupSessions[FGroup]) - 1 then
      begin
        repeat
          Inc(FGroup);
          if FGroup = FGroupCount then
          begin
            FGroup := 0;
          end;
        until Length(FGroupSessions[FGroup]) > 1;
        FGroupSession1 := 0;
      end;
      FGroupSession2 := FGroupSession1 + 1;
    end;
  end;
end;

function TTTBookmark2.GetMaxPosition: Integer;
var
  Group, GroupSessionsCount: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Result := 0;
    for Group := 0 to FGroupCount - 1 do
    begin
      GroupSessionsCount := Length(FGroupSessions[Group]);
      Inc(Result, GroupSessionsCount * (GroupSessionsCount - 1) div 2);
    end;
  end;
  {$IFDEF DEBUG}
  Assert(Result = inherited GetMaxPosition);
  {$ENDIF}
end;

function TTTBookmark2.Move: Integer;
var
  Session1, Session2: Integer;
begin
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Session1 := FGroupSessions[FGroup, FGroupSession1];
    Session2 := FGroupSessions[FGroup, FGroupSession2];
    FPreviousPeriod1 := FTTSessionToPeriod[Session1];
    FPreviousPeriod2 := FTTSessionToPeriod[Session2];
    Result := TTimetable(Individual).Swap(Session1, Session2);
  end;
end;

function TTTBookmark2.Undo: Integer;
var
  Session1, Session2: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Session1 := FGroupSessions[FGroup, FGroupSession1];
    Session2 := FGroupSessions[FGroup, FGroupSession2];
  end;
  with TTimetable(Individual) do
    Result := MoveSession(Session1, FPreviousPeriod1) + MoveSession(Session2, FPreviousPeriod2);
end;

{ TTTBookmark3 }

procedure TTTBookmark3.First;
begin
  inherited;
  FGroup := 0;
  FGroupSession1 := 0;
  FGroupSession2 := 1;
  FGroupSession3 := 1;
end;

function TTTBookmark3.Bof: Boolean;
begin
  Result := (FGroup = 0) and (FGroupSession1 = 0) and (FGroupSession2 = 1) and (FGroupSession3 = 1);
end;

procedure TTTBookmark3.Next;
begin
  inherited;
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Inc(FGroupSession3);
    if FGroupSession3 = Length(FGroupSessions[FGroup]) then
    begin
      Inc(FGroupSession2);
      if FGroupSession2 = Length(FGroupSessions[FGroup]) then
      begin
        Inc(FGroupSession1);
        if FGroupSession1 = Length(FGroupSessions[FGroup]) - 1 then
        begin
          repeat
            Inc(FGroup);
            if FGroup = FGroupCount then
            begin
              FGroup := 0;
            end;
          until Length(FGroupSessions[FGroup]) > 1;
          FGroupSession1 := 0;
        end;
        FGroupSession2 := FGroupSession1 + 1;
      end;
      FGroupSession3 := FGroupSession1 + 1;
    end;
  end;
end;

function TTTBookmark3.GetMaxPosition: Integer;
var
  Group, GroupSessionsCount: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Result := 0;
    for Group := 0 to FGroupCount - 1 do
    begin
      GroupSessionsCount := Length(FGroupSessions[Group]);
      Inc(Result, (GroupSessionsCount * (GroupSessionsCount - 1) div 2)
                  * (2 * GroupSessionsCount - 1) div 3);
    end;
  end;
  {$IFDEF DEBUG}
  Assert(Result = inherited GetMaxPosition);
  {$ENDIF}
end;

function TTTBookmark3.Move: Integer;
var
  Session1, Session2, Session3: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Session1 := FGroupSessions[FGroup, FGroupSession1];
    Session2 := FGroupSessions[FGroup, FGroupSession2];
    Session3 := FGroupSessions[FGroup, FGroupSession3];
  end;
  with TTimetable(Individual) do
  begin
    FPreviousPeriod1 := FTTSessionToPeriod[Session1];
    FPreviousPeriod2 := FTTSessionToPeriod[Session2];
    FPreviousPeriod3 := FTTSessionToPeriod[Session3];
    Result := Swap(Session1, Session2) + Swap(Session2, Session3);
  end;
end;

function TTTBookmark3.Undo: Integer;
var
  Session1, Session2, Session3: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Session1 := FGroupSessions[FGroup, FGroupSession1];
    Session2 := FGroupSessions[FGroup, FGroupSession2];
    Session3 := FGroupSessions[FGroup, FGroupSession3];
  end;
  with TTimetable(Individual) do
  begin
    Result := MoveSession(Session1, FPreviousPeriod1)
      + MoveSession(Session2, FPreviousPeriod2)
      + MoveSession(Session3, FPreviousPeriod3);
  end;
end;

function TTTBookmarkTheme.Bof: Boolean;
begin
  Result := (FThemeIndex = 0) and (FThemeActivity1 = 0) and (FThemeActivity2 = 1)
    and (FParticipant11 = NumFixeds1) and (FParticipant12 = NumFixeds1)
    and (FDeltaNumResource1 = -Min(NumResource11, Free21))
    and (FDeltaNumResource2 = -Min(NumResource12, Free22));
end;

procedure TTTBookmarkTheme.First;
begin
  inherited;
  FThemeIndex := 0;
  FThemeActivity1 := 0;
  FThemeActivity2 := 1;
  FParticipant11 := NumFixeds1;
  FParticipant12 := NumFixeds1;
  FDeltaNumResource1 := -Min(NumResource11, Free21);
  FDeltaNumResource2 := -Min(NumResource12, Free22);
end;

procedure TTTBookmarkTheme.Next;
begin
  inherited;
  with TimetableModel, Timetable do
  begin
    Inc(FDeltaNumResource2);
    while FDeltaNumResource2 > Min(NumResource22, Free12) do
    begin
      Inc(FDeltaNumResource1);
      while FDeltaNumResource1 > Min(NumResource21, Free11) do
      begin
        repeat
          Inc(FParticipant12);
        until (FParticipant12 = Length(FActivityParticipantToResource[Activity1]))
          or (ResourceType1 = ResourceType2);
        if FParticipant12 = Length(FActivityParticipantToResource[Activity1]) then
        begin
          Inc(FParticipant11);
          if FParticipant11 = Length(FActivityParticipantToResource[Activity1]) then
          begin
            Inc(FThemeActivity2);
            if FThemeActivity2 = Length(FThemeToActivities[Theme]) then
            begin
              Inc(FThemeActivity1);
              if FThemeActivity1 = Length(FThemeToActivities[Theme]) - 1 then
              begin
                Inc(FThemeIndex);
                if FThemeIndex = Length(FThemeWithMobileResources) then
                begin
                  FThemeIndex := 0;
                end;
                FThemeActivity1 := 0;
              end;
              FThemeActivity2 := FThemeActivity1 + 1;
            end;
            FParticipant11 := NumFixeds1;
          end;
          FParticipant12 := FParticipant11;
        end;
        Assert(ResourceType1=ResourceType2);
        FDeltaNumResource1 := -Min(NumResource11, Free21);
      end;
      Assert(ResourceType1=ResourceType2);
      FDeltaNumResource2 := -Min(NumResource12, Free22);
    end;
  end;
end;

function TTTBookmarkTheme.GetTheme: Integer;
begin
  Result := TimetableModel.FThemeWithMobileResources[FThemeIndex];
end;

function TTTBookmarkTheme.GetActivity1: Integer;
begin
  Result := TimetableModel.FThemeToActivities[Theme, FThemeActivity1];
end;

function TTTBookmarkTheme.GetActivity2: Integer;
begin
  Result := TimetableModel.FThemeToActivities[Theme, FThemeActivity2];
end;

function TTTBookmarkTheme.GetResource1: Integer;
begin
  Result := TimetableModel.FActivityParticipantToResource[Activity1, FParticipant11];
end;

function TTTBookmarkTheme.GetResource2: Integer;
begin
  Result := TimetableModel.FActivityParticipantToResource[Activity1, FParticipant12];
end;

function TTTBookmarkTheme.GetNumFixeds1: Integer;
begin
  Result := TimetableModel.FActivityToNumFixeds[Activity1];
end;

function TTTBookmarkTheme.GetNumFixeds2: Integer;
begin
  Result := TimetableModel.FActivityToNumFixeds[Activity2];
end;

function TTTBookmarkTheme.GetParticipant21: Integer;
begin
  Result := Participant11 + NumFixeds2 - NumFixeds1;
  Assert(Result>=NumFixeds2);
  Assert(Result<Length(TimetableModel.FActivityParticipantToResource[Activity2]));
end;

function TTTBookmarkTheme.GetParticipant22: Integer;
begin
  Result := Participant12 + NumFixeds2 - NumFixeds1;
  Assert(Result>=NumFixeds2);
  Assert(Result<Length(TimetableModel.FActivityParticipantToResource[Activity2]));
end;

function TTTBookmarkTheme.GetResourceType1: Integer;
begin
  Result := TimetableModel.FResourceToResourceType[Resource1];
end;
  
function TTTBookmarkTheme.GetResourceType2: Integer;
begin
  Result := TimetableModel.FResourceToResourceType[Resource2];
end;
  
function TTTBookmarkTheme.GetLimit: Integer;
begin
  Result := TimetableModel.FThemeResourceTypeToLimit[Theme, ResourceType1];
  Assert(Result>=0);
end;

function TTTBookmarkTheme.GetNumResource12: Integer;
begin
  Result := Timetable.TTActivityToNumResources[Activity1, Participant12];
end;

function TTTBookmarkTheme.GetFree12: Integer;
begin
  Result := Free11 - NumResource12 - FDeltaNumResource1;
end;

function TTTBookmarkTheme.GetNumResource22: Integer;
begin
  Result := Timetable.TTActivityToNumResources[Activity2, Participant22];
end;

function TTTBookmarkTheme.GetFree22: Integer;
begin
  Result := Free21 - NumResource22 + FDeltaNumResource1
end;

function TTTBookmarkTheme.GetFree11: Integer;
begin
  Result := Limit - Timetable.TablingInfo.FActivityResourceTypeToNumber[Activity1, ResourceType1] + NumResource12;
end;

function TTTBookmarkTheme.GetFree21: Integer;
begin
  Result := Limit - Timetable.TablingInfo.FActivityResourceTypeToNumber[Activity2, ResourceType1] + NumResource22;
end;

function TTTBookmarkTheme.GetNumResource11: Integer;
begin
  Result := Timetable.TTActivityToNumResources[Activity1, Participant11];
end;

function TTTBookmarkTheme.GetNumResource21: Integer;
begin
  Result := Timetable.TTActivityToNumResources[Activity2, Participant21];
end;

function TTTBookmarkTheme.Move: Integer;
begin
  with Timetable do
  begin
    Result := FValue;
    FPreviousDeltaNumResource1 := FDeltaNumResource1;
    FPreviousDeltaNumResource2 := FDeltaNumResource2;
    DeltaActivityParticipantValue(Activity1, Participant11, +FDeltaNumResource1);
    DeltaActivityParticipantValue(Activity2, Participant21, -FDeltaNumResource1);
    DeltaActivityParticipantValue(Activity1, Participant12, +FDeltaNumResource2);
    DeltaActivityParticipantValue(Activity2, Participant22, -FDeltaNumResource2);
    FDeltaNumResource1 := 0;
    FDeltaNumResource2 := 0;
    DoUpdateValue;
    Result := FValue - Result;
  end;
end;

function TTTBookmarkTheme.Undo: Integer;
begin
  with Timetable do
  begin
    Result := FValue;
    FDeltaNumResource1 := FPreviousDeltaNumResource1;
    FDeltaNumResource2 := FPreviousDeltaNumResource2;
    DeltaActivityParticipantValue(Activity2, Participant22, +FDeltaNumResource2);
    DeltaActivityParticipantValue(Activity1, Participant12, -FDeltaNumResource2);
    DeltaActivityParticipantValue(Activity2, Participant21, +FDeltaNumResource1);
    DeltaActivityParticipantValue(Activity1, Participant11, -FDeltaNumResource1);
    DoUpdateValue;
    Result := FValue - Result;
  end;
end;

end.
