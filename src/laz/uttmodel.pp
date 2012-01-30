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
    Clase TTimeTableModel
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

  TTimeTable = class;
  TTimeTableArray = array of TTimeTable;

  TSessionArray = array [-1 .. 16382] of Integer;
  PSessionArray = ^TSessionArray;
  { TTimeTableModel }


  TTimeTableModel = class(TModel)
  private
    FClashTeacherValor, FClashSubjectValor, FClashRoomTypeValor,
      FHourHuecaDesubicadaValor, FSessionCortadaValor,
      FTeacherFraccionamientoValor, FSubjectNoDispersaValor: Integer;
    FTimeSlotADay, FTimeSlotAHour, FDayAMaxTimeSlot, FSessionADistribution,
      FSessionASubject, FSessionARoomType, FRoomTypeANumber,
      FSubjectRestrictionASubject, FSubjectRestrictionATimeSlot,
      FSubjectRestrictionASubjectRestrictionType,
      FTeacherRestrictionATeacher, FTeacherRestrictionATimeSlot,
      FTeacherRestrictionATeacherRestrictionType, FDistributionARoomType,
      FClassACourse, FClassALevel, FClassAGroupId,
      FClassASpecialization, FClassASessionCant: TDynamicIntegerArray;
    FSessionADuracion: TSessionArray;
    FDayHourATimeSlot, FLevelSpecializationACourse, FCourseGroupIdAClass,
      FClassSubjectATeacher, FClassSubjectADistribution, FClassSubjectCant,
      FTimeTableDetailPattern, FDistributionASessiones: TDynamicIntegerArrayArray;
    FTeacherTimeSlotATeacherRestrictionType,
      FSubjectTimeSlotASubjectRestrictionType: TDynamicIntegerArrayArray;
    FSubjectRestrictionTypeAValor, FTeacherRestrictionTypeAValor: TDynamicIntegerArray;
    FSubjectRestrictionAValor, FTeacherRestrictionAValor: TDynamicIntegerArray;
    FSubjectCant, FSubjectRestrictionTypeCant, FTeacherRestrictionTypeCant,
      FClassCant, FDayCant, FHourCant, FTimeSlotCant, FTeacherCant, FCourseCant,
      FLevelCant, FSpecializationCant, FRoomTypeCant, FDistributionCant: Integer;
    FGroupIdAIdGroupId, FSubjectAIdSubject, FDayAIdDay, FHourAIdHour,
      FLevelAIdLevel,
      FSpecializationAIdSpecialization: TDynamicIntegerArray;
    FIdLevelALevel, FIdSpecializationASpecialization,
      FIdGroupIdAGroupId, FIdDayADay,
      FIdHourAHour: TDynamicIntegerArray;
    FMinIdLevel, FMinIdSpecialization, FMinIdGroupId, FMinIdDay,
      FMinIdHour: Integer;
    FSessionNumberDoble: Integer;
    function GetDayAMaxTimeSlot(Day: Integer): Integer;
  protected
    property TimeTableDetailPattern: TDynamicIntegerArrayArray read FTimeTableDetailPattern;
    class function GetElitistCount: Integer; override;
  public
    procedure Configure(AClashTeacherValor, AClashSubjectValor,
      AClashRoomTypeValor, ATeacherFraccionamientoValor,
      AHourHuecaDesubicadaValor, ASessionCortadaValor, ASubjectNoDispersaValor: Integer);
    constructor Create(AClashTeacherValor, AClashSubjectValor,
      AClashRoomTypeValor, ATeacherFraccionamientoValor,
      AHourHuecaDesubicadaValor, ASessionCortadaValor, ASubjectNoDispersaValor: Integer);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TIndividual; override;
    property TimeSlotCant: Integer read FTimeSlotCant;
    property ClassCant: Integer read FClassCant;
    property ClashTeacherValor: Integer read FClashTeacherValor;
    property ClashSubjectValor: Integer read FClashSubjectValor;
    property TeacherFraccionamientoValor: Integer read FTeacherFraccionamientoValor;
    property ClashRoomTypeValor: Integer read FClashRoomTypeValor;
    property HourHuecaDesubicadaValor: Integer read FHourHuecaDesubicadaValor;
    property SessionCortadaValor: Integer read FSessionCortadaValor;
    property SubjectNoDispersaValor: Integer read FSubjectNoDispersaValor;
    property SessionNumberDoble: Integer read FSessionNumberDoble;
    property SessionADuracion: TSessionArray read FSessionADuracion;
    property ClassASessionCant: TDynamicIntegerArray read FClassASessionCant;
    property ElitistCount: Integer read GetElitistCount;
  end;

  // type
  // TCountFunc = procedure(Count, Cant: Integer) of object;
  {
    Clase TTimeTable
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
    en los operadores geneticos, como son cruce, mutacion, etc., TimeTableModel
    al que pertenece esta solucion.
  }

  { Manual Tabling:
    Here we have information that can be returned recalculating Values of the
    TTimeTable object, but that are preserved here in order to optimize
    computations.
  }
  (*

    TODO:
    2011-03-13:
    - DONE Change implementation of SubjectNoDispersa for a more compositional formula
    - DONE Remove FClassSubjectDay{Min,Max}Hour
    - DONE IncCant and DecCant must be methods


  *)
  { TTimeTableTablingInfo }
  TTimeTableTablingInfo = class
  protected
    FTeacherTimeSlotCant: TDynamicIntegerArrayArray;
    FSubjectTimeSlotCant: TDynamicIntegerArrayArray;
    FRoomTypeTimeSlotCant: TDynamicIntegerArrayArray;
    FClassDaySubjectCant: TDynamicIntegerArrayArrayArray;
    FClassDaySubjectAcum: TDynamicIntegerArrayArrayArray;
    FSubjectRestrictionTypeASubjectCant: TDynamicIntegerArray;
    FTeacherRestrictionTypeATeacherCant: TDynamicIntegerArray;
    FDayTeacherMinHour: TDynamicIntegerArrayArray;
    FDayTeacherMaxHour: TDynamicIntegerArrayArray;
    FDayTeacherHourHuecaCant: TDynamicIntegerArrayArray;
    FClashTeacher: Integer;
    FClashSubject: Integer;
    FClashRoomType: Integer;
    FTeacherFraccionamiento: Integer;
    FHourHuecaDesubicada: Integer;
    FSubjectNoDispersa: Integer;
    FSessionCortada: Integer;
  end;

  { TTimeTable }

  TTimeTable = class(TIndividual)
  private
    FTablingInfo: TTimeTableTablingInfo;
    FClassTimeSlotASession: TDynamicIntegerArrayArray;
    procedure CheckIntegrity;
    procedure CrossClass(TimeTable2: TTimeTable; AClass: Integer);
    procedure DeltaValues(Delta, AClass, TimeSlot1, TimeSlot2: Integer);
    function DeltaSessionCortada(AClass, TimeSlot1, TimeSlot2: Integer): Integer;
    function GetClashSubjectValor: Integer;
    function GetSubjectNoDispersaValor: Integer;
    function GetHourHuecaDesubicadaValor: Integer;
    function GetClashTeacherValor: Integer;
    function GetSubjectRestrictionValor: Integer;
    function GetTeacherRestrictionValor: Integer;
    function GetTeacherFraccionamientoValor: Integer;
    function GetSessionCortadaValor: Integer;
    function GetClashRoomTypeValor: Integer;
    function GetValue: Integer;
    procedure RandomizeKey(var ARandomKey: TDynamicIntegerArray;
      AClass: Integer);
    procedure Reset;
  protected
    function GetElitistValues(Index: Integer): Integer; override;
  public
    constructor Create(ATimeTableModel: TTimeTableModel);
    destructor Destroy; override;
    {Implements abstract class TIndividual:}
    procedure Update; override;
    procedure UpdateValue; override;
    function NewBookmark: TBookmark; override;
    procedure SaveToDataModule(IdTimeTable: Integer;
      TimeIni, TimeEnd: TDateTime; Summary: TStrings); override;
    procedure LoadFromDataModule(IdTimeTable: Integer); override;
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
    property HourHuecaDesubicada: Integer read FTablingInfo.FHourHuecaDesubicada;
    property SubjectRestrictionTypeASubjectCant: TDynamicIntegerArray
      read FTablingInfo.FSubjectRestrictionTypeASubjectCant;
    property TeacherRestrictionTypeATeacherCant: TDynamicIntegerArray
      read FTablingInfo.FTeacherRestrictionTypeATeacherCant;
    property SubjectNoDispersa: Integer read FTablingInfo.FSubjectNoDispersa;
    property SessionCortada: Integer read FTablingInfo.FSessionCortada;
    property ClashTeacher: Integer read FTablingInfo.FClashTeacher;
    property ClashSubject: Integer read FTablingInfo.FClashSubject;
    property ClashRoomType: Integer read FTablingInfo.FClashRoomType;
    property ClashTeacherValor: Integer read GetClashTeacherValor;
    property ClashSubjectValor: Integer read GetClashSubjectValor;
    property TeacherFraccionamientoValor: Integer read GetTeacherFraccionamientoValor;
    property ClashRoomTypeValor: Integer read GetClashRoomTypeValor;
    property HourHuecaDesubicadaValor: Integer read GetHourHuecaDesubicadaValor;
    property SessionCortadaValor: Integer read GetSessionCortadaValor;
    property SubjectNoDispersaValor: Integer read GetSubjectNoDispersaValor;
    property SubjectRestrictionValor: Integer read GetSubjectRestrictionValor;
    property TeacherRestrictionValor: Integer read GetTeacherRestrictionValor;
    property ClassTimeSlotASession: TDynamicIntegerArrayArray
      read FClassTimeSlotASession write FClassTimeSlotASession;
    property TeacherFraccionamiento: Integer read FTablingInfo.FTeacherFraccionamiento;
    property TablingInfo: TTimeTableTablingInfo read FTablingInfo;
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
  SysUtils, ZSysUtils, ZConnection, MTProcs, DSource, USortAlgs;

constructor TTimeTableModel.Create(AClashTeacherValor,
  AClashSubjectValor, AClashRoomTypeValor, ATeacherFraccionamientoValor,
  AHourHuecaDesubicadaValor, ASessionCortadaValor, ASubjectNoDispersaValor: Integer);
var
  FMinIdTeacher, FMinIdSubject, FMinIdRoomType, FMinIdTeacherRestrictionType,
    FMinIdSubjectRestrictionType: Integer;
  FDistributionASubject, FIdSubjectASubject, FIdTeacherATeacher,
    FIdRoomTypeARoomType, FIdTeacherRestrictionTypeATeacherRestrictionType,
    FIdSubjectRestrictionTypeASubjectRestrictionType, FClassADuracion,
    FDistributionATeacher, FDistributionAClass: TDynamicIntegerArray;
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
  procedure CargarCourse;
  var
    Course, Level, Specialization: Integer;
    VFieldLevel, VFieldSpecialization: TField;
  begin
    with SourceDataModule.TbCourse do
    begin
      IndexFieldNames := 'IdLevel;IdSpecialization';
      First;
      FCourseCant := RecordCount;
      SetLength(FLevelSpecializationACourse, FLevelCant, FSpecializationCant);
      for Level := 0 to FLevelCant - 1 do
        for Specialization := 0 to FSpecializationCant - 1 do
          FLevelSpecializationACourse[Level, Specialization] := -1;
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      for Course := 0 to FCourseCant - 1 do
      begin
        Level := FIdLevelALevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationASpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        FLevelSpecializationACourse[Level, Specialization] := Course;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarTimeSlot;
  var
    TimeSlot, Day, Hour: Integer;
    VFieldDay, VFieldHour: TField;
  begin
    with SourceDataModule.TbTimeSlot do
    begin
      IndexFieldNames := 'IdDay;IdHour';
      First;
      FTimeSlotCant := RecordCount;
      SetLength(FTimeSlotADay, FTimeSlotCant);
      SetLength(FDayAMaxTimeSlot, FDayCant);
      SetLength(FTimeSlotAHour, FTimeSlotCant);
      SetLength(FDayHourATimeSlot, FDayCant, FHourCant);
      for Day := 0 to FDayCant - 1 do
        for Hour := 0 to FHourCant - 1 do
          FDayHourATimeSlot[Day, Hour] := -1;
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      for TimeSlot := 0 to FTimeSlotCant - 1 do
      begin
        Day := FIdDayADay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourAHour[VFieldHour.AsInteger - FMinIdHour];
        FTimeSlotADay[TimeSlot] := Day;
        FTimeSlotAHour[TimeSlot] := Hour;
        FDayHourATimeSlot[Day, Hour] := TimeSlot;
        Next;
      end;
      for Day := 0 to FDayCant - 1 do
      begin
        FDayAMaxTimeSlot[Day] := GetDayAMaxTimeSlot(Day);
      end;
      First;
    end;
  end;
  procedure CargarClass;
  var
    VClass, Course, GroupId, Level, Specialization: Integer;
    VFieldLevel, VFieldSpecialization, VFieldGroupId: TField;
  begin
    with SourceDataModule.TbClass do
    begin
      IndexFieldNames := 'IdLevel;IdSpecialization;IdGroupId';
      First;
      FClassCant := RecordCount;
      SetLength(FClassACourse, FClassCant);
      SetLength(FClassAGroupId, FClassCant);
      SetLength(FClassALevel, FClassCant);
      SetLength(FClassASpecialization, FClassCant);
      SetLength(FCourseGroupIdAClass, FCourseCant, Length
          (FGroupIdAIdGroupId));
      VFieldLevel := FindField('IdLevel');
      VFieldSpecialization := FindField('IdSpecialization');
      VFieldGroupId := FindField('IdGroupId');
      for VClass := 0 to FClassCant - 1 do
      begin
        Level := FIdLevelALevel[VFieldLevel.AsInteger - FMinIdLevel];
        Specialization := FIdSpecializationASpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        Course := FLevelSpecializationACourse[Level, Specialization];
        GroupId := FIdGroupIdAGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        FClassACourse[VClass] := Course;
        FClassALevel[VClass] := Level;
        FClassAGroupId[VClass] := GroupId;
        FClassASpecialization[VClass] := Specialization;
        FCourseGroupIdAClass[Course, GroupId] := VClass;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarRoomType;
  var
    RoomType: Integer;
    VFieldNumber: TField;
  begin
    with SourceDataModule.TbRoomType do
    begin
      IndexFieldNames := 'IdRoomType';
      First;
      SetLength(FRoomTypeANumber, RecordCount);
      VFieldNumber := FindField('Number');
      for RoomType := 0 to RecordCount - 1 do
      begin
        FRoomTypeANumber[RoomType] := VFieldNumber.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarSubjectRestrictionType;
  var
    SubjectRestrictionType: Integer;
    VFieldValor: TField;
  begin
    with SourceDataModule.TbSubjectRestrictionType do
    begin
      IndexFieldNames := 'IdSubjectRestrictionType';
      First;
      VFieldValor := FindField('ValSubjectRestrictionType');
      SetLength(FSubjectRestrictionTypeAValor, RecordCount);
      for SubjectRestrictionType := 0 to RecordCount - 1 do
      begin
        FSubjectRestrictionTypeAValor[SubjectRestrictionType] := VFieldValor.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarTeacherRestrictionType;
  var
    TeacherRestrictionType: Integer;
    VFieldValor: TField;
  begin
    with SourceDataModule.TbTeacherRestrictionType do
    begin
      IndexFieldNames := 'IdTeacherRestrictionType';
      First;
      VFieldValor := FindField('ValTeacherRestrictionType');
      SetLength(FTeacherRestrictionTypeAValor, RecordCount);
      for TeacherRestrictionType := 0 to RecordCount - 1 do
      begin
        FTeacherRestrictionTypeAValor[TeacherRestrictionType] := VFieldValor.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarSubjectRestriction;
  var
    Subject, SubjectRestriction, TimeSlot, SubjectRestrictionType: Integer;
    VFieldSubject, VFieldDay, VFieldHour, VFieldSubjectRestrictionType: TField;
  begin
    with SourceDataModule.TbSubjectRestriction do
    begin
      IndexFieldNames := 'IdSubject;IdDay;IdHour';
      First;
      SetLength(FSubjectRestrictionASubject, RecordCount);
      SetLength(FSubjectRestrictionATimeSlot, RecordCount);
      SetLength(FSubjectRestrictionASubjectRestrictionType, RecordCount);
      SetLength(FSubjectRestrictionAValor, RecordCount);
      SetLength(FSubjectTimeSlotASubjectRestrictionType, FSubjectCant,
        FTimeSlotCant);
      for Subject := 0 to FSubjectCant - 1 do
        for TimeSlot := 0 to FTimeSlotCant - 1 do
          FSubjectTimeSlotASubjectRestrictionType[Subject, TimeSlot] := -1;
      VFieldSubject := FindField('IdSubject');
      VFieldDay := FindField('IdDay');
      VFieldHour := FindField('IdHour');
      VFieldSubjectRestrictionType := FindField('IdSubjectRestrictionType');
      for SubjectRestriction := 0 to RecordCount - 1 do
      begin
        Subject := FIdSubjectASubject[VFieldSubject.AsInteger - FMinIdSubject];
        TimeSlot := FDayHourATimeSlot[FIdDayADay[VFieldDay.AsInteger - FMinIdDay],
          FIdHourAHour[VFieldHour.AsInteger - FMinIdHour]];
        SubjectRestrictionType := FIdSubjectRestrictionTypeASubjectRestrictionType
          [VFieldSubjectRestrictionType.AsInteger - FMinIdSubjectRestrictionType];
        FSubjectRestrictionASubject[SubjectRestriction] := Subject;
        FSubjectRestrictionATimeSlot[SubjectRestriction] := TimeSlot;
        FSubjectRestrictionASubjectRestrictionType[Subject] := SubjectRestrictionType;
        FSubjectRestrictionAValor[SubjectRestriction] := FSubjectRestrictionTypeAValor[SubjectRestrictionType];
        FSubjectTimeSlotASubjectRestrictionType[Subject, TimeSlot] := SubjectRestrictionType;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarTeacherRestriction;
  var
    TeacherRestriction, Teacher, TimeSlot, Day, Hour,
      TeacherRestrictionType, Valor: Integer;
    VFieldTeacher, VFieldDay, VFieldHour,
      VFieldTeacherRestrictionType: TField;
  begin
    with SourceDataModule.TbTeacherRestriction do
    begin
      IndexFieldNames := 'IdTeacher;IdDay;IdHour';
      First;
      SetLength(FTeacherRestrictionATeacher, RecordCount);
      SetLength(FTeacherRestrictionATimeSlot, RecordCount);
      SetLength(FTeacherRestrictionATeacherRestrictionType, RecordCount);
      SetLength(FTeacherRestrictionAValor, RecordCount);
      SetLength(FTeacherTimeSlotATeacherRestrictionType, FTeacherCant,
        FTimeSlotCant);
      for Teacher := 0 to FTeacherCant - 1 do
        for TimeSlot := 0 to FTimeSlotCant - 1 do
          FTeacherTimeSlotATeacherRestrictionType[Teacher, TimeSlot] := -1;
      VFieldTeacher := FindField('IdTeacher');
      VFieldHour := FindField('IdHour');
      VFieldDay := FindField('IdDay');
      VFieldTeacherRestrictionType := FindField('IdTeacherRestrictionType');
      for TeacherRestriction := 0 to RecordCount - 1 do
      begin
        Teacher := FIdTeacherATeacher[VFieldTeacher.AsInteger - FMinIdTeacher];
        Day := FIdDayADay[VFieldDay.AsInteger - FMinIdDay];
        Hour := FIdHourAHour[VFieldHour.AsInteger - FMinIdHour];
        TimeSlot := FDayHourATimeSlot[Day, Hour];
        TeacherRestrictionType := FIdTeacherRestrictionTypeATeacherRestrictionType
          [VFieldTeacherRestrictionType.AsInteger -
          FMinIdTeacherRestrictionType];
        FTeacherRestrictionATeacher[TeacherRestriction] := Teacher;
        FTeacherRestrictionATimeSlot[TeacherRestriction] := TimeSlot;
        FTeacherRestrictionATeacherRestrictionType[TeacherRestriction] := TeacherRestrictionType;
        Valor := FTeacherRestrictionTypeAValor[TeacherRestrictionType];
        FTeacherRestrictionAValor[TeacherRestriction] := Valor;
        FTeacherTimeSlotATeacherRestrictionType[Teacher, TimeSlot] := TeacherRestrictionType;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure CargarDistribution;
  var
    Subject, Level, Specialization, GroupId, Session1, Distribution,
      VClass, Teacher, Course, Session2, Session, RoomType, VPos: Integer;
    VFieldSubject, VFieldLevel, VFieldGroupId, VFieldTeacher,
      VFieldSpecialization, VFieldRoomType, VFieldComposition: TField;
    VSessionADuracion, VSessionADistribution: array [0 .. 16383] of Integer;
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
      FDistributionCant := RecordCount;
      // SetLength(FDistributionAAsignatura, RecordCount);
      SetLength(FDistributionAClass, FDistributionCant);
      SetLength(FDistributionATeacher, FDistributionCant);
      SetLength(FDistributionARoomType, FDistributionCant);
      SetLength(FDistributionASessiones, FDistributionCant);
      SetLength(FDistributionASubject, FDistributionCant);
      SetLength(FClassSubjectATeacher, FClassCant, FSubjectCant);
      SetLength(FClassSubjectCant, FClassCant, FSubjectCant);
      SetLength(FClassSubjectADistribution, FClassCant, FSubjectCant);
      for VClass := 0 to FClassCant - 1 do
        for Subject := 0 to FSubjectCant - 1 do
        begin
          FClassSubjectCant[VClass, Subject] := 0;
          FClassSubjectADistribution[VClass, Subject] := -1;
          FClassSubjectATeacher[VClass, Subject] := -1;
        end;
      Session2 := 0;
      for Distribution := 0 to RecordCount - 1 do
      begin
        Subject := FIdSubjectASubject[VFieldSubject.AsInteger - FMinIdSubject];
        Level := FIdLevelALevel[VFieldLevel.AsInteger - FMinIdLevel];
        GroupId := FIdGroupIdAGroupId[VFieldGroupId.AsInteger -
          FMinIdGroupId];
        Specialization := FIdSpecializationASpecialization
          [VFieldSpecialization.AsInteger - FMinIdSpecialization];
        RoomType := FIdRoomTypeARoomType[VFieldRoomType.AsInteger - FMinIdRoomType];
        Course := FLevelSpecializationACourse[Level, Specialization];
        VClass := FCourseGroupIdAClass[Course, GroupId];
        Teacher := FIdTeacherATeacher[VFieldTeacher.AsInteger - FMinIdTeacher];
        FDistributionAClass[Distribution] := VClass;
        FDistributionATeacher[Distribution] := Teacher;
        FDistributionARoomType[Distribution] := RoomType;
        FDistributionASubject[Distribution] := Subject;
        FClassSubjectATeacher[VClass, Subject] := Teacher;
        FClassSubjectADistribution[VClass, Subject] := Distribution;
        Composition := VFieldComposition.AsString;
        VPos := 1;
        Session1 := Session2;
        // t := 0;
        while VPos <= Length(Composition) do
        begin
          VSessionADuracion[Session2] := StrToInt(ExtractString(Composition, VPos, '.'));
          VSessionADistribution[Session2] := Distribution;
          Inc(FClassSubjectCant[VClass, Subject]);
          // Inc(t, VSessionADuracion[Session2]);
          Inc(Session2);
        end;
        SetLength(FDistributionASessiones[Distribution], Session2 - Session1);
        for Session := Session1 to Session2 - 1 do
        begin
          FDistributionASessiones[Distribution, Session - Session1] := Session;
        end;
        // FClassADuracion[VClass] := FClassADuracion[VClass] + t;
        Next;
      end;
      SetLength(FSessionADistribution, Session2);
      SetLength(FSessionASubject, Session2);
      SetLength(FSessionARoomType, Session2);
      Move(VSessionADuracion[0], FSessionADuracion[0], Session2 * SizeOf(Integer));
      FSessionADuracion[-1] := 1;
      Move(VSessionADistribution[0], FSessionADistribution[0],
        Session2 * SizeOf(Integer));
      for Session := 0 to Session2 - 1 do
      begin
        Distribution := FSessionADistribution[Session];
        FSessionASubject[Session] := FDistributionASubject[Distribution];
        FSessionARoomType[Session] := FDistributionARoomType[Distribution];
      end;
    end;
  end;
  procedure CargarMoldeTimeTableDetail;
  var
    TimeSlot1, VClass, Distribution, TimeSlot, Contador, Duracion, Number: Integer;
  begin
    SetLength(FTimeTableDetailPattern, FClassCant, FTimeSlotCant);
    SetLength(FClassASessionCant, FClassCant);
    SetLength(FClassADuracion, FClassCant);
    for VClass := 0 to FClassCant - 1 do
    begin
      FClassADuracion[VClass] := 0;
      FClassASessionCant[VClass] := 0;
      for TimeSlot := 0 to FTimeSlotCant - 1 do
      begin
        FTimeTableDetailPattern[VClass, TimeSlot] := -1;
      end;
    end;
    for Distribution := FDistributionCant - 1 downto 0 do
    begin
      VClass := FDistributionAClass[Distribution];
      for Contador := High(FDistributionASessiones[Distribution]) downto 0 do
      begin
        Duracion := FSessionADuracion[FDistributionASessiones[Distribution, Contador]];
        TimeSlot1 := FClassADuracion[VClass];
        for TimeSlot := TimeSlot1 to TimeSlot1 + Duracion - 1 do
        begin
          if (TimeSlot < 0) or (TimeSlot >= FTimeSlotCant) then
            raise Exception.CreateFmt(
              'Se desbordo Molde de ClassTimeSlotASession: ' +
                'Class %d-%d Duracion %d', [FClassALevel[VClass],
              FClassAGroupId[VClass], TimeSlot]);
          FTimeTableDetailPattern[VClass, FTimeSlotCant - 1 - TimeSlot]
            := FDistributionASessiones[Distribution, Contador];
        end;
        Inc(FClassADuracion[VClass], Duracion);
      end;
    end;
    for VClass := 0 to FClassCant - 1 do
    begin
      TimeSlot := 0;
      while TimeSlot < FTimeSlotCant do
      begin
        Duracion := FSessionADuracion[FTimeTableDetailPattern[VClass, TimeSlot]];
        Inc(TimeSlot, Duracion);
        Inc(FClassASessionCant[VClass]);
      end;
    end;
    FSessionNumberDoble := 0;
    for VClass := 0 to FClassCant - 1 do
    begin
      Number := FClassASessionCant[VClass];
      Inc(FSessionNumberDoble, (Number * (Number - 1)) div 2);
    end;
  end;
begin
  inherited Create;
  with SourceDataModule do
  begin
    Configure(AClashTeacherValor, AClashSubjectValor, AClashRoomTypeValor,
      ATeacherFraccionamientoValor, AHourHuecaDesubicadaValor,
      ASessionCortadaValor, ASubjectNoDispersaValor);
    Load(TbTeacher, 'IdTeacher', FMinIdTeacher, FIdTeacherATeacher,
      FTeacherAIdTeacher);
    FTeacherCant := Length(FTeacherAIdTeacher);
    Load(TbLevel, 'IdLevel', FMinIdLevel, FIdLevelALevel, FLevelAIdLevel);
    FLevelCant := Length(FLevelAIdLevel);
    Load(TbSpecialization, 'IdSpecialization', FMinIdSpecialization,
      FIdSpecializationASpecialization, FSpecializationAIdSpecialization);
    FSpecializationCant := Length(FSpecializationAIdSpecialization);
    CargarCourse;
    Load(TbGroupId, 'IdGroupId', FMinIdGroupId,
      FIdGroupIdAGroupId, FGroupIdAIdGroupId);
    Load(TbSubject, 'IdSubject', FMinIdSubject, FIdSubjectASubject,
      FSubjectAIdSubject);
    FSubjectCant := Length(FSubjectAIdSubject);
    Load(TbDay, 'IdDay', FMinIdDay, FIdDayADay, FDayAIdDay);
    FDayCant := Length(FDayAIdDay);
    Load(TbHour, 'IdHour', FMinIdHour, FIdHourAHour, FHourAIdHour);
    FHourCant := Length(FHourAIdHour);
    Load(TbSubjectRestrictionType, 'IdSubjectRestrictionType',
      FMinIdSubjectRestrictionType,
      FIdSubjectRestrictionTypeASubjectRestrictionType,
      FSubjectRestrictionTypeAIdSubjectRestrictionType);
    FSubjectRestrictionTypeCant := Length(FSubjectRestrictionTypeAIdSubjectRestrictionType);
    Load(TbTeacherRestrictionType, 'IdTeacherRestrictionType',
      FMinIdTeacherRestrictionType,
      FIdTeacherRestrictionTypeATeacherRestrictionType,
      FTeacherRestrictionTypeAIdTeacherRestrictionType);
    FTeacherRestrictionTypeCant := Length(FTeacherRestrictionTypeAIdTeacherRestrictionType);
    Load(TbRoomType, 'IdRoomType', FMinIdRoomType, FIdRoomTypeARoomType,
      FRoomTypeAIdRoomType);
    FRoomTypeCant := Length(FRoomTypeAIdRoomType);
    CargarTimeSlot;
    CargarClass;
    CargarRoomType;
    CargarSubjectRestrictionType;
    CargarTeacherRestrictionType;
    CargarSubjectRestriction;
    CargarTeacherRestriction;
    CargarDistribution;
    CargarMoldeTimeTableDetail;
  end;
end;

procedure TTimeTableModel.Configure(AClashTeacherValor, AClashSubjectValor,
  AClashRoomTypeValor, ATeacherFraccionamientoValor, AHourHuecaDesubicadaValor,
  ASessionCortadaValor, ASubjectNoDispersaValor: Integer);
begin
  FClashTeacherValor := AClashTeacherValor;
  FClashSubjectValor := AClashSubjectValor;
  FTeacherFraccionamientoValor := ATeacherFraccionamientoValor;
  FClashRoomTypeValor := AClashRoomTypeValor;
  FHourHuecaDesubicadaValor := AHourHuecaDesubicadaValor;
  FSessionCortadaValor := ASessionCortadaValor;
  FSubjectNoDispersaValor := ASubjectNoDispersaValor;
end;

function TTimeTableModel.GetDayAMaxTimeSlot(Day: Integer): Integer;
begin
  if Day = FDayCant - 1 then
    Result := FTimeSlotCant - 1
  else
    Result := FDayHourATimeSlot[Day + 1, 0] - 1;
end;

procedure TTimeTableModel.ReportParameters(AReport: TStrings);
begin
  AReport.Add(Format('Pesos:'#13#10 +
        '  Cruce de profesores          %8.2f'#13#10 +
        '  Cruce de materias            %8.2f'#13#10 +
        '  Cruce de aulas:              %8.2f'#13#10 +
        '  Fracc. h. profesores         %8.2f'#13#10 +
        '  Hours Huecas desubicadas:    %8.2f'#13#10 +
        '  Materias cortadas:           %8.2f'#13#10 +
        '  Materias juntas:             %8.2f', [
          ClashTeacherValor, ClashSubjectValor, ClashRoomTypeValor,
          TeacherFraccionamientoValor, HourHuecaDesubicadaValor,
          SessionCortadaValor, SubjectNoDispersaValor]));
end;

function TTimeTableModel.NewIndividual: TIndividual;
begin
  Result := TTimeTable.Create(Self);
end;

procedure TTimeTable.RandomizeKey(var ARandomKey: TDynamicIntegerArray;
  AClass: Integer);
var
  TimeSlot, Duracion, Counter, MaxTimeSlot: Integer;
  TimeSlotASession: TDynamicIntegerArray;
  NumberList: array [0 .. 4095] of Integer;
begin
  with TTimeTableModel(Model) do
  begin
    for Counter := 0 to FClassASessionCant[AClass] - 1 do
      NumberList[Counter] := Random($7FFFFFFF);
    Sort(NumberList, 0, FClassASessionCant[AClass] - 1);
    TimeSlotASession := ClassTimeSlotASession[AClass];
    TimeSlot := 0;
    Counter := 0;
    while TimeSlot < FTimeSlotCant do
    begin
      Duracion := FSessionADuracion[TimeSlotASession[TimeSlot]];
      MaxTimeSlot := TimeSlot + Duracion;
      while TimeSlot < MaxTimeSlot do
      begin
        ARandomKey[TimeSlot] := NumberList[Counter];
        Inc(TimeSlot);
      end;
      Inc(Counter);
    end;
  end;
end;

procedure TTimeTable.CrossClass(TimeTable2: TTimeTable; AClass: Integer);
var
  Session, TimeSlot, Duracion, Key1, Key2, MaxTimeSlot: Integer;
  RandomKey1, RandomKey2: TDynamicIntegerArray;
begin
  with TTimeTableModel(Model) do
  begin
    SetLength(RandomKey1, FTimeSlotCant);
    RandomizeKey(RandomKey1, AClass);
    SortInteger(ClassTimeSlotASession[AClass], RandomKey1, 0, FTimeSlotCant - 1);

    SetLength(RandomKey2, FTimeSlotCant);
    TimeTable2.RandomizeKey(RandomKey2, AClass);
    SortInteger(TimeTable2.ClassTimeSlotASession[AClass], RandomKey2, 0, FTimeSlotCant - 1);

    TimeSlot := 0;
    while TimeSlot < FTimeSlotCant do
    begin
      Session := FTimeTableDetailPattern[AClass, TimeSlot];
      Duracion := FSessionADuracion[Session];
      if Random(2) = 0 then
      begin
        Key1 := RandomKey1[TimeSlot];
        Key2 := RandomKey2[TimeSlot];
        MaxTimeSlot := TimeSlot + Duracion;
        while TimeSlot < MaxTimeSlot do
        begin
          RandomKey1[TimeSlot] := Key2;
          RandomKey2[TimeSlot] := Key1;
          Inc(TimeSlot);
        end;
      end
      else
        Inc(TimeSlot, Duracion);
    end;
    SortInteger(RandomKey1, ClassTimeSlotASession[AClass], 0, FTimeSlotCant - 1);
    SortInteger(RandomKey2, TimeTable2.ClassTimeSlotASession[AClass], 0,
      FTimeSlotCant - 1);
  end;
end;

procedure TTimeTable.Cross(AIndividual: TIndividual);
var
  VClass: Integer;
begin
  with TTimeTableModel(Model) do
  begin
    for VClass := 0 to FClassCant - 1 do
    begin
      CrossClass(TTimeTable(AIndividual), VClass);
    end;
    Update;
    TTimeTable(AIndividual).Update;
  end;
end;

constructor TTimeTable.Create(ATimeTableModel: TTimeTableModel);
begin
  inherited Create;
  FModel := ATimeTableModel;
  with TTimeTableModel(Model) do
  begin
    SetLength(FClassTimeSlotASession, FClassCant, FTimeSlotCant);
    FTablingInfo := TTimeTableTablingInfo.Create;
    with TablingInfo do
    begin
      SetLength(FSubjectTimeSlotCant, FSubjectCant, FTimeSlotCant);
      SetLength(FTeacherTimeSlotCant, FTeacherCant, FTimeSlotCant);
      SetLength(FRoomTypeTimeSlotCant, FRoomTypeCant, FTimeSlotCant);
      SetLength(FClassDaySubjectCant, FClassCant, FDayCant, FSubjectCant);
      SetLength(FClassDaySubjectAcum, FClassCant, FDayCant, FSubjectCant);
      SetLength(FDayTeacherMinHour, FDayCant, FTeacherCant);
      SetLength(FDayTeacherMaxHour, FDayCant, FTeacherCant);
      SetLength(FDayTeacherHourHuecaCant, FDayCant, FTeacherCant);
      SetLength(FSubjectRestrictionTypeASubjectCant, FSubjectRestrictionTypeCant);
      SetLength(FTeacherRestrictionTypeATeacherCant, FTeacherRestrictionTypeCant);
    end;
  end;
end;

function TTimeTable.GetElitistValues(Index: Integer): Integer;
begin
  case Index of
    0: Result := SessionCortada;
    1: Result := ClashTeacher;
    2: Result := ClashRoomType;
  end;
end;

procedure TTimeTable.MakeRandom;
var
  VClass, TimeSlot, Duracion, MaxTimeSlot, RandomKey: Integer;
  TimeSlotASession: TDynamicIntegerArray;
  RandomKeys: TDynamicIntegerArray;
begin
  with TTimeTableModel(Model) do
  begin
    SetLength(RandomKeys, FTimeSlotCant);
    for VClass := 0 to FClassCant - 1 do
    begin
      TimeSlotASession := ClassTimeSlotASession[VClass];
      for TimeSlot := 0 to FTimeSlotCant - 1 do
        TimeSlotASession[TimeSlot] := FTimeTableDetailPattern[VClass, TimeSlot];
      TimeSlot := 0;
      while TimeSlot < FTimeSlotCant do
      begin
        Duracion := FSessionADuracion[TimeSlotASession[TimeSlot]];
        RandomKey := Random($7FFFFFFF);
        MaxTimeSlot := TimeSlot + Duracion;
        while TimeSlot < MaxTimeSlot do
        begin
          RandomKeys[TimeSlot] := RandomKey;
          Inc(TimeSlot);
        end;
      end;
      SortInteger(RandomKeys, TimeSlotASession, 0, FTimeSlotCant - 1);
    end;
  end;
  Update;
end;

function TTimeTable.Swap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
begin
  Normalize(AClass, ATimeSlot1);
  Normalize(AClass, ATimeSlot2);
  if ATimeSlot1 < ATimeSlot2 then
    Result := InternalSwap(AClass, ATimeSlot1, ATimeSlot2)
  else if ATimeSlot2 < ATimeSlot1 then
    Result := InternalSwap(AClass, ATimeSlot2, ATimeSlot1);
end;

function TTimeTable.DoMove(AClass, ATimeSlot1: Integer; var ATimeSlot2: Integer): Integer;
var
  Duracion1, Duracion2: Integer;
begin
  with TTimeTableModel(Model) do
  begin
    Duracion1 := SessionADuracion[ClassTimeSlotASession[AClass, ATimeSlot1]];
    Duracion2 := SessionADuracion[ClassTimeSlotASession[AClass, ATimeSlot2]];
  end;
  Result := InternalSwap(AClass, ATimeSlot1, ATimeSlot2);
  ATimeSlot2 := ATimeSlot2 + Duracion2 - Duracion1;
end;

procedure TTimeTable.DeltaValues(Delta, AClass, TimeSlot1, TimeSlot2: Integer);
var
  SubjectRestrictionType, TeacherRestrictionType, TimeSlot, TimeSlot0, Day, DDay,
    Day1, Day2, Hour, Session, Teacher, RoomType, Duracion, Subject, Limit,
    DeltaTeacherFraccionamiento, MinTimeSlot, MaxTimeSlot: Integer;
  TimeSlotASession: TDynamicIntegerArray;
  SubjectATeacher: TDynamicIntegerArray;
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    Inc(FSessionCortada, Delta * DeltaSessionCortada(AClass, TimeSlot1, TimeSlot2));
    TimeSlotASession := FClassTimeSlotASession[AClass];
    SubjectATeacher := FClassSubjectATeacher[AClass];
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    for TimeSlot := TimeSlot1 to TimeSlot2 do
    begin
      Session := TimeSlotASession[TimeSlot];
      if Session >= 0 then
      begin
        Subject := FSessionASubject[Session];
        Teacher := SubjectATeacher[Subject];
        RoomType := FSessionARoomType[Session];
        Day := FTimeSlotADay[TimeSlot];
        Hour := FTimeSlotAHour[TimeSlot];
        if FTeacherTimeSlotCant[Teacher, TimeSlot] = Limit then
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
                DeltaTeacherFraccionamiento := FDayTeacherMinHour[Day, Teacher] - Hour - 1;
                FDayTeacherMinHour[Day, Teacher] := Hour;
              end
              else if (FDayTeacherMinHour[Day, Teacher] <= Hour)
                  and (Hour <= FDayTeacherMaxHour[Day, Teacher]) then
                DeltaTeacherFraccionamiento := -1
              else // if FDayTeacherMaxTimeSlot[Day, Teacher] < TimeSlot then
              begin
                DeltaTeacherFraccionamiento := Hour - FDayTeacherMaxHour[Day, Teacher] - 1;
                FDayTeacherMaxHour[Day, Teacher] := Hour;
              end;
              Inc(FDayTeacherHourHuecaCant[Day, Teacher], DeltaTeacherFraccionamiento);
              Inc(FTeacherFraccionamiento, DeltaTeacherFraccionamiento);
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
                MaxTimeSlot := FDayHourATimeSlot[Day, FDayTeacherMaxHour[Day, Teacher]];
                while (TimeSlot0 <= MaxTimeSlot)
                    and (FTeacherTimeSlotCant[Teacher, TimeSlot0] = 0) do
                  Inc(TimeSlot0);
                DeltaTeacherFraccionamiento := Hour + 1 - FTimeSlotAHour[TimeSlot0];
                FDayTeacherMinHour[Day, Teacher] := FTimeSlotAHour[TimeSlot0];
              end
              else if (FDayTeacherMinHour[Day, Teacher] < Hour)
                  and (Hour < FDayTeacherMaxHour[Day, Teacher]) then
              begin
                DeltaTeacherFraccionamiento := 1;
              end
              else // if (FDayTeacherMaxTimeSlot[Day, Teacher] = TimeSlot) then
              begin
                TimeSlot0 := TimeSlot - 1;
                MinTimeSlot := FDayHourATimeSlot[Day, FDayTeacherMinHour[Day, Teacher]];
                while (TimeSlot0 >= MinTimeSlot)
                    and (FTeacherTimeSlotCant[Teacher, TimeSlot0] = 0) do
                  Dec(TimeSlot0);
                DeltaTeacherFraccionamiento := FTimeSlotAHour[TimeSlot0] + 1 - Hour;
                FDayTeacherMaxHour[Day, Teacher] := FTimeSlotAHour[TimeSlot0];
              end;
              Inc(FDayTeacherHourHuecaCant[Day, Teacher], DeltaTeacherFraccionamiento);
              Inc(FTeacherFraccionamiento, DeltaTeacherFraccionamiento);
            end;
          end;
        end;
        if FTeacherTimeSlotCant[Teacher, TimeSlot] > Limit then
          Inc(FClashTeacher, Delta);
        Inc(FTeacherTimeSlotCant[Teacher, TimeSlot], Delta);
        Inc(FSubjectTimeSlotCant[Subject, TimeSlot], Delta);
        if FRoomTypeTimeSlotCant[RoomType, TimeSlot] >= FRoomTypeANumber[RoomType] + Limit then
          Inc(FClashRoomType, Delta);
        Inc(FRoomTypeTimeSlotCant[RoomType, TimeSlot], Delta);
        SubjectRestrictionType := FSubjectTimeSlotASubjectRestrictionType[Subject, TimeSlot];
        if SubjectRestrictionType >= 0 then
          Inc(FSubjectRestrictionTypeASubjectCant[SubjectRestrictionType], Delta);
        TeacherRestrictionType := FTeacherTimeSlotATeacherRestrictionType[Teacher, TimeSlot];
        if TeacherRestrictionType >= 0 then
          Inc(FTeacherRestrictionTypeATeacherCant[TeacherRestrictionType], Delta);
      end
      else if FHourCant - 1 <> FTimeSlotAHour[TimeSlot] then
        Inc(FHourHuecaDesubicada, Delta);
    end;
    TimeSlot := TimeSlot1;
    while TimeSlot <= TimeSlot2 do
    begin
      Session := TimeSlotASession[TimeSlot];
      Duracion := FSessionADuracion[Session];
      if Session >= 0 then
      begin
        Subject := FSessionASubject[Session];
        Day1 := FTimeSlotADay[TimeSlot];
        Day2 := FTimeSlotADay[TimeSlot + Duracion - 1];
        for Day := Day1 to Day2 do
        begin
          if FClassDaySubjectCant[AClass, Day, Subject] > Limit then
            Inc(FClashSubject, Delta);
          Inc(FClassDaySubjectCant[AClass, Day, Subject], Delta);
        end;
        DDay := FDayCant div FClassSubjectCant[AClass, Subject];
        for Day2 := Day1 to Day1 + DDay - 1 do
        begin
          Day := Day2 mod (FDayCant + 1);
          if Day <> FDayCant then
          begin
            if FClassDaySubjectAcum[AClass, Day, Subject] > Limit then
              Inc(FSubjectNoDispersa, Delta);
            Inc(FClassDaySubjectAcum[AClass, Day, Subject], Delta);
          end;
        end;
      end;
      Inc(TimeSlot, Duracion);
    end;
  end;
end;

function TTimeTable.InternalSwap(AClass, ATimeSlot1, ATimeSlot2: Integer): Integer;
var
  Duracion1, Duracion2, Session1, Session2: Integer;
  TimeSlotASession: TDynamicIntegerArray;
  procedure DoMovement;
  var
    TimeSlot: Integer;
  begin
    Move(TimeSlotASession[ATimeSlot1 + Duracion1], TimeSlotASession[ATimeSlot1 + Duracion2],
      (ATimeSlot2 - ATimeSlot1 - Duracion1) * SizeOf(Integer));
    for TimeSlot := ATimeSlot1 to ATimeSlot1 + Duracion2 - 1 do
      TimeSlotASession[TimeSlot] := Session2;
    for TimeSlot := ATimeSlot2 + Duracion2 - Duracion1 to ATimeSlot2 + Duracion2 - 1 do
      TimeSlotASession[TimeSlot] := Session1;
  end;
  // Values that requires total recalculation:
var
  TimeSlot: Integer;
  {$IFDEF DEBUG}
  Value1, Value2: Integer;
  ClashTeacher2: Integer;
  ClashSubject2: Integer;
  ClashRoomType2: Integer;
  TeacherFraccionamiento2: Integer;
  HourHuecaDesubicada2: Integer;
  SubjectRestrictionValor2: Integer;
  SubjectNoDispersa2: Integer;
  TeacherRestrictionValor2: Integer;
  SessionCortada2: Integer;
  {$ENDIF}
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    Result := FValue;
    {$IFDEF DEBUG}
    Update;
    Value1 := FValue;
    {$ENDIF}
    TimeSlotASession := ClassTimeSlotASession[AClass];
    Session1 := TimeSlotASession[ATimeSlot1];
    Session2 := TimeSlotASession[ATimeSlot2];
    Duracion1 := FSessionADuracion[Session1];
    Duracion2 := FSessionADuracion[Session2];
    if (Duracion1 = Duracion2) then
    begin
      DeltaValues(-1, AClass, ATimeSlot1, ATimeSlot1 + Duracion1 - 1);
      DeltaValues(-1, AClass, ATimeSlot2, ATimeSlot2 + Duracion2 - 1);
      for TimeSlot := ATimeSlot1 to ATimeSlot1 + Duracion2 - 1 do
        TimeSlotASession[TimeSlot] := Session2;
      for TimeSlot := ATimeSlot2 to ATimeSlot2 + Duracion2 - 1 do
        TimeSlotASession[TimeSlot] := Session1;
      DeltaValues(1, AClass, ATimeSlot1, ATimeSlot1 + Duracion1 - 1);
      DeltaValues(1, AClass, ATimeSlot2, ATimeSlot2 + Duracion2 - 1);
    end
    else
    begin
      DeltaValues(-1, AClass, ATimeSlot1, ATimeSlot2 + Duracion2 - 1);
      DoMovement;
      DeltaValues(1, AClass, ATimeSlot1, ATimeSlot2 + Duracion2 - 1);
    end;
    FValue := GetValue;
    {$IFDEF DEBUG}
    ClashRoomType2 := FClashRoomType;
    ClashTeacher2 := FClashTeacher;
    ClashSubject2 := FClashSubject;
    HourHuecaDesubicada2 := FHourHuecaDesubicada;
    SubjectNoDispersa2 := FSubjectNoDispersa;
    SubjectRestrictionValor2 := SubjectRestrictionValor;
    TeacherFraccionamiento2 := FTeacherFraccionamiento;
    TeacherRestrictionValor2 := TeacherRestrictionValor;
    SessionCortada2 := FSessionCortada;
    Value2 := FValue;
    Update;
    if abs(FValue - Result - (Value2 - Value1)) > 0.000001 then
      raise Exception.CreateFmt(
      'Value1                   %f - %f'#13#10 +
      'Value2                   %f - %f'#13#10 +
      'ClashTeacher            %d - %d'#13#10 +
      'ClashSubject             %d - %d'#13#10 +
      'ClashRoomType            %d - %d'#13#10 +
      'HourHuecaDesubicada      %d - %d'#13#10 +
      'SubjectNoDispersa        %d - %d'#13#10 +
      'SubjectRestrictionValor  %f - %f'#13#10 +
      'TeacherFraccionamiento  %d - %d'#13#10 +
      'TeacherRestrictionValor %f - %f'#13#10 +
      'SessionCortada            %d - %d',
      [
        Result, Value1,
        FValue, Value2,
        FClashTeacher, ClashTeacher2,
        FClashSubject, ClashSubject2,
        FClashRoomType, ClashRoomType2,
        FHourHuecaDesubicada, HourHuecaDesubicada2,
        FSubjectNoDispersa, SubjectNoDispersa2,
        SubjectRestrictionValor, SubjectRestrictionValor2,
        FTeacherFraccionamiento, TeacherFraccionamiento2,
        TeacherRestrictionValor, TeacherRestrictionValor2,
        FSessionCortada, SessionCortada2
        ]);
    {$ENDIF}
    Result := FValue - Result;
  end;
end;

{WARNING!!! Normalize is a Kludge, avoid its usage!!!}
procedure TTimeTable.Normalize(AClass: Integer; var ATimeSlot: Integer);
var
  Session: Integer;
  TimeSlotASession: TDynamicIntegerArray;
begin
  TimeSlotASession := FClassTimeSlotASession[AClass];
  Session := TimeSlotASession[ATimeSlot];
  if Session >= 0 then
    while (ATimeSlot > 0) and (Session = TimeSlotASession[ATimeSlot - 1]) do
      Dec(ATimeSlot);
end;

{Assembler version of Normalize}
(*
  procedure TTimeTable.Normalize(AClass: Integer; var ATimeSlot: Integer); assembler;
  asm
  push    ebx
  mov     eax, [eax + FClassTimeSlotASession]
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

procedure TTimeTable.ReportValues(AReport: TStrings);
begin
  with AReport, TablingInfo do
  begin
    Add('-----------------------------------------------------------------');
    Add('Detalle                           Cant.         Peso        Valor');
    Add('-----------------------------------------------------------------');
    Add(Format('Cruce de profesores:       %12d %12d %12d',
        [FClashTeacher, TTimeTableModel(Model).ClashTeacherValor, ClashTeacherValor]));
    Add(Format('Cruce de materias:         %12d %12d %12d',
        [FClashSubject, TTimeTableModel(Model).ClashSubjectValor, ClashSubjectValor]));
    Add(Format('Cruce de aulas:            %12d %12d %12d',
        [FClashRoomType, TTimeTableModel(Model).ClashRoomTypeValor, ClashRoomTypeValor]));
    Add(Format('Fracc. h. profesores:      %12d %12d %12d',
        [TeacherFraccionamiento, TTimeTableModel(Model).TeacherFraccionamientoValor,
        TeacherFraccionamientoValor]));
    Add(Format('Hours Huecas desubicadas:  %12d %12d %12d',
        [HourHuecaDesubicada, TTimeTableModel(Model).HourHuecaDesubicadaValor,
        HourHuecaDesubicadaValor]));
    Add(Format('Materias cortadas:         %12d %12d %12d',
        [SessionCortada, TTimeTableModel(Model).SessionCortadaValor, SessionCortadaValor]));
    Add(Format('Materias juntas:           %12d %12d %12d',
        [SubjectNoDispersa, TTimeTableModel(Model).SubjectNoDispersaValor, SubjectNoDispersaValor]));
    Add(Format('Prohibiciones de materia:  %12s %12s %12d',
        ['(' + VarArrToStr(FSubjectRestrictionTypeASubjectCant, ' ') + ')',
         '(' + VarArrToStr(TTimeTableModel(Model).FSubjectRestrictionTypeAValor, ' ') + ')',
         SubjectRestrictionValor]));
    Add(Format('Prohibiciones de profesor: %12s %12s %12d',
        ['(' + VarArrToStr(FTeacherRestrictionTypeATeacherCant, ' ') + ')',
         '(' + VarArrToStr(TTimeTableModel(Model).FTeacherRestrictionTypeAValor, ' ') + ')',
         TeacherRestrictionValor]));
    Add('-----------------------------------------------------------------');
    Add(Format('Valor Total:                                         %12d', [Value]));
  end;
end;

procedure TTimeTable.Mutate;
var
  VClass, TimeSlot1, TimeSlot2: Integer;
begin
  with TTimeTableModel(Model) do
  begin
    TimeSlot1 := Random(FTimeSlotCant);
    TimeSlot2 := Random(FTimeSlotCant);
    VClass := Random(FClassCant);
    if ClassTimeSlotASession[VClass, TimeSlot1]
    <> ClassTimeSlotASession[VClass, TimeSlot2] then
      Swap(VClass, TimeSlot1, TimeSlot2);
  end;
end;

function TTimeTable.GetHourHuecaDesubicadaValor: Integer;
begin
  Result := TTimeTableModel(Model).FHourHuecaDesubicadaValor * HourHuecaDesubicada;
end;

function TTimeTable.GetSubjectRestrictionValor: Integer;
var
  SubjectRestrictionType: Integer;
begin
  Result := 0;
  with TTimeTableModel(Model), TablingInfo do
  for SubjectRestrictionType := 0 to FSubjectRestrictionTypeCant - 1 do
  begin
    Result := Result + FSubjectRestrictionTypeASubjectCant[SubjectRestrictionType]
      * FSubjectRestrictionTypeAValor[SubjectRestrictionType];
  end;
end;

function TTimeTable.GetTeacherRestrictionValor: Integer;
var
  TeacherRestrictionType: Integer;
begin
  Result := 0;
  with TTimeTableModel(Model), TablingInfo do
  for TeacherRestrictionType := 0 to FTeacherRestrictionTypeCant - 1 do
  begin
    Result := Result + FTeacherRestrictionTypeATeacherCant[TeacherRestrictionType]
      * FTeacherRestrictionTypeAValor[TeacherRestrictionType];
  end;
end;

function TTimeTable.GetSessionCortadaValor: Integer;
begin
  Result := TTimeTableModel(Model).SessionCortadaValor * SessionCortada;
end;

function TTimeTable.DeltaSessionCortada(AClass, TimeSlot1, TimeSlot2: Integer): Integer;
var
  TimeSlot, Hour1, Hour2, Day1, Day2, Session, Duracion: Integer;
  TimeSlotASession: TDynamicIntegerArray;
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    TimeSlot := TimeSlot1;
    TimeSlotASession := FClassTimeSlotASession[AClass];
    Result := 0;
    while TimeSlot <= TimeSlot2 do
    begin
      Session := TimeSlotASession[TimeSlot];
      Duracion := FSessionADuracion[Session];
      if Duracion > 1 then
      begin
        Day1 := FTimeSlotADay[TimeSlot];
        Day2 := FTimeSlotADay[TimeSlot + Duracion - 1];
        Hour1 := FTimeSlotAHour[TimeSlot];
        Hour2 := FTimeSlotAHour[TimeSlot + Duracion - 1];
        Inc(Result, (Day2 - Day1) * (FHourCant + 1) + Hour2 - Hour1 + 1 - Duracion);
      end;
      Inc(TimeSlot, Duracion);
    end;
  end;
end;

function TTimeTable.GetSubjectNoDispersaValor: Integer;
begin
  Result := TTimeTableModel(Model).SubjectNoDispersaValor * SubjectNoDispersa;
end;

function TTimeTable.GetClashTeacherValor: Integer;
begin
  Result := TTimeTableModel(Model).ClashTeacherValor * TablingInfo.FClashTeacher;
end;

function TTimeTable.GetClashSubjectValor: Integer;
begin
  Result := TTimeTableModel(Model).ClashSubjectValor * TablingInfo.FClashSubject;
end;


function TTimeTable.GetTeacherFraccionamientoValor: Integer;
begin
  Result := TTimeTableModel(Model).TeacherFraccionamientoValor *
    TablingInfo.FTeacherFraccionamiento;
end;

function TTimeTable.GetClashRoomTypeValor: Integer;
begin
  Result := TTimeTableModel(Model).ClashRoomTypeValor * TablingInfo.FClashRoomType;
end;

function TTimeTable.GetValue: Integer;
begin
  with TablingInfo do
    Result :=
      ClashRoomTypeValor +
      ClashTeacherValor +
      ClashSubjectValor +
      HourHuecaDesubicadaValor +
      SubjectNoDispersaValor +
      SubjectRestrictionValor +
      TeacherFraccionamientoValor +
      TeacherRestrictionValor +
      SessionCortadaValor;
end;

function TTimeTable.NewBookmark: TBookmark;
begin
  Result := TTTBookmark.Create(Self, RandomIndexes(TTimeTableModel(Model).ClassCant));
end;

destructor TTimeTable.Destroy;
begin
  TablingInfo.Free;
  inherited Destroy;
end;

procedure TTimeTable.Assign(AIndividual: TIndividual);
var
  VClass, Subject, Teacher, RoomType, Day: Integer;
  ATimeTable: TTimeTable;
begin
  inherited;
  ATimeTable := TTimeTable(AIndividual);
  with TTimeTableModel(Model), TablingInfo do
  begin
    for VClass := 0 to FClassCant - 1 do
      Move(ATimeTable.ClassTimeSlotASession[VClass, 0],
        ClassTimeSlotASession[VClass, 0], FTimeSlotCant * SizeOf(Integer));
    FClashTeacher := ATimeTable.TablingInfo.FClashTeacher;
    FClashSubject := ATimeTable.TablingInfo.FClashSubject;
    FClashRoomType := ATimeTable.TablingInfo.FClashRoomType;
    FTeacherFraccionamiento := ATimeTable.TablingInfo.FTeacherFraccionamiento;
    FHourHuecaDesubicada := ATimeTable.TablingInfo.FHourHuecaDesubicada;
    FSessionCortada := ATimeTable.TablingInfo.FSessionCortada;
    FSubjectNoDispersa := ATimeTable.TablingInfo.FSubjectNoDispersa;
    FValue := ATimeTable.FValue;
    // TablingInfo := ATimeTable.TablingInfo;
    Move(ATimeTable.TablingInfo.FSubjectRestrictionTypeASubjectCant[0],
      FSubjectRestrictionTypeASubjectCant[0], FSubjectRestrictionTypeCant * SizeOf(Integer));
    Move(ATimeTable.TablingInfo.FTeacherRestrictionTypeATeacherCant[0],
      FTeacherRestrictionTypeATeacherCant[0], FTeacherRestrictionTypeCant * SizeOf(Integer));
    for Subject := 0 to FSubjectCant - 1 do
      Move(ATimeTable.TablingInfo.FSubjectTimeSlotCant[Subject, 0],
           TablingInfo.FSubjectTimeSlotCant[Subject, 0],
           FTimeSlotCant * SizeOf(Integer));
    for Teacher := 0 to FTeacherCant - 1 do
      Move(ATimeTable.TablingInfo.FTeacherTimeSlotCant[Teacher, 0],
           TablingInfo.FTeacherTimeSlotCant[Teacher, 0],
           FTimeSlotCant * SizeOf(Integer));
    for Day := 0 to FDayCant - 1 do
    begin
      Move(ATimeTable.TablingInfo.FDayTeacherMinHour[Day, 0],
        FDayTeacherMinHour[Day, 0], FTeacherCant * SizeOf(Integer));
      Move(ATimeTable.TablingInfo.FDayTeacherMaxHour[Day, 0],
        FDayTeacherMaxHour[Day, 0], FTeacherCant * SizeOf(Integer));
      Move(ATimeTable.TablingInfo.FDayTeacherHourHuecaCant[Day, 0],
        FDayTeacherHourHuecaCant[Day, 0], FTeacherCant * SizeOf(Integer));
    end;
    for RoomType := 0 to FRoomTypeCant - 1 do
      Move(ATimeTable.TablingInfo.FRoomTypeTimeSlotCant[RoomType, 0],
        TablingInfo.FRoomTypeTimeSlotCant[RoomType, 0],
        FTimeSlotCant * SizeOf(Integer));
    for VClass := 0 to FClassCant - 1 do
      for Day := 0 to FDayCant - 1 do
      begin
        Move(ATimeTable.TablingInfo.FClassDaySubjectCant[VClass, Day, 0],
          TablingInfo.FClassDaySubjectCant[VClass, Day, 0],
          FSubjectCant * SizeOf(Integer));
        Move(ATimeTable.TablingInfo.FClassDaySubjectAcum[VClass, Day, 0],
          TablingInfo.FClassDaySubjectAcum[VClass, Day, 0],
          FSubjectCant * SizeOf(Integer));
      end;
  end;
end;

procedure TTimeTable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  VClass, TimeSlot: Integer;
begin
  VStrings := TStringList.Create;
  with TTimeTableModel(Model) do
    try
      for VClass := 0 to FClassCant - 1 do
      begin
        VStrings.Add(Format('Class %d %d %d',
            [FLevelAIdLevel[FClassALevel[VClass]],
            FSpecializationAIdSpecialization[FClassASpecialization[VClass]],
            FGroupIdAIdGroupId[FClassAGroupId[VClass]]]));
        for TimeSlot := 0 to FTimeSlotCant - 1 do
        begin
          VStrings.Add(Format(' Day %d Hour %d Subject %d', [FTimeSlotADay[TimeSlot],
              FTimeSlotAHour[TimeSlot],
              FSubjectAIdSubject[FSessionASubject[ClassTimeSlotASession[
                VClass, TimeSlot]]]]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;

procedure TTimeTable.SaveToStream(Stream: TStream);
var
  VClass: Integer;
begin
  with TTimeTableModel(Model) do
    for VClass := 0 to FClassCant - 1 do
    begin
      Stream.Write(ClassTimeSlotASession[VClass, 0], FTimeSlotCant * SizeOf(Integer));
    end;
end;

procedure TTimeTable.LoadFromStream(Stream: TStream);
var
  VClass: Integer;
begin
  with TTimeTableModel(Model) do
    for VClass := 0 to FClassCant - 1 do
    begin
      Stream.Read(ClassTimeSlotASession[VClass, 0], FTimeSlotCant * SizeOf(Integer));
    end;
  Update;
end;

procedure TTimeTable.SaveToDataModule(IdTimeTable: Integer;
  TimeIni, TimeEnd: TDateTime; Summary: TStrings);
  {$IFDEF USE_SQL}
var
  SQL: TStrings;
  {$ENDIF}
  procedure SaveTimeTable;
  {$IFNDEF USE_SQL}
  var
    Stream: TStream;
  {$ENDIF}
  begin
    {$IFDEF USE_SQL}
    SQL.Add(Format('INSERT INTO TimeTable(IdTimeTable,TimeIni,TimeEnd,Summary) ' +
      'VALUES (%d,"%s","%s","%s");', [
      IdTimeTable,
      DateTimeToAnsiSQLDate(TimeIni),
      DateTimeToAnsiSQLDate(TimeEnd),
      Summary.Text]));
    {$ELSE}
    with SourceDataModule, TbTimeTable do
    begin
      DisableControls;
      try
        IndexFieldNames := 'IdTimeTable';
        Append;
        TbTimeTable.FindField('IdTimeTable').AsInteger := IdTimeTable;
        TbTimeTable.FindField('TimeIni').AsDateTime := TimeIni;
        TbTimeTable.FindField('TimeEnd').AsDateTime := TimeEnd;
        Stream := TMemoryStream.Create;
        try
          Summary.SaveToStream(Stream);
          Stream.Position := 0;
          TBlobField(TbTimeTable.FindField('Summary')).LoadFromStream(Stream);
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
  procedure SaveTimeTableDetail;
  var
    VClass, TimeSlot, IdLevel, IdGroupId, IdSpecialization, Session: Integer;
    {$IFNDEF USE_SQL}
    FieldTimeTable, FieldLevel, FieldGroupId, FieldSpecialization, FieldDay,
      FieldHour, FieldSubject, FieldSession: TField;
    {$ENDIF}
  begin
  {$IFDEF USE_SQL}
      with TTimeTableModel(Model) do
      for VClass := 0 to FClassCant - 1 do
      begin
        IdLevel := FLevelAIdLevel[FClassALevel[VClass]];
        IdGroupId := FGroupIdAIdGroupId[FClassAGroupId[VClass]];
        IdSpecialization := FSpecializationAIdSpecialization
          [FClassASpecialization[VClass]];
        for TimeSlot := 0 to FTimeSlotCant - 1 do
        begin
          Session := ClassTimeSlotASession[VClass, TimeSlot];
          if Session >= 0 then
          begin
            SQL.Add(Format(
              'INSERT INTO TimeTableDetail' +
              '(IdTimeTable,IdLevel,IdGroupId,IdSpecialization,IdDay,' +
              'IdHour,IdSubject,Session) VALUES (%d,%d,%d,%d,%d,%d,%d,%d);',
              [IdTimeTable, IdLevel, IdGroupId, IdSpecialization,
              FDayAIdDay[FTimeSlotADay[TimeSlot]],
              FHourAIdHour[FTimeSlotAHour[TimeSlot]],
              FSubjectAIdSubject[FSessionASubject[Session]],
              Session]));
          end;
        end;
      end;
    {$ELSE}
    with SourceDataModule.TbTimeTableDetail do
    begin
      DisableControls;
      try
        Last;
        FieldTimeTable := FindField('IdTimeTable');
        FieldLevel := FindField('IdLevel');
        FieldGroupId := FindField('IdGroupId');
        FieldSpecialization := FindField('IdSpecialization');
        FieldDay := FindField('IdDay');
        FieldHour := FindField('IdHour');
        FieldSubject := FindField('IdSubject');
        FieldSession := FindField('Session');
        with TTimeTableModel(Model) do
        for VClass := 0 to FClassCant - 1 do
        begin
          IdLevel := FLevelAIdLevel[FClassALevel[VClass]];
          IdGroupId := FGroupIdAIdGroupId[FClassAGroupId[VClass]];
          IdSpecialization := FSpecializationAIdSpecialization
            [FClassASpecialization[VClass]];
          for TimeSlot := 0 to FTimeSlotCant - 1 do
          begin
            Session := ClassTimeSlotASession[VClass, TimeSlot];
            if Session >= 0 then
            begin
              Append;
              FieldTimeTable.AsInteger := IdTimeTable;
              FieldLevel.AsInteger := IdLevel;
              FieldGroupId.AsInteger := IdGroupId;
              FieldSpecialization.AsInteger := IdSpecialization;
              FieldDay.AsInteger := FDayAIdDay[FTimeSlotADay[TimeSlot]];
              FieldHour.AsInteger := FHourAIdHour[FTimeSlotAHour[TimeSlot]];
              FieldSubject.AsInteger := FSubjectAIdSubject[FSessionASubject[Session]];
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
    SaveTimeTable;
    SaveTimeTableDetail;
    {$IFDEF USE_SQL}
    with SourceDataModule do
    begin
      DbZConnection.ExecuteDirect(SQL.Text);
      TbTimeTable.Refresh;
      TbTimeTableDetail.Refresh;
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

procedure TTimeTable.LoadFromDataModule(IdTimeTable: Integer);
var
  FieldLevel, FieldGroupId, FieldSpecialization, FieldDay, FieldHour,
    FieldSession: TLongintField;
  VClass, TimeSlot: Integer;
begin
  with SourceDataModule, TTimeTableModel(Model), TbTimeTableDetail do
  begin
    TbTimeTable.Locate('IdTimeTable', IdTimeTable, []);
    LinkedFields := 'IdTimeTable';
    MasterFields := 'IdTimeTable';
    MasterSource := DSTimeTable;
    try
      FieldLevel := FindField('IdLevel') as TLongintField;
      FieldGroupId := FindField('IdGroupId') as TLongintField;
      FieldSpecialization := FindField('IdSpecialization') as TLongintField;
      FieldDay := FindField('IdDay') as TLongintField;
      FieldHour := FindField('IdHour') as TLongintField;
      FieldSession := FindField('Session') as TLongintField;
      for VClass := 0 to FClassCant - 1 do
        for TimeSlot := 0 to FTimeSlotCant - 1 do
          FClassTimeSlotASession[VClass, TimeSlot] := -1;
      First;
      while not Eof do
      begin
        VClass := FCourseGroupIdAClass[
          FLevelSpecializationACourse[
            FIdLevelALevel[FieldLevel.AsInteger - FMinIdLevel],
            FIdSpecializationASpecialization[FieldSpecialization.AsInteger -
            FMinIdSpecialization]],
          FIdGroupIdAGroupId[FieldGroupId.AsInteger -
          FMinIdGroupId]];
        TimeSlot := FDayHourATimeSlot[FIdDayADay[FieldDay.AsInteger - FMinIdDay],
          FIdHourAHour[FieldHour.AsInteger - FMinIdHour]];
        FClassTimeSlotASession[VClass, TimeSlot] := FieldSession.AsInteger;
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

procedure TTimeTable.CheckIntegrity;
var
  Subject, VClass, TimeSlot, Teacher, Distribution, Counter,
    Session: Integer;
  SessionFound: Boolean;
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    for VClass := 0 to FClassCant - 1 do
      for TimeSlot := 0 to FTimeSlotCant - 1 do
      begin
        Session := FClassTimeSlotASession[VClass, TimeSlot];
        if Session >= 0 then
        begin
          Subject := FSessionASubject[Session];
          Teacher := FClassSubjectATeacher[VClass, Subject];
          if Teacher < 0 then
            raise Exception.CreateFmt('Class %d(%d,%d,%d), Subject %d(%d) no tiene Teacher', [
              VClass,
              FLevelAIdLevel[FClassALevel[VClass]],
              FSpecializationAIdSpecialization[FClassASpecialization[VClass]],
              FGroupIdAIdGroupId[FClassAGroupId[VClass]],
              Subject,
              FSubjectAIdSubject[Subject]]);
          Distribution := FClassSubjectADistribution[VClass, Subject];
          SessionFound := False;
          for Counter := 0 to High(FDistributionASessiones[Distribution]) do
            SessionFound := SessionFound or (FDistributionASessiones[Distribution, Counter] = Session);
          if not SessionFound then
            raise Exception.CreateFmt('Class %d(%d,%d,%d), Subject %d(%d) no aparece en FDistributionASessiones', [
              VClass,
              FLevelAIdLevel[FClassALevel[VClass]],
              FSpecializationAIdSpecialization[FClassASpecialization[VClass]],
              FGroupIdAIdGroupId[FClassAGroupId[VClass]],
              Subject,
              FSubjectAIdSubject[Subject]]);
          if Distribution < 0 then
            raise Exception.CreateFmt('Class %d(%d,%d,%d), Subject %d(%d) no aparece en FClassSubjectADistribution', [
              VClass,
              FLevelAIdLevel[FClassALevel[VClass]],
              FSpecializationAIdSpecialization[FClassASpecialization[VClass]],
              FGroupIdAIdGroupId[FClassAGroupId[VClass]],
              Subject,
              FSubjectAIdSubject[Subject]]);
        end;
      end;
  end;
end;

procedure TTimeTable.Reset;
var
  Teacher, TimeSlot, Subject, SubjectRestrictionType, TeacherRestrictionType,
    VClass, Day, RoomType: Integer;
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    FClashTeacher := 0;
    FClashSubject := 0;
    FClashRoomType := 0;
    FHourHuecaDesubicada := 0;
    FTeacherFraccionamiento := 0;
    FSessionCortada := 0;
    FSubjectNoDispersa := 0;
    for Day := 0 to FDayCant - 1 do
      for Teacher := 0 to FTeacherCant - 1 do
      begin
        FDayTeacherHourHuecaCant[Day, Teacher] := 0;
        FDayTeacherMinHour[Day, Teacher] := 1;
        FDayTeacherMaxHour[Day, Teacher] := 0;
      end;
    for SubjectRestrictionType := 0 to FSubjectRestrictionTypeCant - 1 do
      FSubjectRestrictionTypeASubjectCant[SubjectRestrictionType] := 0;
    for TeacherRestrictionType := 0 to FTeacherRestrictionTypeCant - 1 do
      FTeacherRestrictionTypeATeacherCant[TeacherRestrictionType] := 0;
    for TimeSlot := 0 to FTimeSlotCant - 1 do
    begin
      for Teacher := 0 to FTeacherCant - 1 do
        FTeacherTimeSlotCant[Teacher, TimeSlot] := 0;
      for Subject := 0 to FSubjectCant - 1 do
        FSubjectTimeSlotCant[Subject, TimeSlot] := 0;
      for RoomType := 0 to FRoomTypeCant - 1 do
        FRoomTypeTimeSlotCant[RoomType, TimeSlot] := 0;
    end;
    for VClass := 0 to FClassCant - 1 do
      for Day := 0 to FDayCant - 1 do
        for Subject := 0 to FSubjectCant - 1 do
        begin
          FClassDaySubjectCant[VClass, Day, Subject] := 0;
          FClassDaySubjectAcum[VClass, Day, Subject] := 0;
        end;
  end;
end;

procedure TTimeTable.Update;
var
  VClass: Integer;
begin
  with TTimeTableModel(Model), TablingInfo do
  begin
    Reset;
    for VClass := 0 to FClassCant - 1 do
      DeltaValues(1, VClass, 0, FTimeSlotCant - 1);
    UpdateValue;
  end
end;

procedure TTimeTable.UpdateValue;
begin
  FValue := GetValue;
end;

destructor TTimeTableModel.Destroy;
begin
  inherited Destroy;
end;

class function TTimeTableModel.GetElitistCount: Integer;
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
  Index := (FPosition + FOffset) mod TTimeTableModel(FIndividual.Model).ClassCant;
  Result := FClasses[Index];
end;

procedure TTTBookmark.First;
begin
  FPosition := 0;
  FOffset := 0;
  FTimeSlot1 := 0;
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
    FTimeSlot2 := SessionADuracion[ClassTimeSlotASession[Class_, FTimeSlot1]];
end;

procedure NextTimeSlot(TimeSlotASession: TDynamicIntegerArray; TimeSlotCant: Integer;
  var TimeSlot: Integer);
var
  Session: Integer;
begin
  Session := TimeSlotASession[TimeSlot];
  if Session < 0 then
    Inc(TimeSlot)
  else
    repeat
      Inc(TimeSlot);
    until (TimeSlot >= TimeSlotCant)
      or (TimeSlotASession[TimeSlot] <> Session);
end;

procedure FixTimeSlot(TimeSlotASession: TDynamicIntegerArray; TimeSlotCant: Integer;
  var TimeSlot: Integer);
begin
  if TimeSlot > 0 then
  begin
    Dec(TimeSlot);
    NextTimeSlot(TimeSlotASession, TimeSlotCant, TimeSlot);
  end;
end;


procedure TTTBookmark.Next;
var
  d1, d2: Integer;
  TimeSlotASession: TDynamicIntegerArray;
begin
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
  begin
    TimeSlotASession := ClassTimeSlotASession[Class_];
    d1 := TimeSlotCant - SessionADuracion[TimeSlotASession[TimeSlotCant - 1]];
    if FTimeSlot2 >= d1 then
    begin
      d2 := d1 - SessionADuracion[TimeSlotASession[d1 - 1]];
      if FTimeSlot1 >= d2 then
      begin
        Inc(FPosition);
        FTimeSlot1 := 0;
        FTimeSlot2 := SessionADuracion[ClassTimeSlotASession[Class_, 0]];
      end
      else
      begin
        NextTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot1);
        FTimeSlot2 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]];
      end
    end
    else
    begin
      FixTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot1);
      if FTimeSlot2 <= FTimeSlot1 then
        FTimeSlot2 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]]
      else
        NextTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot2);
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
  with TTimeTableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * TimeSlotCant * (TimeSlotCant - 1) div 2 +
    (FTimeSlot1 * TimeSlotCant - FTimeSlot1 * (FTimeSlot1 + 1) div 2 + FTimeSlot2 - 1);
end;

function TTTBookmark.GetMax: Integer;
begin
  with TTimeTableModel(FIndividual.Model) do
    Result := (FOffset + ClassCant) * TimeSlotCant * (TimeSlotCant - 1) div 2;
end;

function TTTBookmark.Move: Integer;
begin
  Result := TTimeTable(FIndividual).DoMove(Class_, FTimeSlot1, FTimeSlot2);
end;

function TTTBookmark.Undo: Integer;
begin
  Result := Move; // In this case, Move * Move = Identity, so Undo = Move
end;

function TTTBookmark.Eof: Boolean;
begin
  Result := FPosition = TTimeTableModel(FIndividual.Model).ClassCant;
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
  Index := (FPosition + FOffset) mod TTimeTableModel(FIndividual.Model).ClassCant;
  Result := FClasss[Index];
end;

procedure TTTBookmark2.First;
begin
  FPosition := 0;
  FOffset := 0;
  FProgress := 0;
  FTimeSlot1 := 0;
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
    FTimeSlot2 := SessionADuracion[ClassTimeSlotASession[Class_, 0]];
  FTimeSlot3 := FTimeSlot2;
end;

procedure TTTBookmark2.Next;
var
  d1, d2: Integer;
  TimeSlotASession: TDynamicIntegerArray;
begin
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
  begin
    TimeSlotASession := ClassTimeSlotASession[Class_];
    d1 := TimeSlotCant - SessionADuracion[TimeSlotASession[TimeSlotCant - 1]];
    if FTimeSlot3 >= d1 then
    begin
      if FTimeSlot2 >= d1 then
      begin
        d2 := d1 - SessionADuracion[TimeSlotASession[d1 - 1]];
        if FTimeSlot1 >= d2 then
        begin
          Inc(FPosition);
          FTimeSlot1 := 0;
          FTimeSlot2 := SessionADuracion[ClassTimeSlotASession[Class_, 0]];
          FTimeSlot3 := FTimeSlot2;
        end
        else
        begin
          NextTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot1);
          FTimeSlot2 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]];
          FTimeSlot3 := FTimeSlot2;
        end;
      end
      else
      begin
        FixTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot1);
        if FTimeSlot2 <= FTimeSlot1 then
        begin
          FTimeSlot2 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]];
          FTimeSlot3 := FTimeSlot2;
        end
        else
        begin
          NextTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot2);
          FTimeSlot3 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]];
        end;
      end;
    end
    else
    begin
      FixTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot1);
      if FTimeSlot2 <= FTimeSlot1 then
        FTimeSlot2 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]]
      else
        FixTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot2);
      if FTimeSlot3 <= FTimeSlot1 then
        FTimeSlot3 := FTimeSlot1 + SessionADuracion[TimeSlotASession[FTimeSlot1]]
      else
      begin
        NextTimeSlot(TimeSlotASession, TimeSlotCant, FTimeSlot3);
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
  with TTimeTableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * ((TimeSlotCant * (TimeSlotCant - 1) div 2)
      * (2 * TimeSlotCant - 1) div 3) + TimeSlotCant * ( FTimeSlot1 * TimeSlotCant
      + FTimeSlot2 - (FTimeSlot1 + 1) * (FTimeSlot1 + 1) )
      - FTimeSlot2 * (FTimeSlot1 + 1) + (FTimeSlot1 * (FTimeSlot1 + 1) div 2)
      * (2 * FTimeSlot1 + 7) div 3 + FTimeSlot3;
  {Result := FProgress;
  with TTimeTableModel(FIndividual.Model) do
    Result := (FOffset + FPosition) * ((TimeSlotCant * (TimeSlotCant - 1) div 2) *
      (2 * TimeSlotCant - 1) div 3) +
    (FTimeSlot1 * TimeSlotCant - FTimeSlot1 * (FTimeSlot1 + 1) div 2 + FTimeSlot2 - 1);}
end;

function TTTBookmark2.GetMax: Integer;
begin
  with TTimeTableModel(FIndividual.Model) do
    Result := (FOffset + ClassCant) * ((TimeSlotCant * (TimeSlotCant - 1) div 2) *
      (2 * TimeSlotCant - 1) div 3);
end;

function TTTBookmark2.Move: Integer;
begin
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
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
  with TTimeTableModel(FIndividual.Model), TTimeTable(FIndividual) do
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
  Result := FPosition = TTimeTableModel(FIndividual.Model).ClassCant;
end;

initialization

// SortLongint := QuicksortInteger;
// Sort := lQuicksort;
SortInteger := BubblesortInteger;
Sort := lBubblesort;

end.

