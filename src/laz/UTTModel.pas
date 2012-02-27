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

  TSessionArray = array [-1 .. 16382] of Integer;
  PSessionArray = ^TSessionArray;
  { TTimetableModel }


  TTimetableModel = class(TModel)
  private
    FClashActivityValue: Integer;
    FOutOfPositionEmptyHourValue: Integer;
    FBrokenSessionValue: Integer;
    FBreakTimetableResourceValue: Integer;
    FNonScatteredActivityValue: Integer;
    FThemeCount: Integer;
    FThemeRestrictionTypeCount: Integer;
    FResourceTypeCount: Integer;
    FResourceRestrictionTypeCount: Integer;
    FClusterCount: Integer;
    FDayCount: Integer;
    FHourCount: Integer;
    FPeriodCount: Integer;
    FResourceCount: Integer;
    FCategoryCount: Integer;
    FActivityCount: Integer;
    FSessionCount: Integer;
    FJoinedClusterCount: Integer;
    FMinIdCategory: Integer;
    FMinIdParallel: Integer;
    FMinIdDay: Integer;
    FMinIdHour: Integer;
    FSessionNumberDouble: Integer;
    
    FPeriodToDay: TDynamicIntegerArray;
    FPeriodToHour: TDynamicIntegerArray;
    FDayToMaxPeriod: TDynamicIntegerArray;
    FSessionToActivity: TDynamicIntegerArray;
    FSessionToTheme: TDynamicIntegerArray;
    FClusterToCategory: TDynamicIntegerArray;
    FResourceToNumber: TDynamicIntegerArray;
    FResourceToName: TDynamicStringArray;
    FResourceSorted: TDynamicIntegerArray;
    FActivitySorted: TDynamicIntegerArray;
    FSessionSorted: TDynamicIntegerArray;
    FThemeRestrictionToTheme: TDynamicIntegerArray;
    FThemeRestrictionToPeriod: TDynamicIntegerArray;
    FResourceToResourceType: TDynamicIntegerArray;
    FThemeRestrictionToThemeRestrictionType: TDynamicIntegerArray;
    FResourceRestrictionToResource: TDynamicIntegerArray;
    FResourceRestrictionToPeriod: TDynamicIntegerArray;
    FResourceRestrictionToResourceRestrictionType: TDynamicIntegerArray;
    FClusterToParallel: TDynamicIntegerArray;
    FActivityToCluster: TDynamicIntegerArray;
    FClusterToSessionCount: TDynamicIntegerArray;
    FThemeRestrictionTypeToValue: TDynamicIntegerArray;
    FResourceRestrictionTypeToValue: TDynamicIntegerArray;
    FResourceTypeToValue: TDynamicIntegerArray;
    FThemeRestrictionToValue: TDynamicIntegerArray;
    FResourceRestrictionToValue: TDynamicIntegerArray;
    FParallelToIdParallel: TDynamicIntegerArray;
    FThemeToIdTheme: TDynamicIntegerArray;
    FDayToIdDay: TDynamicIntegerArray;
    FHourToIdHour: TDynamicIntegerArray;
    FCategoryToIdCategory: TDynamicIntegerArray;
    FIdCategoryToCategory: TDynamicIntegerArray;
    FIdParallelToParallel: TDynamicIntegerArray;
    FIdDayToDay: TDynamicIntegerArray;
    FIdHourToHour: TDynamicIntegerArray;
    
    // Sessions are grouped to facilitate mutations.
    // Swap of sessions only have sense in elements of the same group
    // FLastResourceWithNewActivities: Integer;
    // GroupCount == Last Resource with New Activities
    // FResourceSorted[Group] == Resource with New Activities
    FGroupCount: Integer;
    FGroupSessions: TDynamicIntegerArrayArray;
    
    FSessionToDuration: TSessionArray;
    
    FDayHourToPeriod: TDynamicIntegerArrayArray;
    FCategoryParallelToCluster: TDynamicIntegerArrayArray;
    FActivityToResources: TDynamicIntegerArrayArray;
    FResourceToActivities: TDynamicIntegerArrayArray;
    FClusterThemeToActivity: TDynamicIntegerArrayArray;
    //FTimetableDetailPattern: TDynamicIntegerArrayArray;
    FActivityToSessions: TDynamicIntegerArrayArray;
    FResourcePeriodToResourceRestrictionType: TDynamicIntegerArrayArray;
    FActivityResourceCount: TDynamicIntegerArrayArray;
    FClusterJoinedClusterToActivity: TDynamicIntegerArrayArray;
    FClusterJoinedClusterToCluster: TDynamicIntegerArrayArray;
    FThemePeriodToThemeRestrictionType: TDynamicIntegerArrayArray;
    
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
    property ClusterCount: Integer read FClusterCount;
    property ClashActivityValue: Integer read FClashActivityValue;
    property BreakTimetableResourceValue: Integer read FBreakTimetableResourceValue;
    property OutOfPositionEmptyHourValue: Integer read FOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read FBrokenSessionValue;
    property NonScatteredActivityValue: Integer read FNonScatteredActivityValue;
    property SessionNumberDouble: Integer read FSessionNumberDouble;
    property SessionToDuration: TSessionArray read FSessionToDuration;
    property ClusterToSessionCount: TDynamicIntegerArray read FClusterToSessionCount;
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
  (*

    TODO:
    2011-03-13:
    - DONE Change implementation of NonScatteredActivity with a more compositional formula
    - DONE Remove FClusterThemeDay{Min,Max}Hour
    - DONE IncCount and DecCount must be methods


  *)
  { TTimetableTablingInfo }
  TTimetableTablingInfo = class
  protected
    FResourcePeriodCount: TDynamicIntegerArrayArray;
    FThemePeriodCount: TDynamicIntegerArrayArray;
    FDayActivityCount: TDynamicIntegerArrayArray;
    FDayActivityAccumulated: TDynamicIntegerArrayArray;
    FThemeRestrictionTypeToThemeCount: TDynamicIntegerArray;
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
    FSessionToPeriod: TDynamicIntegerArray;
    procedure CrossGroup(Timetable2: TTimetable; AGroup: Integer);
    procedure DeltaValues(Delta, Session: Integer);
    function GetClashActivityValue: Integer;
    function GetNonScatteredActivityValue: Integer;
    function GetOutOfPositionEmptyHourValue: Integer;
    function GetClashResourceValue: Integer;
    function GetThemeRestrictionValue: Integer;
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
    property ThemeRestrictionTypeToThemeCount: TDynamicIntegerArray
      read FTablingInfo.FThemeRestrictionTypeToThemeCount;
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
    property ThemeRestrictionValue: Integer read GetThemeRestrictionValue;
    property ResourceRestrictionValue: Integer read GetResourceRestrictionValue;
    property SessionToPeriod: TDynamicIntegerArray
                                read FSessionToPeriod write FSessionToPeriod;
    {property ClusterPeriodToSession: TDynamicIntegerArrayArray
                                       read FClusterPeriodToSession
                                       write FClusterPeriodToSession;}
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
  
(*
  { TTTBookmark3 }
  
  TTTBookmark3 = class(TBookmark)
  private
    FPosition: Integer;
    FOffset: Integer;
    FProgress: Integer;
    FPeriod1: Integer;
    FPeriod2: Integer;
    FPeriod3: Integer;
    FTimetable: TTimetable;
    FClusters: TDynamicIntegerArray;
    function GetCluster: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(ATimetable: TTimetable; AClusters: TDynamicIntegerArray); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Cluster: Integer read GetCluster;
    property Clusters: TDynamicIntegerArray read FClusters;
    property Offset: Integer read FOffset write FOffset;
  end;
*)

implementation

uses
  SysUtils, ZSysUtils, MTProcs, DSource, UTTGConsts, DSourceBaseConsts;

type
  TSortDoubleInt = specialize TSortAlgorithm<Double, Integer>;

constructor TTimetableModel.Create(AClashActivityValue,
                                   ABreakTimetableResourceValue,
                                   AOutOfPositionEmptyHourValue,
                                   ABrokenSessionValue,
                                   ANonScatteredActivityValue: Integer);
var
  FMinIdResource, FMinIdResourceType, FMinIdTheme,
  FMinIdResourceRestrictionType, FMinIdThemeRestrictionType: Integer;
  FActivityToTheme, FIdThemeToTheme, FIdResourceToResource,
  FIdResourceTypeToResourceType, FResourceTypeToIdResourceType,
  FIdResourceRestrictionTypeToResourceRestrictionType,
  FIdThemeRestrictionTypeToThemeRestrictionType,
  FResourceToIdResource, FResourceRestrictionTypeToIdResourceRestrictionType,
  FThemeRestrictionTypeToIdThemeRestrictionType: TDynamicIntegerArray;
  
  procedure Load(ATable: TDataSet; const ALstName: string; out FMinIdLst: Integer;
    out FIdLstALst: TDynamicIntegerArray;
    out FLstAIdLst: TDynamicIntegerArray);
  var
    Field: TField;
    Index, Value, MaxIdLst: Integer;
  begin
    with ATable do
    begin
      First;
      Field := FindField(ALstName);
      FMinIdLst := Field.AsInteger;
      MaxIdLst := Field.AsInteger;
      SetLength(FLstAIdLst, RecordCount);
      for Index := 0 to RecordCount - 1 do
      begin
        Value := Field.AsInteger;
        if MaxIdLst < Value then
          MaxIdLst := Value;
        if FMinIdLst > Value then
          FMinIdLst := Value;
        FLstAIdLst[Index] := Value;
        Next;
      end;
      First;
      SetLength(FIdLstALst, MaxIdLst - FMinIdLst + 1);
      for Index := 0 to RecordCount - 1 do
      begin
        FIdLstALst[Field.AsInteger - FMinIdLst] := Index;
        Next;
      end;
      First;
    end;
  end;
  (*
  procedure Load2(ATable: TDataSet; ALstName1, ALstName2: string;
    out FLst12ALst: TDynamicIntegerArray);
  var
    i, j, k, n: Integer;
    VField1, VField2: TField;
  begin
    with ATable do
    begin
      IndexFieldNames := ALstName1 + ';' + ALstName2;
      First;
      n := RecordCount;
      SetLength(FLst12ALst, FLst1Count, FLst2Count);
      for i := 0 to FLst1Count - 1 do
        for j := 0 to FLst2Count - 1 do
          FLst12ALst[i, j] := -1;
      VField1 := FindField(ALstName1);
      VField2 := FindField(ALstName2);
      while not EOF do
      begin
        i := FIdALst[VField1.AsInteger - FMinId1];
        j := FIdALst[VField2.AsInteger - FMinId2];
        FLst12ALst[i, j] := k;
        Next;
      end;
    end;
  end;
  *)
  procedure LoadPeriod;
  var
    Period, Day, Hour: Integer;
    VFieldDay, VFieldHour: TField;
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
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      for Period := 0 to FPeriodCount - 1 do
      begin
        Day := FIdDayToDay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[VFieldHour.AsInteger - FMinIdHour];
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
  procedure LoadCluster;
  var
    Cluster, Category, Parallel: Integer;
    VFieldCategory, VFieldParallel: TField;
  begin
    with SourceDataModule.TbCluster do
    begin
      IndexFieldNames := 'IdCategory;IdParallel';
      First;
      FClusterCount := RecordCount;
      SetLength(FClusterToCategory, FClusterCount);
      SetLength(FClusterToParallel, FClusterCount);
      SetLength(FClusterToCategory, FClusterCount);
      SetLength(FCategoryParallelToCluster, FCategoryCount, Length
          (FParallelToIdParallel));
      VFieldCategory := FindField('IdCategory');
      VFieldParallel := FindField('IdParallel');
      for Cluster := 0 to FClusterCount - 1 do
      begin
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        FClusterToCategory[Cluster] := Category;
        FClusterToParallel[Cluster] := Parallel;
        FCategoryParallelToCluster[Category, Parallel] := Cluster;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadThemeRestrictionType;
  var
    ThemeRestrictionType: Integer;
    VFieldValue: TField;
  begin
    with SourceDataModule.TbThemeRestrictionType do
    begin
      IndexFieldNames := 'IdThemeRestrictionType';
      First;
      VFieldValue := FindField('ValThemeRestrictionType');
      SetLength(FThemeRestrictionTypeToValue, RecordCount);
      for ThemeRestrictionType := 0 to RecordCount - 1 do
      begin
        FThemeRestrictionTypeToValue[ThemeRestrictionType] := VFieldValue.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceType;
  var
    ResourceType: Integer;
    VFieldValue: TField;
  begin
    with SourceDataModule.TbResourceType do
    begin
      IndexFieldNames := 'IdResourceType';
      First;
      VFieldValue := FindField('ValResourceType');
      SetLength(FResourceTypeToValue, FResourceTypeCount);
      for ResourceType := 0 to FResourceTypeCount - 1 do
      begin
        FResourceTypeToValue[ResourceType] := VFieldValue.AsInteger;
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
    VFieldValue: TField;
  begin
    with SourceDataModule.TbResourceRestrictionType do
    begin
      IndexFieldNames := 'IdResourceRestrictionType';
      First;
      VFieldValue := FindField('ValResourceRestrictionType');
      SetLength(FResourceRestrictionTypeToValue, RecordCount);
      for ResourceRestrictionType := 0 to RecordCount - 1 do
      begin
        FResourceRestrictionTypeToValue[ResourceRestrictionType] := VFieldValue.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadThemeRestriction;
  var
    Theme, ThemeRestriction, Period, ThemeRestrictionType: Integer;
    VFieldTheme, VFieldDay, VFieldHour, VFieldThemeRestrictionType: TField;
  begin
    with SourceDataModule.TbThemeRestriction do
    begin
      IndexFieldNames := 'IdTheme;IdDay;IdHour';
      First;
      SetLength(FThemeRestrictionToTheme, RecordCount);
      SetLength(FThemeRestrictionToPeriod, RecordCount);
      SetLength(FThemeRestrictionToThemeRestrictionType, RecordCount);
      SetLength(FThemeRestrictionToValue, RecordCount);
      SetLength(FThemePeriodToThemeRestrictionType, FThemeCount,
        FPeriodCount);
      for Theme := 0 to FThemeCount - 1 do
        for Period := 0 to FPeriodCount - 1 do
          FThemePeriodToThemeRestrictionType[Theme, Period] := -1;
      VFieldTheme := FindField('IdTheme');
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      VFieldThemeRestrictionType := FindField('IdThemeRestrictionType');
      for ThemeRestriction := 0 to RecordCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        Period := FDayHourToPeriod[FIdDayToDay[VFieldDay.AsInteger - FMinIdDay],
          FIdHourToHour[VFieldHour.AsInteger - FMinIdHour]];
        ThemeRestrictionType := FIdThemeRestrictionTypeToThemeRestrictionType
          [VFieldThemeRestrictionType.AsInteger - FMinIdThemeRestrictionType];
        FThemeRestrictionToTheme[ThemeRestriction] := Theme;
        FThemeRestrictionToPeriod[ThemeRestriction] := Period;
        FThemeRestrictionToThemeRestrictionType[Theme] := ThemeRestrictionType;
        FThemeRestrictionToValue[ThemeRestriction] := FThemeRestrictionTypeToValue[ThemeRestrictionType];
        FThemePeriodToThemeRestrictionType[Theme, Period] := ThemeRestrictionType;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceRestriction;
  var
    ResourceRestriction, Resource, Period, Day, Hour,
      ResourceRestrictionType, Value: Integer;
    VFieldResource, VFieldDay, VFieldHour,
      VFieldResourceRestrictionType: TField;
  begin
    with SourceDataModule.TbResourceRestriction do
    begin
      IndexFieldNames := 'IdResource;IdDay;IdHour';
      First;
      SetLength(FResourceRestrictionToResource, RecordCount);
      SetLength(FResourceRestrictionToPeriod, RecordCount);
      SetLength(FResourceRestrictionToResourceRestrictionType, RecordCount);
      SetLength(FResourceRestrictionToValue, RecordCount);
      SetLength(FResourcePeriodToResourceRestrictionType, FResourceCount,
        FPeriodCount);
      for Resource := 0 to FResourceCount - 1 do
        for Period := 0 to FPeriodCount - 1 do
          FResourcePeriodToResourceRestrictionType[Resource, Period] := -1;
      VFieldResource := FindField('IdResource');
      VFieldHour := FindField('IdHour');
      VFieldDay := FindField('IdDay');
      VFieldResourceRestrictionType := FindField('IdResourceRestrictionType');
      for ResourceRestriction := 0 to RecordCount - 1 do
      begin
        Resource := FIdResourceToResource[VFieldResource.AsInteger - FMinIdResource];
        Day := FIdDayToDay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[VFieldHour.AsInteger - FMinIdHour];
        Period := FDayHourToPeriod[Day, Hour];
        ResourceRestrictionType := FIdResourceRestrictionTypeToResourceRestrictionType
          [VFieldResourceRestrictionType.AsInteger - FMinIdResourceRestrictionType];
        FResourceRestrictionToResource[ResourceRestriction] := Resource;
        FResourceRestrictionToPeriod[ResourceRestriction] := Period;
        FResourceRestrictionToResourceRestrictionType[ResourceRestriction] := ResourceRestrictionType;
        Value := FResourceRestrictionTypeToValue[ResourceRestrictionType];
        FResourceRestrictionToValue[ResourceRestriction] := Value;
        FResourcePeriodToResourceRestrictionType[Resource, Period] := ResourceRestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure LoadActivity;
  var
    Theme, Category, Parallel, Session1, Activity, Cluster,
      Session2, Session, VPos: Integer;
    VFieldTheme, VFieldCategory, VFieldParallel, VFieldComposition: TField;
    Composition: string;
  begin
    with SourceDataModule.TbActivity do
    begin
      IndexFieldNames := 'IdTheme;IdCategory;IdParallel';
      First;
      VFieldTheme := FindField('IdTheme');
      VFieldCategory := FindField('IdCategory');
      VFieldParallel := FindField('IdParallel');
      VFieldComposition := FindField('Composition');
      FActivityCount := RecordCount;
      SetLength(FActivityToCluster, FActivityCount);
      SetLength(FActivityToSessions, FActivityCount);
      SetLength(FActivityToTheme, FActivityCount);
      SetLength(FClusterThemeToActivity, FClusterCount, FThemeCount);
      for Cluster := 0 to FClusterCount - 1 do
        for Theme := 0 to FThemeCount - 1 do
        begin
          FClusterThemeToActivity[Cluster, Theme] := -1;
        end;
      Session2 := 0;
      for Activity := 0 to RecordCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        Cluster := FCategoryParallelToCluster[Category, Parallel];
        FActivityToCluster[Activity] := Cluster;
        FActivityToTheme[Activity] := Theme;
        FClusterThemeToActivity[Cluster, Theme] := Activity;
        Composition := VFieldComposition.AsString;
        VPos := 1;
        Session1 := Session2;
        while VPos <= Length(Composition) do
        begin
          // SetLength(FSessionToDuration, Session2 + 1);
          FSessionToDuration[Session2] := StrToInt(ExtractString(Composition, VPos, '.'));
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
      FSessionToDuration[-1] := 1;
      for Session := 0 to FSessionCount - 1 do
      begin
        Activity := FSessionToActivity[Session];
        FSessionToTheme[Session] := FActivityToTheme[Activity];
      end;
    end;
  end;
  procedure LoadRequirement;
  var
    Requirement, Counter, Cluster, Parallel, Category, Theme,
    RequirementCount, Activity, Resource: Integer;
    VFieldTheme, VFieldCategory, VFieldParallel,
    VFieldResource, VFieldNumRequirement: TField;
  begin
    with SourceDataModule.TbRequirement do
    begin
      IndexFieldNames := 'IdTheme;IdCategory;IdParallel;IdResource';
      First;
      RequirementCount := RecordCount;
      SetLength(FActivityToResources, FActivityCount, 0);
      SetLength(FResourceToActivities, FResourceCount, 0);
      SetLength(FActivityResourceCount, FActivityCount, FResourceCount);
      for Activity := 0 to FActivityCount - 1 do
        for Resource := 0 to FResourceCount - 1 do
          FActivityResourceCount[Activity, Resource] := 0;
      VFieldTheme := FindField('IdTheme');
      VFieldCategory := FindField('IdCategory');
      VFieldParallel := FindField('IdParallel');
      VFieldResource := FindField('IdResource');
      VFieldNumRequirement := FindField('NumRequirement');
      for Requirement := 0 to RequirementCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        Cluster := FCategoryParallelToCluster[Category, Parallel];
        
        Activity := FClusterThemeToActivity[Cluster, Theme];
        Resource := FIdResourceToResource[VFieldResource.AsInteger - FMinIdResource];
        
        Counter := Length(FActivityToResources[Activity]);
        SetLength(FActivityToResources[Activity], Counter + 1);
        FActivityToResources[Activity, Counter] := Resource;
        
        Counter := Length(FResourceToActivities[Resource]);
        SetLength(FResourceToActivities[Resource], Counter + 1);
        FResourceToActivities[Resource, Counter] := Activity;
        
        FActivityResourceCount[Activity, Resource] := VFieldNumRequirement.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadJoinedCluster;
  var
    JoinedCluster, Counter, Cluster1, Category1, Parallel1,
      Cluster, Category, Parallel, Theme,  Activity: Integer;
    VFieldTheme, VFieldCategory, VFieldParallel, VFieldCategory1,
      VFieldParallel1: TField;
  begin
    with SourceDataModule.TbJoinedCluster do
    begin
      IndexFieldNames := 'IdTheme;IdCategory;IdParallel;IdCategory1;IdParallel1';
      First;
      FJoinedClusterCount := RecordCount;
      SetLength(FClusterJoinedClusterToActivity, FClusterCount, 0);
      SetLength(FClusterJoinedClusterToCluster, FClusterCount, 0);
      VFieldTheme := FindField('IdTheme');
      VFieldCategory := FindField('IdCategory');
      VFieldParallel := FindField('IdParallel');
      VFieldCategory1 := FindField('IdCategory1');
      VFieldParallel1 := FindField('IdParallel1');
      for JoinedCluster := 0 to FJoinedClusterCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        Cluster := FCategoryParallelToCluster[Category, Parallel];
        Activity := FClusterThemeToActivity[Cluster, Theme];
        Category1 := FIdCategoryToCategory[VFieldCategory1.AsInteger - FMinIdCategory];
        Parallel1 := FIdParallelToParallel[VFieldParallel1.AsInteger - FMinIdParallel];
        Cluster1 := FCategoryParallelToCluster[Category1, Parallel1];
        Counter := Length(FClusterJoinedClusterToActivity[Cluster]);
        SetLength(FClusterJoinedClusterToActivity[Cluster], Counter + 1);
        SetLength(FClusterJoinedClusterToCluster[Cluster], Counter + 1);
        FClusterJoinedClusterToActivity[Cluster, Counter] := Activity;
        FClusterJoinedClusterToCluster[Cluster, Counter] := Cluster1;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadTimetableDetailPattern2;
  var
    Number, Duration, Activity, ActivityResource, Resource, Count, Group, Session,
    HighActivitySorted, HighSessionSorted, ResourceActivity, ActivitySession: Integer;
    FreedomDegrees: Double; // Logaritmic to prevent overfloat
    ActivityIsPlaced: TDynamicBooleanArray;
    ActivityResourceToFreedomDegrees, ResourceToFreedomDegrees: TDynamicDoubleArray;
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
          Inc(Duration, FSessionToDuration[FActivityToSessions[Activity, ActivitySession]]);
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
  {
  procedure LoadTimetableDetailPattern;
  var
    Period1, Cluster, Activity, Period, Counter, Duration, Number: Integer;
  begin
    SetLength(FTimetableDetailPattern, FClusterCount, FPeriodCount);
    SetLength(FClusterToSessionCount, FClusterCount);
    SetLength(FClusterToDuration, FClusterCount);
    for Cluster := 0 to FClusterCount - 1 do
    begin
      FClusterToDuration[Cluster] := 0;
      FClusterToSessionCount[Cluster] := 0;
      for Period := 0 to FPeriodCount - 1 do
      begin
        FTimetableDetailPattern[Cluster, Period] := -1;
      end;
    end;
    for Activity := FActivityCount - 1 downto 0 do
    begin
      Cluster := FActivityToCluster[Activity];
      for Counter := High(FActivityToSessions[Activity]) downto 0 do
      begin
        Duration := FSessionToDuration[FActivityToSessions[Activity, Counter]];
        Period1 := FClusterToDuration[Cluster];
        for Period := Period1 to Period1 + Duration - 1 do
        begin
          if (Period < 0) or (Period >= FPeriodCount) then
            raise Exception.CreateFmt(SClusterPeriodToSessionOverflow,
              [FClusterToCategory[Cluster], FClusterToParallel[Cluster], Period]);
          FTimetableDetailPattern[Cluster, FPeriodCount - 1 - Period]
            := FActivityToSessions[Activity, Counter];
        end;
        Inc(FClusterToDuration[Cluster], Duration);
      end;
    end;
    for Cluster := 0 to FClusterCount - 1 do
    begin
      Period := 0;
      while Period < FPeriodCount do
      begin
        Duration := FSessionToDuration[FTimetableDetailPattern[Cluster, Period]];
        Inc(Period, Duration);
        Inc(FClusterToSessionCount[Cluster]);
      end;
    end;
    FSessionNumberDouble := 0;
    for Cluster := 0 to FClusterCount - 1 do
    begin
      Number := FClusterToSessionCount[Cluster];
      Inc(FSessionNumberDouble, (Number * (Number - 1)) div 2);
    end;
  end;
  }
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
    Load(TbCategory, 'IdCategory', FMinIdCategory, FIdCategoryToCategory, FCategoryToIdCategory);
    FCategoryCount := Length(FCategoryToIdCategory);
    Load(TbParallel, 'IdParallel', FMinIdParallel,
      FIdParallelToParallel, FParallelToIdParallel);
    Load(TbTheme, 'IdTheme', FMinIdTheme, FIdThemeToTheme,
      FThemeToIdTheme);
    FThemeCount := Length(FThemeToIdTheme);
    Load(TbDay, 'IdDay', FMinIdDay, FIdDayToDay, FDayToIdDay);
    FDayCount := Length(FDayToIdDay);
    Load(TbHour, 'IdHour', FMinIdHour, FIdHourToHour, FHourToIdHour);
    FHourCount := Length(FHourToIdHour);
    Load(TbThemeRestrictionType, 'IdThemeRestrictionType',
      FMinIdThemeRestrictionType,
      FIdThemeRestrictionTypeToThemeRestrictionType,
      FThemeRestrictionTypeToIdThemeRestrictionType);
    FThemeRestrictionTypeCount := Length(FThemeRestrictionTypeToIdThemeRestrictionType);
    Load(TbResourceRestrictionType, 'IdResourceRestrictionType',
      FMinIdResourceRestrictionType,
      FIdResourceRestrictionTypeToResourceRestrictionType,
      FResourceRestrictionTypeToIdResourceRestrictionType);
    FResourceRestrictionTypeCount := Length(FResourceRestrictionTypeToIdResourceRestrictionType);
    LoadPeriod;
    LoadCluster;
    LoadResourceType;
    LoadResource;
    LoadResourceRestrictionType;
    LoadResourceRestriction;
    LoadThemeRestrictionType;
    LoadThemeRestriction;
    LoadActivity;
    LoadRequirement;
    LoadJoinedCluster;
    {LoadTimetableDetailPattern;}
    LoadTimetableDetailPattern2;
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

{
procedure TTimetable.RandomizeKey(var ARandomKey: TDynamicIntegerArray;
  ACluster: Integer);
var
  Period, Duration, Counter, MaxPeriod: Integer;
  PeriodToSession: TDynamicIntegerArray;
  NumberList: array [0 .. 4095] of Integer;
begin
  with TTimetableModel(Model) do
  begin
    for Counter := 0 to FClusterToSessionCount[ACluster] - 1 do
      NumberList[Counter] := Random($7FFFFFFF);
    Sort(NumberList, 0, FClusterToSessionCount[ACluster] - 1);
    PeriodToSession := ClusterPeriodToSession[ACluster];
    Period := 0;
    Counter := 0;
    while Period < FPeriodCount do
    begin
      Duration := FSessionToDuration[PeriodToSession[Period]];
      MaxPeriod := Period + Duration;
      while Period < MaxPeriod do
      begin
        ARandomKey[Period] := NumberList[Counter];
        Inc(Period);
      end;
      Inc(Counter);
    end;
  end;
end;
}

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
        + FSessionToPeriod[Session];
      Sessions1[Counter] := Session;
      SortKey2[Counter] := FSessionToDuration[Session] * $10000
        + Timetable2.FSessionToPeriod[Session];
      Sessions2[Counter] := Session;
    end;
    SortInteger(SortKey1, Sessions1, 0, GroupSessionsCount - 1);
    SortInteger(SortKey2, Sessions2, 0, GroupSessionsCount - 1);
    for Counter := 0 to GroupSessionsCount - 1 do
    begin
      Session1 := Sessions1[Counter];
      Session2 := Sessions2[Counter];
      FSessionToPeriod[Session2] := SortKey1[Counter] and $FFFF;
      Timetable2.FSessionToPeriod[Session1] := SortKey2[Counter] and $FFFF;
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
begin
  inherited Create;
  FModel := ATimetableModel;
  with TTimetableModel(Model) do
  begin
    {SetLength(FClusterPeriodToSession, FClusterCount, FPeriodCount);}
    SetLength(FSessionToPeriod, FSessionCount);
    FTablingInfo := TTimetableTablingInfo.Create;
    with TablingInfo do
    begin
      SetLength(FThemePeriodCount, FThemeCount, FPeriodCount);
      SetLength(FResourcePeriodCount, FResourceCount, FPeriodCount);
      SetLength(FDayActivityCount, FDayCount, FActivityCount);
      SetLength(FDayActivityAccumulated, FDayCount, FActivityCount);
      SetLength(FDayResourceMinHour, FDayCount, FResourceCount);
      SetLength(FDayResourceMaxHour, FDayCount, FResourceCount);
      SetLength(FDayResourceEmptyHourCount, FDayCount, FResourceCount);
      SetLength(FThemeRestrictionTypeToThemeCount, FThemeRestrictionTypeCount);
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
  Count, Activity, Period, ActivitySession, Duration, MinValue, Session,
    SelectedPeriodCount: Integer;
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
          FSessionToPeriod[Session] := Period;
          DeltaValues(1, Session);
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
          DeltaValues(-1, Session);
        end;
        FSessionToPeriod[Session] := SelectedPeriod[Random(SelectedPeriodCount)];
        DeltaValues(1, Session);
      end;
    end;
  end;
  // Update;
end;

procedure TTimetable.DeltaValues(Delta, Session: Integer);
var
  ThemeRestrictionType, ResourceRestrictionType, Period1, Period2, Period,
  Period0, DeltaBrokenSession, Day, DDay, Day1, Day2, Hour, Hour1, Hour2,
  Resource, Duration, Theme, Limit, Requirement, Count, Activity,
  DeltaBreakTimetableResource, MinPeriod, MaxPeriod: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Duration := FSessionToDuration[Session];
    Period1 := SessionToPeriod[Session];
    Period2 := Period1 + Duration - 1;
    Day1 := FPeriodToDay[Period1];
    Day2 := FPeriodToDay[Period2];
    Hour1 := FPeriodToHour[Period1];
    Hour2 := FPeriodToHour[Period2];
    DeltaBrokenSession := (Day2 - Day1) * (FHourCount + 1)
      + Hour2 - Hour1 + 1 - Duration;
    Inc(FBrokenSession, Delta * DeltaBrokenSession);
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    Theme := FSessionToTheme[Session];
    Activity := FSessionToActivity[Session];
    for Requirement := 0 to High(FActivityToResources[Activity]) do
    begin
      Resource := FActivityToResources[Activity, Requirement];
      Count := FActivityResourceCount[Activity, Resource];
      for Period := Period1 to Period2 do
      begin
        Day := FPeriodToDay[Period];
        Hour := FPeriodToHour[Period];
        if FResourcePeriodCount[Resource, Period] = Limit * Count then
        begin
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
                      and (FResourcePeriodCount[Resource, Period0] = 0) do
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
                      and (FResourcePeriodCount[Resource, Period0] = 0) do
                  Dec(Period0);
                DeltaBreakTimetableResource := FPeriodToHour[Period0] + 1 - Hour;
                FDayResourceMaxHour[Day, Resource] := FPeriodToHour[Period0];
              end;
              Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
              Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
            end;
          end;
        end;
        if FResourcePeriodCount[Resource, Period] >= FResourceToNumber[Resource] + Limit * Count then
          Inc(FClashResourceType[FResourceToResourceType[Resource]], Delta * Count);
        Inc(FResourcePeriodCount[Resource, Period], Delta * Count);
        ResourceRestrictionType := FResourcePeriodToResourceRestrictionType[Resource, Period];
        if ResourceRestrictionType >= 0 then
          Inc(FResourceRestrictionTypeToResourceCount[ResourceRestrictionType], Delta * Count);
      end;
    end;
    for Period := Period1 to Period2 do
    begin
      Inc(FThemePeriodCount[Theme, Period], Delta);
      ThemeRestrictionType := FThemePeriodToThemeRestrictionType[Theme, Period];
      if ThemeRestrictionType >= 0 then
        Inc(FThemeRestrictionTypeToThemeCount[ThemeRestrictionType], Delta);
    end;
    {else if FHourCount - 1 <> FPeriodToHour[Period] then
      Inc(FOutOfPositionEmptyHour, Delta);}
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

procedure TTimetable.ReportValues(AReport: TStrings);
var
  SRowFormat: string = '%0:-28s %12d %12d %12d';
begin
  with AReport, TablingInfo do
  begin
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-28s %12s %12s %12s', [SDetail, SCount, SWeight, SValue]));
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-28s %12s %12s %12d', [SClashResource + ':',
         '(' + VarArrToStr(FClashResourceType, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FResourceTypeToValue, ' ') + ')',
         ClashResourceValue]));
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
    Add(Format('%0:-28s %12s %12s %12d', [STbThemeRestriction + ':',
         '(' + VarArrToStr(FThemeRestrictionTypeToThemeCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FThemeRestrictionTypeToValue, ' ') + ')',
         ThemeRestrictionValue]));
    Add(Format('%0:-28s %12s %12s %12d', [STbResourceRestriction + ':',
         '(' + VarArrToStr(FResourceRestrictionTypeToResourceCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FResourceRestrictionTypeToValue, ' ') + ')',
         ResourceRestrictionValue]));
    Add('-------------------------------------------------------------------');
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
      if Period <> FSessionToPeriod[Session1] then
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
    if Period <> FSessionToPeriod[Session] then
    begin
      DeltaValues(-1, Session);
      FSessionToPeriod[Session] := Period;
      DeltaValues(1, Session);
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
    Period1 := FSessionToPeriod[Session1];
    Period2 := FSessionToPeriod[Session2];
    if Period1 <> Period2 then
    begin
      Duration1 := FSessionToDuration[Session1];
      Duration2 := FSessionToDuration[Session2];
      DeltaValues(-1, Session1);
      DeltaValues(-1, Session2);
      if (Period1 < Period2)
              and (Duration1 <= Period2 + Duration2)
              and (Period2 + Duration2 < FPeriodCount)
              and (Period1 + Duration2 < FPeriodCount) then
      begin
        FSessionToPeriod[Session1] := Period2 - Duration1 + Duration2;
        FSessionToPeriod[Session2] := Period1;
      end
      else if (Period1 > Period2)
              and (Duration1 <= Period1 + Duration1)
              and (Period1 + Duration1 < FPeriodCount)
              and (Period2 + Duration1 < FPeriodCount) then
      begin
        FSessionToPeriod[Session1] := Period2;
        FSessionToPeriod[Session2] := Period1 - Duration2 + Duration1;
      end;
      DeltaValues(1, Session2);
      DeltaValues(1, Session1);
    end
  end;
end;

function TTimetable.GetOutOfPositionEmptyHourValue: Integer;
begin
  Result := TTimetableModel(Model).FOutOfPositionEmptyHourValue * OutOfPositionEmptyHour;
end;

function TTimetable.GetThemeRestrictionValue: Integer;
var
  ThemeRestrictionType: Integer;
begin
  Result := 0;
  with TTimetableModel(Model), TablingInfo do
  for ThemeRestrictionType := 0 to FThemeRestrictionTypeCount - 1 do
  begin
    Result := Result + FThemeRestrictionTypeToThemeCount[ThemeRestrictionType]
      * FThemeRestrictionTypeToValue[ThemeRestrictionType];
  end;
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

{
function TTimetable.DeltaBrokenSession(ACluster, Period1, Period2: Integer): Integer;
var
  Period, Hour1, Hour2, Day1, Day2, Session, Duration: Integer;
  PeriodToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Period := Period1;
    PeriodToSession := FClusterPeriodToSession[ACluster];
    Result := 0;
    while Period <= Period2 do
    begin
      Session := PeriodToSession[Period];
      Duration := FSessionToDuration[Session];
      if Duration > 1 then
      begin
        Day1 := FPeriodToDay[Period];
        Day2 := FPeriodToDay[Period + Duration - 1];
        Hour1 := FPeriodToHour[Period];
        Hour2 := FPeriodToHour[Period + Duration - 1];
        Inc(Result, (Day2 - Day1) * (FHourCount + 1) + Hour2 - Hour1 + 1 - Duration);
      end;
      Inc(Period, Duration);
    end;
  end;
end;
}

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
      ThemeRestrictionValue +
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
    Move(ATimetable.FSessionToPeriod[0], FSessionToPeriod[0], FSessionCount * SizeOf(Integer));
    FClashActivity := ATimetable.TablingInfo.FClashActivity;
    FBreakTimetableResource := ATimetable.TablingInfo.FBreakTimetableResource;
    FOutOfPositionEmptyHour := ATimetable.TablingInfo.FOutOfPositionEmptyHour;
    FBrokenSession := ATimetable.TablingInfo.FBrokenSession;
    FNonScatteredActivity := ATimetable.TablingInfo.FNonScatteredActivity;
    FValue := ATimetable.FValue;
    // TablingInfo := ATimetable.TablingInfo;
    Move(ATimetable.TablingInfo.FClashResourceType[0],
         FClashResourceType[0], FResourceTypeCount * SizeOf(Integer));
    Move(ATimetable.TablingInfo.FResourceRestrictionTypeToResourceCount[0],
         FResourceRestrictionTypeToResourceCount[0], FResourceRestrictionTypeCount * SizeOf(Integer));
    Move(ATimetable.TablingInfo.FThemeRestrictionTypeToThemeCount[0],
         FThemeRestrictionTypeToThemeCount[0], FThemeRestrictionTypeCount * SizeOf(Integer));
    for Theme := 0 to FThemeCount - 1 do
      Move(ATimetable.TablingInfo.FThemePeriodCount[Theme, 0],
           TablingInfo.FThemePeriodCount[Theme, 0],
           FPeriodCount * SizeOf(Integer));
    for Resource := 0 to FResourceCount - 1 do
      Move(ATimetable.TablingInfo.FResourcePeriodCount[Resource, 0],
           TablingInfo.FResourcePeriodCount[Resource, 0],
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
      Move(ATimetable.TablingInfo.FResourcePeriodCount[Resource, 0],
        TablingInfo.FResourcePeriodCount[Resource, 0],
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

{
procedure TTimetable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  Cluster, Period: Integer;
begin
  VStrings := TStringList.Create;
  with TTimetableModel(Model) do
    try
      for Cluster := 0 to FClusterCount - 1 do
      begin
        VStrings.Add(Format('Cluster %d %d',
            [FCategoryToIdCategory[FClusterToCategory[Cluster]],
            FParallelToIdParallel[FClusterToParallel[Cluster]]]));
        for Period := 0 to FPeriodCount - 1 do
        begin
          VStrings.Add(Format(' Day %d Hour %d Theme %d', [FPeriodToDay[Period],
              FPeriodToHour[Period],
              FThemeToIdTheme[FSessionToTheme[ClusterPeriodToSession[Cluster, Period]]]]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;
}

procedure TTimetable.SaveToStream(Stream: TStream);
begin
  with TTimetableModel(Model) do
    Stream.Write(SessionToPeriod[0], FSessionCount * SizeOf(Integer));
end;

procedure TTimetable.LoadFromStream(Stream: TStream);
begin
  with TTimetableModel(Model) do
    Stream.Read(SessionToPeriod[0], FSessionCount * SizeOf(Integer));
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
    Activity, Cluster, Period1, Period2, Period, IdCategory, IdParallel,
      Session: Integer;
    {$IFNDEF USE_SQL}
    FieldTimetable, FieldCategory, FieldParallel, FieldDay, FieldHour,
      FieldTheme, FieldSession: TField;
    {$ENDIF}
  begin
    {$IFNDEF USE_SQL}
    with SourceDataModule.TbTimetableDetail do
    begin
      DisableControls;
      try
        Last;
        FieldTimetable := FindField('IdTimetable');
        FieldCategory := FindField('IdCategory');
        FieldParallel := FindField('IdParallel');
        FieldDay := FindField('IdDay');
        FieldHour := FindField('IdHour');
        FieldTheme := FindField('IdTheme');
        FieldSession := FindField('Session');
    {$ENDIF}
        with TTimetableModel(Model) do
        for Session := 0 to FSessionCount - 1 do
        begin
          Activity := FSessionToActivity[Session];
          Cluster := FActivityToCluster[Activity];
          IdCategory := FCategoryToIdCategory[FClusterToCategory[Cluster]];
          IdParallel := FParallelToIdParallel[FClusterToParallel[Cluster]];
          Period1 := FSessionToPeriod[Session];
          Period2 := Period1 + FSessionToDuration[Session] - 1;
          for Period := Period1 to Period2 do
          begin
            {$IFDEF USE_SQL}
            SQL.Add(Format(
                      'INSERT INTO TimetableDetail' +
                        '(IdTimetable,IdCategory,IdParallel,IdDay,' +
                        'IdHour,IdTheme,Session) VALUES (%d,%d,%d,%d,%d,%d,%d);',
                      [IdTimetable, IdCategory, IdParallel,
                       FDayToIdDay[FPeriodToDay[Period]],
                       FHourToIdHour[FPeriodToHour[Period]],
                       FThemeToIdTheme[FSessionToTheme[Session]], Session]));
            {$ELSE}
            Append;
            FieldTimetable.AsInteger := IdTimetable;
            FieldCategory.AsInteger := IdCategory;
            FieldParallel.AsInteger := IdParallel;
            FieldDay.AsInteger := FDayAIdDay[FPeriodADay[Period]];
            FieldHour.AsInteger := FHourAIdHour[FPeriodAHour[Period]];
            FieldTheme.AsInteger := FThemeAIdTheme[FSessionToTheme[Session]];
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
  //FieldCategory, FieldParallel,
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
      FSessionToPeriod[Session] := MaxInt;
    try
      //FieldCategory := FindField('IdCategory') as TLongintField;
      //FieldParallel := FindField('IdParallel') as TLongintField;
      FieldDay := FindField('IdDay') as TLongintField;
      FieldHour := FindField('IdHour') as TLongintField;
      FieldSession := FindField('Session') as TLongintField;
      First;
      while not Eof do
      begin
        Session := FieldSession.AsInteger;
        Period := FDayHourToPeriod[FIdDayToDay[FieldDay.AsInteger - FMinIdDay],
                                   FIdHourToHour[FieldHour.AsInteger - FMinIdHour]];
        if Period < FSessionToPeriod[Session] then
          FSessionToPeriod[Session] := Period;
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

{
procedure TTimetable.CheckIntegrity;
var
  Theme, Cluster, Period, Activity, Counter,
    Session: Integer;
  SessionFound: Boolean;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    for Cluster := 0 to FClusterCount - 1 do
      for Period := 0 to FPeriodCount - 1 do
      begin
        Session := FClusterPeriodToSession[Cluster, Period];
        if Session >= 0 then
        begin
          Theme := FSessionToTheme[Session];
          Activity := FClusterThemeToActivity[Cluster, Theme];
          SessionFound := False;
          for Counter := 0 to High(FActivityToSessions[Activity]) do
            SessionFound := SessionFound or (FActivityToSessions[Activity, Counter] = Session);
          if not SessionFound then
            raise Exception.CreateFmt('%s %d(%d,%d), %s %d(%d) %s FActivityToSessions', [
              SCluster, Cluster,
              FCategoryToIdCategory[FClusterToCategory[Cluster]],
              FParallelToIdParallel[FClusterToParallel[Cluster]],
              SFlActivity_IdTheme,
              Theme,
              FThemeToIdTheme[Theme],
              SDoNotAppearsIn]);
          if Activity < 0 then
            raise Exception.CreateFmt('%s %d(%d,%d), %s %d(%d) %s FClusterThemeToActivity', [
              SCluster, Cluster,
              FCategoryToIdCategory[FClusterToCategory[Cluster]],
              FParallelToIdParallel[FClusterToParallel[Cluster]],
              SFlActivity_IdTheme,
              Theme,
              FThemeToIdTheme[Theme],
              SDoNotAppearsIn]);
        end;
      end;
  end;
end;
}

procedure TTimetable.Reset;
var
  Resource, ResourceType, Period, Theme, ThemeRestrictionType,
    ResourceRestrictionType, Day, Activity: Integer;
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
    for ThemeRestrictionType := 0 to FThemeRestrictionTypeCount - 1 do
      FThemeRestrictionTypeToThemeCount[ThemeRestrictionType] := 0;
    for Period := 0 to FPeriodCount - 1 do
    begin
      for Resource := 0 to FResourceCount - 1 do
        FResourcePeriodCount[Resource, Period] := 0;
      for Theme := 0 to FThemeCount - 1 do
        FThemePeriodCount[Theme, Period] := 0;
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
      DeltaValues(1, Session);
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
  FPreviousPeriod := TTimetable(Individual).SessionToPeriod[FSession];
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
    FPreviousPeriod1 := SessionToPeriod[Session1];
    FPreviousPeriod2 := SessionToPeriod[Session2];
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
    FPreviousPeriod1 := SessionToPeriod[Session1];
    FPreviousPeriod2 := SessionToPeriod[Session2];
    FPreviousPeriod3 := SessionToPeriod[Session3];
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

(*
procedure NextPeriod(PeriodToSession: TDynamicIntegerArray; PeriodCount: Integer;
  var Period: Integer);
var
  Session: Integer;
begin
  Session := PeriodToSession[Period];
  if Session < 0 then
    Inc(Period)
  else
    repeat
      Inc(Period);
    until (Period >= PeriodCount)
      or (PeriodToSession[Period] <> Session);
end;

procedure FixPeriod(PeriodToSession: TDynamicIntegerArray; PeriodCount: Integer;
  var Period: Integer);
begin
  if Period > 0 then
  begin
    Dec(Period);
    NextPeriod(PeriodToSession, PeriodCount, Period);
  end;
end;

{ TTTBookmark3 }

constructor TTTBookmark3.Create(ATimetable: TTimetable; AClusters: TDynamicIntegerArray);
begin
  inherited Create;
  TTimetable(Individual) := ATimetable;
  FClusters := AClusters;
  First;
end;

function TTTBookmark3.Clone: TBookmark;
begin
  Result := TTTBookmark3.Create(TTimetable(Individual), FClusters);
  TTTBookmark3(Result).FPosition := FPosition;
  TTTBookmark3(Result).FOffset := FOffset;
  TTTBookmark3(Result).FPeriod1 := FPeriod1;
  TTTBookmark3(Result).FPeriod2 := FPeriod2;
  TTTBookmark3(Result).FPeriod3 := FPeriod3;
end;

function TTTBookmark3.GetCluster: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod Individual.Model.ClusterCount;
  Result := FClusters[Index];
end;

procedure TTTBookmark3.First;
begin
  FPosition := 0;
  FOffset := 0;
  FProgress := 0;
  FPeriod1 := 0;
  with Individual.Model, TTimetable(Individual) do
    FPeriod2 := SessionToDuration[ClusterPeriodToSession[Cluster, 0]];
  FPeriod3 := FPeriod2;
end;

procedure TTTBookmark3.Next;
var
  d1, d2: Integer;
  PeriodToSession: TDynamicIntegerArray;
begin
  with Individual.Model, TTimetable(Individual) do
  begin
    PeriodToSession := ClusterPeriodToSession[Cluster];
    d1 := PeriodCount - SessionToDuration[PeriodToSession[PeriodCount - 1]];
    if FPeriod3 >= d1 then
    begin
      if FPeriod2 >= d1 then
      begin
        d2 := d1 - SessionToDuration[PeriodToSession[d1 - 1]];
        if FPeriod1 >= d2 then
        begin
          Inc(FPosition);
          FPeriod1 := 0;
          FPeriod2 := SessionToDuration[ClusterPeriodToSession[Cluster, 0]];
          FPeriod3 := FPeriod2;
        end
        else
        begin
          NextPeriod(PeriodToSession, PeriodCount, FPeriod1);
          FPeriod2 := FPeriod1 + SessionToDuration[PeriodToSession[FPeriod1]];
          FPeriod3 := FPeriod2;
        end;
      end
      else
      begin
        FixPeriod(PeriodToSession, PeriodCount, FPeriod1);
        if FPeriod2 <= FPeriod1 then
        begin
          FPeriod2 := FPeriod1 + SessionToDuration[PeriodToSession[FPeriod1]];
          FPeriod3 := FPeriod2;
        end
        else
        begin
          NextPeriod(PeriodToSession, PeriodCount, FPeriod2);
          FPeriod3 := FPeriod1 + SessionToDuration[PeriodToSession[FPeriod1]];
        end;
      end;
    end
    else
    begin
      FixPeriod(PeriodToSession, PeriodCount, FPeriod1);
      if FPeriod2 <= FPeriod1 then
        FPeriod2 := FPeriod1 + SessionToDuration[PeriodToSession[FPeriod1]]
      else
        FixPeriod(PeriodToSession, PeriodCount, FPeriod2);
      if FPeriod3 <= FPeriod1 then
        FPeriod3 := FPeriod1 + SessionToDuration[PeriodToSession[FPeriod1]]
      else
      begin
        NextPeriod(PeriodToSession, PeriodCount, FPeriod3);
      end;
    end;
  end;
end;

procedure TTTBookmark3.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark3.GetProgress: Integer;
begin
  with Individual.Model do
    Result := (FOffset + FPosition) * ((PeriodCount * (PeriodCount - 1) div 2)
      * (2 * PeriodCount - 1) div 3) + PeriodCount * ( FPeriod1 * PeriodCount
      + FPeriod2 - (FPeriod1 + 1) * (FPeriod1 + 1) )
      - FPeriod2 * (FPeriod1 + 1) + (FPeriod1 * (FPeriod1 + 1) div 2)
      * (2 * FPeriod1 + 7) div 3 + FPeriod3;
  {Result := FProgress;
  with Individual.Model do
    Result := (FOffset + FPosition) * ((PeriodCount * (PeriodCount - 1) div 2) *
      (2 * PeriodCount - 1) div 3) +
    (FPeriod1 * PeriodCount - FPeriod1 * (FPeriod1 + 1) div 2 + FPeriod2 - 1);}
end;

function TTTBookmark3.GetMax: Integer;
begin
  with Individual.Model do
    Result := (FOffset + ClusterCount) * ((PeriodCount * (PeriodCount - 1) div 2) *
      (2 * PeriodCount - 1) div 3);
end;

function TTTBookmark3.Move: Integer;
begin
  with Individual.Model, TTimetable(Individual) do
  begin
    if FPeriod2 < FPeriod3 then
    begin
      Result := DoMove(Cluster, FPeriod1, FPeriod2) + DoMove(Cluster, FPeriod2, FPeriod3);
    end
    else if FPeriod2 = FPeriod3 then
    begin
      Result := DoMove(Cluster, FPeriod1, FPeriod2);
      FPeriod3 := FPeriod2;
    end
    else
      Result := DoMove(Cluster, FPeriod1, FPeriod3) + DoMove(Cluster, FPeriod3, FPeriod2);
  end;
end;

function TTTBookmark3.Undo: Integer;
begin
  with Individual.Model, TTimetable(Individual) do
  begin
    if FPeriod2 < FPeriod3 then
    begin
      Result := DoMove(Cluster, FPeriod2, FPeriod3) + DoMove(Cluster, FPeriod1, FPeriod2);
    end
    else if FPeriod2 = FPeriod3 then
    begin
      Result := DoMove(Cluster, FPeriod1, FPeriod2);
      FPeriod3 := FPeriod2;
    end
    else
      Result := DoMove(Cluster, FPeriod3, FPeriod2) + DoMove(Cluster, FPeriod1, FPeriod3);
  end;
end;

function TTTBookmark3.Eof: Boolean;
begin
  Result := FPosition = Individual.Model.ClusterCount;
end;
*)

initialization

  SortInteger := TSortInteger.Quicksort;
  Sort := TSortInteger.Quicksort;
  // SortInteger := TSortInteger.BubbleSort;
  // Sort := TSortInteger.BubbleSort;

end.

