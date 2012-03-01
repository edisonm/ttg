{ -*- mode: Delphi -*- }
unit UTTModel;

{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}CThreads, CMem, {$ENDIF}Classes, DB, Dialogs, Forms, UModel,
  UTTGBasics, USortAlgs;

var
  SortInteger: procedure(var KeyList: array of Integer;
    var ValueList: array of Integer; min, max: Integer) of object;
  Sort: procedure(var KeyList: array of Integer; min, max: Integer) of object;

type
  TSortInteger = specialize TSortAlgorithm<Integer,Integer>;

type
  {
    Clase TTimetableModel
    Descripcion:
    Implementa la carga de la informacion desde la base de datos a la memoria
    RAM.
    Miembros privados:
    Todos los arreglos dinamicos que contienen la informacion, los campos que
    contienen los pesos de la funcion objetivo y las funciones de uso interno.
    Miembros protegidos:
    Arreglo dinamico que contiene el molde de un horario, que facilita la
    construccion de soluciones.
    Miembros publicos:
    El constructor, la funcion que permite configurar los pesos y los pesos
    de cada restriccion.
  }

  TTimetable = class;
  TTimetableArray = array of TTimetable;

  { TTimetableModel }


  TTimetableModel = class(TModel)
  private
    FClashActivityValue: Integer;
    FOutOfPositionEmptyHourValue: Integer;
    FBrokenSessionValue: Integer;
    FBreakTimetableResourceValue: Integer;
    FNonScatteredActivityValue: Integer;
    FThemeCount: Integer;
    FResourceTypeCount: Integer;
    FResourceRestrictionTypeCount: Integer;
    FDayCount: Integer;
    FHourCount: Integer;
    FPeriodCount: Integer;
    FResourceCount: Integer;
    FActivityCount: Integer;
    FSessionCount: Integer;
    FMinIdActivity: Integer;
    FMinIdDay: Integer;
    FMinIdHour: Integer;

    FPeriodToDay: TDynamicIntegerArray;
    FPeriodToHour: TDynamicIntegerArray;
    FDayToMaxPeriod: TDynamicIntegerArray;
    FSessionToActivity: TDynamicIntegerArray;
    FSessionToTheme: TDynamicIntegerArray;
    FResourceToNumber: TDynamicIntegerArray;
    FResourceToName: TDynamicStringArray;
    FResourceSorted: TDynamicIntegerArray;
    FActivitySorted: TDynamicIntegerArray;
    FSessionSorted: TDynamicIntegerArray;
    FResourceToResourceType: TDynamicIntegerArray;
    FResourceRestrictionTypeToValue: TDynamicIntegerArray;
    FResourceRestrictionTypeToName: TDynamicStringArray;
    FResourceTypeToValue: TDynamicIntegerArray;
    FResourceTypeToName: TDynamicStringArray;
    FResourceTypeToDefaultLimit: TDynamicIntegerArray;
    FThemeToIdTheme: TDynamicIntegerArray;
    FDayToIdDay: TDynamicIntegerArray;
    FHourToIdHour: TDynamicIntegerArray;
    FActivityToIdActivity: TDynamicIntegerArray;
    FIdActivityToActivity: TDynamicIntegerArray;
    FActivityToTheme: TDynamicIntegerArray;
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
    FActivityToResources: TDynamicIntegerArrayArray;
    FActivityToNumResources: TDynamicIntegerArrayArray;
    FActivityResourceTypeToNumber: TDynamicIntegerArrayArray;
    FResourceToActivities: TDynamicIntegerArrayArray;
    FThemeResourceTypeToLimit: TDynamicIntegerArrayArray;
    FThemeToResources: TDynamicIntegerArrayArray;
    FResourceToThemes: TDynamicIntegerArrayArray;
    FThemeToNumResources: TDynamicIntegerArrayArray;
    FThemeToLimits: TDynamicIntegerArrayArray;
    //FTimetableDetailPattern: TDynamicIntegerArrayArray;
    FActivityToSessions: TDynamicIntegerArrayArray;
    FResourcePeriodToResourceRestrictionType: TDynamicIntegerArrayArray;

    function GetDayToMaxPeriod(Day: Integer): Integer;
  protected
    //property TimetableDetailPattern: TDynamicIntegerArrayArray read FTimetableDetailPattern;
    function GetElitistCount: Integer; override;
  public
    procedure Configure(AClashActivityValue, ABreakTimetableResourceValue,
                        AOutOfPositionEmptyHourValue, ABrokenSessionValue,
                        ANonScatteredActivityValue: Integer);
    constructor Create(AClashActivityValue, ABreakTimetableResourceValue,
                       AOutOfPositionEmptyHourValue, ABrokenSessionValue,
                       ANonScatteredActivityValue: Integer);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TIndividual; override;
    property PeriodCount: Integer read FPeriodCount;
    property SessionCount: Integer read FSessionCount;
    property ClashActivityValue: Integer read FClashActivityValue;
    property BreakTimetableResourceValue: Integer read FBreakTimetableResourceValue;
    property OutOfPositionEmptyHourValue: Integer read FOutOfPositionEmptyHourValue;
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
    FResourcePeriodNumber: TDynamicIntegerArrayArray;
    FDayActivityCount: TDynamicIntegerArrayArray;
    FDayActivityAccumulated: TDynamicIntegerArrayArray;
    FClashResourceType: TDynamicIntegerArray;
    FResourceRestrictionTypeToResourceCount: TDynamicIntegerArray;
    FDayResourceMinHour: TDynamicIntegerArrayArray;
    FDayResourceMaxHour: TDynamicIntegerArrayArray;
    FDayResourceEmptyHourCount: TDynamicIntegerArrayArray;
    FClashActivity: Integer;
    FBreakTimetableResource: Integer;
    FOutOfPositionEmptyHour: Integer;
    FNonScatteredActivity: Integer;
    FBrokenSession: Integer;
  end;

  { TTimetable }

  TTimetable = class(TIndividual)
  private
    FTablingInfo: TTimetableTablingInfo;
    FTTSessionToPeriod: TDynamicIntegerArray;
    FTTActivityToNumResources: TDynamicIntegerArrayArray;
    procedure CrossGroup(Timetable2: TTimetable; AGroup: Integer);
    procedure DeltaResourceValue(Delta, Limit, Period1, Period2,
                                 Resource, NumResource: Integer);
    procedure DeltaResourcesValue(Delta, Limit, Period1, Period2: Integer;
                                  Resources, NumResources: TDynamicIntegerArray);
    procedure DeltaPeriodsValue(Delta, Limit, Period1, Period2, Activity: Integer);
    procedure DeltaValue(Delta, Session: Integer);
    function GetClashActivityValue: Integer;
    function GetNonScatteredActivityValue: Integer;
    function GetOutOfPositionEmptyHourValue: Integer;
    function GetClashResourceValue: Integer;
    function GetResourceRestrictionValue: Integer;
    function GetBreakTimetableResourceValue: Integer;
    function GetBrokenSessionValue: Integer;
    function GetValue: Integer;
    procedure Reset;
  protected
    function GetElitistValues(Index: Integer): Integer; override;
  public
    constructor Create(ATimetableModel: TTimetableModel);
    destructor Destroy; override;
    {Implements abstract class TIndividual:}
    procedure Update; override;
    procedure UpdateValue; override;
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
    property OutOfPositionEmptyHour: Integer read FTablingInfo.FOutOfPositionEmptyHour;
    property ResourceRestrictionTypeToResourceCount: TDynamicIntegerArray
      read FTablingInfo.FResourceRestrictionTypeToResourceCount;
    property ClashResourceType: TDynamicIntegerArray read FTablingInfo.FClashResourceType;
    property NonScatteredActivity: Integer read FTablingInfo.FNonScatteredActivity;
    property BrokenSession: Integer read FTablingInfo.FBrokenSession;
    property ClashActivity: Integer read FTablingInfo.FClashActivity;
    property ClashResourceValue: Integer read GetClashResourceValue;
    property ClashActivityValue: Integer read GetClashActivityValue;
    property BreakTimetableResourceValue: Integer read GetBreakTimetableResourceValue;
    property OutOfPositionEmptyHourValue: Integer read GetOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read GetBrokenSessionValue;
    property NonScatteredActivityValue: Integer read GetNonScatteredActivityValue;
    property ResourceRestrictionValue: Integer read GetResourceRestrictionValue;
    property TTSessionToPeriod: TDynamicIntegerArray
                                  read FTTSessionToPeriod;
    property TTTActivityToNumResources: TDynamicIntegerArrayArray
                                          read FTTActivityToNumResources;
    property BreakTimetableResource: Integer read FTablingInfo.FBreakTimetableResource;
    property TablingInfo: TTimetableTablingInfo read FTablingInfo;
  end;

  { TTTBookmark1 }

  // Move one Session to one Period
  TTTBookmark1 = class(TBookmark)
  private
    FPosition: Integer;
    FOffset: Integer;
    FSession: Integer;
    FPeriod: Integer;
    FPreviousPeriod: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; APosition, AOffset,
                       ASession, APeriod: Integer); overload;
    constructor Create(AIndividual: TIndividual); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Offset: Integer read FOffset write FOffset;
  end;

  { TTTBookmark2 }

  TTTBookmark2 = class(TBookmark)
  private
    FPosition: Integer;
    FMaxPosition: Integer;
    FOffset: Integer;
    FGroup: Integer;
    FGroupSession1: Integer;
    FGroupSession2: Integer;
    FPreviousPeriod1: Integer;
    FPreviousPeriod2: Integer;
    function GetMaxPosition: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; APosition, AMaxPosition, AOffset,
                       AGroup, AGroupSession1, AGroupSession2: Integer); overload;
    constructor Create(AIndividual: TIndividual); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Offset: Integer read FOffset write FOffset;
  end;

  { TTTBookmark3 }

  TTTBookmark3 = class(TBookmark)
  private
    FPosition: Integer;
    FMaxPosition: Integer;
    FOffset: Integer;
    FGroup: Integer;
    FGroupSession1: Integer;
    FGroupSession2: Integer;
    FGroupSession3: Integer;
    FPreviousPeriod1: Integer;
    FPreviousPeriod2: Integer;
    FPreviousPeriod3: Integer;
    function GetMaxPosition: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; APosition, AMaxPosition,
                       AOffset, AGroup, AGroupSession1, AGroupSession2,
                       AGroupSession3: Integer); overload;
    constructor Create(AIndividual: TIndividual); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Offset: Integer read FOffset write FOffset;
  end;

implementation

uses
  SysUtils, ZSysUtils, MTProcs, DSource, UTTGConsts, DSourceBaseConsts, Math;

type
  TSortDoubleInt = specialize TSortAlgorithm<Double, Integer>;

constructor TTimetableModel.Create(AClashActivityValue,
                                   ABreakTimetableResourceValue,
                                   AOutOfPositionEmptyHourValue,
                                   ABrokenSessionValue,
                                   ANonScatteredActivityValue: Integer);
var
  FMinIdResourceRestrictionType, FMinIdTheme,
    FMinIdResource, FMinIdResourceType: Integer;
  FIdThemeToTheme, FIdResourceToResource, FIdResourceTypeToResourceType,
    FResourceTypeToIdResourceType, FResourceToIdResource,
    FIdResourceRestrictionTypeToResourceRestrictionType,
    FResourceRestrictionTypeToIdResourceRestrictionType: TDynamicIntegerArray;
  FResourceActivityToNumResources, FResourceThemeToNumResources,
    FThemeToComposition: TDynamicIntegerArrayArray;
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
    FieldValue, FieldName, FieldDefaultLimit: TField;
  begin
    with SourceDataModule.TbResourceType do
    begin
      IndexFieldNames := 'IdResourceType';
      First;
      FieldName := FindField('NaResourceType');
      FieldValue := FindField('ValResourceType');
      FieldDefaultLimit := FindField('DefaultLimit');
      SetLength(FResourceTypeToName, FResourceTypeCount);
      SetLength(FResourceTypeToValue, FResourceTypeCount);
      SetLength(FResourceTypeToDefaultLimit, FResourceTypeCount);
      for ResourceType := 0 to FResourceTypeCount - 1 do
      begin
        FResourceTypeToName[ResourceType] := FieldName.AsString;
        FResourceTypeToValue[ResourceType] := FieldValue.AsInteger;
        FResourceTypeToDefaultLimit[ResourceType] := FieldDefaultLimit.AsInteger;
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
      SetLength(FResourceToNumber, FResourceCount);
      SetLength(FResourceToName, FResourceCount);
      for Resource := 0 to FResourceCount - 1 do
      begin
        FResourceToResourceType[Resource] :=
          FIdResourceTypeToResourceType[FieldResourceType.AsInteger - FMinIdResourceType];
        FResourceToNumber[Resource] := FieldResourceNumber.AsInteger;
        FResourceToName[Resource] := FieldResourceName.AsString;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceRestrictionType;
  var
    ResourceRestrictionType: Integer;
    FieldValue, FieldName: TField;
  begin
    with SourceDataModule.TbResourceRestrictionType do
    begin
      IndexFieldNames := 'IdResourceRestrictionType';
      First;
      FieldValue := FindField('ValResourceRestrictionType');
      FieldName := FindField('NaResourceRestrictionType');
      SetLength(FResourceRestrictionTypeToValue, RecordCount);
      SetLength(FResourceRestrictionTypeToName, RecordCount);
      for ResourceRestrictionType := 0 to RecordCount - 1 do
      begin
        FResourceRestrictionTypeToValue[ResourceRestrictionType] := FieldValue.AsInteger;
        FResourceRestrictionTypeToName[ResourceRestrictionType] := FieldName.AsString;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceRestriction;
  var
    ResourceRestriction, Resource, Period, Day, Hour,
      ResourceRestrictionType: Integer;
    FieldResource, FieldDay, FieldHour,
      FieldResourceRestrictionType: TField;
  begin
    with SourceDataModule.TbResourceRestriction do
    begin
      IndexFieldNames := 'IdResource;IdDay;IdHour;IdResourceRestrictionType';
      First;
      SetLength(FResourcePeriodToResourceRestrictionType, FResourceCount, FPeriodCount);
      for Resource := 0 to FResourceCount - 1 do
        for Period := 0 to FPeriodCount - 1 do
          FResourcePeriodToResourceRestrictionType[Resource, Period] := -1;
      FieldResource := FindField('IdResource');
      FieldHour := FindField('IdHour');
      FieldDay := FindField('IdDay');
      FieldResourceRestrictionType := FindField('IdResourceRestrictionType');
      for ResourceRestriction := 0 to RecordCount - 1 do
      begin
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        Day := FIdDayToDay[FieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[FieldHour.AsInteger - FMinIdHour];
        Period := FDayHourToPeriod[Day, Hour];
        ResourceRestrictionType := FIdResourceRestrictionTypeToResourceRestrictionType
          [FieldResourceRestrictionType.AsInteger - FMinIdResourceRestrictionType];
        FResourcePeriodToResourceRestrictionType[Resource, Period] := ResourceRestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure LoadTheme;
  var
    Theme, CompositionCount, VPos: Integer;
    FieldComposition: TField;
    Composition: string;
  begin
    with SourceDataModule.TbTheme do
    begin
      IndexFieldNames := 'IdTheme';
      First;
      FieldComposition := FindField('Composition');
      SetLength(FThemeToComposition, FThemeCount, 0);
      for Theme := 0 to FThemeCount - 1 do
      begin
        Composition := FieldComposition.AsString;
        VPos := 1;
        CompositionCount := 0;
        while VPos <= Length(Composition) do
        begin
          SetLength(FThemeToComposition[Theme], CompositionCount + 1);
          FThemeToComposition[Theme, CompositionCount]
            := StrToInt(ExtractString(Composition, VPos, '.'));
          Inc(CompositionCount);
        end;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadActivity;
  var
    Theme, Session1, Activity, Session2, Session: Integer;
    FieldTheme: TField;
  begin
    with SourceDataModule.TbActivity do
    begin
      IndexFieldNames := 'IdActivity';
      First;
      FieldTheme := FindField('IdTheme');
      FActivityCount := RecordCount;
      SetLength(FActivityToSessions, FActivityCount);
      SetLength(FActivityToTheme, FActivityCount);
      Session2 := 0;
      for Activity := 0 to FActivityCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        FActivityToTheme[Activity] := Theme;
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
    Participant, Counter, ParticipantCount, Activity, Resource, Number,
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
      SetLength(FResourceToActivities, FResourceCount, 0);
      SetLength(FResourceActivityToNumResources, FResourceCount, 0);
      SetLength(FActivityResourceTypeToNumber, FActivityCount, FResourceTypeCount);
      for Activity := 0 to FActivityCount - 1 do
        for ResourceType := 0 to FResourceTypeCount - 1 do
          FActivityResourceTypeToNumber[Activity, ResourceType] := 0;
      FieldActivity := FindField('IdActivity');
      FieldResource := FindField('IdResource');
      FieldNumResource := FindField('NumResource');
      for Participant := 0 to ParticipantCount - 1 do
      begin
        Activity := FIdActivityToActivity[FieldActivity.AsInteger - FMinIdActivity];
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        Counter := Length(FActivityToResources[Activity]);
        SetLength(FActivityToResources[Activity], Counter + 1);
        SetLength(FActivityToNumResources[Activity], Counter + 1);
        FActivityToResources[Activity, Counter] := Resource;
        Number := FieldNumResource.AsInteger;
        FActivityToNumResources[Activity, Counter] := Number;
        Counter := Length(FResourceToActivities[Resource]);
        SetLength(FResourceToActivities[Resource], Counter + 1);
        FResourceToActivities[Resource, Counter] := Activity;
        SetLength(FResourceActivityToNumResources[Resource], Counter + 1);
        FResourceActivityToNumResources[Resource, Counter] := Number;
        Inc(FActivityResourceTypeToNumber[Activity, FResourceToResourceType[Resource]], Number);
        Next;
      end;
      First;
    end;
  end;
  procedure LoadRequirement;
  var
    Requirement, RequirementCount, Theme, ResourceType: Integer;
    FieldTheme, FieldResourceType, FieldLimit: TField;
  begin
    with SourceDataModule.TbRequirement do
    begin
      IndexFieldNames := 'IdTheme;IdResourceType';
      First;
      RequirementCount := RecordCount;
      SetLength(FThemeResourceTypeToLimit, FThemeCount, FResourceTypeCount);
      FieldTheme := FindField('IdTheme');
      FieldResourceType := FindField('IdResourceType');
      FieldLimit := FindField('Limit');
      for Theme := 0 to FThemeCount - 1 do
        for ResourceType := 0 to FResourceTypeCount - 1 do
        begin
          FThemeResourceTypeToLimit[Theme, ResourceType] := FResourceTypeToDefaultLimit[ResourceType];
        end;
      for Requirement := 0 to RequirementCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        ResourceType := FIdResourceTypeToResourceType[FieldResourceType.AsInteger - FMinIdResourceType];
        FThemeResourceTypeToLimit[Theme, ResourceType] := FieldLimit.AsInteger;
        {
         Counter := Length(FThemeToResourceTypes[Theme]);
         SetLength(FThemeToResourceTypes[Theme], Counter + 1);
         SetLength(FThemeToLimits[Theme], Counter + 1);
         FThemeToResourceTypes[Theme, Counter] := ResourceType;
         FThemeToLimits[Theme, Counter] := FieldLimit.AsInteger;
         Counter := Length(FResourceTypeToActivities[ResourceType]);
         SetLength(FResourceTypeToActivities[ResourceType], Counter + 1);
         FResourceTypeToActivities[ResourceType, Counter] := Theme;
        }
        Next;
      end;
      First;
    end;
  end;
  procedure LoadFillRequirement;
  var
    NumResource, FillRequirement, Counter, FillRequirementCount, Resource,
      Theme, ResourceType: Integer;
    FieldTheme, FieldResource, FieldNumResource: TField;
  begin
    with SourceDataModule.TbFillRequirement do
    begin
      IndexFieldNames := 'IdTheme;IdResource';
      First;
      FillRequirementCount := RecordCount;
      SetLength(FThemeToResources, FThemeCount, 0);
      SetLength(FThemeToNumResources, FThemeCount, 0);
      SetLength(FThemeToLimits, FThemeCount, 0);
      SetLength(FResourceToThemes, FResourceCount, 0);
      SetLength(FResourceThemeToNumResources, FResourceCount, 0);
      FieldTheme := FindField('IdTheme');
      FieldResource := FindField('IdResource');
      FieldNumResource := FindField('NumResource');
      NumResource := FieldNumResource.AsInteger;
      for FillRequirement := 0 to FillRequirementCount - 1 do
      begin
        Theme := FIdThemeToTheme[FieldTheme.AsInteger - FMinIdTheme];
        Resource := FIdResourceToResource[FieldResource.AsInteger - FMinIdResource];
        ResourceType := FResourceToResourceType[Resource];
        Counter := Length(FThemeToResources[Theme]);
        SetLength(FThemeToResources[Theme], Counter + 1);
        SetLength(FThemeToNumResources[Theme], Counter + 1);
        SetLength(FThemeToLimits[Theme], Counter + 1);
        FThemeToResources[Theme, Counter] := Resource;
        FThemeToNumResources[Theme, Counter] := NumResource;
        FThemeToLimits[Theme, Counter] := FThemeResourceTypeToLimit[Theme, ResourceType];
        Counter := Length(FResourceToThemes[Resource]);
        SetLength(FResourceToThemes[Resource], Counter + 1);
        FResourceToThemes[Resource, Counter] := Theme;
        SetLength(FResourceThemeToNumResources[Resource], Counter + 1);
        FResourceThemeToNumResources[Resource, Counter] := NumResource;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadGreedyData;
  var
    Number, Duration, Activity, ActivityResource, Theme, ResourceTheme, Resource,
    Count, Group, Session, HighActivitySorted, HighSessionSorted, ResourceActivity,
    ThemeResource, Component, ActivitySession, UBound: Integer;
    FreedomDegrees: Double; // Logaritmic to prevent overfloat
    ActivityIsPlaced: TDynamicBooleanArray;
    ThemeResourceToFreedomDegrees, ActivityResourceToFreedomDegrees,
      ResourceToFreedomDegrees: TDynamicDoubleArray;
  begin
    SetLength(ResourceToFreedomDegrees, FResourceCount);
    SetLength(FResourceSorted, FResourceCount);
    for Resource := 0 to FResourceCount -1 do
    begin
      Duration := 0;
      // Upper bound, not exact due to there is not overlapping
      // between session of the same activity (for example):
      Number := FResourceToNumber[Resource] * FPeriodCount;
      for ResourceActivity := 0 to High(FResourceToActivities[Resource]) do
      begin
        Activity := FResourceToActivities[Resource, ResourceActivity];
        for ActivitySession := 0 to High(FActivityToSessions[Activity]) do
        begin
          Inc(Duration, FResourceActivityToNumResources[Resource, ResourceActivity]
                        * FSessionToDuration[FActivityToSessions[Activity, ActivitySession]]);
        end;
      end;
      // Upper bound
      for ResourceTheme := 0 to High(FResourceToThemes[Resource]) do
      begin
        Theme := FResourceToThemes[Resource, ResourceTheme];
        for Component := 0 to High(FThemeToComposition[Theme]) do
        begin
          UBound := Min(FThemeResourceTypeToLimit[Theme, FResourceToResourceType[Resource]],
                        FResourceThemeToNumResources[Resource, ResourceTheme]);
          Inc(Duration, UBound * FThemeToComposition[Theme, Component]);
        end;
      end;
      FreedomDegrees := Number - Duration;
      if FreedomDegrees < 0 then
        raise Exception.CreateFmt(SResourceOverflow, [FResourceToName[Resource], Duration, Number]);
      ResourceToFreedomDegrees[Resource] := FreedomDegrees;
      FResourceSorted[Resource] := Resource;
      WriteLn(Format('Resource %s(%d), FreedomDegrees=%g',
                     [FResourceToName[Resource],
                      FResourceToIdResource[Resource],
                      ResourceToFreedomDegrees[Resource]]));
    end;
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(ActivityResourceToFreedomDegrees, Length(FActivityToResources[Activity]));
      for ActivityResource := 0 to High(FActivityToResources[Activity]) do
      begin
        ActivityResourceToFreedomDegrees[ActivityResource] :=
          ResourceToFreedomDegrees[FActivityToResources[Activity, ActivityResource]];
      end;
      TSortDoubleInt.QuickSort(ActivityResourceToFreedomDegrees, FActivityToResources[Activity],
                               0, High(FActivityToResources[Activity]));
    end;
    for Theme := 0 to FThemeCount - 1 do
    begin
      SetLength(ThemeResourceToFreedomDegrees, Length(FThemeToResources[Theme]));
      for ThemeResource := 0 to High(FThemeToResources[Theme]) do
      begin
        ThemeResourceToFreedomDegrees[ThemeResource] :=
          ResourceToFreedomDegrees[FThemeToResources[Theme, ThemeResource]];
      end;
      TSortDoubleInt.QuickSort(ThemeResourceToFreedomDegrees, FThemeToResources[Theme],
                               0, High(FThemeToResources[Theme]));
    end;
    TSortDoubleInt.QuickSort(ResourceToFreedomDegrees, FResourceSorted, 0, FResourceCount - 1);
    WriteLn;
    SetLength(ActivityIsPlaced, FActivityCount);
    for Activity := 0 to FActivityCount - 1 do
    begin
      ActivityIsPlaced[Activity] := False;
    end;
    SetLength(FActivitySorted, FActivityCount);
    SetLength(FSessionSorted, FSessionCount);
    HighActivitySorted := 0;
    HighSessionSorted := 0;
    SetLength(FGroupSessions, FResourceCount);
    for Group := 0 to FResourceCount -1 do
    begin
      Resource := FResourceSorted[Group];
      WriteLn(Format('Resource %s(%d), FreedomDegrees=%g',
                     [FResourceToName[Resource],
                      FResourceToIdResource[Resource],
                      ResourceToFreedomDegrees[Group]]));
      for ResourceActivity := 0 to High(FResourceToActivities[Resource]) do
      begin
        Activity := FResourceToActivities[Resource, ResourceActivity];
        if not ActivityIsPlaced[Activity] then
        begin
          FActivitySorted[HighActivitySorted] := Activity;
          Inc(HighActivitySorted);
          ActivityIsPlaced[Activity] := True;
          FGroupCount := Group;
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
    end;
    Inc(FGroupCount);
    SetLength(FGroupSessions, FGroupCount);
    WriteLn;
  end;
begin
  inherited Create;
  with SourceDataModule do
  begin
    Configure(AClashActivityValue,
      ABreakTimetableResourceValue, AOutOfPositionEmptyHourValue,
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
    Load(TbResourceRestrictionType, 'IdResourceRestrictionType',
      FMinIdResourceRestrictionType,
      FIdResourceRestrictionTypeToResourceRestrictionType,
      FResourceRestrictionTypeToIdResourceRestrictionType);
    FResourceRestrictionTypeCount := Length(FResourceRestrictionTypeToIdResourceRestrictionType);
    LoadPeriod;
    LoadResourceType;
    LoadResource;
    LoadResourceRestrictionType;
    LoadResourceRestriction;
    LoadTheme;
    LoadActivity;
    LoadParticipant;
    LoadRequirement;
    LoadFillRequirement;
    LoadGreedyData;
  end;
end;

procedure TTimetableModel.Configure(AClashActivityValue,
  ABreakTimetableResourceValue, AOutOfPositionEmptyHourValue,
  ABrokenSessionValue, ANonScatteredActivityValue: Integer);
begin
  FClashActivityValue := AClashActivityValue;
  FBreakTimetableResourceValue := ABreakTimetableResourceValue;
  FOutOfPositionEmptyHourValue := AOutOfPositionEmptyHourValue;
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
          SOutOfPositionEmptyHour  + ':', OutOfPositionEmptyHourValue,
          SBrokenSession           + ':', BrokenSessionValue,
          SNonScatteredActivity       + ':', NonScatteredActivityValue]));
end;

function TTimetableModel.NewIndividual: TIndividual;
begin
  Result := TTimetable.Create(Self);
end;

procedure TTimetable.CrossGroup(Timetable2: TTimetable; AGroup: Integer);
var
  Session, Session1, Session2, Counter, GroupSessionsCount: Integer;
  Sessions1, Sessions2, SortKey1, SortKey2: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    GroupSessionsCount := Length(FGroupSessions[AGroup]);
    SetLength(SortKey1, GroupSessionsCount);
    SetLength(SortKey2, GroupSessionsCount);
    SetLength(Sessions1, GroupSessionsCount);
    SetLength(Sessions2, GroupSessionsCount);
    for Counter := 0 to GroupSessionsCount - 1 do
    begin
      Session := FGroupSessions[AGroup, Counter];
      SortKey1[Counter] := FSessionToDuration[Session] * $10000
        + FTTSessionToPeriod[Session];
      Sessions1[Counter] := Session;
      SortKey2[Counter] := FSessionToDuration[Session] * $10000
        + Timetable2.FTTSessionToPeriod[Session];
      Sessions2[Counter] := Session;
    end;
    SortInteger(SortKey1, Sessions1, 0, GroupSessionsCount - 1);
    SortInteger(SortKey2, Sessions2, 0, GroupSessionsCount - 1);
    for Counter := 0 to GroupSessionsCount - 1 do
    begin
      Session1 := Sessions1[Counter];
      Session2 := Sessions2[Counter];
      FTTSessionToPeriod[Session2] := SortKey1[Counter] and $FFFF;
      Timetable2.FTTSessionToPeriod[Session1] := SortKey2[Counter] and $FFFF;
    end;
  end;
end;

procedure TTimetable.Cross(AIndividual: TIndividual);
var
  Group: Integer;
begin
  with TTimetableModel(Model) do
  begin
    for Group := 0 to FGroupCount - 1 do
    begin
      CrossGroup(TTimetable(AIndividual), Group);
    end;
    Update;
    TTimetable(AIndividual).Update;
  end;
end;

constructor TTimetable.Create(ATimetableModel: TTimetableModel);
var
  Activity: Integer;
begin
  inherited Create;
  FModel := ATimetableModel;
  with TTimetableModel(Model) do
  begin
    SetLength(FTTSessionToPeriod, FSessionCount);
    SetLength(FTTActivityToNumResources, FActivityCount);
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(FTTActivityToNumResources[Activity],
                Length(FThemeToResources[FActivityToTheme[Activity]]));
    end;
    FTablingInfo := TTimetableTablingInfo.Create;
    with TablingInfo do
    begin
      SetLength(FResourcePeriodNumber, FResourceCount, FPeriodCount);
      SetLength(FDayActivityCount, FDayCount, FActivityCount);
      SetLength(FDayActivityAccumulated, FDayCount, FActivityCount);
      SetLength(FDayResourceMinHour, FDayCount, FResourceCount);
      SetLength(FDayResourceMaxHour, FDayCount, FResourceCount);
      SetLength(FDayResourceEmptyHourCount, FDayCount, FResourceCount);
      SetLength(FClashResourceType, FResourceTypeCount);
      SetLength(FResourceRestrictionTypeToResourceCount, FResourceRestrictionTypeCount);
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
  Count, Activity, Period, ActivitySession, Duration, FillRequirement,
    SelectedPeriodCount, Resource, ResourceType, Limit, Session, Theme,
    MinValue, NumResource, NumAssigned, Remaining: Integer;
  SelectedPeriod: TDynamicIntegerArray;
  ActivityResourceTypeToNumber: TDynamicIntegerArrayArray;
  ThemeToRemainings: TDynamicIntegerArrayArray;
begin
  with TTimetableModel(Model) do
  begin
    Reset;
    SetLength(SelectedPeriod, FPeriodCount);
    SetLength(ThemeToRemainings, FThemeCount);
    for Theme := 0 to FThemeCount - 1 do
    begin
      SetLength(ThemeToRemainings[Theme], Length(FThemeToNumResources[Theme]));
      for FillRequirement := 0 to High(ThemeToRemainings[Theme]) do
        ThemeToRemainings[Theme, FillRequirement]
          := FThemeToNumResources[Theme, FillRequirement];
    end;
    SetLength(ActivityResourceTypeToNumber, Length(FActivityResourceTypeToNumber));
    for Activity := 0 to FActivityCount - 1 do
    begin
      SetLength(ActivityResourceTypeToNumber[Activity],
                Length(FActivityResourceTypeToNumber[Activity]));
      for ResourceType := 0 to High(ActivityResourceTypeToNumber[Activity]) do
        ActivityResourceTypeToNumber[Activity, ResourceType]
          := FActivityResourceTypeToNumber[Activity, ResourceType];
    end;
    for Count := 0 to FActivityCount - 1 do
    begin
      Activity := FActivitySorted[Count];
      Theme := FActivityToTheme[Activity];
      for FillRequirement := 0 to High(FThemeToResources[Theme]) do
      begin
        Resource := FThemeToResources[Theme, FillRequirement];
        ResourceType := FResourceToResourceType[Resource];
        Limit := FThemeToLimits[Theme, FillRequirement];
        Remaining := ThemeToRemainings[Theme, FillRequirement];
        NumResource := ActivityResourceTypeToNumber[Activity, ResourceType];
        if (Remaining > 0) and (NumResource < Limit) then
        begin
          NumAssigned := Min(Remaining, Limit - NumResource);
          Dec(ThemeToRemainings[Theme, FillRequirement], NumAssigned);
          Inc(ActivityResourceTypeToNumber[Activity, ResourceType], NumAssigned);
          Inc(FTTActivityToNumResources[Activity, FillRequirement], NumAssigned);
        end
      end;
    end;
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
          UpdateValue;
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
  // Update;
end;


procedure TTimetable.DeltaResourceValue(Delta, Limit, Period1, Period2,
                                        Resource, NumResource: Integer);
var
  DeltaBreakTimetableResource, ResourceRestrictionType,
  Day, Hour, Period, Period0, MinPeriod, MaxPeriod: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    for Period := Period1 to Period2 do
    begin
      if FResourcePeriodNumber[Resource, Period] = Limit * NumResource then
      begin
        Day := FPeriodToDay[Period];
        Hour := FPeriodToHour[Period];
        if Delta > 0 then
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
            else if (FDayResourceMinHour[Day, Resource] <= Hour)
                    and (Hour <= FDayResourceMaxHour[Day, Resource]) then
              DeltaBreakTimetableResource := -1
            else // if FDayResourceMaxPeriod[Day, Resource] < Period then
            begin
              DeltaBreakTimetableResource := Hour - FDayResourceMaxHour[Day, Resource] - 1;
              FDayResourceMaxHour[Day, Resource] := Hour;
            end;
            Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
            Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
          end;
        end
        else if Delta < 0 then
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
              Period0 := Period + 1;
              MaxPeriod := FDayHourToPeriod[Day, FDayResourceMaxHour[Day, Resource]];
              while (Period0 <= MaxPeriod)
                    and (FResourcePeriodNumber[Resource, Period0] = 0) do
                Inc(Period0);
              DeltaBreakTimetableResource := Hour + 1 - FPeriodToHour[Period0];
              FDayResourceMinHour[Day, Resource] := FPeriodToHour[Period0];
            end
            else if (FDayResourceMinHour[Day, Resource] < Hour)
                    and (Hour < FDayResourceMaxHour[Day, Resource]) then
            begin
              DeltaBreakTimetableResource := 1;
            end
            else // if (FDayResourceMaxPeriod[Day, Resource] = Period) then
            begin
              Period0 := Period - 1;
              MinPeriod := FDayHourToPeriod[Day, FDayResourceMinHour[Day, Resource]];
              while (Period0 >= MinPeriod)
                    and (FResourcePeriodNumber[Resource, Period0] = 0) do
                Dec(Period0);
              DeltaBreakTimetableResource := FPeriodToHour[Period0] + 1 - Hour;
              FDayResourceMaxHour[Day, Resource] := FPeriodToHour[Period0];
            end;
            Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
            Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
          end;
        end;
      end;
      {
      //Delta > 0:
      if FResourcePeriodNumber[Resource, Period] >= FResourceToNumber[Resource] then
        Inc(FClashResourceType[FResourceToResourceType[Resource]], Number)
      else if FResourcePeriodNumber[Resource, Period] + Number > FResourceToNumber[Resource] then
        Inc(FClashResourceType[FResourceToResourceType[Resource]],
            FResourcePeriodNumber[Resource, Period] + Number - FResourceToNumber[Resource]);
      //Delta < 0:
      if FResourcePeriodNumber[Resource, Period] - Number >= FResourceToNumber[Resource] then
        Dec(FClashResourceType[FResourceToResourceType[Resource]], Number)
      else if FResourcePeriodNumber[Resource, Period] > FResourceToNumber[Resource] then
        Dec(FClashResourceType[FResourceToResourceType[Resource]],
          FResourcePeriodNumber[Resource, Period] - FResourceToNumber[Resource]);
      }
      // Unified Deltas:
      if FResourcePeriodNumber[Resource, Period] >= FResourceToNumber[Resource] + Limit * NumResource then
        Inc(FClashResourceType[FResourceToResourceType[Resource]], Delta * NumResource)
      else if FResourcePeriodNumber[Resource, Period] + (1 - Limit) * NumResource > FResourceToNumber[Resource] then
        Inc(FClashResourceType[FResourceToResourceType[Resource]],
            Delta * (FResourcePeriodNumber[Resource, Period] + Limit * NumResource - FResourceToNumber[Resource]));
      Inc(FResourcePeriodNumber[Resource, Period], Delta * NumResource);
      ResourceRestrictionType := FResourcePeriodToResourceRestrictionType[Resource, Period];
      if ResourceRestrictionType >= 0 then
        Inc(FResourceRestrictionTypeToResourceCount[ResourceRestrictionType], Delta * NumResource);
    end;
  end;
  {else if FHourCount - 1 <> FPeriodToHour[Period] then
   Inc(FOutOfPositionEmptyHour, Delta);}
end;

procedure TTimetable.DeltaResourcesValue(Delta, Limit, Period1, Period2: Integer;
                                         Resources, NumResources: TDynamicIntegerArray);
var
  Participant,  Resource, NumResource: Integer;
begin
  for Participant := 0 to High(Resources) do
  begin
    with TTimetableModel(Model), TablingInfo do
    begin
      Resource := Resources[Participant];
      NumResource := NumResources[Participant];
      DeltaResourceValue(Delta, Limit, Period1, Period2, Resource, NumResource);
    end
  end
end;

procedure TTimetable.DeltaPeriodsValue(Delta, Limit, Period1, Period2, Activity: Integer);
var
  Day, DDay, Day1, Day2, Hour1, Hour2, DeltaBrokenSession: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Day1 := FPeriodToDay[Period1];
    Day2 := FPeriodToDay[Period2];
    Hour1 := FPeriodToHour[Period1];
    Hour2 := FPeriodToHour[Period2];
    DeltaBrokenSession := (Day2 - Day1) * (FHourCount + 1)
      + Hour2 - Hour1 + Period1 - Period2;
    Inc(FBrokenSession, Delta * DeltaBrokenSession);
    for Day := Day1 to Day2 do
    begin
      if FDayActivityCount[Day, Activity] > Limit then
        Inc(FClashActivity, Delta);
      Inc(FDayActivityCount[Day, Activity], Delta);
    end;
    DDay := FDayCount div Length(FActivityToSessions[Activity]);
    for Day2 := Day1 to Day1 + DDay - 1 do
    begin
      Day := Day2 mod (FDayCount + 1);
      if Day <> FDayCount then
      begin
        if FDayActivityAccumulated[Day, Activity] > Limit then
          Inc(FNonScatteredActivity, Delta);
        Inc(FDayActivityAccumulated[Day, Activity], Delta);
      end;
    end;
  end;
end;

procedure TTimetable.DeltaValue(Delta, Session: Integer);
var
  Period1, Period2, Activity, Duration, Limit: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Duration := FSessionToDuration[Session];
    Period1 := FTTSessionToPeriod[Session];
    Period2 := Period1 + Duration - 1;
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    Activity := FSessionToActivity[Session];
    DeltaResourcesValue(Delta, Limit, Period1, Period2,
                        FActivityToResources[Activity],
                        FActivityToNumResources[Activity]);
    DeltaResourcesValue(Delta, Limit, Period1, Period2,
                        FThemeToResources[FActivityToTheme[Activity]],
                        FTTActivityToNumResources[Activity]);
    DeltaPeriodsValue(Delta, Limit, Period1, Period2, Activity);
  end;
end;

procedure TTimetable.ReportValues(AReport: TStrings);
var
  ResourceType, ResourceRestrictionType: Integer;
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
    Add(Format(SRowFormat, [SOutOfPositionEmptyHour + ':', OutOfPositionEmptyHour,
      TTimetableModel(Model).OutOfPositionEmptyHourValue, OutOfPositionEmptyHourValue]));
    Add(Format(SRowFormat, [SBrokenSession + ':', BrokenSession,
      TTimetableModel(Model).BrokenSessionValue, BrokenSessionValue]));
    Add(Format(SRowFormat, [SNonScatteredActivity + ':', NonScatteredActivity,
        TTimetableModel(Model).NonScatteredActivityValue, NonScatteredActivityValue]));
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-28s %12s %12s %12s)', [STbResourceRestriction + ':', '', '',
                                          '(' + IntToStr(ResourceRestrictionValue)]));
    for ResourceRestrictionType := 0 to TTimetableModel(Model).FResourceRestrictionTypeCount - 1 do
    begin
      Add(Format('%0:-28s %12d %12d %12d',
                 ['  ' + TTimetableModel(Model).FResourceRestrictionTypeToName[ResourceRestrictionType] + ':',
                  FResourceRestrictionTypeToResourceCount[ResourceRestrictionType],
                  TTimetableModel(Model).FResourceRestrictionTypeToValue[ResourceRestrictionType],
                  FResourceRestrictionTypeToResourceCount[ResourceRestrictionType]
                  * TTimetableModel(Model).FResourceRestrictionTypeToValue[ResourceRestrictionType]]));
    end;
    Add('___________________________________________________________________');
    Add(Format('%0:-54s %12d', [STotalValue, Value]));
  end;
end;

procedure TTimetable.Mutate;
var
  Session1, Session2, Activity1, Activity2, Resource, Period: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Session1 := Random(FSessionCount);
    Activity1 := FSessionToActivity[Session1];
    Resource := FActivityToResources[Activity1, 0]; //Random(Length(FActivityToResources[Activity]))];
    Activity2 := FResourceToActivities[Resource, Random(Length(FResourceToActivities[Resource]))];
    Session2 := FActivityToSessions[Activity2, Random(Length(FActivityToSessions[Activity2]))];
    if Session1 <> Session2 then
      Swap(Session1, Session2)
    else
    begin
      Period := Round(PeriodCount - FSessionToDuration[Session1]);
      if Period <> FTTSessionToPeriod[Session1] then
        MoveSession(Session1, Period);
    end;
  end;
end;

function TTimetable.MoveSession(Session, Period: Integer): Integer;
begin
  Result := FValue;
  DoMoveSession(Session, Period);
  FValue := GetValue;
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
  FValue := GetValue;
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

function TTimetable.GetOutOfPositionEmptyHourValue: Integer;
begin
  Result := TTimetableModel(Model).FOutOfPositionEmptyHourValue * OutOfPositionEmptyHour;
end;

function TTimetable.GetClashResourceValue: Integer;
var
  ResourceType: Integer;
begin
  Result := 0;
  with TTimetableModel(Model), TablingInfo do
  for ResourceType := 0 to FResourceTypeCount - 1 do
  begin
    Inc(Result, FClashResourceType[ResourceType] * FResourceTypeToValue[ResourceType]);
  end;
end;

function TTimetable.GetResourceRestrictionValue: Integer;
var
  ResourceRestrictionType: Integer;
begin
  Result := 0;
  with TTimetableModel(Model), TablingInfo do
  for ResourceRestrictionType := 0 to FResourceRestrictionTypeCount - 1 do
  begin
    Result := Result + FResourceRestrictionTypeToResourceCount[ResourceRestrictionType]
      * FResourceRestrictionTypeToValue[ResourceRestrictionType];
  end;
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
  with TablingInfo do
    Result :=
      ClashResourceValue +
      ClashActivityValue +
      OutOfPositionEmptyHourValue +
      NonScatteredActivityValue +
      BreakTimetableResourceValue +
      ResourceRestrictionValue +
      BrokenSessionValue;
end;

function TTimetable.NewBookmark: TBookmark;
begin
  if Random(2) = 0 then
    Result := TTTBookmark1.Create(Self)
  else
    Result := TTTBookmark2.Create(Self);
end;

destructor TTimetable.Destroy;
begin
  TablingInfo.Free;
  inherited Destroy;
end;

procedure TTimetable.Assign(AIndividual: TIndividual);
var
  Theme, Resource, Day: Integer;
  ATimetable: TTimetable;
begin
  inherited;
  ATimetable := TTimetable(AIndividual);
  with TTimetableModel(Model), TablingInfo do
  begin
    Move(ATimetable.FTTSessionToPeriod[0], FTTSessionToPeriod[0], FSessionCount * SizeOf(Integer));
    FClashActivity := ATimetable.TablingInfo.FClashActivity;
    FBreakTimetableResource := ATimetable.TablingInfo.FBreakTimetableResource;
    FOutOfPositionEmptyHour := ATimetable.TablingInfo.FOutOfPositionEmptyHour;
    FBrokenSession := ATimetable.TablingInfo.FBrokenSession;
    FNonScatteredActivity := ATimetable.TablingInfo.FNonScatteredActivity;
    FValue := ATimetable.FValue;
    // TablingInfo := ATimetable.TablingInfo;
      Move(ATimetable.TablingInfo.FClashResourceType[0],
           FClashResourceType[0], FResourceTypeCount * SizeOf(Integer));
    if FResourceRestrictionTypeCount <> 0 then
      Move(ATimetable.TablingInfo.FResourceRestrictionTypeToResourceCount[0],
           FResourceRestrictionTypeToResourceCount[0], FResourceRestrictionTypeCount * SizeOf(Integer));
    for Theme := 0 to FThemeCount - 1 do
    for Resource := 0 to FResourceCount - 1 do
      Move(ATimetable.TablingInfo.FResourcePeriodNumber[Resource, 0],
           TablingInfo.FResourcePeriodNumber[Resource, 0],
           FPeriodCount * SizeOf(Integer));
    for Day := 0 to FDayCount - 1 do
    begin
      Move(ATimetable.TablingInfo.FDayResourceMinHour[Day, 0],
        FDayResourceMinHour[Day, 0], FResourceCount * SizeOf(Integer));
      Move(ATimetable.TablingInfo.FDayResourceMaxHour[Day, 0],
        FDayResourceMaxHour[Day, 0], FResourceCount * SizeOf(Integer));
      Move(ATimetable.TablingInfo.FDayResourceEmptyHourCount[Day, 0],
        FDayResourceEmptyHourCount[Day, 0], FResourceCount * SizeOf(Integer));
    end;
    for Resource := 0 to FResourceCount - 1 do
      Move(ATimetable.TablingInfo.FResourcePeriodNumber[Resource, 0],
        TablingInfo.FResourcePeriodNumber[Resource, 0],
        FPeriodCount * SizeOf(Integer));
    for Day := 0 to FDayCount - 1 do
    begin
      Move(ATimetable.TablingInfo.FDayActivityCount[Day, 0],
           TablingInfo.FDayActivityCount[Day, 0],
           FActivityCount * SizeOf(Integer));
      Move(ATimetable.TablingInfo.FDayActivityAccumulated[Day, 0],
           TablingInfo.FDayActivityAccumulated[Day, 0],
           FActivityCount * SizeOf(Integer));
    end;
  end;
end;

procedure TTimetable.SaveToStream(Stream: TStream);
begin
  with TTimetableModel(Model) do
    Stream.Write(FTTSessionToPeriod[0], FSessionCount * SizeOf(Integer));
end;

procedure TTimetable.LoadFromStream(Stream: TStream);
begin
  with TTimetableModel(Model) do
    Stream.Read(FTTSessionToPeriod[0], FSessionCount * SizeOf(Integer));
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
begin
  {$IFDEF USE_SQL}
  SQL := TStringList.Create;
  {$ELSE}
  SourceDataModule.CheckRelations := False;
  {$ENDIF}
  try
    SaveTimetable;
    SaveTimetableDetail;
    {$IFDEF USE_SQL}
    with SourceDataModule do
    begin
      DbZConnection.ExecuteDirect(SQL.Text);
      TbTimetable.Refresh;
      TbTimetableDetail.Refresh;
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
  Session, Period: Integer;
  FieldDay, FieldHour, FieldSession: TLongintField;
begin
  with SourceDataModule, TTimetableModel(Model), TbTimetableDetail do
  begin
    TbTimetable.Locate('IdTimetable', IdTimetable, []);
    LinkedFields := 'IdTimetable';
    MasterFields := 'IdTimetable';
    MasterSource := DSTimetable;
    for Session := 0 to FSessionCount - 1 do
      FTTSessionToPeriod[Session] := MaxInt;
    try
      FieldDay := FindField('IdDay') as TLongintField;
      FieldHour := FindField('IdHour') as TLongintField;
      FieldSession := FindField('Session') as TLongintField;
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
  Update;
  {$IFDEF DEBUG}
  {CheckIntegrity;}
  {$ENDIF}
end;

procedure TTimetable.Reset;
var
  Resource, ResourceType, Period, ResourceRestrictionType, Day, Activity: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    FClashActivity := 0;
    FOutOfPositionEmptyHour := 0;
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
    for ResourceRestrictionType := 0 to FResourceRestrictionTypeCount - 1 do
      FResourceRestrictionTypeToResourceCount[ResourceRestrictionType] := 0;
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
  end;
end;

procedure TTimetable.Update;
var
  Session: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Reset;
    for Session := 0 to FSessionCount - 1 do
      DeltaValue(1, Session);
    UpdateValue;
  end
end;

procedure TTimetable.UpdateValue;
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

constructor TTTBookmark1.Create(AIndividual: TIndividual);
begin
  inherited Create(AIndividual);
  First;
end;

constructor TTTBookmark1.Create(AIndividual: TIndividual; APosition,
                                AOffset, ASession, APeriod: Integer);
begin
  inherited Create(AIndividual);
  FPosition := APosition;
  FOffset := AOffset;
  FSession := ASession;
  FPeriod := APeriod;
end;

function TTTBookmark1.Clone: TBookmark;
begin
  Result := TTTBookmark1.Create(Individual, FPosition, FOffset, FSession, FPeriod);
end;

procedure TTTBookmark1.First;
begin
  FPosition := 0;
  FOffset := 0;
  FSession := 0;
  FPeriod := 0;
end;

procedure TTTBookmark1.Next;
begin
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Inc(FPeriod);
    if FPeriod = PeriodCount - FSessionToDuration[FSession] then
    begin
      Inc(FSession);
      if FSession = SessionCount then
        FSession := 0;
      FPeriod := 0;
      Inc(FPosition);
    end;
  end;
end;

procedure TTTBookmark1.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark1.GetProgress: Integer;
begin
  with TTimetableModel(Individual.Model) do
    Result := (FOffset + FPosition) * PeriodCount + FPeriod;
end;

function TTTBookmark1.GetMax: Integer;
begin
  with TTimetableModel(Individual.Model) do
    Result := (FOffset + SessionCount) * PeriodCount;
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

function TTTBookmark1.Eof: Boolean;
begin
  with TTimetableModel(Individual.Model) do
    Result := FPosition = SessionCount;
end;

{ TTTBookmark2 }

constructor TTTBookmark2.Create(AIndividual: TIndividual; APosition, AMaxPosition,
                                AOffset, AGroup, AGroupSession1, AGroupSession2: Integer);
begin
  inherited Create(AIndividual);
  FPosition := APosition;
  FMaxPosition := AMaxPosition;
  FOffset := AOffset;
  FGroup := AGroup;
  FGroupSession1 := AGroupSession1;
  FGroupSession2 := AGroupSession2;
end;

constructor TTTBookmark2.Create(AIndividual: TIndividual);
begin
  inherited Create(AIndividual);
  FMaxPosition := GetMaxPosition;
  First;
end;

function TTTBookmark2.Clone: TBookmark;
begin
  Result := TTTBookmark2.Create(Individual, FPosition, FMaxPosition, FOffset,
                                FGroup, FGroupSession1, FGroupSession2);
end;

procedure TTTBookmark2.First;
begin
  FPosition := 0;
  FOffset := 0;
  FGroup := 0;
  FGroupSession1 := 0;
  FGroupSession2 := 1;
end;

procedure TTTBookmark2.Next;
begin
  with TTimetableModel(Individual.Model), TTimetable(Individual) do
  begin
    Inc(FGroupSession2);
    if FGroupSession2 = Length(FGroupSessions[FGroup]) then
    begin
      Inc(FGroupSession1);
      if FGroupSession1 = Length(FGroupSessions[FGroup]) - 1 then
      begin
        Inc(FGroup);
        if FGroup = FGroupCount then
        begin
          FGroup := 0;
        end;
        FGroupSession1 := 0;
      end;
      FGroupSession2 := FGroupSession1 + 1;
    end;
    Inc(FPosition);
  end;
end;

procedure TTTBookmark2.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark2.GetProgress: Integer;
begin
  with TTimetableModel(Individual.Model) do
    Result := (FOffset + FPosition);
end;

function TTTBookmark2.GetMaxPosition: Integer;
var
  Group, GroupSessionsCount: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Result := FOffset;
    for Group := 0 to FGroupCount - 1 do
    begin
      GroupSessionsCount := Length(FGroupSessions[Group]);
      Inc(Result, GroupSessionsCount * (GroupSessionsCount - 1) div 2);
    end;
  end;
end;

function TTTBookmark2.GetMax: Integer;
begin
  Result := FOffset + FMaxPosition;
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

function TTTBookmark2.Eof: Boolean;
begin
  Result := FPosition = FMaxPosition;
end;

{ TTTBookmark3 }

constructor TTTBookmark3.Create(AIndividual: TIndividual);
begin
  Create(AIndividual, 0, 0, 0, 0, 0, 1, 2);
  FMaxPosition := GetMaxPosition;
end;

constructor TTTBookmark3.Create(AIndividual: TIndividual; APosition,
                                AMaxPosition, AOffset, AGroup, AGroupSession1,
                                AGroupSession2, AGroupSession3: Integer);
begin
  inherited Create(AIndividual);
  FPosition := APosition;
  FMaxPosition := AMaxPosition;
  FOffset := AOffset;
  FGroup := AGroup;
  FGroupSession1 := AGroupSession1;
  FGroupSession2 := AGroupSession2;
  FGroupSession3 := AGroupSession3;
end;

function TTTBookmark3.Clone: TBookmark;
begin
  Result := TTTBookmark3.Create(Individual, FPosition, FMaxPosition,
                                FOffset, FGroup, FGroupSession1,
                                FGroupSession2, FGroupSession3);
end;

procedure TTTBookmark3.First;
begin
  FPosition := 0;
  FOffset := 0;
  FGroup := 0;
  FGroupSession1 := 0;
  FGroupSession2 := 1;
  FGroupSession2 := 2;
end;

procedure TTTBookmark3.Next;
begin
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
          Inc(FGroup);
          if FGroup = FGroupCount then
          begin
            FGroup := 0;
          end;
          FGroupSession1 := 0;
        end;
        FGroupSession2 := FGroupSession1 + 1;
      end;
      FGroupSession3 := FGroupSession1 + 1;
    end;
    Inc(FPosition);
  end;
end;

procedure TTTBookmark3.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark3.GetProgress: Integer;
begin
  with TTimetableModel(Individual.Model) do
    Result := (FOffset + FPosition);
end;

function TTTBookmark3.GetMaxPosition: Integer;
var
  Group, GroupSessionsCount: Integer;
begin
  with TTimetableModel(Individual.Model) do
  begin
    Result := FOffset;
    for Group := 0 to FGroupCount - 1 do
    begin
      GroupSessionsCount := Length(FGroupSessions[Group]);
      Inc(Result, (GroupSessionsCount * (GroupSessionsCount - 1) div 2)
                  * (2*GroupSessionsCount - 1) div 3);
    end;
  end;
end;

function TTTBookmark3.GetMax: Integer;
begin
  Result := FOffset + FMaxPosition;
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

function TTTBookmark3.Eof: Boolean;
begin
  Result := FPosition = FMaxPosition;
end;

initialization

  SortInteger := TSortInteger.Quicksort;
  Sort := TSortInteger.Quicksort;
  // SortInteger := TSortInteger.BubbleSort;
  // Sort := TSortInteger.BubbleSort;

end.

