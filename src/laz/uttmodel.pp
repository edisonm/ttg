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
    FClashTeacherValue, FClashSubjectValue, FClashRoomTypeValue,
      FOutOfPositionEmptyHourValue, FBrokenSessionValue,
      FBreakTimetableTeacherValue, FNonScatteredSubjectValue: Integer;
    FTimeSlotToDay, FTimeSlotToHour, FDayToMaxTimeSlot, FSessionToDistribution,
      FSessionToSubject, FSessionToRoomType, FRoomTypeToNumber,
      FSubjectRestrictionToSubject, FSubjectRestrictionToTimeSlot,
      FSubjectRestrictionToSubjectRestrictionType, FAssistanceToDistribution,
      FAssistanceToTeacher, FTeacherRestrictionToTeacher, FTeacherRestrictionToTimeSlot,
      FTeacherRestrictionToTeacherRestrictionType, FDistributionToRoomType,
      FClassToCourse, FClassToLevel, FClassToGroupId, FDistributionToClass,
      FClassToSpecialization, FClassToSessionCount: TDynamicIntegerArray;
    FSubjectRestrictionTypeToValue, FTeacherRestrictionTypeToValue: TDynamicIntegerArray;
    FSubjectRestrictionToValue, FTeacherRestrictionToValue: TDynamicIntegerArray;
    FSessionToDuration: TSessionArray;
    FDayHourToTimeSlot, FLevelSpecializationToCourse, FCourseGroupIdToClass,
      FClassSubjectToTeacher, FClassSubjectToDistribution, FClassSubjectCount,
      FTimetableDetailPattern, FDistributionToSessions: TDynamicIntegerArrayArray;
    FTeacherTimeSlotToTeacherRestrictionType, FClassJoinedClassToDistribution,
      FClassJoinedClassToClass, FSubjectTimeSlotToSubjectRestrictionType: TDynamicIntegerArrayArray;
    FSubjectCount, FSubjectRestrictionTypeCount, FTeacherRestrictionTypeCount,
      FClassCount, FDayCount, FHourCount, FTimeSlotCount, FTeacherCount, FCourseCount,
      FLevelCount, FSpecializationCount, FRoomTypeCount, FDistributionCount,
      FAssistanceCount, FJoinedClassCount: Integer;
    FGroupIdToIdGroupId, FSubjectToIdSubject, FDayToIdDay, FHourToIdHour,
      FLevelToIdLevel, FSpecializationToIdSpecialization: TDynamicIntegerArray;
    FIdLevelToLevel, FIdSpecializationToSpecialization, FIdGroupIdToGroupId, FIdDayToDay,
      FIdHourToHour: TDynamicIntegerArray;
    FMinIdLevel, FMinIdSpecialization, FMinIdGroupId, FMinIdDay, FMinIdHour: Integer;
    FSessionNumberDouble: Integer;
    function GetDayAMaxTimeSlot(Day: Integer): Integer;
  protected
    property TimetableDetailPattern: TDynamicIntegerArrayArray read FTimetableDetailPattern;
    class function GetElitistCount: Integer; override;
  public
    procedure Configure(AClashTeacherValue, AClashSubjectValue, AClashRoomTypeValue,
      ABreakTimetableTeacherValue, AOutOfPositionEmptyHourValue, ABrokenSessionValue,
      ANonScatteredSubjectValue: Integer);
    constructor Create(AClashTeacherValue, AClashSubjectValue, AClashRoomTypeValue,
      ABreakTimetableTeacherValue, AOutOfPositionEmptyHourValue, ABrokenSessionValue,
      ANonScatteredSubjectValue: Integer);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TIndividual; override;
    property TimeSlotCount: Integer read FTimeSlotCount;
    property ClassCount: Integer read FClassCount;
    property ClashTeacherValue: Integer read FClashTeacherValue;
    property ClashSubjectValue: Integer read FClashSubjectValue;
    property BreakTimetableTeacherValue: Integer read FBreakTimetableTeacherValue;
    property ClashRoomTypeValue: Integer read FClashRoomTypeValue;
    property OutOfPositionEmptyHourValue: Integer read FOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read FBrokenSessionValue;
    property NonScatteredSubjectValue: Integer read FNonScatteredSubjectValue;
    property SessionNumberDouble: Integer read FSessionNumberDouble;
    property SessionToDuration: TSessionArray read FSessionToDuration;
    property ClassToSessionCount: TDynamicIntegerArray read FClassToSessionCount;
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
    - DONE Change implementation of NonScatteredSubject with a more compositional formula
    - DONE Remove FClassSubjectDay{Min,Max}Hour
    - DONE IncCount and DecCount must be methods


  *)
  { TTimetableTablingInfo }
  TTimetableTablingInfo = class
  protected
    FTeacherTimeSlotCount: TDynamicIntegerArrayArray;
    FSubjectTimeSlotCount: TDynamicIntegerArrayArray;
    FRoomTypeTimeSlotCount: TDynamicIntegerArrayArray;
    FClassDaySubjectCount: TDynamicIntegerArrayArrayArray;
    FClassDaySubjectAccumulated: TDynamicIntegerArrayArrayArray;
    FSubjectRestrictionTypeToSubjectCount: TDynamicIntegerArray;
    FTeacherRestrictionTypeATeacherCount: TDynamicIntegerArray;
    FDayTeacherMinHour: TDynamicIntegerArrayArray;
    FDayTeacherMaxHour: TDynamicIntegerArrayArray;
    FDayTeacherEmptyHourCount: TDynamicIntegerArrayArray;
    FClashTeacher: Integer;
    FClashSubject: Integer;
    FClashRoomType: Integer;
    FBreakTimetableTeacher: Integer;
    FOutOfPositionEmptyHour: Integer;
    FNonScatteredSubject: Integer;
    FBrokenSession: Integer;
  end;

  { TTimetable }

  TTimetable = class(TIndividual)
  private
    FTablingInfo: TTimetableTablingInfo;
    FClassTimeSlotToSession: TDynamicIntegerArrayArray;
    procedure CheckIntegrity;
    procedure CrossClass(Timetable2: TTimetable; AClass: Integer);
    procedure DeltaValues(Delta, AClass, TimeSlot1, TimeSlot2: Integer);
    function DeltaBrokenSession(AClass, TimeSlot1, TimeSlot2: Integer): Integer;
    function GetClashSubjectValue: Integer;
    function GetNonScatteredSubjectValue: Integer;
    function GetOutOfPositionEmptyHourValue: Integer;
    function GetClashTeacherValue: Integer;
    function GetSubjectRestrictionValue: Integer;
    function GetTeacherRestrictionValue: Integer;
    function GetBreakTimetableTeacherValue: Integer;
    function GetBrokenSessionValue: Integer;
    function GetClashRoomTypeValue: Integer;
    function GetValue: Integer;
    procedure RandomizeKey(var ARandomKey: TDynamicIntegerArray;
      AClass: Integer);
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

    procedure Normalize(AClass: Integer; var ATimeSlot: Integer);
    function InternalSwap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
    function Swap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
    function DoMove(AClass, ATimeSlot1: Integer; var ATimeSlot2: Integer): Integer;
    procedure SaveToFile(const AFileName: string);
    property OutOfPositionEmptyHour: Integer read FTablingInfo.FOutOfPositionEmptyHour;
    property SubjectRestrictionTypeToSubjectCount: TDynamicIntegerArray
      read FTablingInfo.FSubjectRestrictionTypeToSubjectCount;
    property TeacherRestrictionTypeATeacherCount: TDynamicIntegerArray
      read FTablingInfo.FTeacherRestrictionTypeATeacherCount;
    property NonScatteredSubject: Integer read FTablingInfo.FNonScatteredSubject;
    property BrokenSession: Integer read FTablingInfo.FBrokenSession;
    property ClashTeacher: Integer read FTablingInfo.FClashTeacher;
    property ClashSubject: Integer read FTablingInfo.FClashSubject;
    property ClashRoomType: Integer read FTablingInfo.FClashRoomType;
    property ClashTeacherValue: Integer read GetClashTeacherValue;
    property ClashSubjectValue: Integer read GetClashSubjectValue;
    property BreakTimetableTeacherValue: Integer read GetBreakTimetableTeacherValue;
    property ClashRoomTypeValue: Integer read GetClashRoomTypeValue;
    property OutOfPositionEmptyHourValue: Integer read GetOutOfPositionEmptyHourValue;
    property BrokenSessionValue: Integer read GetBrokenSessionValue;
    property NonScatteredSubjectValue: Integer read GetNonScatteredSubjectValue;
    property SubjectRestrictionValue: Integer read GetSubjectRestrictionValue;
    property TeacherRestrictionValue: Integer read GetTeacherRestrictionValue;
    property ClassTimeSlotToSession: TDynamicIntegerArrayArray
      read FClassTimeSlotToSession write FClassTimeSlotToSession;
    property BreakTimetableTeacher: Integer read FTablingInfo.FBreakTimetableTeacher;
    property TablingInfo: TTimetableTablingInfo read FTablingInfo;
  end;

  { TTTBookmark }

  TTTBookmark = class(TBookmark)
  private
    FIndividual: TIndividual;
    FClasses: TDynamicIntegerArray;
    FPosition, FOffset, FTimeSlot1, FTimeSlot2: Integer;
    function GetClass: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; AClasss: TDynamicIntegerArray); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Class_: Integer read GetClass;
    property Classes: TDynamicIntegerArray read FClasses;
    property Offset: Integer read FOffset write FOffset;
  end;

  { TTTBookmark2 }

  TTTBookmark2 = class(TBookmark)
  private
    FIndividual: TIndividual;
    FClasss: TDynamicIntegerArray;
    FPosition, FOffset, FProgress, FTimeSlot1, FTimeSlot2, FTimeSlot3: Integer;
    function GetClass: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(AIndividual: TIndividual; AClasss: TDynamicIntegerArray); overload;
    function Clone: TBookmark; override;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Undo: Integer; override;
    function Eof: Boolean; override;
    property Class_: Integer read GetClass;
    property Classs: TDynamicIntegerArray read FClasss;
    property Offset: Integer read FOffset write FOffset;
  end;

implementation

uses
  SysUtils, ZSysUtils, MTProcs, DSource, USortAlgs, UTTGConsts, dsourcebaseconsts;

constructor TTimetableModel.Create(AClashTeacherValue,
  AClashSubjectValue, AClashRoomTypeValue, ABreakTimetableTeacherValue,
  AOutOfPositionEmptyHourValue, ABrokenSessionValue, ANonScatteredSubjectValue: Integer);
var
  FMinIdTeacher, FMinIdSubject, FMinIdRoomType, FMinIdTeacherRestrictionType,
    FMinIdSubjectRestrictionType: Integer;
  FDistributionToSubject, FIdSubjectToSubject, FIdTeacherATeacher,
    FIdRoomTypeARoomType, FIdTeacherRestrictionTypeATeacherRestrictionType,
    FIdSubjectRestrictionTypeToSubjectRestrictionType, FClassToDuration,
    FDistributionToTeacher: TDynamicIntegerArray;
  FTeacherAIdTeacher, FTeacherRestrictionTypeAIdTeacherRestrictionType,
    FRoomTypeAIdRoomType, FSubjectRestrictionTypeAIdSubjectRestrictionType: TDynamicIntegerArray;
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
  procedure LoadCourse;
  var
    Course, Level, Specialization: Integer;
    VFieldLevel, VFieldSpecialization: TField;
  begin
    with SourceDataModule.TbCourse do
    begin
      IndexFieldNames := 'IdLevel;IdSpecialization';
      First;
      FCourseCount := RecordCount;
      SetLength(FLevelSpecializationToCourse, FLevelCount, FSpecializationCount);
      for Level := 0 to FLevelCount - 1 do
        for Specialization := 0 to FSpecializationCount - 1 do
          FLevelSpecializationToCourse[Level, Specialization] := -1;
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      for Course := 0 to FCourseCount - 1 do
      begin
        Level := FIdLevelToLevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationToSpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        FLevelSpecializationToCourse[Level, Specialization] := Course;
        Next;
      end;
      First;
    end;
  end;
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
  procedure LoadClass;
  var
    VClass, Course, GroupId, Level, Specialization: Integer;
    VFieldLevel, VFieldSpecialization, VFieldGroupId: TField;
  begin
    with SourceDataModule.TbClass do
    begin
      IndexFieldNames := 'IdLevel;IdSpecialization;IdGroupId';
      First;
      FClassCount := RecordCount;
      SetLength(FClassToCourse, FClassCount);
      SetLength(FClassToGroupId, FClassCount);
      SetLength(FClassToLevel, FClassCount);
      SetLength(FClassToSpecialization, FClassCount);
      SetLength(FCourseGroupIdToClass, FCourseCount, Length
          (FGroupIdToIdGroupId));
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      VFieldGroupId := FindField('IdGroupId');
      for VClass := 0 to FClassCount - 1 do
      begin
        Level := FIdLevelToLevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationToSpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        Course := FLevelSpecializationToCourse[Level, Specialization];
        GroupId := FIdGroupIdToGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        FClassToCourse[VClass] := Course;
        FClassToLevel[VClass] := Level;
        FClassToGroupId[VClass] := GroupId;
        FClassToSpecialization[VClass] := Specialization;
        FCourseGroupIdToClass[Course, GroupId] := VClass;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadRoomType;
  var
    RoomType: Integer;
    VFieldNumber: TField;
  begin
    with SourceDataModule.TbRoomType do
    begin
      IndexFieldNames := 'IdRoomType';
      First;
      SetLength(FRoomTypeToNumber, RecordCount);
      VFieldNumber := FindField('Number');
      for RoomType := 0 to RecordCount - 1 do
      begin
        FRoomTypeToNumber[RoomType] := VFieldNumber.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadSubjectRestrictionType;
  var
    SubjectRestrictionType: Integer;
    VFieldValue: TField;
  begin
    with SourceDataModule.TbSubjectRestrictionType do
    begin
      IndexFieldNames := 'IdSubjectRestrictionType';
      First;
      VFieldValue := FindField('ValSubjectRestrictionType');
      SetLength(FSubjectRestrictionTypeToValue, RecordCount);
      for SubjectRestrictionType := 0 to RecordCount - 1 do
      begin
        FSubjectRestrictionTypeToValue[SubjectRestrictionType] := VFieldValue.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadTeacherRestrictionType;
  var
    TeacherRestrictionType: Integer;
    VFieldValue: TField;
  begin
    with SourceDataModule.TbTeacherRestrictionType do
    begin
      IndexFieldNames := 'IdTeacherRestrictionType';
      First;
      VFieldValue := FindField('ValTeacherRestrictionType');
      SetLength(FTeacherRestrictionTypeToValue, RecordCount);
      for TeacherRestrictionType := 0 to RecordCount - 1 do
      begin
        FTeacherRestrictionTypeToValue[TeacherRestrictionType] := VFieldValue.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadSubjectRestriction;
  var
    Subject, SubjectRestriction, TimeSlot, SubjectRestrictionType: Integer;
    VFieldSubject, VFieldDay, VFieldHour, VFieldSubjectRestrictionType: TField;
  begin
    with SourceDataModule.TbSubjectRestriction do
    begin
      IndexFieldNames := 'IdSubject;IdDay;IdHour';
      First;
      SetLength(FSubjectRestrictionToSubject, RecordCount);
      SetLength(FSubjectRestrictionToTimeSlot, RecordCount);
      SetLength(FSubjectRestrictionToSubjectRestrictionType, RecordCount);
      SetLength(FSubjectRestrictionToValue, RecordCount);
      SetLength(FSubjectTimeSlotToSubjectRestrictionType, FSubjectCount,
        FTimeSlotCount);
      for Subject := 0 to FSubjectCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FSubjectTimeSlotToSubjectRestrictionType[Subject, TimeSlot] := -1;
      VFieldSubject := FindField('IdSubject');
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      VFieldSubjectRestrictionType := FindField('IdSubjectRestrictionType');
      for SubjectRestriction := 0 to RecordCount - 1 do
      begin
        Subject := FIdSubjectToSubject[VFieldSubject.AsInteger - FMinIdSubject];
        TimeSlot := FDayHourToTimeSlot[FIdDayToDay[VFieldDay.AsInteger - FMinIdDay],
          FIdHourToHour[VFieldHour.AsInteger - FMinIdHour]];
        SubjectRestrictionType := FIdSubjectRestrictionTypeToSubjectRestrictionType
          [VFieldSubjectRestrictionType.AsInteger - FMinIdSubjectRestrictionType];
        FSubjectRestrictionToSubject[SubjectRestriction] := Subject;
        FSubjectRestrictionToTimeSlot[SubjectRestriction] := TimeSlot;
        FSubjectRestrictionToSubjectRestrictionType[Subject] := SubjectRestrictionType;
        FSubjectRestrictionToValue[SubjectRestriction] := FSubjectRestrictionTypeToValue[SubjectRestrictionType];
        FSubjectTimeSlotToSubjectRestrictionType[Subject, TimeSlot] := SubjectRestrictionType;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadTeacherRestriction;
  var
    TeacherRestriction, Teacher, TimeSlot, Day, Hour,
      TeacherRestrictionType, Value: Integer;
    VFieldTeacher, VFieldDay, VFieldHour,
      VFieldTeacherRestrictionType: TField;
  begin
    with SourceDataModule.TbTeacherRestriction do
    begin
      IndexFieldNames := 'IdTeacher;IdDay;IdHour';
      First;
      SetLength(FTeacherRestrictionToTeacher, RecordCount);
      SetLength(FTeacherRestrictionToTimeSlot, RecordCount);
      SetLength(FTeacherRestrictionToTeacherRestrictionType, RecordCount);
      SetLength(FTeacherRestrictionToValue, RecordCount);
      SetLength(FTeacherTimeSlotToTeacherRestrictionType, FTeacherCount,
        FTimeSlotCount);
      for Teacher := 0 to FTeacherCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FTeacherTimeSlotToTeacherRestrictionType[Teacher, TimeSlot] := -1;
      VFieldTeacher := FindField('IdTeacher');
      VFieldHour := FindField('IdHour');
      VFieldDay := FindField('IdDay');
      VFieldTeacherRestrictionType := FindField('IdTeacherRestrictionType');
      for TeacherRestriction := 0 to RecordCount - 1 do
      begin
        Teacher := FIdTeacherATeacher[VFieldTeacher.AsInteger - FMinIdTeacher];
        Day := FIdDayToDay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourToHour[VFieldHour.AsInteger - FMinIdHour];
        TimeSlot := FDayHourToTimeSlot[Day, Hour];
        TeacherRestrictionType := FIdTeacherRestrictionTypeATeacherRestrictionType
          [VFieldTeacherRestrictionType.AsInteger -
          FMinIdTeacherRestrictionType];
        FTeacherRestrictionToTeacher[TeacherRestriction] := Teacher;
        FTeacherRestrictionToTimeSlot[TeacherRestriction] := TimeSlot;
        FTeacherRestrictionToTeacherRestrictionType[TeacherRestriction] := TeacherRestrictionType;
        Value := FTeacherRestrictionTypeToValue[TeacherRestrictionType];
        FTeacherRestrictionToValue[TeacherRestriction] := Value;
        FTeacherTimeSlotToTeacherRestrictionType[Teacher, TimeSlot] := TeacherRestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure LoadDistribution;
  var
    Subject, Level, Specialization, GroupId, Session1, Distribution,
      VClass, Teacher, Course, Session2, Session, RoomType, VPos: Integer;
    VFieldSubject, VFieldLevel, VFieldGroupId, VFieldTeacher,
      VFieldSpecialization, VFieldRoomType, VFieldComposition: TField;
    VSessionToDuration, VSessionToDistribution: array [0 .. 16383] of Integer;
    Composition: string;
  begin
    with SourceDataModule.TbDistribution do
    begin
      IndexFieldNames := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
      First;
      VFieldSubject := FindField('IdSubject');
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      VFieldGroupId := FindField('IdGroupId');
      VFieldTeacher := FindField('IdTeacher');
      VFieldRoomType := FindField('IdRoomType');
      VFieldComposition := FindField('Composition');
      FDistributionCount := RecordCount;
      // SetLength(FDistributionAAsignatura, RecordCount);
      SetLength(FDistributionToClass, FDistributionCount);
      SetLength(FDistributionToTeacher, FDistributionCount);
      SetLength(FDistributionToRoomType, FDistributionCount);
      SetLength(FDistributionToSessions, FDistributionCount);
      SetLength(FDistributionToSubject, FDistributionCount);
      SetLength(FClassSubjectToTeacher, FClassCount, FSubjectCount);
      SetLength(FClassSubjectCount, FClassCount, FSubjectCount);
      SetLength(FClassSubjectToDistribution, FClassCount, FSubjectCount);
      for VClass := 0 to FClassCount - 1 do
        for Subject := 0 to FSubjectCount - 1 do
        begin
          FClassSubjectCount[VClass, Subject] := 0;
          FClassSubjectToDistribution[VClass, Subject] := -1;
          FClassSubjectToTeacher[VClass, Subject] := -1;
        end;
      Session2 := 0;
      for Distribution := 0 to RecordCount - 1 do
      begin
        Subject := FIdSubjectToSubject[VFieldSubject.AsInteger - FMinIdSubject];
        Level := FIdLevelToLevel[VFieldLevel.AsInteger - FMinIdLevel];
        GroupId := FIdGroupIdToGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        Specialization := FIdSpecializationToSpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        RoomType := FIdRoomTypeARoomType[VFieldRoomType.AsInteger - FMinIdRoomType];
        Course := FLevelSpecializationToCourse[Level, Specialization];
        VClass := FCourseGroupIdToClass[Course, GroupId];
        Teacher := FIdTeacherATeacher[VFieldTeacher.AsInteger - FMinIdTeacher];
        FDistributionToClass[Distribution] := VClass;
        FDistributionToTeacher[Distribution] := Teacher;
        FDistributionToRoomType[Distribution] := RoomType;
        FDistributionToSubject[Distribution] := Subject;
        FClassSubjectToTeacher[VClass, Subject] := Teacher;
        FClassSubjectToDistribution[VClass, Subject] := Distribution;
        Composition := VFieldComposition.AsString;
        VPos := 1;
        Session1 := Session2;
        // t := 0;
        while VPos <= Length(Composition) do
        begin
          VSessionToDuration[Session2] := StrToInt(ExtractString(Composition, VPos, '.'));
          VSessionToDistribution[Session2] := Distribution;
          Inc(FClassSubjectCount[VClass, Subject]);
          // Inc(t, VSessionToDuration[Session2]);
          Inc(Session2);
        end;
        SetLength(FDistributionToSessions[Distribution], Session2 - Session1);
        for Session := Session1 to Session2 - 1 do
        begin
          FDistributionToSessions[Distribution, Session - Session1] := Session;
        end;
        // FClassToDuration[VClass] := FClassToDuration[VClass] + t;
        Next;
      end;
      SetLength(FSessionToDistribution, Session2);
      SetLength(FSessionToSubject, Session2);
      SetLength(FSessionToRoomType, Session2);
      Move(VSessionToDuration[0], FSessionToDuration[0], Session2 * SizeOf(Integer));
      FSessionToDuration[-1] := 1;
      Move(VSessionToDistribution[0], FSessionToDistribution[0],
        Session2 * SizeOf(Integer));
      for Session := 0 to Session2 - 1 do
      begin
        Distribution := FSessionToDistribution[Session];
        FSessionToSubject[Session] := FDistributionToSubject[Distribution];
        FSessionToRoomType[Session] := FDistributionToRoomType[Distribution];
      end;
    end;
  end;
  procedure LoadAssistance;
  var
    Assistance, VClass, Course, GroupId, Level, Specialization, Subject,
    Distribution, Teacher: Integer;
    VFieldSubject, VFieldLevel, VFieldSpecialization, VFieldGroupId,
    VFieldTeacher: TField;
  begin
    with SourceDataModule.TbAssistance do
    begin
      IndexFieldNames := 'IdSubject;IdLevel;IdSpecialization;IdGroupId;IdTeacher';
      First;
      FAssistanceCount := RecordCount;
      SetLength(FAssistanceToDistribution, FAssistanceCount);
      SetLength(FAssistanceToTeacher, FAssistanceCount);
      VFieldSubject := FindField('IdSubject');
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      VFieldGroupId := FindField('IdGroupId');
      VFieldTeacher := FindField('IdTeacher');
      for Assistance := 0 to FAssistanceCount - 1 do
      begin
        Subject := FIdSubjectToSubject[VFieldSubject.AsInteger - FMinIdSubject];
        Level := FIdLevelToLevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationToSpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        Course := FLevelSpecializationToCourse[Level, Specialization];
        GroupId := FIdGroupIdToGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        VClass := FCourseGroupIdToClass[Course, GroupId];
        Distribution := FClassSubjectToDistribution[VClass, Subject];
        Teacher := FIdTeacherATeacher[VFieldTeacher.AsInteger - FMinIdTeacher];
        FAssistanceToDistribution[Assistance] := Distribution;
        FAssistanceToTeacher[Assistance] := Teacher;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadJoinedClass;
  var
    JoinedClass, Counter, VClass1, Course1, GroupId1, Level1, Specialization1, VClass,
    Course, GroupId, Level, Specialization, Subject,  Distribution: Integer;
    VFieldSubject, VFieldLevel, VFieldSpecialization, VFieldGroupId,
    VFieldLevel1, VFieldSpecialization1, VFieldGroupId1: TField;
  begin
    with SourceDataModule.TbJoinedClass do
    begin
      IndexFieldNames := 'IdSubject;IdLevel;IdSpecialization;IdGroupId;IdLevel1;IdSpecialization1;IdGroupId1';
      First;
      FJoinedClassCount := RecordCount;
      SetLength(FClassJoinedClassToDistribution, FClassCount, 0);
      SetLength(FClassJoinedClassToClass, FClassCount, 0);
      VFieldSubject := FindField('IdSubject');
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      VFieldGroupId := FindField('IdGroupId');
      VFieldLevel1 := FindField('IdLevel1');
      VFieldSpecialization1 := FindField('IdSpecialization1');
      VFieldGroupId1 := FindField('IdGroupId1');
      for JoinedClass := 0 to FJoinedClassCount - 1 do
      begin
        Subject := FIdSubjectToSubject[VFieldSubject.AsInteger - FMinIdSubject];
        Level := FIdLevelToLevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationToSpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        Course := FLevelSpecializationToCourse[Level, Specialization];
        GroupId := FIdGroupIdToGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        VClass := FCourseGroupIdToClass[Course, GroupId];
        Distribution := FClassSubjectToDistribution[VClass, Subject];
        Level1 := FIdLevelToLevel[VFieldLevel1.AsInteger - FMinIdLevel];
        Specialization1 := FIdSpecializationToSpecialization
          [VFieldSpecialization1.AsInteger - FMinIdSpecialization];
        Course1 := FLevelSpecializationToCourse[Level1, Specialization1];
        GroupId1 := FIdGroupIdToGroupId[VFieldGroupId1.AsInteger -
          FMinIdGroupId];
        VClass1 := FCourseGroupIdToClass[Course1, GroupId1];
        Counter := Length(FClassJoinedClassToDistribution[VClass]);
        SetLength(FClassJoinedClassToDistribution[VClass], Counter + 1);
        SetLength(FClassJoinedClassToClass[VClass], Counter + 1);
        FClassJoinedClassToDistribution[VClass, Counter] := Distribution;
        FClassJoinedClassToClass[VClass, Counter] := VClass1;
        Next;
      end;
      First;
    end;
  end;
  procedure LoadPatternTimetableDetail;
  var
    TimeSlot1, VClass, Distribution, TimeSlot, Contador, Duration, Number: Integer;
  begin
    SetLength(FTimetableDetailPattern, FClassCount, FTimeSlotCount);
    SetLength(FClassToSessionCount, FClassCount);
    SetLength(FClassToDuration, FClassCount);
    for VClass := 0 to FClassCount - 1 do
    begin
      FClassToDuration[VClass] := 0;
      FClassToSessionCount[VClass] := 0;
      for TimeSlot := 0 to FTimeSlotCount - 1 do
      begin
        FTimetableDetailPattern[VClass, TimeSlot] := -1;
      end;
    end;
    for Distribution := FDistributionCount - 1 downto 0 do
    begin
      VClass := FDistributionToClass[Distribution];
      for Contador := High(FDistributionToSessions[Distribution]) downto 0 do
      begin
        Duration := FSessionToDuration[FDistributionToSessions[Distribution, Contador]];
        TimeSlot1 := FClassToDuration[VClass];
        for TimeSlot := TimeSlot1 to TimeSlot1 + Duration - 1 do
        begin
          if (TimeSlot < 0) or (TimeSlot >= FTimeSlotCount) then
            raise Exception.CreateFmt(SClassTimeSlotToSessionOverflow,
              [FClassToLevel[VClass], FClassToGroupId[VClass], TimeSlot]);
          FTimetableDetailPattern[VClass, FTimeSlotCount - 1 - TimeSlot]
            := FDistributionToSessions[Distribution, Contador];
        end;
        Inc(FClassToDuration[VClass], Duration);
      end;
    end;
    for VClass := 0 to FClassCount - 1 do
    begin
      TimeSlot := 0;
      while TimeSlot < FTimeSlotCount do
      begin
        Duration := FSessionToDuration[FTimetableDetailPattern[VClass, TimeSlot]];
        Inc(TimeSlot, Duration);
        Inc(FClassToSessionCount[VClass]);
      end;
    end;
    FSessionNumberDouble := 0;
    for VClass := 0 to FClassCount - 1 do
    begin
      Number := FClassToSessionCount[VClass];
      Inc(FSessionNumberDouble, (Number * (Number - 1)) div 2);
    end;
  end;
begin
  inherited Create;
  with SourceDataModule do
  begin
    Configure(AClashTeacherValue, AClashSubjectValue, AClashRoomTypeValue,
      ABreakTimetableTeacherValue, AOutOfPositionEmptyHourValue,
      ABrokenSessionValue, ANonScatteredSubjectValue);
    Load(TbTeacher, 'IdTeacher', FMinIdTeacher, FIdTeacherATeacher,
      FTeacherAIdTeacher);
    FTeacherCount := Length(FTeacherAIdTeacher);
    Load(TbLevel, 'IdLevel', FMinIdLevel, FIdLevelToLevel, FLevelToIdLevel);
    FLevelCount := Length(FLevelToIdLevel);
    Load(TbSpecialization, 'IdSpecialization', FMinIdSpecialization,
      FIdSpecializationToSpecialization, FSpecializationToIdSpecialization);
    FSpecializationCount := Length(FSpecializationToIdSpecialization);
    LoadCourse;
    Load(TbGroupId, 'IdGroupId', FMinIdGroupId,
      FIdGroupIdToGroupId, FGroupIdToIdGroupId);
    Load(TbSubject, 'IdSubject', FMinIdSubject, FIdSubjectToSubject,
      FSubjectToIdSubject);
    FSubjectCount := Length(FSubjectToIdSubject);
    Load(TbDay, 'IdDay', FMinIdDay, FIdDayToDay, FDayToIdDay);
    FDayCount := Length(FDayToIdDay);
    Load(TbHour, 'IdHour', FMinIdHour, FIdHourToHour, FHourToIdHour);
    FHourCount := Length(FHourToIdHour);
    Load(TbSubjectRestrictionType, 'IdSubjectRestrictionType',
      FMinIdSubjectRestrictionType,
      FIdSubjectRestrictionTypeToSubjectRestrictionType,
      FSubjectRestrictionTypeAIdSubjectRestrictionType);
    FSubjectRestrictionTypeCount := Length(FSubjectRestrictionTypeAIdSubjectRestrictionType);
    Load(TbTeacherRestrictionType, 'IdTeacherRestrictionType',
      FMinIdTeacherRestrictionType,
      FIdTeacherRestrictionTypeATeacherRestrictionType,
      FTeacherRestrictionTypeAIdTeacherRestrictionType);
    FTeacherRestrictionTypeCount := Length(FTeacherRestrictionTypeAIdTeacherRestrictionType);
    Load(TbRoomType, 'IdRoomType', FMinIdRoomType, FIdRoomTypeARoomType,
      FRoomTypeAIdRoomType);
    FRoomTypeCount := Length(FRoomTypeAIdRoomType);
    LoadTimeSlot;
    LoadClass;
    LoadRoomType;
    LoadSubjectRestrictionType;
    LoadTeacherRestrictionType;
    LoadSubjectRestriction;
    LoadTeacherRestriction;
    LoadDistribution;
    LoadAssistance;
    LoadJoinedClass;
    LoadPatternTimetableDetail;
  end;
end;

procedure TTimetableModel.Configure(AClashTeacherValue, AClashSubjectValue,
  AClashRoomTypeValue, ABreakTimetableTeacherValue, AOutOfPositionEmptyHourValue,
  ABrokenSessionValue, ANonScatteredSubjectValue: Integer);
begin
  FClashTeacherValue := AClashTeacherValue;
  FClashSubjectValue := AClashSubjectValue;
  FBreakTimetableTeacherValue := ABreakTimetableTeacherValue;
  FClashRoomTypeValue := AClashRoomTypeValue;
  FOutOfPositionEmptyHourValue := AOutOfPositionEmptyHourValue;
  FBrokenSessionValue := ABrokenSessionValue;
  FNonScatteredSubjectValue := ANonScatteredSubjectValue;
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
        '  %0:-29s %8.2f'#13#10 +
        '  %0:-29s %8.2f', [SWeights,
          SClashTeacher           + ':', ClashTeacherValue,
          SClashSubject           + ':', ClashSubjectValue,
          SClashRoomType          + ':', ClashRoomTypeValue,
          SBreakTimetableTeacher  + ':', BreakTimetableTeacherValue,
          SOutOfPositionEmptyHour + ':', OutOfPositionEmptyHourValue,
          SBrokenSession          + ':', BrokenSessionValue,
          SNonScatteredSubject    + ':', NonScatteredSubjectValue]));
end;

function TTimetableModel.NewIndividual: TIndividual;
begin
  Result := TTimetable.Create(Self);
end;

procedure TTimetable.RandomizeKey(var ARandomKey: TDynamicIntegerArray;
  AClass: Integer);
var
  TimeSlot, Duration, Counter, MaxTimeSlot: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  NumberList: array [0 .. 4095] of Integer;
begin
  with TTimetableModel(Model) do
  begin
    for Counter := 0 to FClassToSessionCount[AClass] - 1 do
      NumberList[Counter] := Random($7FFFFFFF);
    Sort(NumberList, 0, FClassToSessionCount[AClass] - 1);
    TimeSlotToSession := ClassTimeSlotToSession[AClass];
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

procedure TTimetable.CrossClass(Timetable2: TTimetable; AClass: Integer);
var
  Session, TimeSlot, Duration, Key1, Key2, MaxTimeSlot: Integer;
  RandomKey1, RandomKey2: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    SetLength(RandomKey1, FTimeSlotCount);
    RandomizeKey(RandomKey1, AClass);
    SortInteger(ClassTimeSlotToSession[AClass], RandomKey1, 0, FTimeSlotCount - 1);

    SetLength(RandomKey2, FTimeSlotCount);
    Timetable2.RandomizeKey(RandomKey2, AClass);
    SortInteger(Timetable2.ClassTimeSlotToSession[AClass], RandomKey2, 0, FTimeSlotCount - 1);

    TimeSlot := 0;
    while TimeSlot < FTimeSlotCount do
    begin
      Session := FTimetableDetailPattern[AClass, TimeSlot];
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
    SortInteger(RandomKey1, ClassTimeSlotToSession[AClass], 0, FTimeSlotCount - 1);
    SortInteger(RandomKey2, Timetable2.ClassTimeSlotToSession[AClass], 0,
      FTimeSlotCount - 1);
  end;
end;

procedure TTimetable.Cross(AIndividual: TIndividual);
var
  VClass: Integer;
begin
  with TTimetableModel(Model) do
  begin
    for VClass := 0 to FClassCount - 1 do
    begin
      CrossClass(TTimetable(AIndividual), VClass);
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
    SetLength(FClassTimeSlotToSession, FClassCount, FTimeSlotCount);
    FTablingInfo := TTimetableTablingInfo.Create;
    with TablingInfo do
    begin
      SetLength(FSubjectTimeSlotCount, FSubjectCount, FTimeSlotCount);
      SetLength(FTeacherTimeSlotCount, FTeacherCount, FTimeSlotCount);
      SetLength(FRoomTypeTimeSlotCount, FRoomTypeCount, FTimeSlotCount);
      SetLength(FClassDaySubjectCount, FClassCount, FDayCount, FSubjectCount);
      SetLength(FClassDaySubjectAccumulated, FClassCount, FDayCount, FSubjectCount);
      SetLength(FDayTeacherMinHour, FDayCount, FTeacherCount);
      SetLength(FDayTeacherMaxHour, FDayCount, FTeacherCount);
      SetLength(FDayTeacherEmptyHourCount, FDayCount, FTeacherCount);
      SetLength(FSubjectRestrictionTypeToSubjectCount, FSubjectRestrictionTypeCount);
      SetLength(FTeacherRestrictionTypeATeacherCount, FTeacherRestrictionTypeCount);
    end;
  end;
end;

function TTimetable.GetElitistValues(Index: Integer): Integer;
begin
  case Index of
    0: Result := BrokenSession;
    1: Result := ClashTeacher;
    2: Result := ClashRoomType;
  end;
end;

procedure TTimetable.MakeRandom;
var
  VClass, TimeSlot, Duration, MaxTimeSlot, RandomKey: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  RandomKeys: TDynamicIntegerArray;
begin
  with TTimetableModel(Model) do
  begin
    SetLength(RandomKeys, FTimeSlotCount);
    for VClass := 0 to FClassCount - 1 do
    begin
      TimeSlotToSession := ClassTimeSlotToSession[VClass];
      for TimeSlot := 0 to FTimeSlotCount - 1 do
        TimeSlotToSession[TimeSlot] := FTimetableDetailPattern[VClass, TimeSlot];
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

function TTimetable.Swap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
begin
  Normalize(AClass, ATimeSlot1);
  Normalize(AClass, ATimeSlot2);
  if ATimeSlot1 < ATimeSlot2 then
    Result := InternalSwap(AClass, ATimeSlot1, ATimeSlot2)
  else if ATimeSlot2 < ATimeSlot1 then
    Result := InternalSwap(AClass, ATimeSlot2, ATimeSlot1);
end;

function TTimetable.DoMove(AClass, ATimeSlot1: Integer; var ATimeSlot2: Integer): Integer;
var
  Duration1, Duration2: Integer;
begin
  with TTimetableModel(Model) do
  begin
    Duration1 := SessionToDuration[ClassTimeSlotToSession[AClass, ATimeSlot1]];
    Duration2 := SessionToDuration[ClassTimeSlotToSession[AClass, ATimeSlot2]];
  end;
  Result := InternalSwap(AClass, ATimeSlot1, ATimeSlot2);
  ATimeSlot2 := ATimeSlot2 + Duration2 - Duration1;
end;

procedure TTimetable.DeltaValues(Delta, AClass, TimeSlot1, TimeSlot2: Integer);
var
  SubjectRestrictionType, TeacherRestrictionType, TimeSlot, TimeSlot0, Day, DDay,
  Day1, Day2, Hour, Session, Teacher, RoomType, Duration, Subject, Limit, Assistance,
  JoinedClass, Distribution, DeltaBreakTimetableTeacher, MinTimeSlot, MaxTimeSlot,
  Class1: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
  SubjectATeacher: TDynamicIntegerArray;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Inc(FBrokenSession, Delta * DeltaBrokenSession(AClass, TimeSlot1, TimeSlot2));
    TimeSlotToSession := FClassTimeSlotToSession[AClass];
    SubjectATeacher := FClassSubjectToTeacher[AClass];
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    for TimeSlot := TimeSlot1 to TimeSlot2 do
    begin
      Session := TimeSlotToSession[TimeSlot];
      if Session >= 0 then
      begin
        Subject := FSessionToSubject[Session];
        Teacher := SubjectATeacher[Subject];
        RoomType := FSessionToRoomType[Session];
        Day := FTimeSlotToDay[TimeSlot];
        Hour := FTimeSlotToHour[TimeSlot];
        if FTeacherTimeSlotCount[Teacher, TimeSlot] = Limit then
        begin
          if Delta > 0 then
          begin
            if FDayTeacherMinHour[Day, Teacher] > FDayTeacherMaxHour[Day, Teacher] then
            begin
              FDayTeacherMinHour[Day, Teacher] := Hour;
              FDayTeacherMaxHour[Day, Teacher] := Hour;
            end
            else
            begin
              if Hour < FDayTeacherMinHour[Day, Teacher] then
              begin
                DeltaBreakTimetableTeacher := FDayTeacherMinHour[Day, Teacher] - Hour - 1;
                FDayTeacherMinHour[Day, Teacher] := Hour;
              end
              else if (FDayTeacherMinHour[Day, Teacher] <= Hour)
                  and (Hour <= FDayTeacherMaxHour[Day, Teacher]) then
                DeltaBreakTimetableTeacher := -1
              else // if FDayTeacherMaxTimeSlot[Day, Teacher] < TimeSlot then
              begin
                DeltaBreakTimetableTeacher := Hour - FDayTeacherMaxHour[Day, Teacher] - 1;
                FDayTeacherMaxHour[Day, Teacher] := Hour;
              end;
              Inc(FDayTeacherEmptyHourCount[Day, Teacher], DeltaBreakTimetableTeacher);
              Inc(FBreakTimetableTeacher, DeltaBreakTimetableTeacher);
            end;
          end
          else if Delta < 0 then
          begin
            if FDayTeacherMinHour[Day, Teacher] = FDayTeacherMaxHour[Day, Teacher] then
            begin
              FDayTeacherMinHour[Day, Teacher] := 1;
              FDayTeacherMaxHour[Day, Teacher] := 0;
            end
            else
            begin
              if Hour = FDayTeacherMinHour[Day, Teacher] then
              begin
                TimeSlot0 := TimeSlot + 1;
                MaxTimeSlot := FDayHourToTimeSlot[Day, FDayTeacherMaxHour[Day, Teacher]];
                while (TimeSlot0 <= MaxTimeSlot)
                    and (FTeacherTimeSlotCount[Teacher, TimeSlot0] = 0) do
                  Inc(TimeSlot0);
                DeltaBreakTimetableTeacher := Hour + 1 - FTimeSlotToHour[TimeSlot0];
                FDayTeacherMinHour[Day, Teacher] := FTimeSlotToHour[TimeSlot0];
              end
              else if (FDayTeacherMinHour[Day, Teacher] < Hour)
                  and (Hour < FDayTeacherMaxHour[Day, Teacher]) then
              begin
                DeltaBreakTimetableTeacher := 1;
              end
              else // if (FDayTeacherMaxTimeSlot[Day, Teacher] = TimeSlot) then
              begin
                TimeSlot0 := TimeSlot - 1;
                MinTimeSlot := FDayHourToTimeSlot[Day, FDayTeacherMinHour[Day, Teacher]];
                while (TimeSlot0 >= MinTimeSlot)
                    and (FTeacherTimeSlotCount[Teacher, TimeSlot0] = 0) do
                  Dec(TimeSlot0);
                DeltaBreakTimetableTeacher := FTimeSlotToHour[TimeSlot0] + 1 - Hour;
                FDayTeacherMaxHour[Day, Teacher] := FTimeSlotToHour[TimeSlot0];
              end;
              Inc(FDayTeacherEmptyHourCount[Day, Teacher], DeltaBreakTimetableTeacher);
              Inc(FBreakTimetableTeacher, DeltaBreakTimetableTeacher);
            end;
          end;
        end;
        if FTeacherTimeSlotCount[Teacher, TimeSlot] > Limit then
          Inc(FClashTeacher, Delta);
        Inc(FTeacherTimeSlotCount[Teacher, TimeSlot], Delta);
        Inc(FSubjectTimeSlotCount[Subject, TimeSlot], Delta);
        if FRoomTypeTimeSlotCount[RoomType, TimeSlot] >= FRoomTypeToNumber[RoomType] + Limit then
          Inc(FClashRoomType, Delta);
        Inc(FRoomTypeTimeSlotCount[RoomType, TimeSlot], Delta);
        SubjectRestrictionType := FSubjectTimeSlotToSubjectRestrictionType[Subject, TimeSlot];
        if SubjectRestrictionType >= 0 then
          Inc(FSubjectRestrictionTypeToSubjectCount[SubjectRestrictionType], Delta);
        TeacherRestrictionType := FTeacherTimeSlotToTeacherRestrictionType[Teacher, TimeSlot];
        if TeacherRestrictionType >= 0 then
          Inc(FTeacherRestrictionTypeATeacherCount[TeacherRestrictionType], Delta);
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
        Subject := FSessionToSubject[Session];
        Day1 := FTimeSlotToDay[TimeSlot];
        Day2 := FTimeSlotToDay[TimeSlot + Duration - 1];
        for Day := Day1 to Day2 do
        begin
          if FClassDaySubjectCount[AClass, Day, Subject] > Limit then
            Inc(FClashSubject, Delta);
          Inc(FClassDaySubjectCount[AClass, Day, Subject], Delta);
        end;
        DDay := FDayCount div FClassSubjectCount[AClass, Subject];
        for Day2 := Day1 to Day1 + DDay - 1 do
        begin
          Day := Day2 mod (FDayCount + 1);
          if Day <> FDayCount then
          begin
            if FClassDaySubjectAccumulated[AClass, Day, Subject] > Limit then
              Inc(FNonScatteredSubject, Delta);
            Inc(FClassDaySubjectAccumulated[AClass, Day, Subject], Delta);
          end;
        end;
      end;
      Inc(TimeSlot, Duration);
    end;
    for Assistance := 0 to FAssistanceCount - 1 do
    begin
      Distribution := FAssistanceToDistribution[Assistance];
      if AClass = FDistributionToClass[Distribution] then
      begin
        Teacher := FAssistanceToTeacher[Assistance];
        for TimeSlot := TimeSlot1 to TimeSlot2 do
        begin
          Session := TimeSlotToSession[TimeSlot];
          Duration := FSessionToDuration[Session];
          if Session >= 0 then
          begin
            if Distribution = FSessionToDistribution[Session] then
            begin
              if FTeacherTimeSlotCount[Teacher, TimeSlot] > Limit then
                Inc(FClashTeacher, Delta);
              Inc(FTeacherTimeSlotCount[Teacher, TimeSlot], Delta);
            end;
          end;
        end
      end;
    end;
    for JoinedClass := 0 to High(FClassJoinedClassToDistribution[AClass]) do
    begin
      Distribution := FClassJoinedClassToDistribution[AClass, JoinedClass];
      Class1 := FClassJoinedClassToClass[AClass, JoinedClass];
      for TimeSlot := TimeSlot1 to TimeSlot2 do
      begin
        Session := TimeSlotToSession[TimeSlot];
        Duration := FSessionToDuration[Session];
        if Session >= 0 then
        begin
          if Distribution = FSessionToDistribution[Session] then
          begin
            if FClassTimeSlotToSession[Class1, TimeSlot] >= 0 then
              Inc(FClashSubject, Delta);
          end;
        end;
      end;
    end;
  end;
end;

function TTimetable.InternalSwap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
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
  ClashTeacher2: Integer;
  ClashSubject2: Integer;
  ClashRoomType2: Integer;
  BreakTimetableTeacher2: Integer;
  OutOfPositionEmptyHour2: Integer;
  SubjectRestrictionValue2: Integer;
  NonScatteredSubject2: Integer;
  TeacherRestrictionValue2: Integer;
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
    TimeSlotToSession := ClassTimeSlotToSession[AClass];
    Session1 := TimeSlotToSession[ATimeSlot1];
    Session2 := TimeSlotToSession[ATimeSlot2];
    Duration1 := FSessionToDuration[Session1];
    Duration2 := FSessionToDuration[Session2];
    if (Duration1 = Duration2) then
    begin
      DeltaValues(-1, AClass, ATimeSlot1, ATimeSlot1 + Duration1 - 1);
      DeltaValues(-1, AClass, ATimeSlot2, ATimeSlot2 + Duration2 - 1);
      for TimeSlot := ATimeSlot1 to ATimeSlot1 + Duration2 - 1 do
        TimeSlotToSession[TimeSlot] := Session2;
      for TimeSlot := ATimeSlot2 to ATimeSlot2 + Duration2 - 1 do
        TimeSlotToSession[TimeSlot] := Session1;
      DeltaValues(1, AClass, ATimeSlot1, ATimeSlot1 + Duration1 - 1);
      DeltaValues(1, AClass, ATimeSlot2, ATimeSlot2 + Duration2 - 1);
    end
    else
    begin
      DeltaValues(-1, AClass, ATimeSlot1, ATimeSlot2 + Duration2 - 1);
      DoMovement;
      DeltaValues(1, AClass, ATimeSlot1, ATimeSlot2 + Duration2 - 1);
    end;
    FValue := GetValue;
    {$IFDEF DEBUG}
    ClashRoomType2 := FClashRoomType;
    ClashTeacher2 := FClashTeacher;
    ClashSubject2 := FClashSubject;
    OutOfPositionEmptyHour2 := FOutOfPositionEmptyHour;
    NonScatteredSubject2 := FNonScatteredSubject;
    SubjectRestrictionValue2 := SubjectRestrictionValue;
    BreakTimetableTeacher2 := FBreakTimetableTeacher;
    TeacherRestrictionValue2 := TeacherRestrictionValue;
    BrokenSession2 := FBrokenSession;
    Value2 := FValue;
    Update;
    if abs(FValue - Result - (Value2 - Value1)) > 0.000001 then
      raise Exception.CreateFmt(
      'Value1                  %f - %f'#13#10 +
      'Value2                  %f - %f'#13#10 +
      'ClashTeacher            %d - %d'#13#10 +
      'ClashSubject            %d - %d'#13#10 +
      'ClashRoomType           %d - %d'#13#10 +
      'OutOfPositionEmptyHour  %d - %d'#13#10 +
      'NonScatteredSubject     %d - %d'#13#10 +
      'SubjectRestrictionValue %f - %f'#13#10 +
      'BreakTimetableTeacher   %d - %d'#13#10 +
      'TeacherRestrictionValue %f - %f'#13#10 +
      'BrokenSession           %d - %d',
      [
        Result, Value1,
        FValue, Value2,
        FClashTeacher, ClashTeacher2,
        FClashSubject, ClashSubject2,
        FClashRoomType, ClashRoomType2,
        FOutOfPositionEmptyHour, OutOfPositionEmptyHour2,
        FNonScatteredSubject, NonScatteredSubject2,
        SubjectRestrictionValue, SubjectRestrictionValue2,
        FBreakTimetableTeacher, BreakTimetableTeacher2,
        TeacherRestrictionValue, TeacherRestrictionValue2,
        FBrokenSession, BrokenSession2
        ]);
    {$ENDIF}
    Result := FValue - Result;
  end;
end;

{WARNING!!! Normalize is a Kludge, avoid its usage!!!}
procedure TTimetable.Normalize(AClass: Integer; var ATimeSlot: Integer);
var
  Session: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  TimeSlotToSession := FClassTimeSlotToSession[AClass];
  Session := TimeSlotToSession[ATimeSlot];
  if Session >= 0 then
    while (ATimeSlot > 0) and (Session = TimeSlotToSession[ATimeSlot - 1]) do
      Dec(ATimeSlot);
end;

{Assembler version of Normalize}
(*
  procedure TTimetable.Normalize(AClass: Integer; var ATimeSlot: Integer); assembler;
  asm
  push    ebx
  mov     eax, [eax + FClassTimeSlotToSession]
  movsx   edx, AClass
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
    Add(Format(SRowFormat, [SClashTeacher + ':', FClashTeacher,
      TTimetableModel(Model).ClashTeacherValue, ClashTeacherValue]));
    Add(Format(SRowFormat, [SClashSubject + ':', FClashSubject,
      TTimetableModel(Model).ClashSubjectValue, ClashSubjectValue]));
    Add(Format(SRowFormat, [SClashRoomType + ':', FClashRoomType,
      TTimetableModel(Model).ClashRoomTypeValue, ClashRoomTypeValue]));
    Add(Format(SRowFormat, [SBreakTimetableTeacher + ':', BreakTimetableTeacher,
      TTimetableModel(Model).BreakTimetableTeacherValue, BreakTimetableTeacherValue]));
    Add(Format(SRowFormat, [SOutOfPositionEmptyHour + ':', OutOfPositionEmptyHour,
      TTimetableModel(Model).OutOfPositionEmptyHourValue, OutOfPositionEmptyHourValue]));
    Add(Format(SRowFormat, [SBrokenSession + ':', BrokenSession,
      TTimetableModel(Model).BrokenSessionValue, BrokenSessionValue]));
    Add(Format(SRowFormat, [SNonScatteredSubject + ':', NonScatteredSubject,
        TTimetableModel(Model).NonScatteredSubjectValue, NonScatteredSubjectValue]));
    Add(Format('%0:-28s %12s %12s %12d', [STbSubjectRestriction + ':',
         '(' + VarArrToStr(FSubjectRestrictionTypeToSubjectCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FSubjectRestrictionTypeToValue, ' ') + ')',
         SubjectRestrictionValue]));
    Add(Format('%0:-28s %12s %12s %12d', [STbTeacherRestriction + ':',
         '(' + VarArrToStr(FTeacherRestrictionTypeATeacherCount, ' ') + ')',
         '(' + VarArrToStr(TTimetableModel(Model).FTeacherRestrictionTypeToValue, ' ') + ')',
         TeacherRestrictionValue]));
    Add('-------------------------------------------------------------------');
    Add(Format('%0:-54s %12d', [STotalValue, Value]));
  end;
end;

procedure TTimetable.Mutate;
var
  VClass, TimeSlot1, TimeSlot2: Integer;
begin
  with TTimetableModel(Model) do
  begin
    TimeSlot1 := Random(FTimeSlotCount);
    TimeSlot2 := Random(FTimeSlotCount);
    VClass := Random(FClassCount);
    if ClassTimeSlotToSession[VClass, TimeSlot1]
    <> ClassTimeSlotToSession[VClass, TimeSlot2] then
      Swap(VClass, TimeSlot1, TimeSlot2);
  end;
end;

function TTimetable.GetOutOfPositionEmptyHourValue: Integer;
begin
  Result := TTimetableModel(Model).FOutOfPositionEmptyHourValue * OutOfPositionEmptyHour;
end;

function TTimetable.GetSubjectRestrictionValue: Integer;
var
  SubjectRestrictionType: Integer;
begin
  Result := 0;
  with TTimetableModel(Model), TablingInfo do
  for SubjectRestrictionType := 0 to FSubjectRestrictionTypeCount - 1 do
  begin
    Result := Result + FSubjectRestrictionTypeToSubjectCount[SubjectRestrictionType]
      * FSubjectRestrictionTypeToValue[SubjectRestrictionType];
  end;
end;

function TTimetable.GetTeacherRestrictionValue: Integer;
var
  TeacherRestrictionType: Integer;
begin
  Result := 0;
  with TTimetableModel(Model), TablingInfo do
  for TeacherRestrictionType := 0 to FTeacherRestrictionTypeCount - 1 do
  begin
    Result := Result + FTeacherRestrictionTypeATeacherCount[TeacherRestrictionType]
      * FTeacherRestrictionTypeToValue[TeacherRestrictionType];
  end;
end;

function TTimetable.GetBrokenSessionValue: Integer;
begin
  Result := TTimetableModel(Model).BrokenSessionValue * BrokenSession;
end;

function TTimetable.DeltaBrokenSession(AClass, TimeSlot1, TimeSlot2: Integer): Integer;
var
  TimeSlot, Hour1, Hour2, Day1, Day2, Session, Duration: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    TimeSlot := TimeSlot1;
    TimeSlotToSession := FClassTimeSlotToSession[AClass];
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

function TTimetable.GetNonScatteredSubjectValue: Integer;
begin
  Result := TTimetableModel(Model).NonScatteredSubjectValue * NonScatteredSubject;
end;

function TTimetable.GetClashTeacherValue: Integer;
begin
  Result := TTimetableModel(Model).ClashTeacherValue * TablingInfo.FClashTeacher;
end;

function TTimetable.GetClashSubjectValue: Integer;
begin
  Result := TTimetableModel(Model).ClashSubjectValue * TablingInfo.FClashSubject;
end;


function TTimetable.GetBreakTimetableTeacherValue: Integer;
begin
  Result := TTimetableModel(Model).BreakTimetableTeacherValue *
    TablingInfo.FBreakTimetableTeacher;
end;

function TTimetable.GetClashRoomTypeValue: Integer;
begin
  Result := TTimetableModel(Model).ClashRoomTypeValue * TablingInfo.FClashRoomType;
end;

function TTimetable.GetValue: Integer;
begin
  with TablingInfo do
    Result :=
      ClashRoomTypeValue +
      ClashTeacherValue +
      ClashSubjectValue +
      OutOfPositionEmptyHourValue +
      NonScatteredSubjectValue +
      SubjectRestrictionValue +
      BreakTimetableTeacherValue +
      TeacherRestrictionValue +
      BrokenSessionValue;
end;

function TTimetable.NewBookmark: TBookmark;
begin
  Result := TTTBookmark.Create(Self, RandomIndexes(TTimetableModel(Model).ClassCount));
end;

destructor TTimetable.Destroy;
begin
  TablingInfo.Free;
  inherited Destroy;
end;

procedure TTimetable.Assign(AIndividual: TIndividual);
var
  VClass, Subject, Teacher, RoomType, Day: Integer;
  ATimetable: TTimetable;
begin
  inherited;
  ATimetable := TTimetable(AIndividual);
  with TTimetableModel(Model), TablingInfo do
  begin
    for VClass := 0 to FClassCount - 1 do
      Move(ATimetable.ClassTimeSlotToSession[VClass, 0],
        ClassTimeSlotToSession[VClass, 0], FTimeSlotCount * SizeOf(Integer));
    FClashTeacher := ATimetable.TablingInfo.FClashTeacher;
    FClashSubject := ATimetable.TablingInfo.FClashSubject;
    FClashRoomType := ATimetable.TablingInfo.FClashRoomType;
    FBreakTimetableTeacher := ATimetable.TablingInfo.FBreakTimetableTeacher;
    FOutOfPositionEmptyHour := ATimetable.TablingInfo.FOutOfPositionEmptyHour;
    FBrokenSession := ATimetable.TablingInfo.FBrokenSession;
    FNonScatteredSubject := ATimetable.TablingInfo.FNonScatteredSubject;
    FValue := ATimetable.FValue;
    // TablingInfo := ATimetable.TablingInfo;
    Move(ATimetable.TablingInfo.FSubjectRestrictionTypeToSubjectCount[0],
      FSubjectRestrictionTypeToSubjectCount[0], FSubjectRestrictionTypeCount * SizeOf(Integer));
    Move(ATimetable.TablingInfo.FTeacherRestrictionTypeATeacherCount[0],
      FTeacherRestrictionTypeATeacherCount[0], FTeacherRestrictionTypeCount * SizeOf(Integer));
    for Subject := 0 to FSubjectCount - 1 do
      Move(ATimetable.TablingInfo.FSubjectTimeSlotCount[Subject, 0],
           TablingInfo.FSubjectTimeSlotCount[Subject, 0],
           FTimeSlotCount * SizeOf(Integer));
    for Teacher := 0 to FTeacherCount - 1 do
      Move(ATimetable.TablingInfo.FTeacherTimeSlotCount[Teacher, 0],
           TablingInfo.FTeacherTimeSlotCount[Teacher, 0],
           FTimeSlotCount * SizeOf(Integer));
    for Day := 0 to FDayCount - 1 do
    begin
      Move(ATimetable.TablingInfo.FDayTeacherMinHour[Day, 0],
        FDayTeacherMinHour[Day, 0], FTeacherCount * SizeOf(Integer));
      Move(ATimetable.TablingInfo.FDayTeacherMaxHour[Day, 0],
        FDayTeacherMaxHour[Day, 0], FTeacherCount * SizeOf(Integer));
      Move(ATimetable.TablingInfo.FDayTeacherEmptyHourCount[Day, 0],
        FDayTeacherEmptyHourCount[Day, 0], FTeacherCount * SizeOf(Integer));
    end;
    for RoomType := 0 to FRoomTypeCount - 1 do
      Move(ATimetable.TablingInfo.FRoomTypeTimeSlotCount[RoomType, 0],
        TablingInfo.FRoomTypeTimeSlotCount[RoomType, 0],
        FTimeSlotCount * SizeOf(Integer));
    for VClass := 0 to FClassCount - 1 do
      for Day := 0 to FDayCount - 1 do
      begin
        Move(ATimetable.TablingInfo.FClassDaySubjectCount[VClass, Day, 0],
          TablingInfo.FClassDaySubjectCount[VClass, Day, 0],
          FSubjectCount * SizeOf(Integer));
        Move(ATimetable.TablingInfo.FClassDaySubjectAccumulated[VClass, Day, 0],
          TablingInfo.FClassDaySubjectAccumulated[VClass, Day, 0],
          FSubjectCount * SizeOf(Integer));
      end;
  end;
end;

procedure TTimetable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  VClass, TimeSlot: Integer;
begin
  VStrings := TStringList.Create;
  with TTimetableModel(Model) do
    try
      for VClass := 0 to FClassCount - 1 do
      begin
        VStrings.Add(Format('Class %d %d %d',
            [FLevelToIdLevel[FClassToLevel[VClass]],
            FSpecializationToIdSpecialization[FClassToSpecialization[VClass]],
            FGroupIdToIdGroupId[FClassToGroupId[VClass]]]));
        for TimeSlot := 0 to FTimeSlotCount - 1 do
        begin
          VStrings.Add(Format(' Day %d Hour %d Subject %d', [FTimeSlotToDay[TimeSlot],
              FTimeSlotToHour[TimeSlot],
              FSubjectToIdSubject[FSessionToSubject[ClassTimeSlotToSession[
                VClass, TimeSlot]]]]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;

procedure TTimetable.SaveToStream(Stream: TStream);
var
  VClass: Integer;
begin
  with TTimetableModel(Model) do
    for VClass := 0 to FClassCount - 1 do
    begin
      Stream.Write(ClassTimeSlotToSession[VClass, 0], FTimeSlotCount * SizeOf(Integer));
    end;
end;

procedure TTimetable.LoadFromStream(Stream: TStream);
var
  VClass: Integer;
begin
  with TTimetableModel(Model) do
    for VClass := 0 to FClassCount - 1 do
    begin
      Stream.Read(ClassTimeSlotToSession[VClass, 0], FTimeSlotCount * SizeOf(Integer));
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
    VClass, TimeSlot, IdLevel, IdGroupId, IdSpecialization, Session: Integer;
    {$IFNDEF USE_SQL}
    FieldTimetable, FieldLevel, FieldGroupId, FieldSpecialization, FieldDay,
      FieldHour, FieldSubject, FieldSession: TField;
    {$ENDIF}
  begin
  {$IFDEF USE_SQL}
      with TTimetableModel(Model) do
      for VClass := 0 to FClassCount - 1 do
      begin
        IdLevel := FLevelToIdLevel[FClassToLevel[VClass]];
        IdGroupId := FGroupIdToIdGroupId[FClassToGroupId[VClass]];
        IdSpecialization := FSpecializationToIdSpecialization
          [FClassToSpecialization[VClass]];
        for TimeSlot := 0 to FTimeSlotCount - 1 do
        begin
          Session := ClassTimeSlotToSession[VClass, TimeSlot];
          if Session >= 0 then
          begin
            SQL.Add(Format(
              'INSERT INTO TimetableDetail' +
              '(IdTimetable,IdLevel,IdGroupId,IdSpecialization,IdDay,' +
              'IdHour,IdSubject,Session) VALUES (%d,%d,%d,%d,%d,%d,%d,%d);',
              [IdTimetable, IdLevel, IdGroupId, IdSpecialization,
              FDayToIdDay[FTimeSlotToDay[TimeSlot]],
              FHourToIdHour[FTimeSlotToHour[TimeSlot]],
              FSubjectToIdSubject[FSessionToSubject[Session]],
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
        FieldLevel := FindField('IdLevel');
        FieldGroupId := FindField('IdGroupId');
        FieldSpecialization := FindField('IdSpecialization');
        FieldDay := FindField('IdDay');
        FieldHour := FindField('IdHour');
        FieldSubject := FindField('IdSubject');
        FieldSession := FindField('Session');
        with TTimetableModel(Model) do
        for VClass := 0 to FClassCount - 1 do
        begin
          IdLevel := FLevelAIdLevel[FClassALevel[VClass]];
          IdGroupId := FGroupIdAIdGroupId[FClassAGroupId[VClass]];
          IdSpecialization := FSpecializationAIdSpecialization
            [FClassASpecialization[VClass]];
          for TimeSlot := 0 to FTimeSlotCount - 1 do
          begin
            Session := ClassTimeSlotToSession[VClass, TimeSlot];
            if Session >= 0 then
            begin
              Append;
              FieldTimetable.AsInteger := IdTimetable;
              FieldLevel.AsInteger := IdLevel;
              FieldGroupId.AsInteger := IdGroupId;
              FieldSpecialization.AsInteger := IdSpecialization;
              FieldDay.AsInteger := FDayAIdDay[FTimeSlotADay[TimeSlot]];
              FieldHour.AsInteger := FHourAIdHour[FTimeSlotAHour[TimeSlot]];
              FieldSubject.AsInteger := FSubjectAIdSubject[FSessionToSubject[Session]];
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
  FieldLevel, FieldGroupId, FieldSpecialization, FieldDay, FieldHour,
    FieldSession: TLongintField;
  VClass, TimeSlot: Integer;
begin
  with SourceDataModule, TTimetableModel(Model), TbTimetableDetail do
  begin
    TbTimetable.Locate('IdTimetable', IdTimetable, []);
    LinkedFields := 'IdTimetable';
    MasterFields := 'IdTimetable';
    MasterSource := DSTimetable;
    try
      FieldLevel := FindField('IdLevel') as TLongintField;
      FieldGroupId := FindField('IdGroupId') as TLongintField;
      FieldSpecialization := FindField('IdSpecialization') as TLongintField;
      FieldDay := FindField('IdDay') as TLongintField;
      FieldHour := FindField('IdHour') as TLongintField;
      FieldSession := FindField('Session') as TLongintField;
      for VClass := 0 to FClassCount - 1 do
        for TimeSlot := 0 to FTimeSlotCount - 1 do
          FClassTimeSlotToSession[VClass, TimeSlot] := -1;
      First;
      while not Eof do
      begin
        VClass := FCourseGroupIdToClass[
          FLevelSpecializationToCourse[
            FIdLevelToLevel[FieldLevel.AsInteger - FMinIdLevel],
            FIdSpecializationToSpecialization[FieldSpecialization.AsInteger -
            FMinIdSpecialization]],
          FIdGroupIdToGroupId[FieldGroupId.AsInteger -
          FMinIdGroupId]];
        TimeSlot := FDayHourToTimeSlot[FIdDayToDay[FieldDay.AsInteger - FMinIdDay],
          FIdHourToHour[FieldHour.AsInteger - FMinIdHour]];
        FClassTimeSlotToSession[VClass, TimeSlot] := FieldSession.AsInteger;
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
  Subject, VClass, TimeSlot, Teacher, Distribution, Counter,
    Session: Integer;
  SessionFound: Boolean;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    for VClass := 0 to FClassCount - 1 do
      for TimeSlot := 0 to FTimeSlotCount - 1 do
      begin
        Session := FClassTimeSlotToSession[VClass, TimeSlot];
        if Session >= 0 then
        begin
          Subject := FSessionToSubject[Session];
          Teacher := FClassSubjectToTeacher[VClass, Subject];
          if Teacher < 0 then
            raise Exception.CreateFmt('%s %d(%d,%d,%d), %s %d(%d) %s', [
              SClass, VClass,
              FLevelToIdLevel[FClassToLevel[VClass]],
              FSpecializationToIdSpecialization[FClassToSpecialization[VClass]],
              FGroupIdToIdGroupId[FClassToGroupId[VClass]],
              SFlDistribution_IdSubject,
              Subject,
              FSubjectToIdSubject[Subject],
              SDoNotHaveTeacher]);
          Distribution := FClassSubjectToDistribution[VClass, Subject];
          SessionFound := False;
          for Counter := 0 to High(FDistributionToSessions[Distribution]) do
            SessionFound := SessionFound or (FDistributionToSessions[Distribution, Counter] = Session);
          if not SessionFound then
            raise Exception.CreateFmt('%s %d(%d,%d,%d), %s %d(%d) %s FDistributionToSessions', [
              SClass, VClass,
              FLevelToIdLevel[FClassToLevel[VClass]],
              FSpecializationToIdSpecialization[FClassToSpecialization[VClass]],
              FGroupIdToIdGroupId[FClassToGroupId[VClass]],
              SFlDistribution_IdSubject,
              Subject,
              FSubjectToIdSubject[Subject],
              SDoNotAppearsIn]);
          if Distribution < 0 then
            raise Exception.CreateFmt('%s %d(%d,%d,%d), %s %d(%d) %s FClassSubjectToDistribution', [
              SClass, VClass,
              FLevelToIdLevel[FClassToLevel[VClass]],
              FSpecializationToIdSpecialization[FClassToSpecialization[VClass]],
              FGroupIdToIdGroupId[FClassToGroupId[VClass]],
              SFlDistribution_IdSubject,
              Subject,
              FSubjectToIdSubject[Subject],
              SDoNotAppearsIn]);
        end;
      end;
  end;
end;

procedure TTimetable.Reset;
var
  Teacher, TimeSlot, Subject, SubjectRestrictionType, TeacherRestrictionType,
    VClass, Day, RoomType: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    FClashTeacher := 0;
    FClashSubject := 0;
    FClashRoomType := 0;
    FOutOfPositionEmptyHour := 0;
    FBreakTimetableTeacher := 0;
    FBrokenSession := 0;
    FNonScatteredSubject := 0;
    for Day := 0 to FDayCount - 1 do
      for Teacher := 0 to FTeacherCount - 1 do
      begin
        FDayTeacherEmptyHourCount[Day, Teacher] := 0;
        FDayTeacherMinHour[Day, Teacher] := 1;
        FDayTeacherMaxHour[Day, Teacher] := 0;
      end;
    for SubjectRestrictionType := 0 to FSubjectRestrictionTypeCount - 1 do
      FSubjectRestrictionTypeToSubjectCount[SubjectRestrictionType] := 0;
    for TeacherRestrictionType := 0 to FTeacherRestrictionTypeCount - 1 do
      FTeacherRestrictionTypeATeacherCount[TeacherRestrictionType] := 0;
    for TimeSlot := 0 to FTimeSlotCount - 1 do
    begin
      for Teacher := 0 to FTeacherCount - 1 do
        FTeacherTimeSlotCount[Teacher, TimeSlot] := 0;
      for Subject := 0 to FSubjectCount - 1 do
        FSubjectTimeSlotCount[Subject, TimeSlot] := 0;
      for RoomType := 0 to FRoomTypeCount - 1 do
        FRoomTypeTimeSlotCount[RoomType, TimeSlot] := 0;
    end;
    for VClass := 0 to FClassCount - 1 do
      for Day := 0 to FDayCount - 1 do
        for Subject := 0 to FSubjectCount - 1 do
        begin
          FClassDaySubjectCount[VClass, Day, Subject] := 0;
          FClassDaySubjectAccumulated[VClass, Day, Subject] := 0;
        end;
  end;
end;

procedure TTimetable.Update;
var
  VClass: Integer;
begin
  with TTimetableModel(Model), TablingInfo do
  begin
    Reset;
    for VClass := 0 to FClassCount - 1 do
      DeltaValues(1, VClass, 0, FTimeSlotCount - 1);
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

class function TTimetableModel.GetElitistCount: Integer;
begin
  Result := 3;
end;

{ TTTBookmark }

constructor TTTBookmark.Create(AIndividual: TIndividual; AClasss: TDynamicIntegerArray);
begin
  inherited Create;
  FIndividual := AIndividual;
  FClasses := AClasss;
  First;
end;

function TTTBookmark.Clone: TBookmark;
begin
  Result := TTTBookmark.Create(FIndividual, FClasses);
  TTTBookmark(Result).FPosition := FPosition;
  TTTBookmark(Result).FOffset := FOffset;
  TTTBookmark(Result).FTimeSlot1 := FTimeSlot1;
  TTTBookmark(Result).FTimeSlot2 := FTimeSlot2;
end;

function TTTBookmark.GetClass: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod TTimetableModel(FIndividual.Model).ClassCount;
  Result := FClasses[Index];
end;

procedure TTTBookmark.First;
begin
  FPosition := 0;
  FOffset := 0;
  FTimeSlot1 := 0;
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
    FTimeSlot2 := SessionToDuration[ClassTimeSlotToSession[Class_, FTimeSlot1]];
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
    TimeSlotToSession := ClassTimeSlotToSession[Class_];
    d1 := TimeSlotCount - SessionToDuration[TimeSlotToSession[TimeSlotCount - 1]];
    if FTimeSlot2 >= d1 then
    begin
      d2 := d1 - SessionToDuration[TimeSlotToSession[d1 - 1]];
      if FTimeSlot1 >= d2 then
      begin
        Inc(FPosition);
        FTimeSlot1 := 0;
        FTimeSlot2 := SessionToDuration[ClassTimeSlotToSession[Class_, 0]];
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
    Result := (FOffset + ClassCount) * TimeSlotCount * (TimeSlotCount - 1) div 2;
end;

function TTTBookmark.Move: Integer;
begin
  Result := TTimetable(FIndividual).DoMove(Class_, FTimeSlot1, FTimeSlot2);
end;

function TTTBookmark.Undo: Integer;
begin
  Result := Move; // In this case, Move * Move = Identity, so Undo = Move
end;

function TTTBookmark.Eof: Boolean;
begin
  Result := FPosition = TTimetableModel(FIndividual.Model).ClassCount;
end;

{ TTTBookmark2 }

constructor TTTBookmark2.Create(AIndividual: TIndividual; AClasss: TDynamicIntegerArray);
begin
  inherited Create;
  FIndividual := AIndividual;
  FClasss := AClasss;
  First;
end;

function TTTBookmark2.Clone: TBookmark;
begin
  Result := TTTBookmark2.Create(FIndividual, FClasss);
  TTTBookmark2(Result).FPosition := FPosition;
  TTTBookmark2(Result).FOffset := FOffset;
  TTTBookmark2(Result).FTimeSlot1 := FTimeSlot1;
  TTTBookmark2(Result).FTimeSlot2 := FTimeSlot2;
  TTTBookmark2(Result).FTimeSlot3 := FTimeSlot3;
end;

function TTTBookmark2.GetClass: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod TTimetableModel(FIndividual.Model).ClassCount;
  Result := FClasss[Index];
end;

procedure TTTBookmark2.First;
begin
  FPosition := 0;
  FOffset := 0;
  FProgress := 0;
  FTimeSlot1 := 0;
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
    FTimeSlot2 := SessionToDuration[ClassTimeSlotToSession[Class_, 0]];
  FTimeSlot3 := FTimeSlot2;
end;

procedure TTTBookmark2.Next;
var
  d1, d2: Integer;
  TimeSlotToSession: TDynamicIntegerArray;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    TimeSlotToSession := ClassTimeSlotToSession[Class_];
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
          FTimeSlot2 := SessionToDuration[ClassTimeSlotToSession[Class_, 0]];
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
    Result := (FOffset + ClassCount) * ((TimeSlotCount * (TimeSlotCount - 1) div 2) *
      (2 * TimeSlotCount - 1) div 3);
end;

function TTTBookmark2.Move: Integer;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    if FTimeSlot2 < FTimeSlot3 then
    begin
      Result := DoMove(Class_, FTimeSlot1, FTimeSlot2) + DoMove(Class_, FTimeSlot2, FTimeSlot3);
    end
    else if FTimeSlot2 = FTimeSlot3 then
    begin
      Result := DoMove(Class_, FTimeSlot1, FTimeSlot2);
      FTimeSlot3 := FTimeSlot2;
    end
    else
      Result := DoMove(Class_, FTimeSlot1, FTimeSlot3) + DoMove(Class_, FTimeSlot3, FTimeSlot2);
  end;
end;

function TTTBookmark2.Undo: Integer;
begin
  with TTimetableModel(FIndividual.Model), TTimetable(FIndividual) do
  begin
    if FTimeSlot2 < FTimeSlot3 then
    begin
      Result := DoMove(Class_, FTimeSlot2, FTimeSlot3) + DoMove(Class_, FTimeSlot1, FTimeSlot2);
    end
    else if FTimeSlot2 = FTimeSlot3 then
    begin
      Result := DoMove(Class_, FTimeSlot1, FTimeSlot2);
      FTimeSlot3 := FTimeSlot2;
    end
    else
      Result := DoMove(Class_, FTimeSlot3, FTimeSlot2) + DoMove(Class_, FTimeSlot1, FTimeSlot3);
  end;
end;

function TTTBookmark2.Eof: Boolean;
begin
  Result := FPosition = TTimetableModel(FIndividual.Model).ClassCount;
end;

initialization

// SortLongint := QuicksortInteger;
// Sort := lQuicksort;
SortInteger := BubblesortInteger;
Sort := lBubblesort;

end.

