{ -*- mode: Delphi -*- }
unit UTTModel;

{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}CThreads, CMem, {$ENDIF}Classes, DB, Dialogs, Forms, UModel,
  UTTGBasics;

var
  SortInteger: procedure(var List1: array of Integer;
    var List2: array of Integer; min, max: Integer);
  Sort: procedure(var List1: array of Integer; min, max: Integer);

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
    FClashThemeValue, FOutOfPositionEmptyHourValue, FBrokenSessionValue,
      FBreakTimetableResourceValue, FNonScatteredThemeValue: Integer;
    FTimeSlotToDay, FTimeSlotToHour, FDayToMaxTimeSlot, FSessionToActivity,
      FSessionToTheme, FClusterToCategory, FResourceToNumber,
      FThemeRestrictionToTheme, FThemeRestrictionToTimeSlot, FResourceToResourceType,
      FThemeRestrictionToThemeRestrictionType, FResourceRestrictionToResource,
      FResourceRestrictionToTimeSlot, FResourceRestrictionToResourceRestrictionType,
      FClusterToParallel, FActivityToCluster, FClusterToSessionCount,
      FThemeRestrictionTypeToValue, FResourceRestrictionTypeToValue, FResourceTypeToValue,
      FThemeRestrictionToValue, FResourceRestrictionToValue: TDynamicIntegerArray;
    FSessionToDuration: TSessionArray;
    FDayHourToTimeSlot, FCategoryParallelToCluster,
      FActivityToResources, FClusterThemeToActivity, FClusterThemeCount,
      FTimetableDetailPattern, FActivityToSessions,
      FResourceTimeSlotToResourceRestrictionType, FActivityResourceCount,
      FClusterJoinedClusterToActivity, FClusterJoinedClusterToCluster,
      FThemeTimeSlotToThemeRestrictionType: TDynamicIntegerArrayArray;
    FThemeCount, FThemeRestrictionTypeCount, FResourceTypeCount, FResourceRestrictionTypeCount,
      FClusterCount, FDayCount, FHourCount, FTimeSlotCount, FResourceCount,
      FCategoryCount, FActivityCount, FJoinedClusterCount: Integer;
    FParallelToIdParallel, FThemeToIdTheme, FDayToIdDay, FHourToIdHour,
      FCategoryToIdCategory: TDynamicIntegerArray;
    FIdCategoryToCategory, FIdParallelToParallel, FIdDayToDay,
      FIdHourToHour: TDynamicIntegerArray;
    FMinIdCategory, FMinIdParallel, FMinIdDay, FMinIdHour: Integer;
    FSessionNumberDouble: Integer;
    function GetDayAMaxTimeSlot(Day: Integer): Integer;
  protected
    property TimetableDetailPattern: TDynamicIntegerArrayArray read FTimetableDetailPattern;
    function GetElitistCount: Integer; override;
  public
    procedure Configure(AClashThemeValue, ABreakTimetableResourceValue,
                        AOutOfPositionEmptyHourValue, ABrokenSessionValue,
                        ANonScatteredThemeValue: Integer);
    constructor Create(AClashThemeValue, ABreakTimetableResourceValue,
                       AOutOfPositionEmptyHourValue, ABrokenSessionValue,
                       ANonScatteredThemeValue: Integer);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TIndividual; override;
    property TimeSlotCount: Integer read FTimeSlotCount;
    property ClusterCount: Integer read FClusterCount;
    property ClashThemeValue: Integer read FClashThemeValue;
    property BreakTimetableResourceValue: Integer read FBreakTimetableResourceValue;
    property OutOfPositionEmptyHourValue: Integer read FOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read FBrokenSessionValue;
    property NonScatteredThemeValue: Integer read FNonScatteredThemeValue;
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
    - DONE Change implementation of NonScatteredTheme with a more compositional formula
    - DONE Remove FClusterThemeDay{Min,Max}Hour
    - DONE IncCount and DecCount must be methods


  *)
  { TTimetableTablingInfo }
  TTimetableTablingInfo = class
  protected
    FResourceTimeSlotCount: TDynamicIntegerArrayArray;
    FThemeTimeSlotCount: TDynamicIntegerArrayArray;
    FClusterDayThemeCount: TDynamicIntegerArrayArrayArray;
    FClusterDayThemeAccumulated: TDynamicIntegerArrayArrayArray;
    FThemeRestrictionTypeToThemeCount: TDynamicIntegerArray;
    FClashResourceType: TDynamicIntegerArray;
    FResourceRestrictionTypeToResourceCount: TDynamicIntegerArray;
    FDayResourceMinHour: TDynamicIntegerArrayArray;
    FDayResourceMaxHour: TDynamicIntegerArrayArray;
    FDayResourceEmptyHourCount: TDynamicIntegerArrayArray;
    FClashTheme: Integer;
    FBreakTimetableResource: Integer;
    FOutOfPositionEmptyHour: Integer;
    FNonScatteredTheme: Integer;
    FBrokenSession: Integer;
  end;

  { TTimetable }

  TTimetable = class(TIndividual)
  private
    FTablingInfo: TTimetableTablingInfo;
    FClusterTimeSlotToSession: TDynamicIntegerArrayArray;
    procedure CheckIntegrity;
    procedure CrossCluster(Timetable2: TTimetable; ACluster: Integer);
    procedure DeltaValues(Delta, ACluster, TimeSlot1, TimeSlot2: Integer);
    function DeltaBrokenSession(ACluster, TimeSlot1, TimeSlot2: Integer): Integer;
    function GetClashThemeValue: Integer;
    function GetNonScatteredThemeValue: Integer;
    function GetOutOfPositionEmptyHourValue: Integer;
    function GetClashResourceValue: Integer;
    function GetThemeRestrictionValue: Integer;
    function GetResourceRestrictionValue: Integer;
    function GetBreakTimetableResourceValue: Integer;
    function GetBrokenSessionValue: Integer;
    function GetValue: Integer;
    procedure RandomizeKey(var ARandomKey: TDynamicIntegerArray;
      ACluster: Integer);
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

    procedure Normalize(ACluster: Integer; var ATimeSlot: Integer);
    function InternalSwap(ACluster, ATimeSlot1, ATimeSlot2: Integer): Integer;
    function Swap(ACluster, ATimeSlot1, ATimeSlot2: Integer): Integer;
    function DoMove(ACluster, ATimeSlot1: Integer; var ATimeSlot2: Integer): Integer;
    procedure SaveToFile(const AFileName: string);
    property OutOfPositionEmptyHour: Integer read FTablingInfo.FOutOfPositionEmptyHour;
    property ThemeRestrictionTypeToThemeCount: TDynamicIntegerArray
      read FTablingInfo.FThemeRestrictionTypeToThemeCount;
    property ResourceRestrictionTypeToResourceCount: TDynamicIntegerArray
      read FTablingInfo.FResourceRestrictionTypeToResourceCount;
    property ClashResourceType: TDynamicIntegerArray read FTablingInfo.FClashResourceType;
    property NonScatteredTheme: Integer read FTablingInfo.FNonScatteredTheme;
    property BrokenSession: Integer read FTablingInfo.FBrokenSession;
    property ClashTheme: Integer read FTablingInfo.FClashTheme;
    property ClashResourceValue: Integer read GetClashResourceValue;
    property ClashThemeValue: Integer read GetClashThemeValue;
    property BreakTimetableResourceValue: Integer read GetBreakTimetableResourceValue;
    property OutOfPositionEmptyHourValue: Integer read GetOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read GetBrokenSessionValue;
    property NonScatteredThemeValue: Integer read GetNonScatteredThemeValue;
    property ThemeRestrictionValue: Integer read GetThemeRestrictionValue;
    property ResourceRestrictionValue: Integer read GetResourceRestrictionValue;
    property ClusterTimeSlotToSession: TDynamicIntegerArrayArray
      read FClusterTimeSlotToSession write FClusterTimeSlotToSession;
    property BreakTimetableResource: Integer read FTablingInfo.FBreakTimetableResource;
    property TablingInfo: TTimetableTablingInfo read FTablingInfo;
  end;

  { TTTBookmark }

  TTTBookmark = class(TBookmark)
  private
    FIndividual: TIndividual;
    FClusters: TDynamicIntegerArray;
    FPosition, FOffset, FTimeSlot1, FTimeSlot2: Integer;
    function GetCluster: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; AClusters: TDynamicIntegerArray); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Cluster_: Integer read GetCluster;
    property Clusters: TDynamicIntegerArray read FClusters;
    property Offset: Integer read FOffset write FOffset;
  end;

  { TTTBookmark2 }

  TTTBookmark2 = class(TBookmark)
  private
    FIndividual: TIndividual;
    FClusters: TDynamicIntegerArray;
    FPosition, FOffset, FProgress, FTimeSlot1, FTimeSlot2, FTimeSlot3: Integer;
    function GetCluster: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; AClusters: TDynamicIntegerArray); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Cluster_: Integer read GetCluster;
    property Clusters: TDynamicIntegerArray read FClusters;
    property Offset: Integer read FOffset write FOffset;
  end;

implementation

uses
  SysUtils, ZSysUtils, MTProcs, DSource, USortAlgs, UTTGConsts, dsourcebaseconsts;

constructor TTimetableModel.Create(AClashThemeValue,
                                   ABreakTimetableResourceValue,
                                   AOutOfPositionEmptyHourValue,
                                   ABrokenSessionValue,
                                   ANonScatteredThemeValue: Integer);
var
  FMinIdResource, FMinIdResourceType, FMinIdTheme,
  FMinIdResourceRestrictionType, FMinIdThemeRestrictionType: Integer;
  FActivityToTheme, FIdThemeToTheme, FIdResourceToResource,
  FIdResourceTypeToResourceType, FResourceTypeToIdResourceType,
  FIdResourceRestrictionTypeToResourceRestrictionType,
  FIdThemeRestrictionTypeToThemeRestrictionType, FClusterToDuration,
  FResourceToIdResource, FResourceRestrictionTypeAIdResourceRestrictionType,
  FThemeRestrictionTypeAIdThemeRestrictionType: TDynamicIntegerArray;
  
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
  procedure LoadTimeSlot;
  var
    TimeSlot, Day, Hour: Integer;
    VFieldDay, VFieldHour: TField;
  begin
    with SourceDataModule.TbTimeSlot do
    begin
      IndexFieldNames := 'IdDay;IdHour';
      First;
      FTimeSlotCount := RecordCount;
      SetLength(FTimeSlotToDay, FTimeSlotCount);
      SetLength(FDayToMaxTimeSlot, FDayCount);
      SetLength(FTimeSlotToHour, FTimeSlotCount);
      SetLength(FDayHourToTimeSlot, FDayCount, FHourCount);
      for Day := 0 to FDayCount - 1 do
        for Hour := 0 to FHourCount - 1 do
          FDayHourToTimeSlot[Day, Hour] := -1;
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      for TimeSlot := 0 to FTimeSlotCount - 1 do
      begin
        Day := FIdDayToDay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[VFieldHour.AsInteger - FMinIdHour];
        FTimeSlotToDay[TimeSlot] := Day;
        FTimeSlotToHour[TimeSlot] := Hour;
        FDayHourToTimeSlot[Day, Hour] := TimeSlot;
        Next;
      end;
      for Day := 0 to FDayCount - 1 do
      begin
        FDayToMaxTimeSlot[Day] := GetDayAMaxTimeSlot(Day);
      end;
      First;
    end;
  end;
  procedure LoadCluster;
  var
    VCluster, Category, Parallel: Integer;
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
      for VCluster := 0 to FClusterCount - 1 do
      begin
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        FClusterToCategory[VCluster] := Category;
        FClusterToParallel[VCluster] := Parallel;
        FCategoryParallelToCluster[Category, Parallel] := VCluster;
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
    FieldResourceType, FieldResourceNumber: TField;
  begin
    with SourceDataModule.TbResource do
    begin
      IndexFieldNames := 'IdResource';
      First;
      FieldResourceType := FindField('IdResourceType');
      FieldResourceNumber := FindField('NumResource');
      SetLength(FResourceToResourceType, FResourceCount);
      SetLength(FResourceToNumber, FResourceCount);
      for Resource := 0 to FResourceCount - 1 do
      begin
        FResourceToResourceType[Resource] :=
          FIdResourceTypeToResourceType[FieldResourceType.AsInteger - FMinIdResourceType];
        FResourceToNumber[Resource] := FieldResourceNumber.AsInteger;
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
    Theme, ThemeRestriction, TimeSlot, ThemeRestrictionType: Integer;
    VFieldTheme, VFieldDay, VFieldHour, VFieldThemeRestrictionType: TField;
  begin
    with SourceDataModule.TbThemeRestriction do
    begin
      IndexFieldNames := 'IdTheme;IdDay;IdHour';
      First;
      SetLength(FThemeRestrictionToTheme, RecordCount);
      SetLength(FThemeRestrictionToTimeSlot, RecordCount);
      SetLength(FThemeRestrictionToThemeRestrictionType, RecordCount);
      SetLength(FThemeRestrictionToValue, RecordCount);
      SetLength(FThemeTimeSlotToThemeRestrictionType, FThemeCount,
        FTimeSlotCount);
      for Theme := 0 to FThemeCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FThemeTimeSlotToThemeRestrictionType[Theme, TimeSlot] := -1;
      VFieldTheme := FindField('IdTheme');
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      VFieldThemeRestrictionType := FindField('IdThemeRestrictionType');
      for ThemeRestriction := 0 to RecordCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        TimeSlot := FDayHourToTimeSlot[FIdDayToDay[VFieldDay.AsInteger - FMinIdDay],
          FIdHourToHour[VFieldHour.AsInteger - FMinIdHour]];
        ThemeRestrictionType := FIdThemeRestrictionTypeToThemeRestrictionType
          [VFieldThemeRestrictionType.AsInteger - FMinIdThemeRestrictionType];
        FThemeRestrictionToTheme[ThemeRestriction] := Theme;
        FThemeRestrictionToTimeSlot[ThemeRestriction] := TimeSlot;
        FThemeRestrictionToThemeRestrictionType[Theme] := ThemeRestrictionType;
        FThemeRestrictionToValue[ThemeRestriction] := FThemeRestrictionTypeToValue[ThemeRestrictionType];
        FThemeTimeSlotToThemeRestrictionType[Theme, TimeSlot] := ThemeRestrictionType;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadResourceRestriction;
  var
    ResourceRestriction, Resource, TimeSlot, Day, Hour,
      ResourceRestrictionType, Value: Integer;
    VFieldResource, VFieldDay, VFieldHour,
      VFieldResourceRestrictionType: TField;
  begin
    with SourceDataModule.TbResourceRestriction do
    begin
      IndexFieldNames := 'IdResource;IdDay;IdHour';
      First;
      SetLength(FResourceRestrictionToResource, RecordCount);
      SetLength(FResourceRestrictionToTimeSlot, RecordCount);
      SetLength(FResourceRestrictionToResourceRestrictionType, RecordCount);
      SetLength(FResourceRestrictionToValue, RecordCount);
      SetLength(FResourceTimeSlotToResourceRestrictionType, FResourceCount,
        FTimeSlotCount);
      for Resource := 0 to FResourceCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FResourceTimeSlotToResourceRestrictionType[Resource, TimeSlot] := -1;
      VFieldResource := FindField('IdResource');
      VFieldHour := FindField('IdHour');
      VFieldDay := FindField('IdDay');
      VFieldResourceRestrictionType := FindField('IdResourceRestrictionType');
      for ResourceRestriction := 0 to RecordCount - 1 do
      begin
        Resource := FIdResourceToResource[VFieldResource.AsInteger - FMinIdResource];
        Day := FIdDayToDay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[VFieldHour.AsInteger - FMinIdHour];
        TimeSlot := FDayHourToTimeSlot[Day, Hour];
        ResourceRestrictionType := FIdResourceRestrictionTypeToResourceRestrictionType
          [VFieldResourceRestrictionType.AsInteger - FMinIdResourceRestrictionType];
        FResourceRestrictionToResource[ResourceRestriction] := Resource;
        FResourceRestrictionToTimeSlot[ResourceRestriction] := TimeSlot;
        FResourceRestrictionToResourceRestrictionType[ResourceRestriction] := ResourceRestrictionType;
        Value := FResourceRestrictionTypeToValue[ResourceRestrictionType];
        FResourceRestrictionToValue[ResourceRestriction] := Value;
        FResourceTimeSlotToResourceRestrictionType[Resource, TimeSlot] := ResourceRestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure LoadActivity;
  var
    Theme, Category, Parallel, Session1, Activity, VCluster,
      Session2, Session, VPos: Integer;
    VFieldTheme, VFieldCategory, VFieldParallel, VFieldComposition: TField;
    VSessionToDuration, VSessionToActivity: array [0 .. 16383] of Integer;
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
      // SetLength(FActivityAAsignatura, RecordCount);
      SetLength(FActivityToCluster, FActivityCount);
      SetLength(FActivityToSessions, FActivityCount);
      SetLength(FActivityToTheme, FActivityCount);
      SetLength(FClusterThemeCount, FClusterCount, FThemeCount);
      SetLength(FClusterThemeToActivity, FClusterCount, FThemeCount);
      for VCluster := 0 to FClusterCount - 1 do
        for Theme := 0 to FThemeCount - 1 do
        begin
          FClusterThemeCount[VCluster, Theme] := 0;
          FClusterThemeToActivity[VCluster, Theme] := -1;
        end;
      Session2 := 0;
      for Activity := 0 to RecordCount - 1 do
      begin
        Theme := FIdThemeToTheme[VFieldTheme.AsInteger - FMinIdTheme];
        Category := FIdCategoryToCategory[VFieldCategory.AsInteger - FMinIdCategory];
        Parallel := FIdParallelToParallel[VFieldParallel.AsInteger - FMinIdParallel];
        VCluster := FCategoryParallelToCluster[Category, Parallel];
        FActivityToCluster[Activity] := VCluster;
        FActivityToTheme[Activity] := Theme;
        FClusterThemeToActivity[VCluster, Theme] := Activity;
        Composition := VFieldComposition.AsString;
        VPos := 1;
        Session1 := Session2;
        // t := 0;
        while VPos <= Length(Composition) do
        begin
          VSessionToDuration[Session2] := StrToInt(ExtractString(Composition, VPos, '.'));
          VSessionToActivity[Session2] := Activity;
          Inc(FClusterThemeCount[VCluster, Theme]);
          // Inc(t, VSessionToDuration[Session2]);
          Inc(Session2);
        end;
        SetLength(FActivityToSessions[Activity], Session2 - Session1);
        for Session := Session1 to Session2 - 1 do
        begin
          FActivityToSessions[Activity, Session - Session1] := Session;
        end;
        // FClusterToDuration[VCluster] := FClusterToDuration[VCluster] + t;
        Next;
      end;
      SetLength(FSessionToActivity, Session2);
      SetLength(FSessionToTheme, Session2);
      Move(VSessionToDuration[0], FSessionToDuration[0], Session2 * SizeOf(Integer));
      FSessionToDuration[-1] := 1;
      Move(VSessionToActivity[0], FSessionToActivity[0],
        Session2 * SizeOf(Integer));
      for Session := 0 to Session2 - 1 do
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
        FActivityResourceCount[Activity, Resource] := VFieldNumRequirement.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadJoinedCluster;
  var
    JoinedCluster, Counter, VCluster1, Category1, Parallel1,
      VCluster, Category, Parallel, Theme,  Activity: Integer;
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
        VCluster := FCategoryParallelToCluster[Category, Parallel];
        Activity := FClusterThemeToActivity[VCluster, Theme];
        Category1 := FIdCategoryToCategory[VFieldCategory1.AsInteger - FMinIdCategory];
        Parallel1 := FIdParallelToParallel[VFieldParallel1.AsInteger - FMinIdParallel];
        VCluster1 := FCategoryParallelToCluster[Category1, Parallel1];
        Counter := Length(FClusterJoinedClusterToActivity[VCluster]);
        SetLength(FClusterJoinedClusterToActivity[VCluster], Counter + 1);
        SetLength(FClusterJoinedClusterToCluster[VCluster], Counter + 1);
        FClusterJoinedClusterToActivity[VCluster, Counter] := Activity;
        FClusterJoinedClusterToCluster[VCluster, Counter] := VCluster1;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadPatternTimetableDetail;
  var
    TimeSlot1, VCluster, Activity, TimeSlot, Contador, Duration, Number: Integer;
  begin
    SetLength(FTimetableDetailPattern, FClusterCount, FTimeSlotCount);
    SetLength(FClusterToSessionCount, FClusterCount);
    SetLength(FClusterToDuration, FClusterCount);
    for VCluster := 0 to FClusterCount - 1 do
    begin
      FClusterToDuration[VCluster] := 0;
      FClusterToSessionCount[VCluster] := 0;
      for TimeSlot := 0 to FTimeSlotCount - 1 do
      begin
        FTimetableDetailPattern[VCluster, TimeSlot] := -1;
      end;
    end;
    for Activity := FActivityCount - 1 downto 0 do
    begin
      VCluster := FActivityToCluster[Activity];
      for Contador := High(FActivityToSessions[Activity]) downto 0 do
      begin
        Duration := FSessionToDuration[FActivityToSessions[Activity, Contador]];
        TimeSlot1 := FClusterToDuration[VCluster];
        for TimeSlot := TimeSlot1 to TimeSlot1 + Duration - 1 do
        begin
          if (TimeSlot < 0) or (TimeSlot >= FTimeSlotCount) then
            raise Exception.CreateFmt(SClusterTimeSlotToSessionOverflow,
              [FClusterToCategory[VCluster], FClusterToParallel[VCluster], TimeSlot]);
          FTimetableDetailPattern[VCluster, FTimeSlotCount - 1 - TimeSlot]
            := FActivityToSessions[Activity, Contador];
        end;
        Inc(FClusterToDuration[VCluster], Duration);
      end;
    end;
    for VCluster := 0 to FClusterCount - 1 do
    begin
      TimeSlot := 0;
      while TimeSlot < FTimeSlotCount do
      begin
        Duration := FSessionToDuration[FTimetableDetailPattern[VCluster, TimeSlot]];
        Inc(TimeSlot, Duration);
        Inc(FClusterToSessionCount[VCluster]);
      end;
    end;
    FSessionNumberDouble := 0;
    for VCluster := 0 to FClusterCount - 1 do
    begin
      Number := FClusterToSessionCount[VCluster];
      Inc(FSessionNumberDouble, (Number * (Number - 1)) div 2);
    end;
  end;
begin
  inherited Create;
  with SourceDataModule do
  begin
    Configure(AClashThemeValue,
      ABreakTimetableResourceValue, AOutOfPositionEmptyHourValue,
      ABrokenSessionValue, ANonScatteredThemeValue);
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
      FThemeRestrictionTypeAIdThemeRestrictionType);
    FThemeRestrictionTypeCount := Length(FThemeRestrictionTypeAIdThemeRestrictionType);
    Load(TbResourceRestrictionType, 'IdResourceRestrictionType',
      FMinIdResourceRestrictionType,
      FIdResourceRestrictionTypeToResourceRestrictionType,
      FResourceRestrictionTypeAIdResourceRestrictionType);
    FResourceRestrictionTypeCount := Length(FResourceRestrictionTypeAIdResourceRestrictionType);
    LoadTimeSlot;
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
    LoadPatternTimetableDetail;
  end;
end;

procedure TTimetableModel.Configure(AClashThemeValue,
  ABreakTimetableResourceValue, AOutOfPositionEmptyHourValue,
  ABrokenSessionValue, ANonScatteredThemeValue: Integer);
begin
  FClashThemeValue := AClashThemeValue;
  FBreakTimetableResourceValue := ABreakTimetableResourceValue;
  FOutOfPositionEmptyHourValue := AOutOfPositionEmptyHourValue;
  FBrokenSessionValue := ABrokenSessionValue;
  FNonScatteredThemeValue := ANonScatteredThemeValue;
end;

function TTimetableModel.GetDayAMaxTimeSlot(Day: Integer): Integer;
begin
  if Day = FDayCount - 1 then
    Result := FTimeSlotCount - 1
  else
    Result := FDayHourToTimeSlot[Day + 1, 0] - 1;
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
          SClashTheme              + ':', ClashThemeValue,
          SBreakTimetableResource  + ':', BreakTimetableResourceValue,
          SOutOfPositionEmptyHour  + ':', OutOfPositionEmptyHourValue,
          SBrokenSession           + ':', BrokenSessionValue,
          SNonScatteredTheme       + ':', NonScatteredThemeValue]));
end;

function TTimetableModel.NewIndividual: TIndividual;
begin
  Result := TTimetable.Create(Self);
end;

procedure TTimetable.RandomizeKey(var ARandomKey: TDynamicIntegerArray;
  ACluster: Integer);
var
  TimeSlot, Duration, Counter, MaxTimeSlot: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  NumberList: array [0 .. 4095] of Integer;
begin
  with TTimetableModel(Model) do
  begin
    for Counter := 0 to FClusterToSessionCount[ACluster] - 1 do
      NumberList[Counter] := Random($7FFFFFFF);
    Sort(NumberList, 0, FClusterToSessionCount[ACluster] - 1);
    TimeSlotToSession := ClusterTimeSlotToSession[ACluster];
    TimeSlot := 0;
    Counter := 0;
    while TimeSlot < FTimeSlotCount do
    begin
      Duration := FSessionToDuration[TimeSlotToSession[TimeSlot]];
      MaxTimeSlot := TimeSlot + Duration;
      while TimeSlot < MaxTimeSlot do
      begin
        ARandomKey[TimeSlot] := NumberList[Counter];
        Inc(TimeSlot);
      end;
      Inc(Counter);
    end;
  end;
end;

procedure TTimetable.CrossCluster(Timetable2: TTimetable; ACluster: Integer);
var
  Session, TimeSlot, Duration, Key1, Key2, MaxTimeSlot: Integer;
  RandomKey1, RandomKey2: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    SetLength(RandomKey1, FTimeSlotCount);
    RandomizeKey(RandomKey1, ACluster);
    SortInteger(ClusterTimeSlotToSession[ACluster], RandomKey1, 0, FTimeSlotCount - 1);

    SetLength(RandomKey2, FTimeSlotCount);
    Timetable2.RandomizeKey(RandomKey2, ACluster);
    SortInteger(Timetable2.ClusterTimeSlotToSession[ACluster], RandomKey2, 0, FTimeSlotCount - 1);

    TimeSlot := 0;
    while TimeSlot < FTimeSlotCount do
    begin
      Session := FTimetableDetailPattern[ACluster, TimeSlot];
      Duration := FSessionToDuration[Session];
      if Random(2) = 0 then
      begin
        Key1 := RandomKey1[TimeSlot];
        Key2 := RandomKey2[TimeSlot];
        MaxTimeSlot := TimeSlot + Duration;
        while TimeSlot < MaxTimeSlot do
        begin
          RandomKey1[TimeSlot] := Key2;
          RandomKey2[TimeSlot] := Key1;
          Inc(TimeSlot);
        end;
      end
      else
        Inc(TimeSlot, Duration);
    end;
    SortInteger(RandomKey1, ClusterTimeSlotToSession[ACluster], 0, FTimeSlotCount - 1);
    SortInteger(RandomKey2, Timetable2.ClusterTimeSlotToSession[ACluster], 0,
      FTimeSlotCount - 1);
  end;
end;

procedure TTimetable.Cross(AIndividual: TIndividual);
var
  VCluster: Integer;
begin
  with TTimetableModel(Model) do
  begin
    for VCluster := 0 to FClusterCount - 1 do
    begin
      CrossCluster(TTimetable(AIndividual), VCluster);
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
    SetLength(FClusterTimeSlotToSession, FClusterCount, FTimeSlotCount);
    FTablingInfo := TTimetableTablingInfo.Create;
    with TablingInfo do
    begin
      SetLength(FThemeTimeSlotCount, FThemeCount, FTimeSlotCount);
      SetLength(FResourceTimeSlotCount, FResourceCount, FTimeSlotCount);
      SetLength(FClusterDayThemeCount, FClusterCount, FDayCount, FThemeCount);
      SetLength(FClusterDayThemeAccumulated, FClusterCount, FDayCount, FThemeCount);
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
  VCluster, TimeSlot, Duration, MaxTimeSlot, RandomKey: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  RandomKeys: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    SetLength(RandomKeys, FTimeSlotCount);
    for VCluster := 0 to FClusterCount - 1 do
    begin
      TimeSlotToSession := ClusterTimeSlotToSession[VCluster];
      for TimeSlot := 0 to FTimeSlotCount - 1 do
        TimeSlotToSession[TimeSlot] := FTimetableDetailPattern[VCluster, TimeSlot];
      TimeSlot := 0;
      while TimeSlot < FTimeSlotCount do
      begin
        Duration := FSessionToDuration[TimeSlotToSession[TimeSlot]];
        RandomKey := Random($7FFFFFFF);
        MaxTimeSlot := TimeSlot + Duration;
        while TimeSlot < MaxTimeSlot do
        begin
          RandomKeys[TimeSlot] := RandomKey;
          Inc(TimeSlot);
        end;
      end;
      SortInteger(RandomKeys, TimeSlotToSession, 0, FTimeSlotCount - 1);
    end;
  end;
  Update;
end;

function TTimetable.Swap(ACluster, ATimeSlot1, ATimeSlot2: Integer): Integer;
begin
  Normalize(ACluster, ATimeSlot1);
  Normalize(ACluster, ATimeSlot2);
  if ATimeSlot1 < ATimeSlot2 then
    Result := InternalSwap(ACluster, ATimeSlot1, ATimeSlot2)
  else if ATimeSlot2 < ATimeSlot1 then
    Result := InternalSwap(ACluster, ATimeSlot2, ATimeSlot1);
end;

function TTimetable.DoMove(ACluster, ATimeSlot1: Integer; var ATimeSlot2: Integer): Integer;
var
  Duration1, Duration2: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Duration1 := SessionToDuration[ClusterTimeSlotToSession[ACluster, ATimeSlot1]];
    Duration2 := SessionToDuration[ClusterTimeSlotToSession[ACluster, ATimeSlot2]];
  end;
  Result := InternalSwap(ACluster, ATimeSlot1, ATimeSlot2);
  ATimeSlot2 := ATimeSlot2 + Duration2 - Duration1;
end;

procedure TTimetable.DeltaValues(Delta, ACluster, TimeSlot1, TimeSlot2: Integer);
var
  ThemeRestrictionType, ResourceRestrictionType, TimeSlot, TimeSlot0, Day, DDay,
  Day1, Day2, Hour, Session, Resource, Duration, Theme, Limit, Requirement, Count,
  JoinedCluster, Activity, DeltaBreakTimetableResource, MinTimeSlot, MaxTimeSlot,
  Cluster1: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Inc(FBrokenSession, Delta * DeltaBrokenSession(ACluster, TimeSlot1, TimeSlot2));
    TimeSlotToSession := FClusterTimeSlotToSession[ACluster];
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    for TimeSlot := TimeSlot1 to TimeSlot2 do
    begin
      Session := TimeSlotToSession[TimeSlot];
      if Session >= 0 then
      begin
        Theme := FSessionToTheme[Session];
        Day := FTimeSlotToDay[TimeSlot];
        Hour := FTimeSlotToHour[TimeSlot];
        Activity := FSessionToActivity[Session];
        for Requirement := 0 to High(FActivityToResources[Activity]) do
        begin
          Resource := FActivityToResources[Activity, Requirement];
          Count := FActivityResourceCount[Activity, Resource];
          if FResourceTimeSlotCount[Resource, TimeSlot] = Limit * Count then
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
                else // if FDayResourceMaxTimeSlot[Day, Resource] < TimeSlot then
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
                  TimeSlot0 := TimeSlot + 1;
                  MaxTimeSlot := FDayHourToTimeSlot[Day, FDayResourceMaxHour[Day, Resource]];
                  while (TimeSlot0 <= MaxTimeSlot)
                        and (FResourceTimeSlotCount[Resource, TimeSlot0] = 0) do
                    Inc(TimeSlot0);
                  DeltaBreakTimetableResource := Hour + 1 - FTimeSlotToHour[TimeSlot0];
                  FDayResourceMinHour[Day, Resource] := FTimeSlotToHour[TimeSlot0];
                end
                else if (FDayResourceMinHour[Day, Resource] < Hour)
                        and (Hour < FDayResourceMaxHour[Day, Resource]) then
                begin
                  DeltaBreakTimetableResource := 1;
                end
                else // if (FDayResourceMaxTimeSlot[Day, Resource] = TimeSlot) then
                begin
                  TimeSlot0 := TimeSlot - 1;
                  MinTimeSlot := FDayHourToTimeSlot[Day, FDayResourceMinHour[Day, Resource]];
                  while (TimeSlot0 >= MinTimeSlot)
                        and (FResourceTimeSlotCount[Resource, TimeSlot0] = 0) do
                    Dec(TimeSlot0);
                  DeltaBreakTimetableResource := FTimeSlotToHour[TimeSlot0] + 1 - Hour;
                  FDayResourceMaxHour[Day, Resource] := FTimeSlotToHour[TimeSlot0];
                end;
                Inc(FDayResourceEmptyHourCount[Day, Resource], DeltaBreakTimetableResource);
                Inc(FBreakTimetableResource, DeltaBreakTimetableResource);
              end;
            end;
          end;
          if FResourceTimeSlotCount[Resource, TimeSlot] >= FResourceToNumber[Resource] + Limit * Count then
            Inc(FClashResourceType[FResourceToResourceType[Resource]], Delta * Count);
          Inc(FResourceTimeSlotCount[Resource, TimeSlot], Delta * Count);
          ResourceRestrictionType := FResourceTimeSlotToResourceRestrictionType[Resource, TimeSlot];
          if ResourceRestrictionType >= 0 then
            Inc(FResourceRestrictionTypeToResourceCount[ResourceRestrictionType], Delta * Count);
        end;
        Inc(FThemeTimeSlotCount[Theme, TimeSlot], Delta);
        ThemeRestrictionType := FThemeTimeSlotToThemeRestrictionType[Theme, TimeSlot];
        if ThemeRestrictionType >= 0 then
          Inc(FThemeRestrictionTypeToThemeCount[ThemeRestrictionType], Delta);
      end
      else if FHourCount - 1 <> FTimeSlotToHour[TimeSlot] then
        Inc(FOutOfPositionEmptyHour, Delta);
    end;
    TimeSlot := TimeSlot1;
    while TimeSlot <= TimeSlot2 do
    begin
      Session := TimeSlotToSession[TimeSlot];
      Duration := FSessionToDuration[Session];
      if Session >= 0 then
      begin
        Theme := FSessionToTheme[Session];
        Day1 := FTimeSlotToDay[TimeSlot];
        Day2 := FTimeSlotToDay[TimeSlot + Duration - 1];
        for Day := Day1 to Day2 do
        begin
          if FClusterDayThemeCount[ACluster, Day, Theme] > Limit then
            Inc(FClashTheme, Delta);
          Inc(FClusterDayThemeCount[ACluster, Day, Theme], Delta);
        end;
        DDay := FDayCount div FClusterThemeCount[ACluster, Theme];
        for Day2 := Day1 to Day1 + DDay - 1 do
        begin
          Day := Day2 mod (FDayCount + 1);
          if Day <> FDayCount then
          begin
            if FClusterDayThemeAccumulated[ACluster, Day, Theme] > Limit then
              Inc(FNonScatteredTheme, Delta);
            Inc(FClusterDayThemeAccumulated[ACluster, Day, Theme], Delta);
          end;
        end;
      end;
      Inc(TimeSlot, Duration);
    end;
    for JoinedCluster := 0 to High(FClusterJoinedClusterToActivity[ACluster]) do
    begin
      Activity := FClusterJoinedClusterToActivity[ACluster, JoinedCluster];
      Cluster1 := FClusterJoinedClusterToCluster[ACluster, JoinedCluster];
      for TimeSlot := TimeSlot1 to TimeSlot2 do
      begin
        Session := TimeSlotToSession[TimeSlot];
        if Session >= 0 then
        begin
          if Activity = FSessionToActivity[Session] then
          begin
            if FClusterTimeSlotToSession[Cluster1, TimeSlot] >= 0 then
              Inc(FClashTheme, Delta);
          end;
        end;
      end;
    end;
  end;
end;

function TTimetable.InternalSwap(ACluster, ATimeSlot1, ATimeSlot2: Integer): Integer;
var
  Duration1, Duration2, Session1, Session2: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  procedure DoMovement;
  var
    TimeSlot: Integer;
  begin
    Move(TimeSlotToSession[ATimeSlot1 + Duration1], TimeSlotToSession[ATimeSlot1 + Duration2],
      (ATimeSlot2 - ATimeSlot1 - Duration1) * SizeOf(Integer));
    for TimeSlot := ATimeSlot1 to ATimeSlot1 + Duration2 - 1 do
      TimeSlotToSession[TimeSlot] := Session2;
    for TimeSlot := ATimeSlot2 + Duration2 - Duration1 to ATimeSlot2 + Duration2 - 1 do
      TimeSlotToSession[TimeSlot] := Session1;
  end;
  // Values that requires total recalculation:
var
  TimeSlot: Integer;
  {$IFDEF DEBUG}
  Value1, Value2: Integer;
  ClashTheme2: Integer;
  BreakTimetableResource2: Integer;
  OutOfPositionEmptyHour2: Integer;
  ThemeRestrictionValue2: Integer;
  NonScatteredTheme2: Integer;
  ClashResourceValue2: Integer;
  ResourceRestrictionValue2: Integer;
  BrokenSession2: Integer;
  {$ENDIF}
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Result := FValue;
    {$IFDEF DEBUG}
    Update;
    Value1 := FValue;
    {$ENDIF}
    TimeSlotToSession := ClusterTimeSlotToSession[ACluster];
    Session1 := TimeSlotToSession[ATimeSlot1];
    Session2 := TimeSlotToSession[ATimeSlot2];
    Duration1 := FSessionToDuration[Session1];
    Duration2 := FSessionToDuration[Session2];
    if (Duration1 = Duration2) then
    begin
      DeltaValues(-1, ACluster, ATimeSlot1, ATimeSlot1 + Duration1 - 1);
      DeltaValues(-1, ACluster, ATimeSlot2, ATimeSlot2 + Duration2 - 1);
      for TimeSlot := ATimeSlot1 to ATimeSlot1 + Duration2 - 1 do
        TimeSlotToSession[TimeSlot] := Session2;
      for TimeSlot := ATimeSlot2 to ATimeSlot2 + Duration2 - 1 do
        TimeSlotToSession[TimeSlot] := Session1;
      DeltaValues(1, ACluster, ATimeSlot1, ATimeSlot1 + Duration1 - 1);
      DeltaValues(1, ACluster, ATimeSlot2, ATimeSlot2 + Duration2 - 1);
    end
    else
    begin
      DeltaValues(-1, ACluster, ATimeSlot1, ATimeSlot2 + Duration2 - 1);
      DoMovement;
      DeltaValues(1, ACluster, ATimeSlot1, ATimeSlot2 + Duration2 - 1);
    end;
    FValue := GetValue;
    {$IFDEF DEBUG}
    ClashTheme2 := FClashTheme;
    OutOfPositionEmptyHour2 := FOutOfPositionEmptyHour;
    NonScatteredTheme2 := FNonScatteredTheme;
    ThemeRestrictionValue2 := ThemeRestrictionValue;
    BreakTimetableResource2 := FBreakTimetableResource;
    ClashResourceValue2 := ClashResourceValue;
    ResourceRestrictionValue2 := ResourceRestrictionValue;
    BrokenSession2 := FBrokenSession;
    Value2 := FValue;
    Update;
    if abs(FValue - Result - (Value2 - Value1)) > 0.000001 then
      raise Exception.CreateFmt(
      'Value1                   %f - %f'#13#10 +
      'Value2                   %f - %f'#13#10 +
      'ClashTheme               %d - %d'#13#10 +
      'OutOfPositionEmptyHour   %d - %d'#13#10 +
      'NonScatteredTheme        %d - %d'#13#10 +
      'ThemeRestrictionValue    %f - %f'#13#10 +
      'BreakTimetableResource   %d - %d'#13#10 +
      'ClashResourceValue       %f - %f'#13#10 +
      'ResourceRestrictionValue %f - %f'#13#10 +
      'BrokenSession            %d - %d',
      [
        Result, Value1,
        FValue, Value2,
        FClashTheme, ClashTheme2,
        FOutOfPositionEmptyHour, OutOfPositionEmptyHour2,
        FNonScatteredTheme, NonScatteredTheme2,
        ThemeRestrictionValue, ThemeRestrictionValue2,
        FBreakTimetableResource, BreakTimetableResource2,
        ClashResourceValue, ClashResourceValue2,
        ResourceRestrictionValue, ResourceRestrictionValue2,
        FBrokenSession, BrokenSession2
        ]);
    {$ENDIF}
    Result := FValue - Result;
  end;
end;

{WARNING!!! Normalize is a Kludge, avoid its usage!!!}
procedure TTimetable.Normalize(ACluster: Integer; var ATimeSlot: Integer);
var
  Session: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  TimeSlotToSession := FClusterTimeSlotToSession[ACluster];
  Session := TimeSlotToSession[ATimeSlot];
  if Session >= 0 then
    while (ATimeSlot > 0) and (Session = TimeSlotToSession[ATimeSlot - 1]) do
      Dec(ATimeSlot);
end;

{Assembler version of Normalize}
(*
  procedure TTimetable.Normalize(ACluster: Integer; var ATimeSlot: Integer); assembler;
  asm
  push    ebx
  mov     eax, [eax + FClusterTimeSlotToSession]
  movsx   edx, ACluster
  mov     eax, [eax + edx * 4]
  movsx   edx, word ptr [ecx]
  mov     bx, [eax + edx * 2]
  cmp     bx, 0
  jl      @end2
  @beg:
  cmp     edx, 0
  jle     @end
  cmp     bx, word ptr [eax + edx * 2 - 2]
  jne     @end
  Dec     edx
  jmp     @beg
  @end:
  mov     [ecx], dx
  @end2:
  pop     ebx
  end;
*)

procedure TTimetable.ReportValues(AReport: TStrings);
var
  SRowFormat: string = '%0:-28s %12d %12d %12d';
begin
  with AReport, TablingInfo do
  begin
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-28s %12s %12s %12s', [SDetail, SCount, SWeight, SValue]));
    Add('-------------------------------------------------------------------');
    Add(Format(SRowFormat, [SClashTheme + ':', FClashTheme,
      TTimetableModel(Model).ClashThemeValue, ClashThemeValue]));
    Add(Format(SRowFormat, [SBreakTimetableResource + ':', BreakTimetableResource,
      TTimetableModel(Model).BreakTimetableResourceValue, BreakTimetableResourceValue]));
    Add(Format(SRowFormat, [SOutOfPositionEmptyHour + ':', OutOfPositionEmptyHour,
      TTimetableModel(Model).OutOfPositionEmptyHourValue, OutOfPositionEmptyHourValue]));
    Add(Format(SRowFormat, [SBrokenSession + ':', BrokenSession,
      TTimetableModel(Model).BrokenSessionValue, BrokenSessionValue]));
    Add(Format(SRowFormat, [SNonScatteredTheme + ':', NonScatteredTheme,
        TTimetableModel(Model).NonScatteredThemeValue, NonScatteredThemeValue]));
    Add(Format('%0:-28s %12s %12s %12d', [SClashResource + ':',
         '(' + VarArrToStr(FClashResourceType, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FResourceTypeToValue, ' ') + ')',
         ClashResourceValue]));
    Add(Format('%0:-28s %12s %12s %12d', [STbResourceRestriction + ':',
         '(' + VarArrToStr(FResourceRestrictionTypeToResourceCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FResourceRestrictionTypeToValue, ' ') + ')',
         ResourceRestrictionValue]));
    Add(Format('%0:-28s %12s %12s %12d', [STbThemeRestriction + ':',
         '(' + VarArrToStr(FThemeRestrictionTypeToThemeCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FThemeRestrictionTypeToValue, ' ') + ')',
         ThemeRestrictionValue]));
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-54s %12d', [STotalValue, Value]));
  end;
end;

procedure TTimetable.Mutate;
var
  VCluster, TimeSlot1, TimeSlot2: Integer;
begin
  with TTimetableModel(Model) do
  begin
    TimeSlot1 := Random(FTimeSlotCount);
    TimeSlot2 := Random(FTimeSlotCount);
    VCluster := Random(FClusterCount);
    if ClusterTimeSlotToSession[VCluster, TimeSlot1]
    <> ClusterTimeSlotToSession[VCluster, TimeSlot2] then
      Swap(VCluster, TimeSlot1, TimeSlot2);
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

function TTimetable.DeltaBrokenSession(ACluster, TimeSlot1, TimeSlot2: Integer): Integer;
var
  TimeSlot, Hour1, Hour2, Day1, Day2, Session, Duration: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    TimeSlot := TimeSlot1;
    TimeSlotToSession := FClusterTimeSlotToSession[ACluster];
    Result := 0;
    while TimeSlot <= TimeSlot2 do
    begin
      Session := TimeSlotToSession[TimeSlot];
      Duration := FSessionToDuration[Session];
      if Duration > 1 then
      begin
        Day1 := FTimeSlotToDay[TimeSlot];
        Day2 := FTimeSlotToDay[TimeSlot + Duration - 1];
        Hour1 := FTimeSlotToHour[TimeSlot];
        Hour2 := FTimeSlotToHour[TimeSlot + Duration - 1];
        Inc(Result, (Day2 - Day1) * (FHourCount + 1) + Hour2 - Hour1 + 1 - Duration);
      end;
      Inc(TimeSlot, Duration);
    end;
  end;
end;

function TTimetable.GetNonScatteredThemeValue: Integer;
begin
  Result := TTimetableModel(Model).NonScatteredThemeValue * NonScatteredTheme;
end;

function TTimetable.GetClashThemeValue: Integer;
begin
  Result := TTimetableModel(Model).ClashThemeValue * TablingInfo.FClashTheme;
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
      ClashThemeValue +
      OutOfPositionEmptyHourValue +
      NonScatteredThemeValue +
      ThemeRestrictionValue +
      BreakTimetableResourceValue +
      ResourceRestrictionValue +
      BrokenSessionValue;
end;

function TTimetable.NewBookmark: TBookmark;
begin
  Result := TTTBookmark.Create(Self, RandomIndexes(TTimetableModel(Model).ClusterCount));
end;

destructor TTimetable.Destroy;
begin
  TablingInfo.Free;
  inherited Destroy;
end;

procedure TTimetable.Assign(AIndividual: TIndividual);
var
  VCluster, Theme, Resource, Day: Integer;
  ATimetable: TTimetable;
begin
  inherited;
  ATimetable := TTimetable(AIndividual);
  with TTimetableModel(Model), TablingInfo do
  begin
    for VCluster := 0 to FClusterCount - 1 do
      Move(ATimetable.ClusterTimeSlotToSession[VCluster, 0],
        ClusterTimeSlotToSession[VCluster, 0], FTimeSlotCount * SizeOf(Integer));
    FClashTheme := ATimetable.TablingInfo.FClashTheme;
    FBreakTimetableResource := ATimetable.TablingInfo.FBreakTimetableResource;
    FOutOfPositionEmptyHour := ATimetable.TablingInfo.FOutOfPositionEmptyHour;
    FBrokenSession := ATimetable.TablingInfo.FBrokenSession;
    FNonScatteredTheme := ATimetable.TablingInfo.FNonScatteredTheme;
    FValue := ATimetable.FValue;
    // TablingInfo := ATimetable.TablingInfo;
    Move(ATimetable.TablingInfo.FClashResourceType[0],
         FClashResourceType[0], FResourceTypeCount * SizeOf(Integer));
    Move(ATimetable.TablingInfo.FResourceRestrictionTypeToResourceCount[0],
         FResourceRestrictionTypeToResourceCount[0], FResourceRestrictionTypeCount * SizeOf(Integer));
    Move(ATimetable.TablingInfo.FThemeRestrictionTypeToThemeCount[0],
         FThemeRestrictionTypeToThemeCount[0], FThemeRestrictionTypeCount * SizeOf(Integer));
    for Theme := 0 to FThemeCount - 1 do
      Move(ATimetable.TablingInfo.FThemeTimeSlotCount[Theme, 0],
           TablingInfo.FThemeTimeSlotCount[Theme, 0],
           FTimeSlotCount * SizeOf(Integer));
    for Resource := 0 to FResourceCount - 1 do
      Move(ATimetable.TablingInfo.FResourceTimeSlotCount[Resource, 0],
           TablingInfo.FResourceTimeSlotCount[Resource, 0],
           FTimeSlotCount * SizeOf(Integer));
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
      Move(ATimetable.TablingInfo.FResourceTimeSlotCount[Resource, 0],
        TablingInfo.FResourceTimeSlotCount[Resource, 0],
        FTimeSlotCount * SizeOf(Integer));
    for VCluster := 0 to FClusterCount - 1 do
      for Day := 0 to FDayCount - 1 do
      begin
        Move(ATimetable.TablingInfo.FClusterDayThemeCount[VCluster, Day, 0],
          TablingInfo.FClusterDayThemeCount[VCluster, Day, 0],
          FThemeCount * SizeOf(Integer));
        Move(ATimetable.TablingInfo.FClusterDayThemeAccumulated[VCluster, Day, 0],
          TablingInfo.FClusterDayThemeAccumulated[VCluster, Day, 0],
          FThemeCount * SizeOf(Integer));
      end;
  end;
end;

procedure TTimetable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  VCluster, TimeSlot: Integer;
begin
  VStrings := TStringList.Create;
  with TTimetableModel(Model) do
    try
      for VCluster := 0 to FClusterCount - 1 do
      begin
        VStrings.Add(Format('Cluster %d %d',
            [FCategoryToIdCategory[FClusterToCategory[VCluster]],
            FParallelToIdParallel[FClusterToParallel[VCluster]]]));
        for TimeSlot := 0 to FTimeSlotCount - 1 do
        begin
          VStrings.Add(Format(' Day %d Hour %d Theme %d', [FTimeSlotToDay[TimeSlot],
              FTimeSlotToHour[TimeSlot],
              FThemeToIdTheme[FSessionToTheme[ClusterTimeSlotToSession[
                VCluster, TimeSlot]]]]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;

procedure TTimetable.SaveToStream(Stream: TStream);
var
  VCluster: Integer;
begin
  with TTimetableModel(Model) do
    for VCluster := 0 to FClusterCount - 1 do
    begin
      Stream.Write(ClusterTimeSlotToSession[VCluster, 0], FTimeSlotCount * SizeOf(Integer));
    end;
end;

procedure TTimetable.LoadFromStream(Stream: TStream);
var
  VCluster: Integer;
begin
  with TTimetableModel(Model) do
    for VCluster := 0 to FClusterCount - 1 do
    begin
      Stream.Read(ClusterTimeSlotToSession[VCluster, 0], FTimeSlotCount * SizeOf(Integer));
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
    VCluster, TimeSlot, IdCategory, IdParallel, Session: Integer;
    {$IFNDEF USE_SQL}
    FieldTimetable, FieldCategory, FieldParallel, FieldDay, FieldHour,
      FieldTheme, FieldSession: TField;
    {$ENDIF}
  begin
  {$IFDEF USE_SQL}
      with TTimetableModel(Model) do
      for VCluster := 0 to FClusterCount - 1 do
      begin
        IdCategory := FCategoryToIdCategory[FClusterToCategory[VCluster]];
        IdParallel := FParallelToIdParallel[FClusterToParallel[VCluster]];
        for TimeSlot := 0 to FTimeSlotCount - 1 do
        begin
          Session := ClusterTimeSlotToSession[VCluster, TimeSlot];
          if Session >= 0 then
          begin
            SQL.Add(Format(
              'INSERT INTO TimetableDetail' +
              '(IdTimetable,IdCategory,IdParallel,IdDay,' +
              'IdHour,IdTheme,Session) VALUES (%d,%d,%d,%d,%d,%d,%d);',
              [IdTimetable, IdCategory, IdParallel,
              FDayToIdDay[FTimeSlotToDay[TimeSlot]],
              FHourToIdHour[FTimeSlotToHour[TimeSlot]],
              FThemeToIdTheme[FSessionToTheme[Session]],
              Session]));
          end;
        end;
      end;
    {$ELSE}
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
        with TTimetableModel(Model) do
        for VCluster := 0 to FClusterCount - 1 do
        begin
          IdCategory := FCategoryAIdCategory[FClusterACategory[VCluster]];
          IdParallel := FParallelAIdParallel[FClusterAParallel[VCluster]];
          for TimeSlot := 0 to FTimeSlotCount - 1 do
          begin
            Session := ClusterTimeSlotToSession[VCluster, TimeSlot];
            if Session >= 0 then
            begin
              Append;
              FieldTimetable.AsInteger := IdTimetable;
              FieldCategory.AsInteger := IdCategory;
              FieldParallel.AsInteger := IdParallel;
              FieldDay.AsInteger := FDayAIdDay[FTimeSlotADay[TimeSlot]];
              FieldHour.AsInteger := FHourAIdHour[FTimeSlotAHour[TimeSlot]];
              FieldTheme.AsInteger := FThemeAIdTheme[FSessionToTheme[Session]];
              FieldSession.AsInteger := Session;
              Post;
            end;
          end;
        end;
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
  FieldCategory, FieldParallel, FieldDay, FieldHour, FieldSession: TLongintField;
  VCluster, TimeSlot: Integer;
begin
  with SourceDataModule, TTimetableModel(Model), TbTimetableDetail do
  begin
    TbTimetable.Locate('IdTimetable', IdTimetable, []);
    LinkedFields := 'IdTimetable';
    MasterFields := 'IdTimetable';
    MasterSource := DSTimetable;
    try
      FieldCategory := FindField('IdCategory') as TLongintField;
      FieldParallel := FindField('IdParallel') as TLongintField;
      FieldDay := FindField('IdDay') as TLongintField;
      FieldHour := FindField('IdHour') as TLongintField;
      FieldSession := FindField('Session') as TLongintField;
      for VCluster := 0 to FClusterCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FClusterTimeSlotToSession[VCluster, TimeSlot] := -1;
      First;
      while not Eof do
      begin
        VCluster := FCategoryParallelToCluster[
          FIdCategoryToCategory[FieldCategory.AsInteger - FMinIdCategory],
          FIdParallelToParallel[FieldParallel.AsInteger - FMinIdParallel]];
        TimeSlot := FDayHourToTimeSlot[FIdDayToDay[FieldDay.AsInteger - FMinIdDay],
          FIdHourToHour[FieldHour.AsInteger - FMinIdHour]];
        FClusterTimeSlotToSession[VCluster, TimeSlot] := FieldSession.AsInteger;
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
  CheckIntegrity;
  {$ENDIF}
end;

procedure TTimetable.CheckIntegrity;
var
  Theme, VCluster, TimeSlot, Activity, Counter,
    Session: Integer;
  SessionFound: Boolean;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    for VCluster := 0 to FClusterCount - 1 do
      for TimeSlot := 0 to FTimeSlotCount - 1 do
      begin
        Session := FClusterTimeSlotToSession[VCluster, TimeSlot];
        if Session >= 0 then
        begin
          Theme := FSessionToTheme[Session];
          Activity := FClusterThemeToActivity[VCluster, Theme];
          SessionFound := False;
          for Counter := 0 to High(FActivityToSessions[Activity]) do
            SessionFound := SessionFound or (FActivityToSessions[Activity, Counter] = Session);
          if not SessionFound then
            raise Exception.CreateFmt('%s %d(%d,%d), %s %d(%d) %s FActivityToSessions', [
              SCluster, VCluster,
              FCategoryToIdCategory[FClusterToCategory[VCluster]],
              FParallelToIdParallel[FClusterToParallel[VCluster]],
              SFlActivity_IdTheme,
              Theme,
              FThemeToIdTheme[Theme],
              SDoNotAppearsIn]);
          if Activity < 0 then
            raise Exception.CreateFmt('%s %d(%d,%d), %s %d(%d) %s FClusterThemeToActivity', [
              SCluster, VCluster,
              FCategoryToIdCategory[FClusterToCategory[VCluster]],
              FParallelToIdParallel[FClusterToParallel[VCluster]],
              SFlActivity_IdTheme,
              Theme,
              FThemeToIdTheme[Theme],
              SDoNotAppearsIn]);
        end;
      end;
  end;
end;

procedure TTimetable.Reset;
var
  Resource, ResourceType, TimeSlot, Theme, ThemeRestrictionType,
    ResourceRestrictionType, VCluster, Day: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    FClashTheme := 0;
    FOutOfPositionEmptyHour := 0;
    FBreakTimetableResource := 0;
    FBrokenSession := 0;
    FNonScatteredTheme := 0;
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
    for TimeSlot := 0 to FTimeSlotCount - 1 do
    begin
      for Resource := 0 to FResourceCount - 1 do
        FResourceTimeSlotCount[Resource, TimeSlot] := 0;
      for Theme := 0 to FThemeCount - 1 do
        FThemeTimeSlotCount[Theme, TimeSlot] := 0;
    end;
    for VCluster := 0 to FClusterCount - 1 do
      for Day := 0 to FDayCount - 1 do
        for Theme := 0 to FThemeCount - 1 do
        begin
          FClusterDayThemeCount[VCluster, Day, Theme] := 0;
          FClusterDayThemeAccumulated[VCluster, Day, Theme] := 0;
        end;
  end;
end;

procedure TTimetable.Update;
var
  VCluster: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Reset;
    for VCluster := 0 to FClusterCount - 1 do
      DeltaValues(1, VCluster, 0, FTimeSlotCount - 1);
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

constructor TTTBookmark.Create(AIndividual: TIndividual; AClusters: TDynamicIntegerArray);
begin
  inherited Create;
  FIndividual := AIndividual;
  FClusters := AClusters;
  First;
end;

function TTTBookmark.Clone: TBookmark;
begin
  Result := TTTBookmark.Create(FIndividual, FClusters);
  TTTBookmark(Result).FPosition := FPosition;
  TTTBookmark(Result).FOffset := FOffset;
  TTTBookmark(Result).FTimeSlot1 := FTimeSlot1;
  TTTBookmark(Result).FTimeSlot2 := FTimeSlot2;
end;

function TTTBookmark.GetCluster: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod TTimetableModel(FIndividual.Model).ClusterCount;
  Result := FClusters[Index];
end;

procedure TTTBookmark.First;
begin
  FPosition := 0;
  FOffset := 0;
  FTimeSlot1 := 0;
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
    FTimeSlot2 := SessionToDuration[ClusterTimeSlotToSession[Cluster_, FTimeSlot1]];
end;

procedure NextTimeSlot(TimeSlotToSession: TDynamicIntegerArray; TimeSlotCount: Integer;
  var TimeSlot: Integer);
var
  Session: Integer;
begin
  Session := TimeSlotToSession[TimeSlot];
  if Session < 0 then
    Inc(TimeSlot)
  else
    repeat
      Inc(TimeSlot);
    until (TimeSlot >= TimeSlotCount)
      or (TimeSlotToSession[TimeSlot] <> Session);
end;

procedure FixTimeSlot(TimeSlotToSession: TDynamicIntegerArray; TimeSlotCount: Integer;
  var TimeSlot: Integer);
begin
  if TimeSlot > 0 then
  begin
    Dec(TimeSlot);
    NextTimeSlot(TimeSlotToSession, TimeSlotCount, TimeSlot);
  end;
end;


procedure TTTBookmark.Next;
var
  d1, d2: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    TimeSlotToSession := ClusterTimeSlotToSession[Cluster_];
    d1 := TimeSlotCount - SessionToDuration[TimeSlotToSession[TimeSlotCount - 1]];
    if FTimeSlot2 >= d1 then
    begin
      d2 := d1 - SessionToDuration[TimeSlotToSession[d1 - 1]];
      if FTimeSlot1 >= d2 then
      begin
        Inc(FPosition);
        FTimeSlot1 := 0;
        FTimeSlot2 := SessionToDuration[ClusterTimeSlotToSession[Cluster_, 0]];
      end
      else
      begin
        NextTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot1);
        FTimeSlot2 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]];
      end
    end
    else
    begin
      FixTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot1);
      if FTimeSlot2 <= FTimeSlot1 then
        FTimeSlot2 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]]
      else
        NextTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot2);
    end;
  end;
end;

procedure TTTBookmark.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark.GetProgress: Integer;
begin
  with TTimetableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * TimeSlotCount * (TimeSlotCount - 1) div 2 +
    (FTimeSlot1 * TimeSlotCount - FTimeSlot1 * (FTimeSlot1 + 1) div 2 + FTimeSlot2 - 1);
end;

function TTTBookmark.GetMax: Integer;
begin
  with TTimetableModel(FIndividual.Model) do
    Result := (FOffset + ClusterCount) * TimeSlotCount * (TimeSlotCount - 1) div 2;
end;

function TTTBookmark.Move: Integer;
begin
  Result := TTimetable(FIndividual).DoMove(Cluster_, FTimeSlot1, FTimeSlot2);
end;

function TTTBookmark.Undo: Integer;
begin
  Result := Move; // In this case, Move * Move = Identity, so Undo = Move
end;

function TTTBookmark.Eof: Boolean;
begin
  Result := FPosition = TTimetableModel(FIndividual.Model).ClusterCount;
end;

{ TTTBookmark2 }

constructor TTTBookmark2.Create(AIndividual: TIndividual; AClusters: TDynamicIntegerArray);
begin
  inherited Create;
  FIndividual := AIndividual;
  FClusters := AClusters;
  First;
end;

function TTTBookmark2.Clone: TBookmark;
begin
  Result := TTTBookmark2.Create(FIndividual, FClusters);
  TTTBookmark2(Result).FPosition := FPosition;
  TTTBookmark2(Result).FOffset := FOffset;
  TTTBookmark2(Result).FTimeSlot1 := FTimeSlot1;
  TTTBookmark2(Result).FTimeSlot2 := FTimeSlot2;
  TTTBookmark2(Result).FTimeSlot3 := FTimeSlot3;
end;

function TTTBookmark2.GetCluster: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod TTimetableModel(FIndividual.Model).ClusterCount;
  Result := FClusters[Index];
end;

procedure TTTBookmark2.First;
begin
  FPosition := 0;
  FOffset := 0;
  FProgress := 0;
  FTimeSlot1 := 0;
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
    FTimeSlot2 := SessionToDuration[ClusterTimeSlotToSession[Cluster_, 0]];
  FTimeSlot3 := FTimeSlot2;
end;

procedure TTTBookmark2.Next;
var
  d1, d2: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    TimeSlotToSession := ClusterTimeSlotToSession[Cluster_];
    d1 := TimeSlotCount - SessionToDuration[TimeSlotToSession[TimeSlotCount - 1]];
    if FTimeSlot3 >= d1 then
    begin
      if FTimeSlot2 >= d1 then
      begin
        d2 := d1 - SessionToDuration[TimeSlotToSession[d1 - 1]];
        if FTimeSlot1 >= d2 then
        begin
          Inc(FPosition);
          FTimeSlot1 := 0;
          FTimeSlot2 := SessionToDuration[ClusterTimeSlotToSession[Cluster_, 0]];
          FTimeSlot3 := FTimeSlot2;
        end
        else
        begin
          NextTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot1);
          FTimeSlot2 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]];
          FTimeSlot3 := FTimeSlot2;
        end;
      end
      else
      begin
        FixTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot1);
        if FTimeSlot2 <= FTimeSlot1 then
        begin
          FTimeSlot2 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]];
          FTimeSlot3 := FTimeSlot2;
        end
        else
        begin
          NextTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot2);
          FTimeSlot3 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]];
        end;
      end;
    end
    else
    begin
      FixTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot1);
      if FTimeSlot2 <= FTimeSlot1 then
        FTimeSlot2 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]]
      else
        FixTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot2);
      if FTimeSlot3 <= FTimeSlot1 then
        FTimeSlot3 := FTimeSlot1 + SessionToDuration[TimeSlotToSession[FTimeSlot1]]
      else
      begin
        NextTimeSlot(TimeSlotToSession, TimeSlotCount, FTimeSlot3);
      end;
    end;
  end;
end;

procedure TTTBookmark2.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark2.GetProgress: Integer;
begin
  with TTimetableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * ((TimeSlotCount * (TimeSlotCount - 1) div 2)
      * (2 * TimeSlotCount - 1) div 3) + TimeSlotCount * ( FTimeSlot1 * TimeSlotCount
      + FTimeSlot2 - (FTimeSlot1 + 1) * (FTimeSlot1 + 1) )
      - FTimeSlot2 * (FTimeSlot1 + 1) + (FTimeSlot1 * (FTimeSlot1 + 1) div 2)
      * (2 * FTimeSlot1 + 7) div 3 + FTimeSlot3;
  {Result := FProgress;
  with TTimetableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * ((TimeSlotCount * (TimeSlotCount - 1) div 2) *
      (2 * TimeSlotCount - 1) div 3) +
    (FTimeSlot1 * TimeSlotCount - FTimeSlot1 * (FTimeSlot1 + 1) div 2 + FTimeSlot2 - 1);}
end;

function TTTBookmark2.GetMax: Integer;
begin
  with TTimetableModel(FIndividual.Model) do
    Result := (FOffset + ClusterCount) * ((TimeSlotCount * (TimeSlotCount - 1) div 2) *
      (2 * TimeSlotCount - 1) div 3);
end;

function TTTBookmark2.Move: Integer;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    if FTimeSlot2 < FTimeSlot3 then
    begin
      Result := DoMove(Cluster_, FTimeSlot1, FTimeSlot2) + DoMove(Cluster_, FTimeSlot2, FTimeSlot3);
    end
    else if FTimeSlot2 = FTimeSlot3 then
    begin
      Result := DoMove(Cluster_, FTimeSlot1, FTimeSlot2);
      FTimeSlot3 := FTimeSlot2;
    end
    else
      Result := DoMove(Cluster_, FTimeSlot1, FTimeSlot3) + DoMove(Cluster_, FTimeSlot3, FTimeSlot2);
  end;
end;

function TTTBookmark2.Undo: Integer;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    if FTimeSlot2 < FTimeSlot3 then
    begin
      Result := DoMove(Cluster_, FTimeSlot2, FTimeSlot3) + DoMove(Cluster_, FTimeSlot1, FTimeSlot2);
    end
    else if FTimeSlot2 = FTimeSlot3 then
    begin
      Result := DoMove(Cluster_, FTimeSlot1, FTimeSlot2);
      FTimeSlot3 := FTimeSlot2;
    end
    else
      Result := DoMove(Cluster_, FTimeSlot3, FTimeSlot2) + DoMove(Cluster_, FTimeSlot1, FTimeSlot3);
  end;
end;

function TTTBookmark2.Eof: Boolean;
begin
  Result := FPosition = TTimetableModel(FIndividual.Model).ClusterCount;
end;

initialization

// SortLongint := QuicksortInteger;
// Sort := lQuicksort;
SortInteger := BubblesortInteger;
Sort := lBubblesort;

end.

