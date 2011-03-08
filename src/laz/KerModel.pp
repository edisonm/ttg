unit KerModel;
{$I ttg.inc}

interface

uses
  Classes, DB, Dialogs, Math, Forms, UIndivid;

type
  TDynamicWordArray = array of Word;
  TDynamicWordArrayArray = array of TDynamicWordArray;
  TDynamicSmallintArray = array of Smallint;
  TDynamicSmallintArrayArray = array of TDynamicSmallintArray;
  TDynamicSmallintArrayArrayArray = array of TDynamicSmallintArrayArray;
  TDynamicShortintArray = array of Shortint;
  TDynamicShortintArrayArray = array of TDynamicShortintArray;
  TDynamicIntegerArray = array of Integer;
  TDynamicIntegerArrayArray = array of TDynamicIntegerArray;
  TDynamicLongintArray = array of Longint;
  TDynamicLongintArrayArray = array of TDynamicLongintArray;
  TDynamicDoubleArray = array of Double;
  TDynamicDoubleArrayArray = array of TDynamicDoubleArray;
  TDynamicStringArray = array of string;
  PLongintArray = ^TLongintArray;
  TLongintArray = array [0 .. 16383] of Longint;
  PSmallintArray = ^TSmallintArray;
  TSmallintArray = array [0 .. 16383] of Smallint;
  PSmallintArrayArray = ^TSmallintArrayArray;
  TSmallintArrayArray = array [0 .. 0] of PSmallintArray;
  PShortintArray = ^TShortintArray;
  TShortintArray = array [0 .. 32767] of Shortint;
  PDoubleArray = ^TDoubleArray;
  TDoubleArray = array [0 .. 0] of Double;
  PBooleanArray = ^TBooleanArray;
  TBooleanArray = array [0 .. 16383] of Boolean;
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
  TProgressEvent = procedure(Progress, Step: Integer; TimeTable: TTimeTable;
    var Stop: Boolean) of object;
  TTimeTableArray = array of TTimeTable;

  { TTimeTableModel }

  TTimeTableModel = class(TInterfacedObject, IModel)
  private
    FOnProgress: TProgressEvent;
    FCruceProfesorValor, FCruceAulaTipoValor, FHoraHuecaDesubicadaValor,
      FSesionCortadaValor, FProfesorFraccionamientoValor,
      FMateriaNoDispersaValor: Double;
    FPeriodoADia, FPeriodoAHora, FDiaAMaxPeriodo, FSesionADistributivo,
      FSesionAMateria, FSesionAAulaTipo, FAulaTipoACantidad,
      FMateriaProhibicionAMateria, FMateriaProhibicionAPeriodo,
      FMateriaProhibicionAMateriaProhibicionTipo,
      FProfesorProhibicionAProfesor, FProfesorProhibicionAPeriodo,
      FProfesorProhibicionAProfesorProhibicionTipo, FDistributivoAAulaTipo,
      FParaleloACurso, FParaleloANivel, FParaleloAParaleloId,
      FParaleloAEspecializacion, FProfesorCantHora,
      FParaleloASesionCant: TDynamicSmallintArray;
    FSesionADuracion: array [-1 .. 16382] of Smallint;
    FDiaHoraAPeriodo, FNivelEspecializacionACurso, FCursoParaleloIdAParalelo,
      FParaleloMateriaAProfesor, FParaleloMateriaADistributivo,
      FTimeTableDetailPattern, FDistributivoASesiones: TDynamicSmallintArrayArray;
    FProfesorPeriodoAProfesorProhibicionTipo,
      FMateriaPeriodoAMateriaProhibicionTipo: TDynamicShortintArrayArray;
    FMateriaProhibicionTipoAValor,
      FProfesorProhibicionTipoAValor: array [-1 .. 4094] of Double;
    FMateriaProhibicionAValor, FProfesorProhibicionAValor: TDynamicDoubleArray;
    FParaleloCant, FMateriaCant, FDiaCant, FHoraCant, FPeriodoCant,
      FProfesorCant, FNivelCant, FEspecializacionCant, FCursoCant,
      FAulaTipoCant, FDistributivoCant, FMaxProfesorProhibicionTipo,
      FMaxMateriaProhibicionTipo: Smallint;
    FMaxProfesorProhibicionTipoValor: Double;
    FParaleloIdACodParaleloId, FMateriaACodMateria, FDiaACodDia, FHoraACodHora,
      FNivelACodNivel,
      FEspecializacionACodEspecializacion: TDynamicLongintArray;
    FCodNivelANivel, FCodEspecializacionAEspecializacion,
      FCodParaleloIdAParaleloId, FCodDiaADia,
      FCodHoraAHora: TDynamicSmallintArray;
    FMinCodNivel, FMinCodEspecializacion, FMinCodParaleloId, FMinCodDia,
      FMinCodHora: Longint;
    FSesionCantidadDoble: Integer;
    FElitistCount: Smallint;
    function GetDiaAMaxPeriodo(Dia: Smallint): Smallint;
  protected
    property TimeTableDetailPattern: TDynamicSmallintArrayArray read FTimeTableDetailPattern;
  public
    property PeriodoCant: Smallint read FPeriodoCant;
    property ParaleloCant: Smallint read FParaleloCant;
    property ElitistCount: Smallint read FElitistCount;
    procedure DoProgress(Position, RefreshInterval: Integer; Horario: TTimeTable;
      var Stop: Boolean);
    dynamic;
    procedure Configurar(ACruceProfesorValor, AProfesorFraccionamientoValor,
      ACruceAulaTipoValor, AHoraHuecaDesubicadaValor, ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    constructor CreateFromDataModule(ACruceProfesorValor,
      AProfesorFraccionamientoValor, ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor, ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    property CruceProfesorValor: Double read FCruceProfesorValor;
    property ProfesorFraccionamientoValor: Double read FProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read FCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read FHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read FSesionCortadaValor;
    property MateriaNoDispersaValor: Double read FMateriaNoDispersaValor;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property SesionCantidadDoble: Integer read FSesionCantidadDoble;
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

  { TTimeTableTablingInfo }
  TTimeTableTablingInfo = record
    FValue: Double;
    FCruceProfesor: Integer;
    FProfesorFraccionamiento: Integer;
    FCruceAulaTipo: Integer;
    FHoraHuecaDesubicada: Integer;
    FSesionCortada: Integer;
    FMateriaNoDispersa: Integer;
    FMateriaProhibicion: Integer;
    FProfesorProhibicion: Integer;
    FMateriaProhibicionValor: Double;
    FProfesorProhibicionValor: Double;
    FAulaTipoPeriodoCant: TDynamicSmallintArrayArray;
    FProfesorPeriodoCant: TDynamicSmallintArrayArray;
    FMateriaPeriodoCant: TDynamicSmallintArrayArray;
    FParaleloMateriaDiaMaxHora: TDynamicSmallintArrayArrayArray;
    FParaleloMateriaDiaMinHora: TDynamicSmallintArrayArrayArray;
    FDiaProfesorFraccionamiento: TDynamicSmallintArrayArray;
  end;

  { TTimeTable }

  TTimeTable = class
  private
    FModel: TTimeTableModel;
    FParaleloPeriodoASesion,
      FAntMateriaDiaMinHora, FAntMateriaDiaMaxHora, FAntDiaProfesorMinHora,
      FAntDiaProfesorMaxHora: TDynamicSmallintArrayArray;
    FAntListaCambios: TList;
    FParaleloMateriaNoDispersa: TDynamicSmallintArray;
    FAntMateriaNoDispersa: Integer;
    TablingInfo: TTimeTableTablingInfo;
    FRecalculateValue: Boolean;
    procedure CalculateValue;
    procedure Normalize(AParalelo: Smallint; var APeriodo: Smallint);
    {
      procedure SetClaveAleatoriaInterno(AParalelo, APeriodo: Smallint;
      AClaveAleatoria: Integer); overload;
      procedure SetClaveAleatoriaInterno(AParalelo, APeriodo, ADuracion: Smallint;
      AClaveAleatoria: Integer); overload;
    }
    procedure DoGetMateriaNoDispersa;
    procedure DoGetHoraHuecaDesubicada;
    procedure DoGetSesionCortada;
    procedure DoGetProfesorProhibicionValor;
    procedure DoGetMateriaProhibicionValor;
    function GetMateriaNoDispersaValor: Double;
    function GetHoraHuecaDesubicadaValor: Double;
    function GetCruceProfesorValor: Double;
    function GetProfesorFraccionamientoValor: Double;
    function GetSesionCortadaValor: Double;
    function GetCruceAulaTipoValor: Double;
    procedure InternalMutate;
    function InternalDownHill(Delta: Double): Boolean; overload;
    function InternalDownHill: Boolean; overload;
    procedure InternalSwap(AParalelo, APeriodo1, APeriodo2: Smallint;
      FueEvaluado: Boolean = False);
    procedure Swap(AParalelo, APeriodo1, APeriodo2: Smallint);
    function EvaluateInternalSwap(AParalelo, APeriodo1, APeriodo2: Smallint): Double;
    property ProfesorPeriodoCant: TDynamicSmallintArrayArray read TablingInfo.FProfesorPeriodoCant;
    property AulaTipoPeriodoCant: TDynamicSmallintArrayArray read TablingInfo.FAulaTipoPeriodoCant;
    procedure DoGetCruceProfesor;
    procedure DoGetCruceAulaTipo;
    procedure UpdateAulaTipoPeriodoCant(APeriodo1, APeriodo2: Smallint); overload;
    procedure UpdateAulaTipoPeriodoCant; overload;
    procedure UpdateProfesorPeriodoCant;
    procedure UpdateMateriaPeriodoCant;
    procedure UpdateParaleloMateriaDiaMinMaxHora; overload;
    procedure UpdateParaleloMateriaDiaMinMaxHora(AParalelo: Smallint); overload;
    function GetParaleloMateriaNoDispersa(AParalelo: Smallint;
      var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
    procedure DoGetProfesorFraccionamiento;
    procedure UpdateDiaProfesorFraccionamiento;
    function GetDiaProfesorFraccionamiento(Dia, Profesor: Smallint): Smallint;
    function InternalDoubleDownHill(Step: Integer): Boolean;
    function InternalDownHillEach(var Delta: Double): Boolean; overload;
    function InternalDownHillEach
      (AParalelo: Smallint; var Delta: Double): Boolean; overload;
    function GetElitistValues(Index: Integer): Double;
{$IFDEF DEBUG}
    procedure ErrorMsgValue(const AMethod: string);
    function GetValue: Double;
    function GetMateriaNoDispersa: Integer;
    function GetHoraHuecaDesubicada: Integer;
    function GetSesionCortada: Integer;
    function GetMateriaProhibicion: Integer;
    function GetMateriaProhibicionValor: Double;
    function GetProfesorProhibicion: Integer;
    function GetProfesorProhibicionValor: Double;
{$ENDIF}
  protected
  public
    procedure PartialUpdate;
    procedure Update;
    procedure UpdateValue;
    function DownHill: Boolean;
    function DoubleDownHill(Step: Integer): Boolean;
    procedure DoubleDownHillForced(Step: Integer);
    procedure DownHillForced;
    function InternalDownHillOptimized(Step: Integer): Boolean;
    procedure InternalDownHillOptimizedForced(Step: Integer);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToDataModule(CodHorario: Integer;
      MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
    procedure LoadFromDataModule(CodHorario: Integer);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    constructor Create(ATimeTableModel: TTimeTableModel);
    destructor Destroy; override;
    procedure MakeRandom;
    procedure Mutate; overload;
    procedure Mutate(Orden: Integer); overload;
    procedure MutateDia;
    procedure ReportValues(AReport: TStrings);
    procedure Assign(ATimeTable: TTimeTable);
    {$IFDEF DEBUG}
    property Value: Double read GetValue;
    property MateriaNoDispersa: Integer read GetMateriaNoDispersa;
    property HoraHuecaDesubicada: Integer read GetHoraHuecaDesubicada;
    property SesionCortada: Integer read GetSesionCortada;
    property MateriaProhibicion: Integer read GetMateriaProhibicion;
    property MateriaProhibicionValor: Double read GetMateriaProhibicionValor;
    property ProfesorProhibicion: Integer read GetProfesorProhibicion;
    property ProfesorProhibicionValor: Double read GetProfesorProhibicionValor;
    {$ELSE}
    property Value: Double read TablingInfo.FValue;
    property HoraHuecaDesubicada: Integer read TablingInfo.FHoraHuecaDesubicada;
    property MateriaNoDispersa: Integer read TablingInfo.FMateriaNoDispersa;
    property SesionCortada: Integer read TablingInfo.FSesionCortada;
    property MateriaProhibicion: Integer read TablingInfo.FMateriaProhibicion;
    property MateriaProhibicionValor: Double read TablingInfo.FMateriaProhibicionValor;
    property ProfesorProhibicion: Integer read TablingInfo.FProfesorProhibicion;
    property ProfesorProhibicionValor: Double read TablingInfo.FProfesorProhibicionValor;
    {$ENDIF}
    property ElitistValues[Index: Integer]: Double read GetElitistValues;
    property CruceProfesor: Integer read TablingInfo.FCruceProfesor;
    property CruceAulaTipo: Integer read TablingInfo.FCruceAulaTipo;
    property CruceProfesorValor: Double read GetCruceProfesorValor;
    property RecalculateValue: Boolean read FRecalculateValue write FRecalculateValue;
    property ProfesorFraccionamientoValor: Double read GetProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read GetCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read GetHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read GetSesionCortadaValor;
    
    property MateriaNoDispersaValor: Double read GetMateriaNoDispersaValor;
    property ParaleloPeriodoASesion
      : TDynamicSmallintArrayArray read FParaleloPeriodoASesion write
      FParaleloPeriodoASesion;
    property TimeTableModel: TTimeTableModel read FModel;
    property ProfesorFraccionamiento: Integer read TablingInfo.FProfesorFraccionamiento;
  end;

  // Procedimiento que crea una solucion aleatoria de un TTimeTableModel
procedure CreateRandomFromModel(var ATimeTable: TTimeTable;
  ATimeTableModel: TTimeTableModel);
procedure LoadFixedFromModel(var ATimeTable: TTimeTable;
  ATimeTableModel: TTimeTableModel; CodHorario: Integer);

// Procedimiento que aplica el operador de cruzamiento sobre dos TObjetoTimeTableModel
procedure CrossIndividuals(var TimeTable1, TimeTable2: TTimeTable);

implementation

uses
  SysUtils, SortAlgs, Rand, DSource, HorColCm;

var
  SortLongint: procedure(var List1: array of Longint;
    var List2: array of Smallint; min, max: Longint);
  SortSmallint: procedure(var List1: array of Smallint;
    var List2: array of Longint; min, max: Longint);
  lSort: procedure(var List1: array of Longint; min, max: Longint);

constructor TTimeTableModel.CreateFromDataModule(ACruceProfesorValor,
  AProfesorFraccionamientoValor, ACruceAulaTipoValor,
  AHoraHuecaDesubicadaValor, ASesionCortadaValor,
  AMateriaNoDispersaValor: Double);
var
  iMax: Integer;
  FMinCodProfesor, FMinCodMateria, FMinCodAulaTipo, FMinCodProfProhibicionTipo,
    FMinCodMateProhibicionTipo: Longint;
  FDistributivoAMateria, FCodMateriaAMateria,
    FCodProfesorAProfesor, FCodAulaTipoAAulaTipo,
    FCodProfProhibicionTipoAProfesorProhibicionTipo,
    FCodMateProhibicionTipoAMateriaProhibicionTipo, FParaleloADuracion,
    FDistributivoAProfesor, FDistributivoAParalelo: TDynamicSmallintArray;
  FProfesorACodProfesor, FProfesorProhibicionTipoACodProfProhibicionTipo,
    FAulaTipoACodAulaTipo,
    FMateriaProhibicionTipoACodMateProhibicionTipo: TDynamicLongintArray;
  procedure Cargar(ATable: TDataSet; ALstName: string; out FMinCodLst: Integer;
    out FCodLstALst: TDynamicSmallintArray;
    out FLstACodLst: TDynamicLongintArray);
  var
    VField: TField;
    I, v: Integer;
  begin
    with ATable do
    begin
      First;
      VField := FindField(ALstName);
      FMinCodLst := VField.AsInteger;
      iMax := VField.AsInteger;
      SetLength(FLstACodLst, RecordCount);
      for I := 0 to RecordCount - 1 do
      begin
        v := VField.AsInteger;
        if iMax < v then
          iMax := v;
        if FMinCodLst > v then
          FMinCodLst := v;
        FLstACodLst[I] := v;
        Next;
      end;
      First;
      SetLength(FCodLstALst, iMax - FMinCodLst + 1);
      for I := 0 to RecordCount - 1 do
      begin
        FCodLstALst[VField.AsInteger - FMinCodLst] := I;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarCurso;
  var
    I, j, k: Integer;
    VFieldNivel, VFieldEspecializacion: TField;
  begin
    with SourceDataModule.TbCurso do
    begin
      IndexFieldNames := 'CodNivel;CodEspecializacion';
      First;
      FCursoCant := RecordCount;
      SetLength(FNivelEspecializacionACurso, FNivelCant, FEspecializacionCant);
      for I := 0 to FNivelCant - 1 do
      begin
        FillChar(FNivelEspecializacionACurso[I, 0],
          FEspecializacionCant * SizeOf(Smallint), #$FF);
      end;
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      for I := 0 to FCursoCant - 1 do
      begin
        j := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        k := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        FNivelEspecializacionACurso[j, k] := I;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarPeriodo;
  var
    I, j, k: Integer;
    VFieldDia, VFieldHora: TField;
  begin
    with SourceDataModule.TbPeriodo do
    begin
      IndexFieldNames := 'CodDia;CodHora';
      First;
      FPeriodoCant := RecordCount;
      SetLength(FPeriodoADia, FPeriodoCant);
      SetLength(FDiaAMaxPeriodo, FDiaCant);
      SetLength(FPeriodoAHora, FPeriodoCant);
      SetLength(FDiaHoraAPeriodo, FDiaCant, FHoraCant);
      for I := 0 to FDiaCant - 1 do
      begin
        FillChar(FDiaHoraAPeriodo[I, 0], FHoraCant * SizeOf(Smallint), #$FF);
      end;
      VFieldDia := FindField('CodDia');
      VFieldHora := FindField('CodHora');
      for I := 0 to FPeriodoCant - 1 do
      begin
        j := FCodDiaADia[VFieldDia.AsInteger - FMinCodDia];
        k := FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora];
        FPeriodoADia[I] := j;
        FPeriodoAHora[I] := k;
        FDiaHoraAPeriodo[j, k] := I;
        Next;
      end;
      for I := 0 to FDiaCant - 1 do
      begin
        FDiaAMaxPeriodo[I] := GetDiaAMaxPeriodo(I);
      end;
      First;
    end;
  end;
  procedure CargarParalelo;
  var
    I, j, k, l, m: Integer;
    VFieldNivel, VFieldEspecializacion, VFieldParaleloId: TField;
  begin
    with SourceDataModule.TbParalelo do
    begin
      IndexFieldNames := 'CodNivel;CodEspecializacion;CodParaleloId';
      First;
      FParaleloCant := RecordCount;
      SetLength(FParaleloACurso, FParaleloCant);
      SetLength(FParaleloAParaleloId, FParaleloCant);
      SetLength(FParaleloANivel, FParaleloCant);
      SetLength(FParaleloAEspecializacion, FParaleloCant);
      SetLength(FCursoParaleloIdAParalelo, FCursoCant, Length
          (FParaleloIdACodParaleloId));
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      VFieldParaleloId := FindField('CodParaleloId');
      for I := 0 to FParaleloCant - 1 do
      begin
        l := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        m := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        j := FNivelEspecializacionACurso[l, m];
        k := FCodParaleloIdAParaleloId[VFieldParaleloId.AsInteger -
          FMinCodParaleloId];
        FParaleloACurso[I] := j;
        FParaleloANivel[I] := l;
        FParaleloAParaleloId[I] := k;
        FParaleloAEspecializacion[I] := m;
        FCursoParaleloIdAParalelo[j, k] := I;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarAulaTipo;
  var
    I: Integer;
    VFieldCantidad: TField;
  begin
    with SourceDataModule.TbAulaTipo do
    begin
      IndexFieldNames := 'CodAulaTipo';
      First;
      SetLength(FAulaTipoACantidad, RecordCount);
      VFieldCantidad := FindField('Cantidad');
      for I := 0 to RecordCount - 1 do
      begin
        FAulaTipoACantidad[I] := VFieldCantidad.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarMateriaProhibicionTipo;
  var
    I: Integer;
    VFieldValor: TField;
    dMaxMateriaProhibicionTipoValor: Double;
  begin
    with SourceDataModule.TbMateriaProhibicionTipo do
    begin
      IndexFieldNames := 'CodMateProhibicionTipo';
      First;
      VFieldValor := FindField('ValMateProhibicionTipo');
      FMaxMateriaProhibicionTipo := -1;
      dMaxMateriaProhibicionTipoValor := -1.7E308;
      FMateriaProhibicionTipoAValor[-1] := 0;
      for I := 0 to RecordCount - 1 do
      begin
        FMateriaProhibicionTipoAValor[I] := VFieldValor.AsFloat;
        if dMaxMateriaProhibicionTipoValor < FMateriaProhibicionTipoAValor[I]
          then
        begin
          dMaxMateriaProhibicionTipoValor := FMateriaProhibicionTipoAValor[I];
          FMaxMateriaProhibicionTipo := I;
        end;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarProfesorProhibicionTipo;
  var
    I: Integer;
    VFieldValor: TField;
  begin
    with SourceDataModule.TbProfesorProhibicionTipo do
    begin
      IndexFieldNames := 'CodProfProhibicionTipo';
      First;
      VFieldValor := FindField('ValProfProhibicionTipo');
      FMaxProfesorProhibicionTipo := -1;
      FMaxProfesorProhibicionTipoValor := -1.7E308;
      FProfesorProhibicionTipoAValor[-1] := 0;
      for I := 0 to RecordCount - 1 do
      begin
        FProfesorProhibicionTipoAValor[I] := VFieldValor.AsFloat;
        if FMaxProfesorProhibicionTipoValor < FProfesorProhibicionTipoAValor[I]
          then
        begin
          FMaxProfesorProhibicionTipoValor := FProfesorProhibicionTipoAValor[I];
          FMaxProfesorProhibicionTipo := I;
        end;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarMateriaProhibicion;
  var
    I, j, k, l: Integer;
    VFieldMateria, VFieldDia, VFieldHora, VFieldMateriaProhibicionTipo: TField;
  begin
    with SourceDataModule.TbMateriaProhibicion do
    begin
      IndexFieldNames := 'CodMateria;CodDia;CodHora';
      First;
      SetLength(FMateriaProhibicionAMateria, RecordCount);
      SetLength(FMateriaProhibicionAPeriodo, RecordCount);
      SetLength(FMateriaProhibicionAMateriaProhibicionTipo, RecordCount);
      SetLength(FMateriaProhibicionAValor, RecordCount);
      SetLength(FMateriaPeriodoAMateriaProhibicionTipo, FMateriaCant,
        FPeriodoCant);
      for I := 0 to FMateriaCant - 1 do
        FillChar(FMateriaPeriodoAMateriaProhibicionTipo[I, 0],
          FPeriodoCant * SizeOf(Shortint), #$FF);
      VFieldMateria := FindField('CodMateria');
      VFieldDia := FindField('CodDia');
      VFieldHora := FindField('CodHora');
      VFieldMateriaProhibicionTipo := FindField('CodMateProhibicionTipo');
      for I := 0 to RecordCount - 1 do
      begin
        j := FCodMateriaAMateria[VFieldMateria.AsInteger - FMinCodMateria];
        k := FDiaHoraAPeriodo[FCodDiaADia[VFieldDia.AsInteger - FMinCodDia],
          FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora]];
        l := FCodMateProhibicionTipoAMateriaProhibicionTipo
          [VFieldMateriaProhibicionTipo.AsInteger - FMinCodMateProhibicionTipo];
        FMateriaProhibicionAMateria[I] := j;
        FMateriaProhibicionAPeriodo[I] := k;
        FMateriaProhibicionAMateriaProhibicionTipo[I] := l;
        FMateriaProhibicionAValor[I] := FMateriaProhibicionTipoAValor[l];
        FMateriaPeriodoAMateriaProhibicionTipo[j, k] := l;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarProfesorProhibicion;
  var
    I, j, k, l: Integer;
    v: Double;
    p, h, d: Smallint;
    VFieldProfesor, VFieldDia, VFieldHora,
      VFieldProfesorProhibicionTipo: TField;
  begin
    with SourceDataModule.TbProfesorProhibicion do
    begin
      IndexFieldNames := 'CodProfesor;CodDia;CodHora';
      First;
      SetLength(FProfesorProhibicionAProfesor, RecordCount);
      SetLength(FProfesorProhibicionAPeriodo, RecordCount);
      SetLength(FProfesorProhibicionAProfesorProhibicionTipo, RecordCount);
      SetLength(FProfesorProhibicionAValor, RecordCount);
      SetLength(FProfesorPeriodoAProfesorProhibicionTipo, FProfesorCant,
        FPeriodoCant);
      for p := 0 to FProfesorCant - 1 do
        FillChar(FProfesorPeriodoAProfesorProhibicionTipo[p, 0],
          FPeriodoCant * SizeOf(Shortint), #$FF);
      VFieldProfesor := FindField('CodProfesor');
      VFieldHora := FindField('CodHora');
      VFieldDia := FindField('CodDia');
      VFieldProfesorProhibicionTipo := FindField('CodProfProhibicionTipo');
      for I := 0 to RecordCount - 1 do
      begin
        j := FCodProfesorAProfesor[VFieldProfesor.AsInteger - FMinCodProfesor];
        d := FCodDiaADia[VFieldDia.AsInteger - FMinCodDia];
        h := FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora];
        k := FDiaHoraAPeriodo[d, h];
        l := FCodProfProhibicionTipoAProfesorProhibicionTipo
          [VFieldProfesorProhibicionTipo.AsInteger -
          FMinCodProfProhibicionTipo];
        FProfesorProhibicionAProfesor[I] := j;
        FProfesorProhibicionAPeriodo[I] := k;
        FProfesorProhibicionAProfesorProhibicionTipo[I] := l;
        v := FProfesorProhibicionTipoAValor[l];
        FProfesorProhibicionAValor[I] := v;
        if v = FMaxProfesorProhibicionTipoValor then
        begin
          Inc(FProfesorCantHora[j]);
        end;
        FProfesorPeriodoAProfesorProhibicionTipo[j, k] := l;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure CargarDistributivo;
  var
    I, j, k, l, m, n, o, p, q, ss, a, VPos: Integer;
    VFieldMateria, VFieldNivel, VFieldParaleloId, VFieldProfesor,
      VFieldEspecializacion, VFieldAulaTipo, VFieldComposicion: TField;
    VSesionADuracion, VSesionADistributivo: array [0 .. 16383] of Smallint;
    s: string;
  begin
    with SourceDataModule.TbDistributivo do
    begin
      IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      First;
      VFieldMateria := FindField('CodMateria');
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      VFieldParaleloId := FindField('CodParaleloId');
      VFieldProfesor := FindField('CodProfesor');
      VFieldAulaTipo := FindField('CodAulaTipo');
      VFieldComposicion := FindField('Composicion');
      FDistributivoCant := RecordCount;
      // SetLength(FDistributivoAAsignatura, RecordCount);
      SetLength(FDistributivoAParalelo, FDistributivoCant);
      SetLength(FDistributivoAProfesor, FDistributivoCant);
      SetLength(FDistributivoAAulaTipo, FDistributivoCant);
      SetLength(FDistributivoASesiones, FDistributivoCant);
      SetLength(FDistributivoAMateria, FDistributivoCant);
      SetLength(FParaleloMateriaAProfesor, FParaleloCant, FMateriaCant);
      SetLength(FParaleloMateriaADistributivo, FParaleloCant, FMateriaCant);
      for I := 0 to FParaleloCant - 1 do
        FillChar(FParaleloMateriaADistributivo[I, 0], FMateriaCant * SizeOf
            (Smallint), #$FF);
      for I := 0 to FParaleloCant - 1 do
      begin
        FillChar(FParaleloMateriaAProfesor[I, 0], FMateriaCant * SizeOf
            (Smallint), #$FF);
      end;
      ss := 0;
      for I := 0 to RecordCount - 1 do
      begin
        j := FCodMateriaAMateria[VFieldMateria.AsInteger - FMinCodMateria];
        k := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        l := FCodParaleloIdAParaleloId[VFieldParaleloId.AsInteger -
          FMinCodParaleloId];
        q := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        a := FCodAulaTipoAAulaTipo[VFieldAulaTipo.AsInteger - FMinCodAulaTipo];
        p := FNivelEspecializacionACurso[k, q];
        n := FCursoParaleloIdAParalelo[p, l];
        o := FCodProfesorAProfesor[VFieldProfesor.AsInteger - FMinCodProfesor];
        FDistributivoAParalelo[I] := n;
        FDistributivoAProfesor[I] := o;
        FDistributivoAAulaTipo[I] := a;
        FDistributivoAMateria[I] := j;
        FParaleloMateriaAProfesor[n, j] := o;
        FParaleloMateriaADistributivo[n, j] := I;
        s := VFieldComposicion.AsString;
        VPos := 1;
        l := ss;
        // t := 0;
        while VPos <= Length(s) do
        begin
          VSesionADuracion[ss] := StrToInt(ExtractString(s, VPos, '.'));
          VSesionADistributivo[ss] := I;
          // Inc(t, VSesionADuracion[ss]);
          Inc(ss);
        end;
        SetLength(FDistributivoASesiones[I], ss - l);
        for m := l to ss - 1 do
        begin
          FDistributivoASesiones[I, m - l] := m
        end;
        // FParaleloADuracion[n] := FParaleloADuracion[n] + t;
        Next;
      end;
      SetLength(FSesionADistributivo, ss);
      SetLength(FSesionAMateria, ss);
      SetLength(FSesionAAulaTipo, ss);
      Move(VSesionADuracion[0], FSesionADuracion[0], ss * SizeOf(Smallint));
      FSesionADuracion[-1] := 1;
      Move(VSesionADistributivo[0], FSesionADistributivo[0], ss * SizeOf
          (Smallint));
      for I := 0 to ss - 1 do
      begin
        a := FSesionADistributivo[I];
        FSesionAMateria[I] := FDistributivoAMateria[a];
        FSesionAAulaTipo[I] := FDistributivoAAulaTipo[a];
      end;
    end;
  end;
  procedure CargarMoldeHorarioDetalle;
  var
    d, I, j, k, m, n, o, q, r, s: Integer;
  begin
    SetLength(FTimeTableDetailPattern, FParaleloCant, FPeriodoCant);
    SetLength(FParaleloASesionCant, FParaleloCant);
    SetLength(FParaleloADuracion, FParaleloCant);
    r := FPeriodoCant;
    for I := 0 to FParaleloCant - 1 do
      FillChar(FTimeTableDetailPattern[I, 0], r * SizeOf(Smallint), #$FF);
    for I := FDistributivoCant - 1 downto 0 do
    begin
      k := FDistributivoAParalelo[I];
      for m := High(FDistributivoASesiones[I]) downto 0 do
      begin
        n := FSesionADuracion[FDistributivoASesiones[I, m]];
        d := FParaleloADuracion[k];
        for o := n - 1 downto 0 do
        begin
          q := d + o;
          if (q < 0) or (q >= r) then
            raise Exception.CreateFmt(
              'Se desbordo Molde de ParaleloPeriodoASesion: ' +
                'Paralelo %d-%d Duracion %d', [FParaleloANivel[k],
              FParaleloAParaleloId[k], q]);
          FTimeTableDetailPattern[k, r - 1 - q] := FDistributivoASesiones[I, m];
        end;
        Inc(FParaleloADuracion[k], n);
      end;
    end;
    for I := 0 to FParaleloCant - 1 do
    begin
      j := 0;
      while j < FPeriodoCant do
      begin
        s := FTimeTableDetailPattern[I, j];
        d := FSesionADuracion[s];
        Inc(j, d);
        Inc(FParaleloASesionCant[I]);
        if s >= 0 then
          Inc(FProfesorCantHora[FParaleloMateriaAProfesor[I, FSesionAMateria[s]]
              ], d);
      end;
    end;
    FSesionCantidadDoble := 0;
    for I := 0 to FParaleloCant - 1 do
    begin
      j := FParaleloASesionCant[I];
      Inc(FSesionCantidadDoble, (j * (j - 1)) div 2);
    end;
  end;
begin
  inherited Create;
  FElitistCount := 3;
  with SourceDataModule do
  begin
    Configurar(ACruceProfesorValor, AProfesorFraccionamientoValor,
      ACruceAulaTipoValor, AHoraHuecaDesubicadaValor, ASesionCortadaValor,
      AMateriaNoDispersaValor);
    Cargar(TbProfesor, 'CodProfesor', FMinCodProfesor, FCodProfesorAProfesor,
      FProfesorACodProfesor);
    FProfesorCant := Length(FProfesorACodProfesor);
    SetLength(FProfesorCantHora, FProfesorCant);
    Cargar(TbNivel, 'CodNivel', FMinCodNivel, FCodNivelANivel, FNivelACodNivel);
    FNivelCant := Length(FNivelACodNivel);
    Cargar(TbEspecializacion, 'CodEspecializacion', FMinCodEspecializacion,
      FCodEspecializacionAEspecializacion, FEspecializacionACodEspecializacion);
    FEspecializacionCant := Length(FEspecializacionACodEspecializacion);
    CargarCurso;
    Cargar(TbParaleloId, 'CodParaleloId', FMinCodParaleloId,
      FCodParaleloIdAParaleloId, FParaleloIdACodParaleloId);
    Cargar(TbMateria, 'CodMateria', FMinCodMateria, FCodMateriaAMateria,
      FMateriaACodMateria);
    FMateriaCant := Length(FMateriaACodMateria);
    Cargar(TbDia, 'CodDia', FMinCodDia, FCodDiaADia, FDiaACodDia);
    FDiaCant := Length(FDiaACodDia);
    Cargar(TbHora, 'CodHora', FMinCodHora, FCodHoraAHora, FHoraACodHora);
    FHoraCant := Length(FHoraACodHora);
    Cargar(TbMateriaProhibicionTipo, 'CodMateProhibicionTipo',
      FMinCodMateProhibicionTipo,
      FCodMateProhibicionTipoAMateriaProhibicionTipo,
      FMateriaProhibicionTipoACodMateProhibicionTipo);
    Cargar(TbProfesorProhibicionTipo, 'CodProfProhibicionTipo',
      FMinCodProfProhibicionTipo,
      FCodProfProhibicionTipoAProfesorProhibicionTipo,
      FProfesorProhibicionTipoACodProfProhibicionTipo);
    Cargar(TbAulaTipo, 'CodAulaTipo', FMinCodAulaTipo, FCodAulaTipoAAulaTipo,
      FAulaTipoACodAulaTipo);
    FAulaTipoCant := Length(FAulaTipoACodAulaTipo);
    CargarPeriodo;
    CargarParalelo;
    CargarAulaTipo;
    CargarMateriaProhibicionTipo;
    CargarProfesorProhibicionTipo;
    CargarMateriaProhibicion;
    CargarProfesorProhibicion;
    CargarDistributivo;
    CargarMoldeHorarioDetalle;
  end;
end;

procedure TTimeTableModel.Configurar(ACruceProfesorValor,
  AProfesorFraccionamientoValor, ACruceAulaTipoValor,
  AHoraHuecaDesubicadaValor, ASesionCortadaValor,
  AMateriaNoDispersaValor: Double);
begin
  FCruceProfesorValor := ACruceProfesorValor;
  FProfesorFraccionamientoValor := AProfesorFraccionamientoValor;
  FCruceAulaTipoValor := ACruceAulaTipoValor;
  FHoraHuecaDesubicadaValor := AHoraHuecaDesubicadaValor;
  FSesionCortadaValor := ASesionCortadaValor;
  FMateriaNoDispersaValor := AMateriaNoDispersaValor;
end;

function TTimeTableModel.GetDiaAMaxPeriodo(Dia: Smallint): Smallint;
begin
  if Dia = FDiaCant - 1 then
    Result := FPeriodoCant - 1
  else
    Result := FDiaHoraAPeriodo[Dia + 1, 0] - 1;
end;

procedure TTimeTableModel.ReportParameters(AReport: TStrings);
begin
  AReport.Add(Format('Pesos:'#13#10 +
        '  Cruce de profesores          %8.2f'#13#10 +
        '  Fracc. h. profesores         %8.2f'#13#10 +
        '  Cruce de aulas:              %8.2f'#13#10 +
        '  Horas Huecas desubicadas:    %8.2f'#13#10 +
        '  Materias cortadas:           %8.2f'#13#10 +
        '  Materias no dispersas:       %8.2f', [CruceProfesorValor,
      ProfesorFraccionamientoValor, CruceAulaTipoValor,
      HoraHuecaDesubicadaValor, SesionCortadaValor, MateriaNoDispersaValor]));
end;

procedure CreateRandomFromModel(var ATimeTable: TTimeTable;
  ATimeTableModel: TTimeTableModel);
begin
  if not Assigned(ATimeTable) then
    ATimeTable := TTimeTable.Create(ATimeTableModel);
  ATimeTable.MakeRandom;
end;

procedure LoadFixedFromModel(var ATimeTable: TTimeTable;
  ATimeTableModel: TTimeTableModel; CodHorario: Integer);
begin
  if not Assigned(ATimeTable) then
    ATimeTable := TTimeTable.Create(ATimeTableModel);
  ATimeTable.LoadFromDataModule(CodHorario);
end;

procedure CrossIndividualsParalelo(var TimeTable1, TimeTable2: TTimeTable;
    AParalelo: Smallint);
  procedure RandomizeKey(ATimeTable: TTimeTable; var ARandomKey: TDynamicLongintArray);
  var
    Periodo, Duracion, Counter, MaxPeriodo: Smallint;
    NumberList: array [0 .. 4095] of Longint;
    PeriodoASesion: TDynamicSmallintArray;
  begin
    with ATimeTable.TimeTableModel do
    begin
      // Check(AParalelo, 'AleatorizarClaveAntes');
      Fillcrand32(NumberList, FParaleloASesionCant[AParalelo]);
      lSort(NumberList, 0, FParaleloASesionCant[AParalelo] - 1);
      PeriodoASesion := ATimeTable.ParaleloPeriodoASesion[AParalelo];
      Periodo := 0;
      Counter := 0;
      while Periodo < FPeriodoCant do
      begin
        Duracion := FSesionADuracion[PeriodoASesion[Periodo]];
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          ARandomKey[Periodo] := NumberList[Counter];
          Inc(Periodo);
        end;
        Inc(Counter);
      end;
    end;
  end;
var
  Sesion, Periodo, Duracion: Smallint;
  Key1, Key2, MaxPeriodo: Longint;
  RandomKey1, RandomKey2: TDynamicLongintArray;
begin
  with TimeTable1.TimeTableModel do
  begin
    SetLength(RandomKey1, FPeriodoCant);
    SetLength(RandomKey2, FPeriodoCant);
    RandomizeKey(TimeTable1, RandomKey1);
    RandomizeKey(TimeTable2, RandomKey2);
    SortSmallint(TimeTable1.ParaleloPeriodoASesion[AParalelo],
      RandomKey1, 0, FPeriodoCant - 1);
    SortSmallint(TimeTable2.ParaleloPeriodoASesion[AParalelo],
      RandomKey2, 0, FPeriodoCant - 1);
    Periodo := 0;
    while Periodo < FPeriodoCant do
    begin
      Sesion := FTimeTableDetailPattern[AParalelo, Periodo];
      Duracion := FSesionADuracion[Sesion];
      if crand32 mod 2 = 0 then
      begin
        Key1 := RandomKey1[Periodo];
        Key2 := RandomKey2[Periodo];
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          RandomKey1[Periodo] := Key2;
          RandomKey2[Periodo] := Key1;
          Inc(Periodo);
        end;
      end
      else
        Inc(Periodo, Duracion);
    end;
    SortLongint(RandomKey1, TimeTable1.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
    SortLongint(RandomKey2, TimeTable2.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
  end;
end;

procedure CrossIndividuals(var TimeTable1, TimeTable2: TTimeTable);
var
  Paralelo: Smallint;
begin
  with TimeTable1.TimeTableModel do
  begin
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      CrossIndividualsParalelo(TimeTable1, TimeTable2, Paralelo);
    end;
    TimeTable1.Update;
    TimeTable2.Update;
    TimeTable1.RecalculateValue := True;
    TimeTable2.RecalculateValue := True;
  end;
end;

constructor TTimeTable.Create(ATimeTableModel: TTimeTableModel);
begin
  inherited Create;
  FAntListaCambios := TList.Create;
  FModel := ATimeTableModel;
  FRecalculateValue := True;
  with TimeTableModel do
  begin
    SetLength(FParaleloPeriodoASesion, FParaleloCant, FPeriodoCant);
    SetLength(TablingInfo.FMateriaPeriodoCant, FMateriaCant, FPeriodoCant);
    SetLength(TablingInfo.FProfesorPeriodoCant, FProfesorCant, FPeriodoCant);
    SetLength(TablingInfo.FAulaTipoPeriodoCant, FAulaTipoCant, FPeriodoCant);
    SetLength(TablingInfo.FParaleloMateriaDiaMinHora, FParaleloCant, FMateriaCant, FDiaCant);
    SetLength(TablingInfo.FParaleloMateriaDiaMaxHora, FParaleloCant, FMateriaCant, FDiaCant);
    SetLength(TablingInfo.FDiaProfesorFraccionamiento, FDiaCant, FProfesorCant);
    SetLength(FParaleloMateriaNoDispersa, FParaleloCant);
    SetLength(FAntMateriaDiaMinHora, FMateriaCant, FDiaCant);
    SetLength(FAntMateriaDiaMaxHora, FMateriaCant, FDiaCant);
    SetLength(FAntDiaProfesorMinHora, FDiaCant, FProfesorCant);
    SetLength(FAntDiaProfesorMaxHora, FDiaCant, FProfesorCant);
  end;
end;

function TTimeTable.GetElitistValues(Index: Integer): Double;
begin
  case Index of
    0: Result := SesionCortada;
    1: Result := CruceProfesor;
    2: Result := CruceAulaTipo;
  end;
end;

procedure TTimeTable.MakeRandom;
var
  Paralelo, Periodo, Duracion, MaxPeriodo: Smallint;
  r: Longint;
  PeriodoASesion: TDynamicSmallintArray;
  ClaveAleatoria: TDynamicLongintArray;
begin
  with TimeTableModel do
  begin
    SetLength(ClaveAleatoria, FPeriodoCant);
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      Move(FTimeTableDetailPattern[Paralelo, 0], PeriodoASesion[0],
        FPeriodoCant * SizeOf(Smallint));
      Periodo := 0;
      while Periodo < FPeriodoCant do
      begin
        Duracion := FSesionADuracion[PeriodoASesion[Periodo]];
        r := crand32;
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          ClaveAleatoria[Periodo] := r;
          Inc(Periodo);
        end;
      end;
      SortLongint(ClaveAleatoria, PeriodoASesion, 0, FPeriodoCant - 1);
    end;
  end;
  Update;
  RecalculateValue := True;
end;

procedure TTimeTable.UpdateMateriaPeriodoCant;
var
  Paralelo, Periodo, Materia, Sesion: Smallint;
  PeriodoASesion: TDynamicSmallintArray;
begin
  with TimeTableModel, TablingInfo do
  begin
    for Materia := 0 to FMateriaCant - 1 do
    begin
      FillChar(FMateriaPeriodoCant[Materia, 0], FPeriodoCant * SizeOf(Smallint), #0);
    end;
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        Sesion := PeriodoASesion[Periodo];
        if Sesion >= 0 then
        begin
          Materia := FSesionAMateria[Sesion];
          Inc(FMateriaPeriodoCant[Materia, Periodo]);
        end;
      end;
    end;
  end;
end;

procedure TTimeTable.UpdateParaleloMateriaDiaMinMaxHora;
var
  Paralelo: Smallint;
begin
  with TimeTableModel do
    for Paralelo := 0 to FParaleloCant - 1 do
      UpdateParaleloMateriaDiaMinMaxHora(Paralelo);
end;

procedure TTimeTable.UpdateParaleloMateriaDiaMinMaxHora(AParalelo: Smallint);
var
  Periodo, Dia, Hora, Materia, Sesion: Smallint;
  PeriodoASesion: TDynamicSmallintArray;
begin
  with TimeTableModel, TablingInfo do
  begin
    for Materia := 0 to FMateriaCant - 1 do
    begin
      FillChar(FParaleloMateriaDiaMaxHora[AParalelo, Materia, 0],
        FDiaCant * SizeOf(Smallint), #$FF);
      FillChar(FParaleloMateriaDiaMinHora[AParalelo, Materia, 0],
        FDiaCant * SizeOf(Smallint), #$3F);
    end;
    PeriodoASesion := ParaleloPeriodoASesion[AParalelo];
    for Periodo := 0 to FPeriodoCant - 1 do
    begin
      Sesion := PeriodoASesion[Periodo];
      if Sesion >= 0 then
      begin
        Materia := FSesionAMateria[Sesion];
        Dia := FPeriodoADia[Periodo];
        Hora := FPeriodoAHora[Periodo];
        if FParaleloMateriaDiaMaxHora[AParalelo, Materia, Dia] < Hora then
          FParaleloMateriaDiaMaxHora[AParalelo, Materia, Dia] := Hora;
        if FParaleloMateriaDiaMinHora[AParalelo, Materia, Dia] > Hora then
          FParaleloMateriaDiaMinHora[AParalelo, Materia, Dia] := Hora;
      end;
    end;
    FParaleloMateriaNoDispersa[AParalelo] := GetParaleloMateriaNoDispersa
      (AParalelo, FParaleloMateriaDiaMaxHora[AParalelo]);
  end;
end;

procedure TTimeTable.UpdateDiaProfesorFraccionamiento;
var
  Dia, Profesor: Smallint;
begin
  with FModel, TablingInfo do
  begin
    for Dia := 0 to FDiaCant - 1 do
    begin
      for Profesor := 0 to FProfesorCant - 1 do
      begin
        FDiaProfesorFraccionamiento[Dia, Profesor] :=
          GetDiaProfesorFraccionamiento(Dia, Profesor);
      end;
    end;
  end;
end;

procedure TTimeTable.Swap(AParalelo, APeriodo1, APeriodo2: Smallint);
begin
  Normalize(AParalelo, APeriodo1);
  Normalize(AParalelo, APeriodo2);
  if APeriodo1 < APeriodo2 then
    InternalSwap(AParalelo, APeriodo1, APeriodo2)
  else if APeriodo2 < APeriodo1 then
    InternalSwap(AParalelo, APeriodo2, APeriodo1);
end;

procedure TTimeTable.InternalSwap(AParalelo, APeriodo1, APeriodo2: Smallint;
  FueEvaluado: Boolean = False);
var
  Materia, Duracion, Duracion1, Duracion2, Sesion1, Sesion2, Profesor: Smallint;
  PeriodoASesion, MateriaAProfesor: TDynamicSmallintArray;
  TmpMateriaDiaMinMaxHora: TDynamicSmallintArrayArray;
  TmpMateriaNoDispersa: Integer;
  procedure RealizarMovimiento;
  var
    l: Smallint;
  begin
    Move(PeriodoASesion[APeriodo1 + Duracion1], PeriodoASesion[APeriodo1 + Duracion2],
      (APeriodo2 - APeriodo1 - Duracion1) * SizeOf(Smallint));
    for l := Duracion1 - 1 downto 0 do
    begin
      PeriodoASesion[APeriodo2 + Duracion2 - Duracion1 + l] := Sesion1;
    end;
    for l := Duracion2 - 1 downto 0 do
    begin
      PeriodoASesion[APeriodo1 + l] := Sesion2;
    end;
  end;
  procedure DecCants(Periodo1, Periodo2: Smallint);
  var
    Periodo, Sesion, Profesor, AulaTipo: Smallint;
  begin
    with TimeTableModel, TablingInfo do
    for Periodo := Periodo1 to Periodo2 do
    begin
      Sesion := PeriodoASesion[Periodo];
      if Sesion >= 0 then
      begin
        Materia := FSesionAMateria[Sesion];
        Profesor := MateriaAProfesor[Materia];
        AulaTipo := FSesionAAulaTipo[Sesion];
        Dec(FProfesorPeriodoCant[Profesor, Periodo]);
        Dec(FMateriaPeriodoCant[Materia, Periodo]);
        Dec(FAulaTipoPeriodoCant[AulaTipo, Periodo]);
      end;
    end;
  end;
  procedure IncCants(Periodo1, Periodo2: Smallint);
  var
    Periodo, Sesion, Profesor, AulaTipo: Smallint;
  begin
    with TimeTableModel, TablingInfo do
    for Periodo := Periodo1 to Periodo2 do
    begin
      Sesion := PeriodoASesion[Periodo];
      if Sesion >= 0 then
      begin
        Materia := FSesionAMateria[Sesion];
        Profesor := MateriaAProfesor[Materia];
        AulaTipo := FSesionAAulaTipo[Sesion];
        Inc(FProfesorPeriodoCant[Profesor, Periodo]);
        Inc(FMateriaPeriodoCant[Materia, Periodo]);
        Inc(FAulaTipoPeriodoCant[AulaTipo, Periodo]);
      end;
    end;
  end;
var
  l: Smallint;
  pd: LongWord;
begin
  with TimeTableModel, TablingInfo do
  begin
    PeriodoASesion := ParaleloPeriodoASesion[AParalelo];
    MateriaAProfesor := FParaleloMateriaAProfesor[AParalelo];
    Sesion1 := PeriodoASesion[APeriodo1];
    Sesion2 := PeriodoASesion[APeriodo2];
    Duracion1 := FSesionADuracion[Sesion1];
    Duracion2 := FSesionADuracion[Sesion2];
    if Duracion1 = Duracion2 then
    begin
      DecCants(APeriodo1, APeriodo1 + Duracion1 - 1);
      DecCants(APeriodo2, APeriodo2 + Duracion2 - 1);
      for l := Duracion1 - 1 downto 0 do
      begin
        PeriodoASesion[APeriodo1 + l] := Sesion2;
        PeriodoASesion[APeriodo2 + l] := Sesion1;
      end;
      IncCants(APeriodo1, APeriodo1 + Duracion1 - 1);
      IncCants(APeriodo2, APeriodo2 + Duracion2 - 1);
    end
    else
    begin
      DecCants(APeriodo1, APeriodo2 + Duracion2 - 1);
      RealizarMovimiento;
      IncCants(APeriodo1, APeriodo2 + Duracion2 - 1);
    end;
    if FueEvaluado then
    begin
      TmpMateriaDiaMinMaxHora := FParaleloMateriaDiaMinHora[AParalelo];
      FParaleloMateriaDiaMinHora[AParalelo] := FAntMateriaDiaMinHora;
      FAntMateriaDiaMinHora := TmpMateriaDiaMinMaxHora;
      TmpMateriaDiaMinMaxHora := FParaleloMateriaDiaMaxHora[AParalelo];
      FParaleloMateriaDiaMaxHora[AParalelo] := FAntMateriaDiaMaxHora;
      FAntMateriaDiaMaxHora := TmpMateriaDiaMinMaxHora;
      TmpMateriaNoDispersa := FParaleloMateriaNoDispersa[AParalelo];
      FParaleloMateriaNoDispersa[AParalelo] := FAntMateriaNoDispersa;
      FAntMateriaNoDispersa := TmpMateriaNoDispersa;
      for l := FAntListaCambios.Count - 1 downto 0 do
      begin
        pd := LongWord(FAntListaCambios.Items[l]);
        Profesor := Smallint(pd);
        Duracion := Smallint(pd shr 16);
        FDiaProfesorFraccionamiento[Duracion, Profesor] :=
          GetDiaProfesorFraccionamiento(Duracion, Profesor);
      end;
      // UpdateDiaProfesorFraccionamiento;
    end
    else
    begin
      UpdateParaleloMateriaDiaMinMaxHora(AParalelo);
      UpdateDiaProfesorFraccionamiento;
    end;
  end;
end;

procedure TTimeTable.Normalize(AParalelo: Smallint; var APeriodo: Smallint);
var
  Sesion: Smallint;
  PeriodoASesion: TDynamicSmallintArray;
begin
  PeriodoASesion := FParaleloPeriodoASesion[AParalelo];
  Sesion := PeriodoASesion[APeriodo];
  if Sesion >= 0 then
    while (APeriodo > 0) and (Sesion = PeriodoASesion[APeriodo - 1]) do
      Dec(APeriodo);
end;

{Assembler version of Normalize}
(*
  procedure TTimeTable.Normalize(AParalelo: Smallint; var APeriodo: Smallint); assembler;
  asm
  push    ebx
  mov     eax, [eax + FParaleloPeriodoASesion]
  movsx   edx, AParalelo
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
    Add('--------------------------------------------------');
    Add('Detalle                     Cant.    Peso    Valor');
    Add('--------------------------------------------------');
    Add(Format('Cruce de profesores:        %5.d %7.2f %8.2f', [FCruceProfesor,
        TimeTableModel.CruceProfesorValor, CruceProfesorValor]));
    Add(Format('Fracc. h. profesores:       %5.d %7.2f %8.2f',
        [ProfesorFraccionamiento, TimeTableModel.ProfesorFraccionamientoValor,
        ProfesorFraccionamientoValor]));
    Add(Format('Cruce de aulas:             %5.d %7.2f %8.2f', [FCruceAulaTipo,
        TimeTableModel.CruceAulaTipoValor, CruceAulaTipoValor]));
    Add(Format('Horas Huecas desubicadas:   %5.d %7.2f %8.2f',
        [HoraHuecaDesubicada, TimeTableModel.HoraHuecaDesubicadaValor,
        HoraHuecaDesubicadaValor]));
    Add(Format('Materias cortadas:          %5.d %7.2f %8.2f', [SesionCortada,
        TimeTableModel.SesionCortadaValor, SesionCortadaValor]));
    Add(Format('Materias no dispersas:      %5.d %7.2f %8.2f',
        [MateriaNoDispersa, TimeTableModel.MateriaNoDispersaValor,
        MateriaNoDispersaValor]));
    Add(Format('Prohibiciones de materia:   %5.d         %8.2f',
        [MateriaProhibicion, MateriaProhibicionValor]));
    Add(Format('Prohibiciones de profesor:  %5.d         %8.2f',
        [ProfesorProhibicion, ProfesorProhibicionValor]));
    Add('--------------------------------------------------');
    Add(Format('Valor Total:                              %8.2f', [Value]));
  end;
end;

procedure TTimeTable.InternalMutate;
var
  RandNum: Longint;
  Paralelo, Periodo1, Periodo2: Smallint;
begin
  with TimeTableModel do
  begin
    RandNum := crand32;
    Periodo1 := RandNum mod FPeriodoCant; RandNum := RandNum div FPeriodoCant;
    Periodo2 := RandNum mod FPeriodoCant; RandNum := RandNum div FPeriodoCant;
    Paralelo := RandNum mod FParaleloCant;
    if ParaleloPeriodoASesion[Paralelo, Periodo1]
    <> ParaleloPeriodoASesion[Paralelo, Periodo2] then
      Swap(Paralelo, Periodo1, Periodo2);
  end;
end;

procedure TTimeTable.Mutate;
begin
  // Check('MutarAntes');
  InternalMutate;
  RecalculateValue := True;
  // Check('MutarDespues');
end;

procedure TTimeTable.Mutate(Orden: Integer);
var
  c: Integer;
begin
  // Check('MutarAntes(...)');
  for c := crand32 mod Orden downto 0 do
    InternalMutate;
  RecalculateValue := True;
  // Check('MutarDespues(...)');
end;

procedure TTimeTable.MutateDia;
var
  AulaTipo, Paralelo, Dia1, Dia2, Periodo, MinPeriodo1, MinPeriodo2,
    DPeriodo1, DPeriodo2, MaxPeriodo1, MaxPeriodo2: Smallint;
  b: array [0 .. 16383] of Smallint;
  PeriodoASesion: TDynamicSmallintArray;
  RecalcSwap: Boolean;
  Count: SizeInt;
begin
  // Check('MutarDiaAntes');
  with TimeTableModel do
  begin
    Dia1 := crand32 mod FDiaCant;
    repeat
      Dia2 := crand32 mod FDiaCant;
    until Dia1 <> Dia2;
    MinPeriodo1 := FDiaHoraAPeriodo[Dia1, 0];
    MinPeriodo2 := FDiaHoraAPeriodo[Dia2, 0];
    MaxPeriodo1 := FDiaAMaxPeriodo[Dia1];
    MaxPeriodo2 := FDiaAMaxPeriodo[Dia2];
    DPeriodo1 := MaxPeriodo1 - MinPeriodo1;
    DPeriodo2 := MaxPeriodo2 - MinPeriodo2;
    if DPeriodo1 = DPeriodo2 then
    begin
      RecalcSwap := False;
      Count := (DPeriodo1 + 1) * SizeOf(Smallint);
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
        if (DPeriodo1 = DPeriodo2)
           and ((MinPeriodo1 = 0)
                or (PeriodoASesion[MinPeriodo1 - 1] < 0)
                or (PeriodoASesion[MinPeriodo1 - 1] <> PeriodoASesion[MinPeriodo1]))
           and ((MinPeriodo2 = 0)
                or (PeriodoASesion[MinPeriodo2 - 1] < 0)
                or (PeriodoASesion[MinPeriodo2 - 1] <> PeriodoASesion[MinPeriodo2]))
           and ((MaxPeriodo1 = FPeriodoCant - 1)
                or (PeriodoASesion[MaxPeriodo1] < 0)
                or (PeriodoASesion[MaxPeriodo1] <> PeriodoASesion[MaxPeriodo1 + 1]))
           and ((MaxPeriodo2 = FPeriodoCant - 1)
                or (PeriodoASesion[MaxPeriodo2] < 0)
                or (PeriodoASesion[MaxPeriodo2] <> PeriodoASesion[MaxPeriodo2 + 1])) then
        begin
          Move(PeriodoASesion[MinPeriodo1], b[0], Count);
          Move(PeriodoASesion[MinPeriodo2], PeriodoASesion[MinPeriodo1], Count);
          Move(b[0], PeriodoASesion[MinPeriodo2], Count);
        end
        else
          RecalcSwap := True;
      end;
      if RecalcSwap then
      begin
        UpdateAulaTipoPeriodoCant(MinPeriodo1, MaxPeriodo1);
        UpdateAulaTipoPeriodoCant(MinPeriodo2, MaxPeriodo2);
      end
      else
      with TablingInfo do begin
        for AulaTipo := 0 to FAulaTipoCant - 1 do
        begin
          Move(FAulaTipoPeriodoCant[AulaTipo, MinPeriodo1], b[0], Count);
          Move(FAulaTipoPeriodoCant[AulaTipo, MinPeriodo2],
               FAulaTipoPeriodoCant[AulaTipo, MinPeriodo1], Count);
          Move(b[0], FAulaTipoPeriodoCant[AulaTipo, MinPeriodo2], Count);
          // TODO: DoGetCruceAulaTipo no required here
        end;
      end;
      PartialUpdate;
      FRecalculateValue := True;
    end;
  end;
end;

procedure TTimeTable.UpdateValue;
begin
  if RecalculateValue then
    CalculateValue;
end;

{$IFDEF DEBUG}
procedure TTimeTable.ErrorMsgValue(const AMethod: string);
begin
  MessageDlg(Format('TTimeTable.%s:', [AMethod]), 'Value not calculated yet',
    mtError, [mbOk], 0);
end;

function TTimeTable.GetValue: Double;
begin
  if RecalculateValue then
  begin
    ErrorMsgValue('GetValue');
    CalculateValue;
  end;
  Result := TablingInfo.FValue;
end;

function TTimeTable.GetMateriaNoDispersa: Integer;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetMateriaNoDispersa');
    CalculateValue;
  end;
  Result := TablingInfo.FMateriaNoDispersa;
end;

function TTimeTable.GetHoraHuecaDesubicada: Integer;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetHoraHuecaDesubicada');
    CalculateValue;
  end;
  Result := TablingInfo.FHoraHuecaDesubicada;
end;

function TTimeTable.GetSesionCortada: Integer;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetSesionCortada');
    CalculateValue;
  end;
  Result := TablingInfo.FSesionCortada;
end;

function TTimeTable.GetMateriaProhibicion: Integer;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetMateriaProhibicion');
    CalculateValue;
  end;
  Result := TablingInfo.FMateriaProhibicion;
end;

function TTimeTable.GetMateriaProhibicionValor: Double;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetMateriaProhibicionValor');
    CalculateValue;
  end;
  Result := TablingInfo.FMateriaProhibicionValor;
end;

function TTimeTable.GetProfesorProhibicion: Integer;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetProfesorProhibicion');
    CalculateValue;
  end;
  Result := TablingInfo.FProfesorProhibicion;
end;

function TTimeTable.GetProfesorProhibicionValor: Double;
begin
  if FRecalculateValue then
  begin
    ErrorMsgValue('GetProfesorProhibicionValor');
    CalculateValue;
  end;
  Result := TablingInfo.FProfesorProhibicionValor;
end;

{$ENDIF}

function TTimeTable.GetHoraHuecaDesubicadaValor: Double;
begin
  Result := TimeTableModel.FHoraHuecaDesubicadaValor * HoraHuecaDesubicada;
end;

procedure TTimeTable.DoGetHoraHuecaDesubicada;
var
  Paralelo, Periodo, Sesion: Integer;
  PeriodoASesion: PSmallintArray;
begin
  TablingInfo.FHoraHuecaDesubicada := 0;
  with TimeTableModel do
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      PeriodoASesion := @ParaleloPeriodoASesion[Paralelo, 0];
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        Sesion := PeriodoASesion[Periodo];
        if (Sesion < 0) and (FHoraCant - 1 <> FPeriodoAHora[Periodo]) then
          Inc(TablingInfo.FHoraHuecaDesubicada);
      end;
    end;
end;

function TTimeTable.GetSesionCortadaValor: Double;
begin
  Result := TimeTableModel.FSesionCortadaValor * SesionCortada;
end;

procedure TTimeTable.DoGetSesionCortada;
var
  I, j, d, s: Integer;
  l, m, k, t: Smallint;
begin
  TablingInfo.FSesionCortada := 0;
  with TimeTableModel, TablingInfo do
    for I := 0 to FParaleloCant - 1 do
    begin
      j := 0;
      while j < FPeriodoCant do
      begin
        s := ParaleloPeriodoASesion[I, j];
        l := FSesionADuracion[s];
        if s >= 0 then
        begin
          d := FPeriodoADia[j];
          m := FSesionAMateria[s];
          t := FParaleloMateriaDiaMaxHora[I, m, d] - FParaleloMateriaDiaMinHora
            [I, m, d];
          if t >= 0 then
          begin
            k := Abs(t + 1 - l);
            Inc(TablingInfo.FSesionCortada, k);
          end;
        end;
        Inc(j, l);
      end;
    end;
end;

function TTimeTable.GetMateriaNoDispersaValor: Double;
begin
  Result := TimeTableModel.FMateriaNoDispersaValor * MateriaNoDispersa;
end;

function TTimeTable.GetParaleloMateriaNoDispersa(AParalelo: Smallint;
  var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
var
  m, n, l, k, ns, ns1: Smallint;
  pm: PSmallintArray;
begin
  Result := 0;
  with TimeTableModel do
    for m := 0 to FMateriaCant - 1 do
    begin
      n := FParaleloMateriaADistributivo[AParalelo, m];
      if n >= 0 then
      begin
        l := 0;
        pm := @AMateriaDiaMaxHora[m, 0];
        for k := 0 to FDiaCant - 2 do
        begin
          if (pm[k] >= 0) xor (pm[k + 1] >= 0) then
            Inc(l);
        end;
        if pm[0] >= 0 then
          Inc(l);
        if pm[FDiaCant - 1] >= 0 then
          Inc(l);
        ns1 := Length(FDistributivoASesiones[n]);
        ns := 2 * min(ns1, FDiaCant + 1 - ns1);
        Inc(Result, Abs(ns - l))
      end;
    end;
end;

procedure TTimeTable.DoGetMateriaNoDispersa;
var
  I: Smallint;
begin
  TablingInfo.FMateriaNoDispersa := 0;
  with TimeTableModel do
  begin
    for I := 0 to FParaleloCant - 1 do
    begin
      Inc(TablingInfo.FMateriaNoDispersa, FParaleloMateriaNoDispersa[I]);
    end;
  end;
end;

procedure TTimeTable.DoGetProfesorFraccionamiento;
var
  p, d: Smallint;
begin
  with TimeTableModel, TablingInfo do
  begin
    TablingInfo.FProfesorFraccionamiento := 0;
    for d := 0 to FDiaCant - 1 do
    begin
      for p := 0 to FProfesorCant - 1 do
      begin
        Inc(TablingInfo.FProfesorFraccionamiento, FDiaProfesorFraccionamiento[d, p]);
      end;
    end;
  end;
end;

procedure TTimeTable.DoGetMateriaProhibicionValor;
var
  I, m, j, c: Integer;
  d: Double;
begin
  TablingInfo.FMateriaProhibicionValor := 0;
  TablingInfo.FMateriaProhibicion := 0;
  with TimeTableModel, TablingInfo do
    for I := 0 to High(FMateriaProhibicionAMateria) do
    begin
      m := FMateriaProhibicionAMateria[I];
      j := FMateriaProhibicionAPeriodo[I];
      c := FMateriaPeriodoCant[m, j];
      d := c * FMateriaProhibicionAValor[I];
      TablingInfo.FMateriaProhibicionValor := TablingInfo.FMateriaProhibicionValor + d;
      Inc(TablingInfo.FMateriaProhibicion, c);
    end;
end;

procedure TTimeTable.DoGetProfesorProhibicionValor;
var
  I, p, j, c: Smallint;
  d: Double;
begin
  with TimeTableModel do
  begin
    TablingInfo.FProfesorProhibicionValor := 0;
    TablingInfo.FProfesorProhibicion := 0;
    for I := 0 to High(FProfesorProhibicionAProfesor) do
    begin
      p := FProfesorProhibicionAProfesor[I];
      j := FProfesorProhibicionAPeriodo[I];
      c := TablingInfo.FProfesorPeriodoCant[p, j];
      d := c * FProfesorProhibicionAValor[I];
      TablingInfo.FProfesorProhibicionValor := TablingInfo.FProfesorProhibicionValor + d;
      Inc(TablingInfo.FProfesorProhibicion, c);
    end;
  end;
end;

procedure TTimeTable.DoGetCruceProfesor;
var
  j, p, c: Smallint;
  r: PSmallintArray;
begin
  TablingInfo.FCruceProfesor := 0;
  with TimeTableModel, TablingInfo do
  begin
    for p := 0 to FProfesorCant - 1 do
    begin
      r := @FProfesorPeriodoCant[p, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        c := r[j];
        if c > 1 then
          Inc(TablingInfo.FCruceProfesor, c - 1);
      end;
    end;
  end;
end;

procedure TTimeTable.DoGetCruceAulaTipo;
var
  Periodo, AulaTipo, Cruces: Smallint;
  VPeriodoCant: PSmallintArray;
begin
  with TimeTableModel, TablingInfo do
  begin
    FCruceAulaTipo := 0;
    for AulaTipo := 0 to FAulaTipoCant - 1 do
    begin
      VPeriodoCant := @FAulaTipoPeriodoCant[AulaTipo, 0];
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        Cruces := VPeriodoCant[Periodo] - FAulaTipoACantidad[AulaTipo];
        if Cruces > 0 then
          Inc(FCruceAulaTipo, Cruces);
      end;
    end;
  end;
end;

function TTimeTable.GetCruceProfesorValor: Double;
begin
  Result := TimeTableModel.FCruceProfesorValor * TablingInfo.FCruceProfesor;
end;

function TTimeTable.GetProfesorFraccionamientoValor: Double;
begin
  Result := TimeTableModel.FProfesorFraccionamientoValor *
    TablingInfo.FProfesorFraccionamiento;
end;

function TTimeTable.GetCruceAulaTipoValor: Double;
begin
  Result := TimeTableModel.FCruceAulaTipoValor * TablingInfo.FCruceAulaTipo;
end;

procedure TTimeTable.CalculateValue;
begin
  RecalculateValue := False;
  with TimeTableModel do
  begin
    DoGetCruceAulaTipo;
    DoGetCruceProfesor;
    DoGetHoraHuecaDesubicada;
    DoGetMateriaNoDispersa;
    DoGetMateriaProhibicionValor;
    DoGetProfesorFraccionamiento;
    DoGetProfesorProhibicionValor;
    DoGetSesionCortada;
    with TablingInfo do
      FValue :=
      Self.CruceAulaTipoValor +
      Self.CruceProfesorValor +
      FHoraHuecaDesubicada * FHoraHuecaDesubicadaValor +
      FMateriaNoDispersa * FMateriaNoDispersaValor +
      FMateriaProhibicionValor +
      FProfesorFraccionamiento * FProfesorFraccionamientoValor +
      FProfesorProhibicionValor +
      FSesionCortada * FSesionCortadaValor;
  end;
end;

procedure TTimeTable.UpdateProfesorPeriodoCant;
var
  I, j, p, s: Smallint;
  q, r: PSmallintArray;
begin
  with TimeTableModel, TablingInfo do
  begin
    for I := 0 to FProfesorCant - 1 do
      FillChar(FProfesorPeriodoCant[I, 0], FPeriodoCant * SizeOf(Smallint), #0);
    for I := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[I, 0];
      r := @FParaleloMateriaAProfesor[I, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          p := r[FSesionAMateria[s]];
          Inc(FProfesorPeriodoCant[p, j]);
        end;
      end;
    end;
  end;
end;

procedure TTimeTable.UpdateAulaTipoPeriodoCant(APeriodo1, APeriodo2: Smallint);
var
  AulaTipo, Paralelo, Periodo, Sesion: Smallint;
  PeriodoASesion: PSmallintArray;
begin
  with TimeTableModel, TablingInfo do
  begin
    for AulaTipo := 0 to FAulaTipoCant - 1 do
      FillChar(FAulaTipoPeriodoCant[AulaTipo, APeriodo1],
        (APeriodo2 - APeriodo1 + 1) * SizeOf(Smallint), #0);
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      PeriodoASesion := @ParaleloPeriodoASesion[Paralelo, 0];
      for Periodo := APeriodo1 to APeriodo2 do
      begin
        Sesion := PeriodoASesion[Periodo];
        if Sesion >= 0 then
        begin
          AulaTipo := FSesionAAulaTipo[Sesion];
          Inc(FAulaTipoPeriodoCant[AulaTipo, Periodo]);
        end;
      end;
    end;
  end;
end;

procedure TTimeTable.UpdateAulaTipoPeriodoCant;
begin
  UpdateAulaTipoPeriodoCant(0, TimeTableModel.FPeriodoCant - 1);
end;

function TTimeTable.EvaluateInternalSwap(AParalelo, APeriodo1, APeriodo2: Smallint): Double;
var
  Duracion1, Duracion2, Sesion1, Sesion2, MinPeriodo, MaxPeriodo,
  Materia1, Materia2, Profesor1, Profesor2: Smallint;
  PeriodoASesion, MateriaAProfesor: PSmallintArray;
  FIncDiaProfesorCantHora, FIncProfesorPeriodoCant: TDynamicSmallintArrayArray;
  // TList sera usado como arreglo de enteros de 32 bits, no de punteros!
  procedure InsertarCambio(Dia, Profesor: Smallint);
  var
    v: LongWord;
  begin
    v := Dia shl 16 + Profesor;
    if FAntListaCambios.IndexOf(Pointer(v)) < 0 then
      FAntListaCambios.Add(Pointer(v));
  end;
  function _EvaluarCruceProfesor: Smallint;
  var
    l, di_, di1_: Smallint;
  begin
    with FModel, TablingInfo do
    begin
      Result := 0;
      if Profesor1 <> Profesor2 then
      begin
        if Profesor1 >= 0 then
        begin
          for l := Duracion1 - 1 downto 0 do
          begin
            if FProfesorPeriodoCant[Profesor1, APeriodo2 + l] >= 1 then
            begin
              Inc(Result);
            end;
            if FProfesorPeriodoCant[Profesor1, APeriodo1 + l] > 1 then
            begin
              Dec(Result);
            end;
            di_ := FPeriodoADia[APeriodo1 + l];
            di1_ := FPeriodoADia[APeriodo2 + l];
            Inc(FIncProfesorPeriodoCant[Profesor1, APeriodo2 + l]);
            Inc(FIncDiaProfesorCantHora[di1_, Profesor1]);
            InsertarCambio(di1_, Profesor1);
            Dec(FIncDiaProfesorCantHora[di_, Profesor1]);
            Dec(FIncProfesorPeriodoCant[Profesor1, APeriodo1 + l]);
            InsertarCambio(di_, Profesor1);
          end;
        end;
        if Profesor2 >= 0 then
        begin
          for l := Duracion1 - 1 downto 0 do
          begin
            if ProfesorPeriodoCant[Profesor2, APeriodo1 + l] >= 1 then
              Inc(Result);
            if ProfesorPeriodoCant[Profesor2, APeriodo2 + l] > 1 then
              Dec(Result);
            di_ := FPeriodoADia[APeriodo1 + l];
            di1_ := FPeriodoADia[APeriodo2 + l];
            Inc(FIncProfesorPeriodoCant[Profesor2, APeriodo1 + l]);
            Inc(FIncDiaProfesorCantHora[di_, Profesor2]);
            InsertarCambio(di_, Profesor2);
            Dec(FIncProfesorPeriodoCant[Profesor2, APeriodo2 + l]);
            Dec(FIncDiaProfesorCantHora[di1_, Profesor2]);
            InsertarCambio(di1_, Profesor2);
          end;
        end;
      end;
    end;
  end;
  function _EvaluarCruceProfesorMovido: Integer;
  var
    p_, p1_, j_, s_, s1_, di_: Smallint;
  begin
    with FModel do
    begin
      Result := 0;
      for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
          p_ := MateriaAProfesor[FSesionAMateria[s_]]
        else
          p_ := -1;
        if p_ <> Profesor2 then
        begin
          di_ := FPeriodoADia[j_];
          if (p_ >= 0) then
          begin
            if ProfesorPeriodoCant[p_, j_] > 1 then
            begin
              Dec(Result);
            end;
            Dec(FIncProfesorPeriodoCant[p_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p_]);
            InsertarCambio(di_, p_);
          end;
          if (Profesor2 >= 0) then
          begin
            if ProfesorPeriodoCant[Profesor2, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorPeriodoCant[Profesor2, j_]);
            Inc(FIncDiaProfesorCantHora[di_, Profesor2]);
            InsertarCambio(di_, Profesor2);
          end;
        end;
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s1_ := PeriodoASesion[j_];
        if s1_ >= 0 then
          p1_ := MateriaAProfesor[FSesionAMateria[s1_]]
        else
          p1_ := -1;
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if s_ >= 0 then
          p_ := MateriaAProfesor[FSesionAMateria[s_]]
        else
          p_ := -1;
        if p_ <> p1_ then
        begin
          di_ := FPeriodoADia[j_];
          if p1_ >= 0 then
          begin
            if ProfesorPeriodoCant[p1_, j_] > 1 then
              Dec(Result);
            Dec(FIncProfesorPeriodoCant[p1_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p1_]);
            InsertarCambio(di_, p1_);
          end;
          if p_ >= 0 then
          begin
            if ProfesorPeriodoCant[p_, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorPeriodoCant[p_, j_]);
            Inc(FIncDiaProfesorCantHora[di_, p_]);
            InsertarCambio(di_, p_);
          end;
        end;
      end;
      for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
          p1_ := MateriaAProfesor[FSesionAMateria[s_]]
        else
          p1_ := -1;
        if Profesor1 <> p1_ then
        begin
          di_ := FPeriodoADia[j_];
          if p1_ >= 0 then
          begin
            if (ProfesorPeriodoCant[p1_, j_] > 1) then
              Dec(Result);
            Dec(FIncProfesorPeriodoCant[p1_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p1_]);
            InsertarCambio(di_, p1_);
          end;
          if Profesor1 >= 0 then
          begin
            if ProfesorPeriodoCant[Profesor1, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorPeriodoCant[Profesor1, j_]);
            Inc(FIncDiaProfesorCantHora[di_, Profesor1]);
            InsertarCambio(di_, Profesor1);
          end;
        end;
      end;
    end;
  end;
  function _EvaluarProfesorMinMaxMovido: Integer;
    function GetAntDiaProfesorFraccionamiento(di, p: Smallint): Smallint;
    var
      h_, iMax, iMin, iCant: Smallint;
    begin
      iCant := 0;
      iMax := -1;
      iMin := 32767;
      with TimeTableModel, TablingInfo do
        for h_ := FDiaHoraAPeriodo[di, 0] to FDiaAMaxPeriodo[di] do
        begin
          if (FIncProfesorPeriodoCant[p, h_] + FProfesorPeriodoCant[p, h_] > 0)
            or (FProfesorProhibicionTipoAValor[
              FProfesorPeriodoAProfesorProhibicionTipo[p, h_]] =
              FMaxProfesorProhibicionTipoValor) then
          begin
            iMax := FPeriodoAHora[h_];
            Inc(iCant);
            if iMin > iMax then
              iMin := iMax;
          end;
        end;
      if iCant = 0 then
        Result := 0
      else
        Result := iMax - iMin + 1 - iCant;
    end;

  var
    p, di: Smallint;
    pd: LongWord;
    I: Integer;
  begin
    Result := 0;
    with FModel, TablingInfo do
      for I := FAntListaCambios.Count - 1 downto 0 do
      begin
        pd := LongWord(FAntListaCambios.Items[I]);
        p := Smallint(pd);
        di := Smallint(pd shr 16);
        Inc(Result, GetAntDiaProfesorFraccionamiento(di, p)
            - FDiaProfesorFraccionamiento[di, p]);
      end;
  end;
  procedure ActMateriaDiaMinMaxEntraMovido;
    procedure Preparar;
    var
      j_: Smallint;
    begin
      with TimeTableModel do
      begin
        for j_ := 0 to FMateriaCant - 1 do
        begin
          FillChar(FAntMateriaDiaMaxHora[j_, 0], FDiaCant * SizeOf(Smallint),
            #$FF);
          FillChar(FAntMateriaDiaMinHora[j_, 0], FDiaCant * SizeOf(Smallint),
            #$3F);
        end;
      end;
    end;

  var
    m_, di_, h, s_, j_: Smallint;
  begin
    Preparar;
    with TimeTableModel do
    begin
      for j_ := 0 to APeriodo1 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[m_, di_] < h then
            FAntMateriaDiaMaxHora[m_, di_] := h;
          if FAntMateriaDiaMinHora[m_, di_] > h then
            FAntMateriaDiaMinHora[m_, di_] := h;
        end;
      end;
      if Sesion2 >= 0 then
      begin
        for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
        begin
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[Materia2, di_] < h then
            FAntMateriaDiaMaxHora[Materia2, di_] := h;
          if FAntMateriaDiaMinHora[Materia2, di_] > h then
            FAntMateriaDiaMinHora[Materia2, di_] := h;
        end;
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[m_, di_] < h then
            FAntMateriaDiaMaxHora[m_, di_] := h;
          if FAntMateriaDiaMinHora[m_, di_] > h then
            FAntMateriaDiaMinHora[m_, di_] := h;
        end;
      end;
      if Sesion1 >= 0 then
      begin
        for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
        begin
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[Materia1, di_] < h then
            FAntMateriaDiaMaxHora[Materia1, di_] := h;
          if FAntMateriaDiaMinHora[Materia1, di_] > h then
            FAntMateriaDiaMinHora[Materia1, di_] := h;
        end;
      end;
      for j_ := APeriodo2 + Duracion2 to FPeriodoCant - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[m_, di_] < h then
            FAntMateriaDiaMaxHora[m_, di_] := h;
          if FAntMateriaDiaMinHora[m_, di_] > h then
            FAntMateriaDiaMinHora[m_, di_] := h;
        end;
      end;
    end;
  end;
  function _EvaluarSesionCortadaMovido: Smallint;
  var
    j_, s_, d_, di_, m_, t: Smallint;
  begin
    with TimeTableModel, TablingInfo do
    begin
      Result := 0;
      j_ := MinPeriodo;
      Normalize(AParalelo, j_);
      if j_ <> MinPeriodo then
        Inc(j_, FSesionADuracion[PeriodoASesion[j_]]);
      while j_ <= MaxPeriodo do
      begin
        s_ := PeriodoASesion[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FPeriodoADia[j_];
          m_ := FSesionAMateria[s_];
          t := FParaleloMateriaDiaMaxHora[AParalelo, m_, di_] -
            FParaleloMateriaDiaMinHora[AParalelo, m_, di_];
          if t >= 0 then
          begin
            Dec(Result, Abs(t + 1 - d_));
          end
        end;
        Inc(j_, d_);
      end;
      j_ := MinPeriodo;
      Normalize(AParalelo, j_);
      if j_ <> MinPeriodo then
        Inc(j_, FSesionADuracion[PeriodoASesion[j_]]);
      while j_ < APeriodo1 do
      begin
        s_ := PeriodoASesion[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FPeriodoADia[j_];
          m_ := FSesionAMateria[s_];
          t := FAntMateriaDiaMaxHora[m_, di_] - FAntMateriaDiaMinHora[m_, di_];
          if t >= 0 then
          begin
            Inc(Result, Abs(t + 1 - d_));
          end
        end;
        Inc(j_, d_);
      end;
      if Sesion2 >= 0 then
      begin
        di_ := FPeriodoADia[APeriodo1];
        t := FAntMateriaDiaMaxHora[Materia2, di_] - FAntMateriaDiaMinHora[Materia2, di_];
        if t >= 0 then
        begin
          Inc(Result, Abs(t + 1 - Duracion2));
        end
      end;
      Inc(j_, Duracion1);
      while j_ < APeriodo2 do
      begin
        s_ := PeriodoASesion[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FPeriodoADia[j_ + Duracion2 - Duracion1];
          m_ := FSesionAMateria[s_];
          t := FAntMateriaDiaMaxHora[m_, di_] - FAntMateriaDiaMinHora[m_, di_];
          if t >= 0 then
          begin
            Inc(Result, Abs(t + 1 - d_));
          end
        end;
        Inc(j_, d_);
      end;
      if Sesion1 >= 0 then
      begin
        di_ := FPeriodoADia[APeriodo2 + Duracion2 - Duracion1];
        t := FAntMateriaDiaMaxHora[Materia1, di_] - FAntMateriaDiaMinHora[Materia1, di_];
        if t >= 0 then
        begin
          Inc(Result, Abs(t + 1 - Duracion1));
        end
      end;
      Inc(j_, Duracion2);
      while j_ <= MaxPeriodo do
      begin
        s_ := PeriodoASesion[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FPeriodoADia[j_];
          m_ := FSesionAMateria[s_];
          t := FAntMateriaDiaMaxHora[m_, di_] - FAntMateriaDiaMinHora[m_, di_];
          if t >= 0 then
          begin
            Inc(Result, Abs(t + 1 - d_));
          end
        end;
        Inc(j_, d_);
      end;
    end;
  end;
  function _EvaluarCruceAulaTipo: Smallint;
  var
    a, a1, l, c, c1: Smallint;
  begin
    with FModel do
    begin
      if Sesion1 >= 0 then
        a := FSesionAAulaTipo[Sesion1]
      else
        a := -1;
      if Sesion2 >= 0 then
        a1 := FSesionAAulaTipo[Sesion2]
      else
        a1 := -1;
      if a = a1 then
        Result := 0
      else
      begin
        Result := 0;
        if a >= 0 then
        begin
          c := FAulaTipoACantidad[a];
          for l := Duracion1 - 1 downto 0 do
          begin
            if AulaTipoPeriodoCant[a, APeriodo2 + l] >= c then
              Inc(Result);
            if AulaTipoPeriodoCant[a, APeriodo1 + l] > c then
              Dec(Result);
          end;
        end;
        if a1 >= 0 then
        begin
          c1 := FAulaTipoACantidad[a1];
          for l := Duracion1 - 1 downto 0 do
          begin
            if AulaTipoPeriodoCant[a1, APeriodo1 + l] >= c1 then
              Inc(Result);
            if AulaTipoPeriodoCant[a1, APeriodo2 + l] > c1 then
              Dec(Result);
          end;
        end;
      end;
    end;
  end;
  function _EvaluarCruceAulaTipoMovido: Integer;
  var
    a, a1, c, c1, j_, s_, s1_: Smallint;
  begin
    with FModel do
    begin
      Result := 0;
      c := 0;
      c1 := 0;
      if Sesion2 >= 0 then
      begin
        a1 := FSesionAAulaTipo[Sesion2];
        c1 := FAulaTipoACantidad[a1];
      end
      else
        a1 := -1;
      for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
          a := FSesionAAulaTipo[s_]
        else
          a := -1;
        if a <> a1 then
        begin
          if a >= 0 then
          begin
            c := FAulaTipoACantidad[a];
            if AulaTipoPeriodoCant[a, j_] > c then
              Dec(Result);
          end;
          if a1 >= 0 then
          begin
            if AulaTipoPeriodoCant[a1, j_] >= c1 then
              Inc(Result);
          end;
        end;
      end;
      if Sesion1 >= 0 then
      begin
        a := FSesionAAulaTipo[Sesion1];
        c := FAulaTipoACantidad[a];
      end
      else
        a := -1;
      for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
        begin
          a1 := FSesionAAulaTipo[s_];
          c1 := FAulaTipoACantidad[a1];
        end
        else
          a1 := -1;
        if a <> a1 then
        begin
          if a1 >= 0 then
          begin
            if AulaTipoPeriodoCant[a1, j_] > c1 then
              Dec(Result);
          end;
          if (a >= 0) then
          begin
            if AulaTipoPeriodoCant[a, j_] >= c then
              Inc(Result);
          end;
        end;
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s1_ := PeriodoASesion[j_];
        if s1_ >= 0 then
        begin
          a1 := FSesionAAulaTipo[s1_];
          c1 := FAulaTipoACantidad[a1];
        end
        else
          a1 := -1;
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if s_ >= 0 then
        begin
          a := FSesionAAulaTipo[s_];
          c := FAulaTipoACantidad[a];
        end
        else
          a := -1;
        if a <> a1 then
        begin
          if a1 >= 0 then
          begin
            if AulaTipoPeriodoCant[a1, j_] > c1 then
              Dec(Result);
          end;
          if a >= 0 then
          begin
            if AulaTipoPeriodoCant[a, j_] >= c then
              Inc(Result);
          end;
        end;
      end;
    end;
  end;
  function _EvaluarHoraHuecaDesubicada: Smallint;
  var
    k: Smallint;
  begin
    Result := 0;
    with TimeTableModel do
      if Sesion1 <> Sesion2 then
      begin
        if Sesion1 < 0 then
        begin
          for k := 0 to Duracion1 - 1 do
          begin
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo1 + k] then
              Dec(Result);
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo2 + k] then
              Inc(Result);
          end;
        end
        else if Sesion2 < 0 then
        begin
          for k := 0 to Duracion1 - 1 do
          begin
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo1 + k] then
              Inc(Result);
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo2 + k] then
              Dec(Result);
          end;
        end;
      end;
  end;
  function _EvaluarHoraHuecaDesubicadaMovido: Smallint;
  var
    j_, s_: Smallint;
  begin
    with FModel do
    begin
      Result := 0;
      for j_ := APeriodo1 to APeriodo2 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if (s_ < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Dec(Result);
      end;
      for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
      begin
        if (Sesion2 < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Inc(Result);
      end;
      for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
      begin
        if (Sesion1 < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Inc(Result);
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if (s_ < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Inc(Result);
      end;
    end;
  end;
  function _EvaluarMateriaNoDispersaMovido: Smallint;
  begin
    FAntMateriaNoDispersa := GetParaleloMateriaNoDispersa
      (AParalelo, FAntMateriaDiaMaxHora);
    Result := FAntMateriaNoDispersa - FParaleloMateriaNoDispersa[AParalelo];
  end;
  function _EvaluarMateriaProhibicion: Double;
  var
    k, mp, mp1: Smallint;
  begin
    with TimeTableModel do
    begin
      Result := 0;
      if Sesion1 <> Sesion2 then
      begin
        if Sesion1 >= 0 then
        begin
          for k := 0 to Duracion1 - 1 do
          begin
            mp := FMateriaPeriodoAMateriaProhibicionTipo[Materia1, APeriodo1 + k];
            mp1 := FMateriaPeriodoAMateriaProhibicionTipo[Materia1, APeriodo2 + k];
            if mp <> mp1 then
            begin
              if mp >= 0 then
                Result := Result - FMateriaProhibicionTipoAValor[mp];
              if mp1 >= 0 then
                Result := Result + FMateriaProhibicionTipoAValor[mp1];
            end;
          end;
        end;
        if Sesion2 >= 0 then
        begin
          for k := 0 to Duracion1 - 1 do
          begin
            mp1 := FMateriaPeriodoAMateriaProhibicionTipo[Materia2, APeriodo2 + k];
            mp := FMateriaPeriodoAMateriaProhibicionTipo[Materia2, APeriodo1 + k];
            if mp <> mp1 then
            begin
              if mp1 >= 0 then
                Result := Result - FMateriaProhibicionTipoAValor[mp1];
              if mp >= 0 then
                Result := Result + FMateriaProhibicionTipoAValor[mp];
            end;
          end;
        end;
      end
    end;
  end;
  function _EvaluarMateriaProhibicionMovido: Double;
  var
    j_, m_, mp, s_: Smallint;
  begin
    with TimeTableModel do
    begin
      Result := 0;
      for j_ := APeriodo1 to APeriodo2 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          mp := FMateriaPeriodoAMateriaProhibicionTipo[m_, j_];
          if mp >= 0 then
            Result := Result - FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if Sesion2 >= 0 then
      begin
        for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
        begin
          mp := FMateriaPeriodoAMateriaProhibicionTipo[Materia2, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if Sesion1 >= 0 then
      begin
        for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
        begin
          mp := FMateriaPeriodoAMateriaProhibicionTipo[Materia1, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          mp := FMateriaPeriodoAMateriaProhibicionTipo[m_, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
    end;
  end;
  function _EvaluarProfesorProhibicion: Double;
  var
    p, p1, k, pp: Smallint;
  begin
    with TimeTableModel do
    begin
      Result := 0;
      if Sesion1 <> Sesion2 then
      begin
        if Sesion1 >= 0 then
        begin
          p := MateriaAProfesor[Materia1];
          for k := 0 to Duracion1 - 1 do
          begin
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p, APeriodo1 + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p, APeriodo2 + k];
            if pp >= 0 then
              Result := Result + FProfesorProhibicionTipoAValor[pp];
          end;
        end;
        if Sesion2 >= 0 then
        begin
          p1 := MateriaAProfesor[Materia2];
          for k := 0 to Duracion1 - 1 do
          begin
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p1, APeriodo2 + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p1, APeriodo1 + k];
            if pp >= 0 then
              Result := Result + FProfesorProhibicionTipoAValor[pp];
          end;
        end;
      end
    end;
  end;
  function _EvaluarProfesorProhibicionMovido: Double;
  var
    j_, p_, pp, s_: Smallint;
  begin
    with TimeTableModel do
    begin
      Result := 0;
      for j_ := APeriodo1 to APeriodo2 + Duracion2 - 1 do
      begin
        s_ := PeriodoASesion[j_];
        if s_ >= 0 then
        begin
          p_ := MateriaAProfesor[FSesionAMateria[s_]];
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result - FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if Sesion2 >= 0 then
      begin
        p_ := MateriaAProfesor[Materia2];
        for j_ := APeriodo1 to APeriodo1 + Duracion2 - 1 do
        begin
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if Sesion1 >= 0 then
      begin
        p_ := MateriaAProfesor[Materia1];
        for j_ := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
        begin
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      for j_ := APeriodo1 + Duracion2 to APeriodo2 + Duracion2 - Duracion1 - 1 do
      begin
        s_ := PeriodoASesion[j_ + Duracion1 - Duracion2];
        if s_ >= 0 then
        begin
          p_ := MateriaAProfesor[FSesionAMateria[s_]];
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
    end;
  end;

begin
  with FModel do
  begin
    PeriodoASesion := @ParaleloPeriodoASesion[AParalelo, 0];
    MateriaAProfesor := @FParaleloMateriaAProfesor[AParalelo, 0];
    Sesion1 := PeriodoASesion[APeriodo1];
    Sesion2 := PeriodoASesion[APeriodo2];
    Duracion1 := FSesionADuracion[Sesion1];
    Duracion2 := FSesionADuracion[Sesion2];
    if Sesion1 >= 0 then
    begin
      Materia1 := FSesionAMateria[Sesion1];
      Profesor1 := MateriaAProfesor[Materia1];
    end
    else
    begin
      Materia1 := -1;
      Profesor1 := -1;
    end;
    if Sesion2 >= 0 then
    begin
      Materia2 := FSesionAMateria[Sesion2];
      Profesor2 := MateriaAProfesor[Materia2];
    end
    else
    begin
      Materia2 := -1;
      Profesor2 := -1;
    end;
    MinPeriodo := FDiaHoraAPeriodo[FPeriodoADia[APeriodo1], 0];
    MaxPeriodo := FDiaAMaxPeriodo[FPeriodoADia[APeriodo2 + Duracion2 - 1]];
    SetLength(FIncDiaProfesorCantHora, FDiaCant, FProfesorCant);
    SetLength(FIncProfesorPeriodoCant, FProfesorCant, FPeriodoCant);
    ActMateriaDiaMinMaxEntraMovido;
    // ActDiaProfesorMinMaxEntraMovido;
    FAntListaCambios.Clear;
    if Duracion1 = Duracion2 then
    begin
      Result := FCruceProfesorValor * _EvaluarCruceProfesor +
        FProfesorFraccionamientoValor * _EvaluarProfesorMinMaxMovido +
        FSesionCortadaValor * _EvaluarSesionCortadaMovido +
        FCruceAulaTipoValor * _EvaluarCruceAulaTipo +
        FHoraHuecaDesubicadaValor * _EvaluarHoraHuecaDesubicada +
        FMateriaNoDispersaValor * _EvaluarMateriaNoDispersaMovido +
        _EvaluarMateriaProhibicion + _EvaluarProfesorProhibicion;
    end
    else
    begin
      Result := FCruceProfesorValor * _EvaluarCruceProfesorMovido +
        FProfesorFraccionamientoValor * _EvaluarProfesorMinMaxMovido +
        FSesionCortadaValor * _EvaluarSesionCortadaMovido +
        FCruceAulaTipoValor * _EvaluarCruceAulaTipoMovido +
        FHoraHuecaDesubicadaValor * _EvaluarHoraHuecaDesubicadaMovido +
        FMateriaNoDispersaValor * _EvaluarMateriaNoDispersaMovido +
        _EvaluarMateriaProhibicionMovido + _EvaluarProfesorProhibicionMovido;
    end;
  end;
end;

{
  procedure TObjetoTimeTableModel.Check(AParalelo: Smallint; s: string);
  var
  j, d: Smallint;
  p: PSmallintArray;
  q: PLongintArray;
  begin
  p := @FParaleloPeriodoASesion[AParalelo, 0];
  q := @FClaveAleatoria[AParalelo, 0];
  j := 0;
  with TimeTableModel do
  begin
  while j < FPeriodoCant do
  begin
  d := FSesionADuracion[p[j]];
  if q[j] <> q[j + d - 1] then
  raise Exception.Create('Error de sincronizacion entre clave aleatoria, duracion y periodos ' + s);
  if p[j] <> p[j + d - 1] then
  raise Exception.Create('Error de sincronizacion entre sesion, duracion y periodos ' + s);
  j := j + d;
  end;
  end;
  end;

  procedure TObjetoTimeTableModel.Check(s: string);
  var
  i: Smallint;
  begin
  with TimeTableModel do
  begin
  for i := 0 to FParaleloCant - 1 do
  begin
  Check(i, s);
  end;
  end;
  end;
}

function TTimeTable.InternalDownHillEach(AParalelo: Smallint; var Delta: Double): Boolean;
var
  Periodo1, Periodo2, Duracion: Smallint;
  DValue: Double;
  PeriodoASesion: TDynamicSmallintArray;
begin
  with FModel do
  begin
    Result := True;
    Periodo1 := 0;
    PeriodoASesion := FParaleloPeriodoASesion[AParalelo];
    while Periodo1 < FPeriodoCant do
    begin
      Periodo2 := Periodo1 + FSesionADuracion[PeriodoASesion[Periodo1]];
      while Periodo2 < FPeriodoCant do
      begin
        Duracion := FSesionADuracion[PeriodoASesion[Periodo2]];
        DValue := EvaluateInternalSwap(AParalelo, Periodo1, Periodo2);
        if Delta + DValue < 0 then
        begin
          InternalSwap(AParalelo, Periodo1, Periodo2, True);
          Delta := Delta + DValue;
          Result := False;
          Exit;
        end;
        Inc(Periodo2, Duracion);
      end;
      Inc(Periodo1, FSesionADuracion[PeriodoASesion[Periodo1]]);
    end;
  end;
end;

function TTimeTable.InternalDownHillEach(var Delta: Double): Boolean;
var
  Counter, Paralelo, Periodo1, Periodo2, Duracion: Smallint;
  DValue: Double;
  RandomOrders: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  PeriodoASesion: TDynamicSmallintArray;
begin
  with FModel do
  begin
    Result := True;
    for Counter := 0 to FParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := rand32;
    end;
    SortLongint(RandomValues, RandomOrders, 0, FParaleloCant - 1);
    Counter := 0;
    while Counter < FParaleloCant do
    begin
      Paralelo := RandomOrders[Counter];
      Periodo1 := 0;
      PeriodoASesion := FParaleloPeriodoASesion[Paralelo];
      while Periodo1 < FPeriodoCant do
      begin
        Periodo2 := Periodo1 + FSesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < FPeriodoCant do
        begin
          Duracion := FSesionADuracion[PeriodoASesion[Periodo2]];
          DValue := EvaluateInternalSwap(Paralelo, Periodo1, Periodo2);
          if Delta + DValue < 0 then
          begin
            InternalSwap(Paralelo, Periodo1, Periodo2, True);
            Delta := Delta + DValue;
            Result := False;
            Exit;
          end;
          Inc(Periodo2, Duracion);
        end;
        Inc(Periodo1, FSesionADuracion[PeriodoASesion[Periodo1]]);
      end;
      Inc(Counter);
    end;
  end;
end;

function TTimeTable.InternalDownHillOptimized(Step: Integer): Boolean;
var
  Periodo, Periodo1, Periodo2, Duracion1, Duracion2, Counter, Profesor,
    Paralelo, Sesion, MaxParalelo: Smallint;
  DValue, Value1: Double;
  RandomOrders: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  PeriodoASesion: PSmallintArray;
  Stop: Boolean;
  { Continuar: Boolean; }
begin
  Update;
  CalculateValue;
  with TimeTableModel, TablingInfo do
  begin
    for Counter := 0 to FParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := $7FFFFFFF;
    end;
    for Profesor := 0 to FProfesorCant - 1 do
    begin
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        if FProfesorPeriodoCant[Profesor, Periodo] > 1 then
        begin
          for Paralelo := 0 to FParaleloCant - 1 do
          begin
            Sesion := FParaleloPeriodoASesion[Paralelo, Periodo];
            if (Sesion >= 0) and (FParaleloMateriaAProfesor[Paralelo, FSesionAMateria[Sesion]]
                = Profesor) then
              RandomValues[Paralelo] := rand32 div 2;
          end;
        end;
      end;
    end;
    SortLongint(RandomValues, RandomOrders, 0, FParaleloCant - 1);
    Result := True;
    MaxParalelo := 0;
    while (MaxParalelo < FParaleloCant) and (RandomValues[MaxParalelo] <> $7FFFFFFF) do
    begin
      Inc(MaxParalelo);
    end;
    Counter := 0;
    Value1 := Value;
    while Counter < MaxParalelo do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[Counter];
      Periodo1 := 0;
      PeriodoASesion := @FParaleloPeriodoASesion[Paralelo, 0];
      while Periodo1 < FPeriodoCant do
      begin
        Periodo2 := Periodo1 + FSesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < FPeriodoCant do
        begin
          Stop := False;
          // Max := MaxParalelo * Sqr(FPeriodoCant);
          DoProgress((Periodo1 + Counter * FPeriodoCant) * FPeriodoCant + Periodo2,
            Step, Self, Stop);
          if Stop then
            Exit;
          DValue := EvaluateInternalSwap(Paralelo, Periodo1, Periodo2);
          Duracion1 := FSesionADuracion[PeriodoASesion[Periodo1]];
          Duracion2 := FSesionADuracion[PeriodoASesion[Periodo2]];
          InternalSwap(Paralelo, Periodo1, Periodo2, True);
          if DValue < 0 then
          begin
            Result := False;
          end
          else
          begin
            if InternalDownHillEach(Paralelo, DValue) then
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              DValue := 0;
            end
            else
            begin
              Normalize(Paralelo, Periodo1);
              Result := False;
            end;
          end;
          Value1 := Value1 + DValue;
          Normalize(Paralelo, Periodo2);
          Inc(Periodo2, FSesionADuracion[PeriodoASesion[Periodo2]]);
        end;
        Normalize(Paralelo, Periodo1);
        Inc(Periodo1, FSesionADuracion[PeriodoASesion[Periodo1]]);
      end;
      { if Continuar then }
      Inc(Counter);
    end;
  end;
end;

function TTimeTable.InternalDoubleDownHill(Step: Integer): Boolean;
var
  Periodo1, Periodo2, Duracion1, Duracion2, Counter, Paralelo { , k } : Smallint;
  DValue, Value1: Double;
  Position: Integer;
  RandomOrders: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  PeriodoASesion: PSmallintArray;
  Stop: Boolean;
  { Continuar: Boolean; }
begin
  Update;
  CalculateValue;
  with TimeTableModel do
  begin
    for Counter := 0 to FParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := rand32;
    end;
    SortLongint(RandomValues, RandomOrders, 0, FParaleloCant - 1);
    Result := True;
    Counter := 0;
    Value1 := Value;
    Position := 0;
    while Counter < FParaleloCant do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[Counter];
      Periodo1 := 0;
      PeriodoASesion := @FParaleloPeriodoASesion[Paralelo, 0];
      while Periodo1 < FPeriodoCant do
      begin
        Periodo2 := Periodo1 + FSesionADuracion[PeriodoASesion[Periodo1]];
        // k := Periodo2;
        while Periodo2 < FPeriodoCant do
        begin
          Stop := False;
          // Position := Counter * FPeriodoCant * (FPeriodoCant - 1) div 2
          // + Periodo1 * (FPeriodoCant - 1) - Periodo1 * (Periodo1 - 1) div 2 + Periodo2 - k
          DoProgress(Position, Step, Self, Stop);
          if Stop then
            Exit;
          Inc(Position);
          DValue := EvaluateInternalSwap(Paralelo, Periodo1, Periodo2);
          Duracion1 := FSesionADuracion[PeriodoASesion[Periodo1]];
          Duracion2 := FSesionADuracion[PeriodoASesion[Periodo2]];
          InternalSwap(Paralelo, Periodo1, Periodo2, True);
          if DValue < 0 then
          begin
            Result := False;
          end
          else
          begin
            if InternalDownHillEach(DValue) then
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              DValue := 0;
            end
            else
            begin
              Normalize(Paralelo, Periodo1);
              Result := False;
            end;
          end;
          Value1 := Value1 + DValue;
          Normalize(Paralelo, Periodo2);
          Inc(Periodo2, FSesionADuracion[PeriodoASesion[Periodo2]]);
        end;
        Normalize(Paralelo, Periodo1);
        Inc(Periodo1, FSesionADuracion[PeriodoASesion[Periodo1]]);
      end;
      { if Continuar then }
      Inc(Counter);
    end;
  end;
end;

{ Retorna verdadero cuando no ha descendido }

function TTimeTable.InternalDownHill: Boolean;
begin
  Result := InternalDownHill(0);
end;

function TTimeTable.InternalDownHill(Delta: Double): Boolean;
var
  Counter, Paralelo, Periodo1, Periodo2, Duracion2: Smallint;
  DValue{$IFDEF DEBUG}, Value1, Value2 {$ENDIF}: Double;
  RandomOrders: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  PeriodoASesion: TDynamicSmallintArray;
  { Continuar: Boolean; }
begin
  with TimeTableModel do
  begin
    for Counter := 0 to FParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := rand32;
    end;
    SortLongint(RandomValues, RandomOrders, 0, FParaleloCant - 1);
    Result := True;
    Counter := 0;
    while Counter < FParaleloCant do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[Counter];
      PeriodoASesion := FParaleloPeriodoASesion[Paralelo];
      Periodo1 := 0;
      while Periodo1 < FPeriodoCant do
      begin
        Periodo2 := Periodo1 + FSesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < FPeriodoCant do
        begin
          Duracion2 := FSesionADuracion[PeriodoASesion[Periodo2]];
{$IFDEF DEBUG}
          Update;
          CalculateValue;
          Value1 := Value;
{$ENDIF}
          DValue := EvaluateInternalSwap(Paralelo, Periodo1, Periodo2);
          if (DValue < Delta) { or ((DValue = 0) and ((rand32 mod 4) = 0)) } then
          begin
            InternalSwap(Paralelo, Periodo1, Periodo2, True);
{$IFDEF DEBUG}
            Update;
            CalculateValue;
            Value2 := Value;
            if Abs((Value2 - Value1) - DValue) > 0.00001 then
              raise Exception.Create('Problemas');
{$ENDIF}
            Result := False;
          end;
          { Continuar := Continuar and (DValue >= 0); }
          Inc(Periodo2, Duracion2);
        end;
        Inc(Periodo1, FSesionADuracion[PeriodoASesion[Periodo1]]);
      end;
      { if Continuar then }
      Inc(Counter);
    end;
  end;
end;

function TTimeTable.DownHill: Boolean;
begin
  // Check('DescensoRapidoAntes');
  Result := InternalDownHill;
  RecalculateValue := RecalculateValue or not Result;
  // Check('DescensoRapidoDespues');
end;

function TTimeTable.DoubleDownHill(Step: Integer): Boolean;
begin
  Result := InternalDoubleDownHill(Step);
  RecalculateValue := True;
end;

procedure TTimeTable.InternalDownHillOptimizedForced(Step: Integer);
var
  b: Boolean;
begin
  b := True;
  repeat
    b := b and InternalDownHillOptimized(Step);
  until b;
  RecalculateValue := RecalculateValue or not b;
end;

procedure TTimeTable.DoubleDownHillForced(Step: Integer);
begin
  repeat
    // Application.ProcessMessages;
  until InternalDoubleDownHill(Step);
  RecalculateValue := True;
end;

procedure TTimeTable.DownHillForced;
var
  b: Boolean;
begin
  b := True;
  repeat
    // Application.ProcessMessages;
    b := b and InternalDownHill;
  until b;
  RecalculateValue := RecalculateValue or not b;
end;

{ procedure TTimeTable.DescensoRapido2(CallBack: TCountFunc);
  begin
  DescensoRapidoInterno2(CallBack);
  RecalcularValor := True;
  end; }

destructor TTimeTable.Destroy;
begin
  FModel := nil;
  FAntListaCambios.Free;
  inherited Destroy;
end;

procedure TTimeTable.Assign(ATimeTable: TTimeTable);
var
  Paralelo, Materia, Profesor, AulaTipo, Dia: Smallint;
begin
  with TimeTableModel, TablingInfo do
  begin
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Move(ATimeTable.ParaleloPeriodoASesion[Paralelo, 0],
        ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Smallint));
    end;
    if ATimeTable.RecalculateValue then
      RecalculateValue := True
    else
    begin
      FCruceProfesor := ATimeTable.TablingInfo.FCruceProfesor;
      FProfesorFraccionamiento := ATimeTable.TablingInfo.FProfesorFraccionamiento;
      FCruceAulaTipo := ATimeTable.TablingInfo.FCruceAulaTipo;
      FHoraHuecaDesubicada := ATimeTable.TablingInfo.FHoraHuecaDesubicada;
      FSesionCortada := ATimeTable.TablingInfo.FSesionCortada;
      FMateriaNoDispersa := ATimeTable.TablingInfo.FMateriaNoDispersa;
      FMateriaProhibicion := ATimeTable.TablingInfo.FMateriaProhibicion;
      FProfesorProhibicion := ATimeTable.TablingInfo.FProfesorProhibicion;
      FMateriaProhibicionValor := ATimeTable.TablingInfo.FMateriaProhibicionValor;
      FProfesorProhibicionValor := ATimeTable.TablingInfo.FProfesorProhibicionValor;
      FValue := ATimeTable.TablingInfo.FValue;
//      TablingInfo := ATimeTable.TablingInfo;
      RecalculateValue := False;
    end;
    Move(ATimeTable.FParaleloMateriaNoDispersa[0],
      FParaleloMateriaNoDispersa[0], FParaleloCant * SizeOf(Smallint));
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      for Materia := 0 to FMateriaCant - 1 do
      begin
        Move(ATimeTable.TablingInfo.FParaleloMateriaDiaMinHora[Paralelo, Materia, 0],
          FParaleloMateriaDiaMinHora[Paralelo, Materia, 0], FDiaCant * SizeOf(Smallint));
        Move(ATimeTable.TablingInfo.FParaleloMateriaDiaMaxHora[Paralelo, Materia, 0],
          FParaleloMateriaDiaMaxHora[Paralelo, Materia, 0], FDiaCant * SizeOf(Smallint));
      end;
    end;
    for Materia := 0 to FMateriaCant - 1 do
      Move(ATimeTable.TablingInfo.FMateriaPeriodoCant[Materia, 0], TablingInfo.FMateriaPeriodoCant[Materia, 0],
        FPeriodoCant * SizeOf(Smallint));
    for Profesor := 0 to FProfesorCant - 1 do
      Move(ATimeTable.TablingInfo.FProfesorPeriodoCant[Profesor, 0], TablingInfo.FProfesorPeriodoCant[Profesor, 0],
        FPeriodoCant * SizeOf(Smallint));
    for Dia := 0 to FDiaCant - 1 do
    begin
      Move(ATimeTable.TablingInfo.FDiaProfesorFraccionamiento[Dia, 0],
        FDiaProfesorFraccionamiento[Dia, 0], FProfesorCant * SizeOf(Smallint));
      { Move(AObjetoTimeTableModel.FDiaProfesorSumaHora[Dia, 0],
        FDiaProfesorSumaHora[Dia, 0], FProfesorCant * SizeOf(Smallint));
        Move(AObjetoTimeTableModel.FDiaProfesorSumaCuadradoHora[Dia, 0],
        FDiaProfesorSumaCuadradoHora[Dia, 0], FProfesorCant * SizeOf(Smallint)); }
    end;
    for AulaTipo := 0 to FAulaTipoCant - 1 do
      Move(ATimeTable.TablingInfo.FAulaTipoPeriodoCant[AulaTipo, 0],
        TablingInfo.FAulaTipoPeriodoCant[AulaTipo, 0], FPeriodoCant * SizeOf(Smallint));
  end;
end;

procedure TTimeTable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  Paralelo, Periodo: Integer;
begin
  VStrings := TStringList.Create;
  with TimeTableModel do
    try
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        VStrings.Add(Format('Paralelo %d %d %d',
            [FNivelACodNivel[FParaleloANivel[Paralelo]],
            FEspecializacionACodEspecializacion[FParaleloAEspecializacion[Paralelo]],
            FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]]]));
        for Periodo := 0 to FPeriodoCant - 1 do
        begin
          VStrings.Add(Format(' Dia %d Hora %d Materia %d', [FPeriodoADia[Periodo],
              FPeriodoAHora[Periodo],
              FMateriaACodMateria[FSesionAMateria[ParaleloPeriodoASesion[Paralelo, Periodo]]]
                ]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;

procedure TTimeTable.SaveToStream(Stream: TStream);
var
  Paralelo: Smallint;
begin
  with FModel do
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Stream.Write(ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Smallint));
    end;
end;

procedure TTimeTable.LoadFromStream(Stream: TStream);
var
  Paralelo: Smallint;
begin
  with FModel do
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Stream.Read(ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Smallint));
    end;
  Update;
  FRecalculateValue := True;
end;

procedure TTimeTable.SaveToDataModule(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
var
  Stream: TStream;
  procedure SaveHorario;
  begin
    with SourceDataModule, TbHorario do
    begin
      DisableControls;
      try
        IndexFieldNames := 'CodHorario';
        Append;
        TbHorario.FindField('CodHorario').AsInteger := CodHorario;
        TbHorario.FindField('MomentoInicial').AsDateTime := MomentoInicial;
        TbHorario.FindField('MomentoFinal').AsDateTime := MomentoFinal;
        Stream := TMemoryStream.Create;
        try
          Informe.SaveToStream(Stream);
          Stream.Position := 0;
          TBlobField(TbHorario.FindField('Informe')).LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
        Post;
      finally
        EnableControls;
      end;
    end;
  end;
  procedure SaveHorarioDetalle;
  var
    Paralelo, Periodo, CodNivel, CodParaleloId, CodEspecializacion, Sesion: Integer;
    {$IFDEF USE_SQL}
    SQL: TStrings;
    {$ELSE}
    FieldHorario, FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia,
      FieldHora, FieldMateria, FieldSesion: TField;
    {$ENDIF}
  begin
  {$IFDEF USE_SQL}
    SQL := TStringList.Create;
    try
      with TimeTableModel do
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        CodNivel := FNivelACodNivel[FParaleloANivel[Paralelo]];
        CodParaleloId := FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]];
        CodEspecializacion := FEspecializacionACodEspecializacion
          [FParaleloAEspecializacion[Paralelo]];
        for Periodo := 0 to FPeriodoCant - 1 do
        begin
          Sesion := ParaleloPeriodoASesion[Paralelo, Periodo];
          if Sesion >= 0 then
          begin
            SQL.Add(Format(
              'INSERT INTO HorarioDetalle' +
              '(CodHorario,CodNivel,CodParaleloId,CodEspecializacion,CodDia,' +
              'CodHora,CodMateria,Sesion) VALUES (%d,%d,%d,%d,%d,%d,%d,%d);',
              [CodHorario, CodNivel, CodParaleloId, CodEspecializacion,
              FDiaACodDia[FPeriodoADia[Periodo]],
              FHoraACodHora[FPeriodoAHora[Periodo]],
              FMateriaACodMateria[FSesionAMateria[Sesion]],
              Sesion]));
          end;
        end;
      end;
      SourceDataModule.Database.ExecuteDirect(SQL.Text);
      SourceDataModule.TbHorarioDetalle.Refresh;
    finally
      SQL.Free;
    end;
    {$ELSE}
    with SourceDataModule.TbHorarioDetalle do
    begin
      DisableControls;
      try
        Last;
        FieldHorario := FindField('CodHorario');
        FieldNivel := FindField('CodNivel');
        FieldParaleloId := FindField('CodParaleloId');
        FieldEspecializacion := FindField('CodEspecializacion');
        FieldDia := FindField('CodDia');
        FieldHora := FindField('CodHora');
        FieldMateria := FindField('CodMateria');
        FieldSesion := FindField('Sesion');
        with TimeTableModel do
        for Paralelo := 0 to FParaleloCant - 1 do
        begin
          CodNivel := FNivelACodNivel[FParaleloANivel[Paralelo]];
          CodParaleloId := FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]];
          CodEspecializacion := FEspecializacionACodEspecializacion
            [FParaleloAEspecializacion[Paralelo]];
          for Periodo := 0 to FPeriodoCant - 1 do
          begin
            Sesion := ParaleloPeriodoASesion[Paralelo, Periodo];
            if Sesion >= 0 then
            begin
              Append;
              FieldHorario.AsInteger := CodHorario;
              FieldNivel.AsInteger := CodNivel;
              FieldParaleloId.AsInteger := CodParaleloId;
              FieldEspecializacion.AsInteger := CodEspecializacion;
              FieldDia.AsInteger := FDiaACodDia[FPeriodoADia[Periodo]];
              FieldHora.AsInteger := FHoraACodHora[FPeriodoAHora[Periodo]];
              FieldMateria.AsInteger := FMateriaACodMateria[FSesionAMateria[Sesion]];
              FieldSesion.AsInteger := Sesion;
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
  SourceDataModule.CheckRelations := False;
  try
    SaveHorario;
    SaveHorarioDetalle;
  finally
    SourceDataModule.CheckRelations := True;
  end;
end;

function TTimeTable.GetDiaProfesorFraccionamiento(Dia, Profesor: Smallint): Smallint;
var
  Periodo, Max, Min, Count, MaxPeriodo: Smallint;
  VPeriodoCant: TDynamicSmallintArray;
  PeriodoAProfesorProhibicionTipo: TDynamicShortintArray;
begin
  Count := 0;
  Max := -1;
  Min := 32767;
  with TimeTableModel, TablingInfo do
  begin
    MaxPeriodo := FDiaAMaxPeriodo[Dia];
    VPeriodoCant := FProfesorPeriodoCant[Profesor];
    PeriodoAProfesorProhibicionTipo := FProfesorPeriodoAProfesorProhibicionTipo[Profesor];
    for Periodo := FDiaHoraAPeriodo[Dia, 0] to MaxPeriodo do
    begin
      if (VPeriodoCant[Periodo] > 0)
        or (FProfesorProhibicionTipoAValor[PeriodoAProfesorProhibicionTipo[Periodo]] =
          FMaxProfesorProhibicionTipoValor) then
      begin
        Max := FPeriodoAHora[Periodo];
        Inc(Count);
        if Min > Max then
          Min := Max;
      end;
    end;
  end;
  if Count = 0 then
    Result := 0
  else
    Result := Max - Min + 1 - Count;
end;

procedure TTimeTable.LoadFromDataModule(CodHorario: Integer);
var
  FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia, FieldHora,
    FieldSesion: TLongintField;
  Paralelo, Periodo: Smallint;
begin
  with SourceDataModule, TimeTableModel, TbHorarioDetalle do
  begin
    TbHorario.Locate('CodHorario', CodHorario, []);
    LinkedFields := 'CodHorario';
    MasterFields := 'CodHorario';
    MasterSource := DSHorario;
    try
      FieldNivel := FindField('CodNivel') as TLongintField;
      FieldParaleloId := FindField('CodParaleloId') as TLongintField;
      FieldEspecializacion := FindField('CodEspecializacion') as TLongintField;
      FieldDia := FindField('CodDia') as TLongintField;
      FieldHora := FindField('CodHora') as TLongintField;
      FieldSesion := FindField('Sesion') as TLongintField;
      for Paralelo := 0 to FParaleloCant - 1 do
        FillChar(FParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Smallint)
            , #$FF);
      First;
      while not Eof do
      begin
        Paralelo := FCursoParaleloIdAParalelo[FNivelEspecializacionACurso
          [FCodNivelANivel[FieldNivel.AsInteger - FMinCodNivel],
          FCodEspecializacionAEspecializacion[FieldEspecializacion.AsInteger -
          FMinCodEspecializacion]],
          FCodParaleloIdAParaleloId[FieldParaleloId.AsInteger -
          FMinCodParaleloId]];
        Periodo := FDiaHoraAPeriodo[FCodDiaADia[FieldDia.AsInteger - FMinCodDia],
          FCodHoraAHora[FieldHora.AsInteger - FMinCodHora]];
        FParaleloPeriodoASesion[Paralelo, Periodo] := FieldSesion.AsInteger;
        Next;
      end;
    finally
      MasterSource := nil;
      MasterFields := '';
      LinkedFields := '';
    end;
  end;
  Update;
  RecalculateValue := True;
end;

procedure TTimeTable.PartialUpdate;
begin
  UpdateProfesorPeriodoCant;
  UpdateMateriaPeriodoCant;
  UpdateParaleloMateriaDiaMinMaxHora;
  UpdateDiaProfesorFraccionamiento;
end;

procedure TTimeTable.Update;
begin
  UpdateAulaTipoPeriodoCant;
  PartialUpdate;
end;

procedure TTimeTableModel.DoProgress(Position, RefreshInterval: Integer;
  Horario: TTimeTable; var Stop: Boolean);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Position, RefreshInterval, Horario, Stop);
end;

destructor TTimeTableModel.Destroy;
begin
  inherited Destroy;
end;

initialization

// SortLongint := QuicksortLongint;
// SortSmallint := QuicksortSmallint;
// lSort := lQuicksort;
SortLongint := BubblesortLongint;
SortSmallint := BubblesortSmallint;
lSort := lBubblesort;

end.

