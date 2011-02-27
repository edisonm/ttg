unit KerModel;
{$I ttg.inc}

interface

uses
  Classes, DB, Dialogs, SysConst, Math, Forms, ZConnection, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractTable, ZDataset;

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
    Clase TModeloHorario
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
  TProgressEvent = procedure(Progress, Step: Integer; Horario: TTimeTable;
    var Stop: Boolean) of object;

  TModeloHorario = class
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
      FMoldeHorarioDetalle, FDistributivoASesiones: TDynamicSmallintArrayArray;
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
    function GetDiaAMaxPeriodo(d: Smallint): Smallint;
  protected
    property MoldeHorarioDetalle
      : TDynamicSmallintArrayArray read FMoldeHorarioDetalle;
  public
    property PeriodoCant: Smallint read FPeriodoCant;
    property ParaleloCant: Smallint read FParaleloCant;
    procedure DoProgress(I, Step: Integer; Horario: TTimeTable;
      var Stop: Boolean);
    dynamic;
    procedure Configurar(ACruceProfesorValor, AProfesorFraccionamientoValor,
      ACruceAulaTipoValor, AHoraHuecaDesubicadaValor, ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    constructor CrearDesdeDataModule(ACruceProfesorValor,
      AProfesorFraccionamientoValor, ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor, ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    property CruceProfesorValor: Double read FCruceProfesorValor;
    property ProfesorFraccionamientoValor
      : Double read FProfesorFraccionamientoValor;
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
    Clase TObjetoModeloHorario
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
    en los operadores geneticos, como son cruce, mutacion, etc., ModeloHorario
    al que pertenece esta solucion.
  }
  TTimeTable = class
  private
    FModeloHorario: TModeloHorario;
    FParaleloPeriodoASesion, FMateriaPeriodoCant, FProfesorPeriodoCant,
      FAulaTipoPeriodoCant, FAntMateriaDiaMinHora, FAntMateriaDiaMaxHora,
      FAntDiaProfesorMinHora,
      FAntDiaProfesorMaxHora: TDynamicSmallintArrayArray;
    FParaleloMateriaDiaMinHora,
      FParaleloMateriaDiaMaxHora: TDynamicSmallintArrayArrayArray;
    FAntListaCambios: TList;
    FParaleloMateriaNoDispersa: TDynamicSmallintArray;
    FDiaProfesorFraccionamiento: TDynamicSmallintArrayArray;
    FCruceProfesor, FCruceAulaTipo, FHoraHuecaDesubicada, FSesionCortada,
      FMateriaNoDispersa, FMateriaProhibicion, FProfesorProhibicion,
      FAntMateriaNoDispersa: Integer;
    FProfesorFraccionamiento: Integer;
    FMateriaProhibicionValor, FProfesorProhibicionValor, FValor: Double;
    FRecalcularValor: Boolean;
    function GetValor: Double;
    procedure DoGetValor;
    procedure Normalizar(AParalelo: Smallint; var APeriodo: Smallint);
    {
      procedure SetClaveAleatoriaInterno(AParalelo, APeriodo: Smallint;
      AClaveAleatoria: Integer); overload;
      procedure SetClaveAleatoriaInterno(AParalelo, APeriodo, ADuracion: Smallint;
      AClaveAleatoria: Integer); overload;
    }
    function GetMateriaNoDispersa: Integer;
    procedure DoGetMateriaNoDispersa;
    procedure DoGetHoraHuecaDesubicada;
    procedure DoGetSesionCortada;
    function GetHoraHuecaDesubicada: Integer;
    function GetSesionCortada: Integer;
    procedure DoGetProfesorProhibicionValor;
    procedure DoGetMateriaProhibicionValor;
    function GetProfesorProhibicionValor: Double;
    function GetMateriaProhibicionValor: Double;
    function GetMateriaNoDispersaValor: Double;
    function GetHoraHuecaDesubicadaValor: Double;
    function GetCruceProfesorValor: Double;
    function GetProfesorFraccionamientoValor: Double;
    function GetSesionCortadaValor: Double;
    function GetCruceAulaTipoValor: Double;
    function GetProfesorProhibicion: Integer;
    function GetMateriaProhibicion: Integer;
    procedure MutarInterno;
    function DescensoRapidoInterno(Delta: Double): Boolean; overload;
    function DescensoRapidoInterno: Boolean; overload;
    procedure IntercambiarInterno(AParalelo, APeriodo, APeriodo1: Smallint;
      FueEvaluado: Boolean = False);
    procedure Intercambiar(AParalelo, APeriodo, APeriodo1: Smallint);
    function EvaluarIntercambioInterno(AParalelo, APeriodo, APeriodo1: Smallint)
      : Double;
    property ProfesorPeriodoCant
      : TDynamicSmallintArrayArray read FProfesorPeriodoCant;
    property MateriaPeriodoCant
      : TDynamicSmallintArrayArray read FMateriaPeriodoCant;
    property AulaTipoPeriodoCant
      : TDynamicSmallintArrayArray read FAulaTipoPeriodoCant;
    procedure DoGetCruceProfesor;
    procedure DoGetCruceAulaTipo;
    procedure ActualizarAulaTipoPeriodoCant;
    procedure ActualizarProfesorPeriodoCant;
    procedure ActualizarMateriaPeriodoCant;
    procedure ActualizarParaleloMateriaDiaMinMaxHora; overload;
    procedure ActualizarParaleloMateriaDiaMinMaxHora(AParalelo: Smallint);
      overload;
    function GetParaleloMateriaNoDispersa(AParalelo: Smallint;
      var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
    procedure DoGetProfesorFraccionamiento;
    procedure ActualizarDiaProfesorFraccionamiento;
    function GetDiaProfesorFraccionamiento(di, p: Smallint): Smallint;
    function DescensoRapidoDobleInterno(Step: Integer): Boolean;
    function DescensoRapidoPuntualInterno(var Delta: Double): Boolean; overload;
    function DescensoRapidoPuntualInterno
      (AParalelo: Smallint; var Delta: Double): Boolean; overload;
    // procedure Check(s: string); overload;
    // procedure Check(AParalelo: Smallint; s: string); overload;
  protected
    property RecalcularValor
      : Boolean read FRecalcularValor write FRecalcularValor;
  public

    function DescensoRapido: Boolean;
    function DescensoRapidoDoble(Step: Integer): Boolean;
    procedure DescensoRapidoDobleForzado(Step: Integer);
    procedure DescensoRapidoForzado;
    function DescensoRapidoOptimizadoInterno(Step: Integer): Boolean;
    procedure DescensoRapidoOptimizadoForzado(Step: Integer);
    procedure InvalidarValor;
    procedure Actualizar;
    procedure SaveToFile(const AFileName: string);
    procedure SaveToDataModule(CodHorario: Integer;
      MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
    procedure LoadFromDataModule(CodHorario: Integer);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    constructor CrearDesdeModelo(AModeloHorario: TModeloHorario);
    destructor Destroy; override;
    procedure HacerAleatorio;
    procedure Mutar; overload;
    procedure Mutar(Orden: Integer); overload;
    procedure MutarDia;
    procedure ReportValues(AReport: TStrings);
    procedure Assign(ATimeTable: TTimeTable);
    property Valor: Double read GetValor;
    property CruceProfesor: Integer read FCruceProfesor;
    property CruceAulaTipo: Integer read FCruceAulaTipo;
    property HoraHuecaDesubicada: Integer read GetHoraHuecaDesubicada;
    property SesionCortada: Integer read GetSesionCortada;
    property CruceProfesorValor: Double read GetCruceProfesorValor;
    property ProfesorFraccionamientoValor
      : Double read GetProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read GetCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read GetHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read GetSesionCortadaValor;
    property MateriaProhibicion: Integer read GetMateriaProhibicion;
    property ProfesorProhibicion: Integer read GetProfesorProhibicion;
    property MateriaProhibicionValor: Double read GetMateriaProhibicionValor;
    property ProfesorProhibicionValor: Double read GetProfesorProhibicionValor;
    property MateriaNoDispersa: Integer read GetMateriaNoDispersa;
    property MateriaNoDispersaValor: Double read GetMateriaNoDispersaValor;
    property ParaleloPeriodoASesion
      : TDynamicSmallintArrayArray read FParaleloPeriodoASesion write
      FParaleloPeriodoASesion;
    property ModeloHorario: TModeloHorario read FModeloHorario;
    property ProfesorFraccionamiento: Integer read FProfesorFraccionamiento;
  end;

  // Procedimiento que crea una solucion aleatoria de un TModeloHorario
procedure CrearAleatorioDesdeModelo(var ATimeTable: TTimeTable;
  AModeloHorario: TModeloHorario);
procedure CargarPrefijadoDesdeModelo(var AObjetoModeloHorario: TTimeTable;
  AModeloHorario: TModeloHorario; CodHorario: Integer);

// Procedimiento que aplica el operador de cruzamiento sobre dos TObjetoModeloHorario
procedure CruzarIndividuos(var Uno, Dos: TTimeTable);

implementation

uses
  SysUtils, SortAlgs, Rand, DSource, TTGUtls;

var
  SortLongint: procedure(var List1: array of Longint;
    var List2: array of Smallint; min, max: Longint);
  SortSmallint: procedure(var List1: array of Smallint;
    var List2: array of Longint; min, max: Longint);
  lSort: procedure(var List1: array of Longint; min, max: Longint);

constructor TModeloHorario.CrearDesdeDataModule(ACruceProfesorValor,
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
  procedure Cargar(ATable: TZTable; ALstName: string; var FMinCodLst: Integer;
    var FCodLstALst: TDynamicSmallintArray;
    var FLstACodLst: TDynamicLongintArray);
  var
    VField: TField;
    I, v: Integer;
  begin
    with ATable do
    begin
      IndexFieldNames := ALstName;
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
    SetLength(FMoldeHorarioDetalle, FParaleloCant, FPeriodoCant);
    SetLength(FParaleloASesionCant, FParaleloCant);
    SetLength(FParaleloADuracion, FParaleloCant);
    r := FPeriodoCant;
    for I := 0 to FParaleloCant - 1 do
      FillChar(FMoldeHorarioDetalle[I, 0], r * SizeOf(Smallint), #$FF);
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
          FMoldeHorarioDetalle[k, r - 1 - q] := FDistributivoASesiones[I, m];
        end;
        Inc(FParaleloADuracion[k], n);
      end;
    end;
    for I := 0 to FParaleloCant - 1 do
    begin
      j := 0;
      while j < FPeriodoCant do
      begin
        s := FMoldeHorarioDetalle[I, j];
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

procedure TModeloHorario.Configurar(ACruceProfesorValor,
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

function TModeloHorario.GetDiaAMaxPeriodo(d: Smallint): Smallint;
begin
  if d = FDiaCant - 1 then
    Result := FPeriodoCant - 1
  else
    Result := FDiaHoraAPeriodo[d + 1, 0] - 1;
end;

procedure TModeloHorario.ReportParameters(AReport: TStrings);
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

procedure CrearAleatorioDesdeModelo(var ATimeTable: TTimeTable;
  AModeloHorario: TModeloHorario);
begin
  if not Assigned(ATimeTable) then
    ATimeTable := TTimeTable.CrearDesdeModelo(AModeloHorario);
  ATimeTable.HacerAleatorio;
end;

procedure CargarPrefijadoDesdeModelo(var AObjetoModeloHorario: TTimeTable;
  AModeloHorario: TModeloHorario; CodHorario: Integer);
begin
  if not Assigned(AObjetoModeloHorario) then
    AObjetoModeloHorario := TTimeTable.CrearDesdeModelo(AModeloHorario);
  AObjetoModeloHorario.LoadFromDataModule(CodHorario);
end;

procedure CruzarIndividuosPunto(var Uno, Dos: TTimeTable; AParalelo: Smallint);
var
  s, j, d: Smallint;
  k1, k2, l: Longint;
  ClaveAleatoria1, ClaveAleatoria2: TDynamicLongintArray;
  procedure AleatorizarClave(AObjetoModeloHorario: TTimeTable;
    var AClaveAleatoria: TDynamicLongintArray);
  var
    j, d, k, l: Smallint;
    NumberList: array [0 .. 4095] of Longint;
    p: PSmallintArray;
    q: PLongintArray;
  begin
    with AObjetoModeloHorario.ModeloHorario do
    begin
      // Check(AParalelo, 'AleatorizarClaveAntes');
      Fillcrand32(NumberList, FParaleloASesionCant[AParalelo]);
      lSort(NumberList, 0, FParaleloASesionCant[AParalelo] - 1);
      p := @AObjetoModeloHorario.ParaleloPeriodoASesion[AParalelo, 0];
      q := @AClaveAleatoria[0];
      j := 0;
      k := 0;
      while j < FPeriodoCant do
      begin
        d := FSesionADuracion[p[j]];
        for l := j + d - 1 downto j do
          q[l] := NumberList[k];
        Inc(k);
        Inc(j, d);
      end;
    end;
  end;

begin
  with Uno.ModeloHorario do
  begin
    SetLength(ClaveAleatoria1, FPeriodoCant);
    SetLength(ClaveAleatoria2, FPeriodoCant);
    AleatorizarClave(Uno, ClaveAleatoria1);
    AleatorizarClave(Dos, ClaveAleatoria2);
    SortSmallint(Uno.ParaleloPeriodoASesion[AParalelo], ClaveAleatoria1, 0,
      FPeriodoCant - 1);
    SortSmallint(Dos.ParaleloPeriodoASesion[AParalelo], ClaveAleatoria2, 0,
      FPeriodoCant - 1);
    j := 0;
    while j < FPeriodoCant do
    begin
      s := FMoldeHorarioDetalle[AParalelo, j];
      d := FSesionADuracion[s];
      if crand32 mod 2 = 0 then
      begin
        k1 := ClaveAleatoria1[j];
        k2 := ClaveAleatoria2[j];
        for l := j + d - 1 downto j do
        begin
          ClaveAleatoria1[l] := k2;
          ClaveAleatoria2[l] := k1;
        end;
      end;
      Inc(j, d);
    end;
    SortLongint(ClaveAleatoria1, Uno.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
    SortLongint(ClaveAleatoria2, Dos.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
  end;
end;

procedure CruzarIndividuos(var Uno, Dos: TTimeTable);
var
  I: Smallint;
begin
  with Uno.ModeloHorario do
  begin
    for I := 0 to FParaleloCant - 1 do
    begin
      CruzarIndividuosPunto(Uno, Dos, I);
    end;
    Uno.Actualizar;
    Dos.Actualizar;
    Uno.RecalcularValor := True;
    Dos.RecalcularValor := True;
    // Uno.Check('CruzarIndividuosUnoDespues');
    // Dos.Check('CruzarIndividuosDosDespues');
  end;
end;

constructor TTimeTable.CrearDesdeModelo(AModeloHorario: TModeloHorario);
begin
  inherited Create;
  FAntListaCambios := TList.Create;
  FModeloHorario := AModeloHorario;
  FRecalcularValor := True;
  with ModeloHorario do
  begin
    SetLength(FParaleloPeriodoASesion, FParaleloCant, FPeriodoCant);
    SetLength(FMateriaPeriodoCant, FMateriaCant, FPeriodoCant);
    SetLength(FProfesorPeriodoCant, FProfesorCant, FPeriodoCant);
    SetLength(FAulaTipoPeriodoCant, FAulaTipoCant, FPeriodoCant);
    SetLength(FParaleloMateriaDiaMinHora, FParaleloCant, FMateriaCant, FDiaCant);
    SetLength(FParaleloMateriaDiaMaxHora, FParaleloCant, FMateriaCant, FDiaCant);
    SetLength(FDiaProfesorFraccionamiento, FDiaCant, FProfesorCant);
    SetLength(FParaleloMateriaNoDispersa, FParaleloCant);
    SetLength(FAntMateriaDiaMinHora, FMateriaCant, FDiaCant);
    SetLength(FAntMateriaDiaMaxHora, FMateriaCant, FDiaCant);
    SetLength(FAntDiaProfesorMinHora, FDiaCant, FProfesorCant);
    SetLength(FAntDiaProfesorMaxHora, FDiaCant, FProfesorCant);
  end;
end;

procedure TTimeTable.HacerAleatorio;
var
  I, j, d, l: Smallint;
  r: Longint;
  p: PSmallintArray;
  q: PLongintArray;
  ClaveAleatoria: TDynamicLongintArray;
begin
  with ModeloHorario do
  begin
    SetLength(ClaveAleatoria, FPeriodoCant);
    for I := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[I, 0];
      q := @ClaveAleatoria[0];
      Move(FMoldeHorarioDetalle[I, 0], p[0], FPeriodoCant * SizeOf(Smallint));
      j := 0;
      while j < FPeriodoCant do
      begin
        d := FSesionADuracion[p[j]];
        r := crand32;
        for l := j + d - 1 downto j do
          q[l] := r;
        Inc(j, d);
      end;
      SortLongint(q^, p^, 0, FPeriodoCant - 1);
    end;
  end;
  Actualizar;
  RecalcularValor := True;
end;

procedure TTimeTable.ActualizarMateriaPeriodoCant;
var
  I, j, m, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for m := 0 to FMateriaCant - 1 do
    begin
      FillChar(FMateriaPeriodoCant[m, 0], FPeriodoCant * SizeOf(Smallint), #0);
    end;
    for I := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[I, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          m := FSesionAMateria[s];
          Inc(FMateriaPeriodoCant[m, j]);
        end;
      end;
    end;
  end;
end;

procedure TTimeTable.ActualizarParaleloMateriaDiaMinMaxHora;
var
  I: Smallint;
begin
  with ModeloHorario do
    for I := 0 to FParaleloCant - 1 do
      ActualizarParaleloMateriaDiaMinMaxHora(I);
end;

procedure TTimeTable.ActualizarParaleloMateriaDiaMinMaxHora
  (AParalelo: Smallint);
var
  j, di, h, m, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for j := 0 to FMateriaCant - 1 do
    begin
      FillChar(FParaleloMateriaDiaMaxHora[AParalelo, j, 0], FDiaCant * SizeOf
          (Smallint), #$FF);
      FillChar(FParaleloMateriaDiaMinHora[AParalelo, j, 0], FDiaCant * SizeOf
          (Smallint), #$3F);
    end;
    q := @ParaleloPeriodoASesion[AParalelo, 0];
    for j := 0 to FPeriodoCant - 1 do
    begin
      s := q[j];
      if s >= 0 then
      begin
        m := FSesionAMateria[s];
        di := FPeriodoADia[j];
        h := FPeriodoAHora[j];
        if FParaleloMateriaDiaMaxHora[AParalelo, m, di] < h then
          FParaleloMateriaDiaMaxHora[AParalelo, m, di] := h;
        if FParaleloMateriaDiaMinHora[AParalelo, m, di] > h then
          FParaleloMateriaDiaMinHora[AParalelo, m, di] := h;
      end;
    end;
    FParaleloMateriaNoDispersa[AParalelo] := GetParaleloMateriaNoDispersa
      (AParalelo, FParaleloMateriaDiaMaxHora[AParalelo]);
  end;
end;

procedure TTimeTable.ActualizarDiaProfesorFraccionamiento;
var
  d, p: Smallint;
begin
  with FModeloHorario do
  begin
    for d := 0 to FDiaCant - 1 do
    begin
      for p := 0 to FProfesorCant - 1 do
      begin
        FDiaProfesorFraccionamiento[d, p] := GetDiaProfesorFraccionamiento
          (d, p);
      end;
    end;
  end;
end;

procedure TTimeTable.InvalidarValor;
begin
  Actualizar;
  RecalcularValor := True;
end;

{
  procedure TObjetoModeloHorario.SetClaveAleatoriaInterno(AParalelo,
  APeriodo: Smallint; AClaveAleatoria: Longint);
  begin
  SetClaveAleatoriaInterno(AParalelo, APeriodo,
  ModeloHorario.FSesionADuracion[ParaleloPeriodoASesion[AParalelo, APeriodo]],
  AClaveAleatoria);
  end;

  procedure TObjetoModeloHorario.SetClaveAleatoriaInterno(AParalelo, APeriodo,
  ADuracion: Smallint; AClaveAleatoria: Longint);
  var
  l: Smallint;
  begin
  for l := APeriodo + ADuracion - 1 downto APeriodo do
  FClaveAleatoria[AParalelo, l] := AClaveAleatoria;
  end;
}

procedure TTimeTable.Intercambiar(AParalelo, APeriodo, APeriodo1: Smallint);
begin
  Normalizar(AParalelo, APeriodo);
  Normalizar(AParalelo, APeriodo1);
  if APeriodo < APeriodo1 then
    IntercambiarInterno(AParalelo, APeriodo, APeriodo1)
  else if APeriodo1 < APeriodo then
    IntercambiarInterno(AParalelo, APeriodo1, APeriodo);
end;

procedure TTimeTable.IntercambiarInterno
  (AParalelo, APeriodo, APeriodo1: Smallint; FueEvaluado: Boolean = False);
var
  m, m1, d, d1, s, s1, p, p1, a, a1, j_, s_, p_, a_, m_,
  { h, h1, h_, } hl, hl1: Smallint;
  q, r: PSmallintArray;
  TmpMateriaDiaMinMaxHora: TDynamicSmallintArrayArray;
  TmpMateriaNoDispersa: Integer;
  procedure RealizarMovimiento;
  var
    l: Smallint;
  begin
    Move(q[APeriodo + d], q[APeriodo + d1], (APeriodo1 - APeriodo - d) * SizeOf
        (Smallint));
    for l := d - 1 downto 0 do
    begin
      q[APeriodo1 + d1 - d + l] := s;
    end;
    for l := d1 - 1 downto 0 do
    begin
      q[APeriodo + l] := s1;
    end;
  end;

var
  l: Smallint;
  pd: LongWord;
begin
  with ModeloHorario do
  begin
    q := @ParaleloPeriodoASesion[AParalelo, 0];
    r := @FParaleloMateriaAProfesor[AParalelo, 0];
    s := q[APeriodo];
    s1 := q[APeriodo1];
    d := FSesionADuracion[s];
    d1 := FSesionADuracion[s1];
    if d = d1 then
    begin
      for l := d - 1 downto 0 do
      begin
        q[APeriodo + l] := s1;
        q[APeriodo1 + l] := s;
      end;
      if s >= 0 then
      begin
        m := FSesionAMateria[s];
        p := r[m];
        a := FSesionAAulaTipo[s];
        for l := d - 1 downto 0 do
        begin
          hl := APeriodo + l;
          hl1 := APeriodo1 + l;
          Dec(ProfesorPeriodoCant[p, hl]);
          Inc(ProfesorPeriodoCant[p, hl1]);
          Dec(MateriaPeriodoCant[m, hl]);
          Inc(MateriaPeriodoCant[m, hl1]);
          Dec(AulaTipoPeriodoCant[a, hl]);
          Inc(AulaTipoPeriodoCant[a, hl1]);
        end;
      end;
      if s1 >= 0 then
      begin
        m1 := FSesionAMateria[s1];
        p1 := r[m1];
        a1 := FSesionAAulaTipo[s1];
        for l := d - 1 downto 0 do
        begin
          hl := APeriodo + l;
          hl1 := APeriodo1 + l;
          Dec(ProfesorPeriodoCant[p1, hl1]);
          Inc(ProfesorPeriodoCant[p1, hl]);
          Dec(MateriaPeriodoCant[m1, hl1]);
          Inc(MateriaPeriodoCant[m1, hl]);
          Dec(AulaTipoPeriodoCant[a1, hl1]);
          Inc(AulaTipoPeriodoCant[a1, hl]);
        end;
      end;
    end
    else
    begin
      for j_ := APeriodo to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          p_ := r[m_];
          a_ := FSesionAAulaTipo[s_];
          Dec(ProfesorPeriodoCant[p_, j_]);
          Dec(MateriaPeriodoCant[m_, j_]);
          Dec(AulaTipoPeriodoCant[a_, j_]);
        end;
      end;
      RealizarMovimiento;
      for j_ := APeriodo to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          p_ := r[m_];
          a_ := FSesionAAulaTipo[s_];
          Inc(ProfesorPeriodoCant[p_, j_]);
          Inc(MateriaPeriodoCant[m_, j_]);
          Inc(AulaTipoPeriodoCant[a_, j_]);
        end;
      end;
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
        p := Smallint(pd);
        d := Smallint(pd shr 16);
        FDiaProfesorFraccionamiento[d, p] := GetDiaProfesorFraccionamiento
          (d, p);
      end;
      // ActualizarDiaProfesorFraccionamiento;
    end
    else
    begin
      ActualizarParaleloMateriaDiaMinMaxHora(AParalelo);
      ActualizarDiaProfesorFraccionamiento;
    end;
  end;
end;

{
  Version en Pascal del procedimiento Normalizar.  No borrar, ya que es la base
  de la version en ensamblador
}

procedure TTimeTable.Normalizar(AParalelo: Smallint; var APeriodo: Smallint);
var
  k: Smallint;
  l: PSmallintArray;
begin
  l := @FParaleloPeriodoASesion[AParalelo, 0];
  k := l[APeriodo];
  if k >= 0 then
    while (APeriodo > 0) and (k = l[APeriodo - 1]) do
      Dec(APeriodo);
end;

procedure TTimeTable.ReportValues(AReport: TStrings);
begin
  with AReport do
  begin
    Add('Detalle                     Cant.    Peso    Valor');
    Add('--------------------------------------------------');
    Add(Format('Cruce de profesores:        %5.d %7.2f %8.2f', [CruceProfesor,
        ModeloHorario.CruceProfesorValor, CruceProfesorValor]));
    Add(Format('Fracc. h. profesores:       %5.d %7.2f %8.2f',
        [ProfesorFraccionamiento, ModeloHorario.ProfesorFraccionamientoValor,
        ProfesorFraccionamientoValor]));
    Add(Format('Cruce de aulas:             %5.d %7.2f %8.2f', [CruceAulaTipo,
        ModeloHorario.CruceAulaTipoValor, CruceAulaTipoValor]));
    Add(Format('Horas Huecas desubicadas:   %5.d %7.2f %8.2f',
        [HoraHuecaDesubicada, ModeloHorario.HoraHuecaDesubicadaValor,
        HoraHuecaDesubicadaValor]));
    Add(Format('Materias cortadas:          %5.d %7.2f %8.2f', [SesionCortada,
        ModeloHorario.SesionCortadaValor, SesionCortadaValor]));
    Add(Format('Materias no dispersas:      %5.d %7.2f %8.2f',
        [MateriaNoDispersa, ModeloHorario.MateriaNoDispersaValor,
        MateriaNoDispersaValor]));
    Add(Format('Prohibiciones de materia:   %5.d         %8.2f',
        [MateriaProhibicion, MateriaProhibicionValor]));
    Add(Format('Prohibiciones de profesor:  %5.d         %8.2f',
        [ProfesorProhibicion, ProfesorProhibicionValor]));
    Add('--------------------------------------------------');
    Add(Format('Valor Total:                              %8.2f', [Valor]));
  end;
end;

(*
  procedure TObjetoModeloHorario.Normalizar(AParalelo: Smallint;
  var APeriodo: Smallint); assembler;
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

procedure TTimeTable.MutarInterno;
var
  l: Longint;
  Paralelo, Periodo1, Periodo2: Smallint;
begin
  with ModeloHorario do
  begin
    l := crand32;
    Periodo1 := l mod FPeriodoCant; l := l div FPeriodoCant;
    Periodo2 := l mod FPeriodoCant; l := l div FPeriodoCant;
    Paralelo := l mod FParaleloCant;
    if ParaleloPeriodoASesion[Paralelo, Periodo1]
    <> ParaleloPeriodoASesion[Paralelo, Periodo2] then
      Intercambiar(Paralelo, Periodo1, Periodo2);
  end;
end;

procedure TTimeTable.Mutar;
begin
  // Check('MutarAntes');
  MutarInterno;
  RecalcularValor := True;
  // Check('MutarDespues');
end;

procedure TTimeTable.Mutar(Orden: Integer);
var
  c: Integer;
begin
  // Check('MutarAntes(...)');
  for c := crand32 mod Orden downto 0 do
    MutarInterno;
  RecalcularValor := True;
  // Check('MutarDespues(...)');
end;

procedure TTimeTable.MutarDia;
var
  I, j1, j2, n1, n2, d1, d2, m1, m2: Smallint;
  b: array [0 .. 16383] of Smallint;
  p: PSmallintArray;
begin
  // Check('MutarDiaAntes');
  with ModeloHorario do
  begin
    j1 := crand32 mod FDiaCant;
    repeat
      j2 := crand32 mod FDiaCant;
    until j1 <> j2;
    for I := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[I, 0];
      n1 := FDiaHoraAPeriodo[j1, 0];
      n2 := FDiaHoraAPeriodo[j2, 0];
      m1 := FDiaAMaxPeriodo[j1];
      m2 := FDiaAMaxPeriodo[j2];
      d1 := m1 - n1;
      d2 := m2 - n2;
      if (d1 = d2) and ((n1 = 0) or (p[n1 - 1] < 0) or (p[n1 - 1] <> p[n1]))
        and ((n2 = 0) or (p[n2 - 1] < 0) or (p[n2 - 1] <> p[n2])) and
        ((m1 = FPeriodoCant - 1) or (p[m1] < 0) or (p[m1] <> p[m1 + 1])) and
        ((m2 = FPeriodoCant - 1) or (p[m2] < 0) or (p[m2] <> p[m2 + 1])) then
      begin
        Move(p[n1], b[0], (d1 + 1) * SizeOf(Smallint));
        Move(p[n2], p[n1], (d1 + 1) * SizeOf(Smallint));
        Move(b[0], p[n2], (d1 + 1) * SizeOf(Smallint));
      end;
    end;
  end;
  Actualizar;
  FRecalcularValor := True;
  // Check('MutarDiaDespues');
end;

function TTimeTable.GetValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FValor;
end;

function TTimeTable.GetHoraHuecaDesubicadaValor: Double;
begin
  Result := ModeloHorario.FHoraHuecaDesubicadaValor * GetHoraHuecaDesubicada;
end;

function TTimeTable.GetHoraHuecaDesubicada: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FHoraHuecaDesubicada;
end;

procedure TTimeTable.DoGetHoraHuecaDesubicada;
var
  I, j, s: Integer;
  p: PSmallintArray;
begin
  FHoraHuecaDesubicada := 0;
  with ModeloHorario do
    for I := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[I, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        s := p[j];
        if (s < 0) and (FHoraCant - 1 <> FPeriodoAHora[j]) then
          Inc(FHoraHuecaDesubicada);
      end;
    end;
end;

function TTimeTable.GetSesionCortadaValor: Double;
begin
  Result := GetSesionCortada * ModeloHorario.FSesionCortadaValor;
end;

function TTimeTable.GetSesionCortada: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FSesionCortada;
end;

procedure TTimeTable.DoGetSesionCortada;
var
  I, j, d, s: Integer;
  l, m, k, t: Smallint;
begin
  FSesionCortada := 0;
  with ModeloHorario do
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
            Inc(FSesionCortada, k);
          end;
        end;
        Inc(j, l);
      end;
    end;
end;

function TTimeTable.GetMateriaNoDispersaValor: Double;
begin
  Result := ModeloHorario.FMateriaNoDispersaValor * GetMateriaNoDispersa;
end;

function TTimeTable.GetMateriaNoDispersa: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaNoDispersa;
end;

function TTimeTable.GetParaleloMateriaNoDispersa(AParalelo: Smallint;
  var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
var
  m, n, l, k, ns, ns1: Smallint;
  pm: PSmallintArray;
begin
  Result := 0;
  with ModeloHorario do
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
  FMateriaNoDispersa := 0;
  with ModeloHorario do
  begin
    for I := 0 to FParaleloCant - 1 do
    begin
      Inc(FMateriaNoDispersa, FParaleloMateriaNoDispersa[I]);
    end;
  end;
end;

procedure TTimeTable.DoGetProfesorFraccionamiento;
var
  p, d: Smallint;
begin
  with ModeloHorario do
  begin
    FProfesorFraccionamiento := 0;
    for d := 0 to FDiaCant - 1 do
    begin
      for p := 0 to FProfesorCant - 1 do
      begin
        Inc(FProfesorFraccionamiento, FDiaProfesorFraccionamiento[d, p]);
      end;
    end;
  end;
end;

function TTimeTable.GetMateriaProhibicion: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaProhibicion;
end;

function TTimeTable.GetMateriaProhibicionValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaProhibicionValor;
end;

procedure TTimeTable.DoGetMateriaProhibicionValor;
var
  I, m, j, c: Integer;
  d: Double;
begin
  FMateriaProhibicionValor := 0;
  FMateriaProhibicion := 0;
  with ModeloHorario do
    for I := 0 to High(FMateriaProhibicionAMateria) do
    begin
      m := FMateriaProhibicionAMateria[I];
      j := FMateriaProhibicionAPeriodo[I];
      c := FMateriaPeriodoCant[m, j];
      d := c * FMateriaProhibicionAValor[I];
      FMateriaProhibicionValor := FMateriaProhibicionValor + d;
      Inc(FMateriaProhibicion, c);
    end;
end;

function TTimeTable.GetProfesorProhibicion: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FProfesorProhibicion;
end;

function TTimeTable.GetProfesorProhibicionValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FProfesorProhibicionValor;
end;

procedure TTimeTable.DoGetProfesorProhibicionValor;
var
  I, p, j, c: Smallint;
  d: Double;
begin
  FProfesorProhibicionValor := 0;
  FProfesorProhibicion := 0;
  with ModeloHorario do
    for I := 0 to High(FProfesorProhibicionAProfesor) do
    begin
      p := FProfesorProhibicionAProfesor[I];
      j := FProfesorProhibicionAPeriodo[I];
      c := FProfesorPeriodoCant[p, j];
      d := c * FProfesorProhibicionAValor[I];
      FProfesorProhibicionValor := FProfesorProhibicionValor + d;
      Inc(FProfesorProhibicion, c);
    end;
end;

procedure TTimeTable.DoGetCruceProfesor;
var
  j, p, c: Smallint;
  r: PSmallintArray;
begin
  FCruceProfesor := 0;
  with ModeloHorario do
  begin
    for p := 0 to FProfesorCant - 1 do
    begin
      r := @FProfesorPeriodoCant[p, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        c := r[j];
        if c > 1 then
          Inc(FCruceProfesor, c - 1);
      end;
    end;
  end;
end;

procedure TTimeTable.DoGetCruceAulaTipo;
var
  j, a, c: Smallint;
  r: PSmallintArray;
begin
  FCruceAulaTipo := 0;
  with ModeloHorario do
  begin
    for a := 0 to FAulaTipoCant - 1 do
    begin
      r := @FAulaTipoPeriodoCant[a, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        c := r[j] - FAulaTipoACantidad[a];
        if c > 0 then
          Inc(FCruceAulaTipo, c);
      end;
    end;
  end;
end;

function TTimeTable.GetCruceProfesorValor: Double;
begin
  Result := ModeloHorario.FCruceProfesorValor * FCruceProfesor;
end;

function TTimeTable.GetProfesorFraccionamientoValor: Double;
begin
  Result := ModeloHorario.FProfesorFraccionamientoValor *
    FProfesorFraccionamiento;
end;

function TTimeTable.GetCruceAulaTipoValor: Double;
begin
  Result := ModeloHorario.FCruceAulaTipoValor * FCruceAulaTipo;
end;

procedure TTimeTable.DoGetValor;
begin
  RecalcularValor := False;
  with ModeloHorario do
  begin
    DoGetHoraHuecaDesubicada;
    DoGetCruceProfesor;
    DoGetCruceAulaTipo;
    DoGetSesionCortada;
    DoGetMateriaNoDispersa;
    DoGetMateriaProhibicionValor;
    DoGetProfesorProhibicionValor;
    DoGetProfesorFraccionamiento;
    FValor := Self.CruceProfesorValor + Self.CruceAulaTipoValor +
      FMateriaProhibicionValor + FProfesorProhibicionValor +
      FMateriaNoDispersa * FMateriaNoDispersaValor + FSesionCortada *
      FSesionCortadaValor + FHoraHuecaDesubicada * FHoraHuecaDesubicadaValor +
      FProfesorFraccionamiento * FProfesorFraccionamientoValor;
  end;
end;

procedure TTimeTable.ActualizarProfesorPeriodoCant;
var
  I, j, p, s: Smallint;
  q, r: PSmallintArray;
begin
  with ModeloHorario do
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

procedure TTimeTable.ActualizarAulaTipoPeriodoCant;
var
  I, j, a, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for I := 0 to FAulaTipoCant - 1 do
      FillChar(FAulaTipoPeriodoCant[I, 0], FPeriodoCant * SizeOf(Smallint), #0);
    for I := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[I, 0];
      for j := 0 to FPeriodoCant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          a := FSesionAAulaTipo[s];
          Inc(FAulaTipoPeriodoCant[a, j]);
        end;
      end;
    end;
  end;
end;

function TTimeTable.EvaluarIntercambioInterno
  (AParalelo, APeriodo, APeriodo1: Smallint): Double;
var
  d, d1, s, s1, di, di1, hl, hl1, m, m1, p, p1: Smallint;
  q, r: PSmallintArray;
  FIncDiaProfesorCantHora, FIncProfesorPeriodoCant: TDynamicSmallintArrayArray;
  // TList sera usado como arreglo de enteros de 32 bits, no de punteros!
  procedure InsertarCambio(d, p: Smallint);
  var
    v: LongWord;
  begin
    v := d shl 16 + p;
    if FAntListaCambios.IndexOf(Pointer(v)) < 0 then
      FAntListaCambios.Add(Pointer(v));
  end;
  function _EvaluarCruceProfesor: Smallint;
  var
    l, di_, di1_: Smallint;
  begin
    with FModeloHorario do
    begin
      Result := 0;
      if p <> p1 then
      begin
        if p >= 0 then
        begin
          for l := d - 1 downto 0 do
          begin
            if ProfesorPeriodoCant[p, APeriodo1 + l] >= 1 then
            begin
              Inc(Result);
            end;
            if ProfesorPeriodoCant[p, APeriodo + l] > 1 then
            begin
              Dec(Result);
            end;
            di_ := FPeriodoADia[APeriodo + l];
            di1_ := FPeriodoADia[APeriodo1 + l];
            Inc(FIncProfesorPeriodoCant[p, APeriodo1 + l]);
            Inc(FIncDiaProfesorCantHora[di1_, p]);
            InsertarCambio(di1_, p);
            Dec(FIncDiaProfesorCantHora[di_, p]);
            Dec(FIncProfesorPeriodoCant[p, APeriodo + l]);
            InsertarCambio(di_, p);
          end;
        end;
        if p1 >= 0 then
        begin
          for l := d - 1 downto 0 do
          begin
            if ProfesorPeriodoCant[p1, APeriodo + l] >= 1 then
              Inc(Result);
            if ProfesorPeriodoCant[p1, APeriodo1 + l] > 1 then
              Dec(Result);
            di_ := FPeriodoADia[APeriodo + l];
            di1_ := FPeriodoADia[APeriodo1 + l];
            Inc(FIncProfesorPeriodoCant[p1, APeriodo + l]);
            Inc(FIncDiaProfesorCantHora[di_, p1]);
            InsertarCambio(di_, p1);
            Dec(FIncProfesorPeriodoCant[p1, APeriodo1 + l]);
            Dec(FIncDiaProfesorCantHora[di1_, p1]);
            InsertarCambio(di1_, p1);
          end;
        end;
      end;
    end;
  end;
  function _EvaluarCruceProfesorMovido: Integer;
  var
    p_, p1_, j_, s_, s1_, di_: Smallint;
  begin
    with FModeloHorario do
    begin
      Result := 0;
      for j_ := APeriodo to APeriodo + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
          p_ := r[FSesionAMateria[s_]]
        else
          p_ := -1;
        if p_ <> p1 then
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
          if (p1 >= 0) then
          begin
            if ProfesorPeriodoCant[p1, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorPeriodoCant[p1, j_]);
            Inc(FIncDiaProfesorCantHora[di_, p1]);
            InsertarCambio(di_, p1);
          end;
        end;
      end;
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s1_ := q[j_];
        if s1_ >= 0 then
          p1_ := r[FSesionAMateria[s1_]]
        else
          p1_ := -1;
        s_ := q[j_ + d - d1];
        if s_ >= 0 then
          p_ := r[FSesionAMateria[s_]]
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
      for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
          p1_ := r[FSesionAMateria[s_]]
        else
          p1_ := -1;
        if p <> p1_ then
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
          if p >= 0 then
          begin
            if ProfesorPeriodoCant[p, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorPeriodoCant[p, j_]);
            Inc(FIncDiaProfesorCantHora[di_, p]);
            InsertarCambio(di_, p);
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
      with ModeloHorario do
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
    with FModeloHorario do
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
      with ModeloHorario do
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
    with ModeloHorario do
    begin
      for j_ := 0 to APeriodo - 1 do
      begin
        s_ := q[j_];
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
      if s1 >= 0 then
      begin
        for j_ := APeriodo to APeriodo + d1 - 1 do
        begin
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[m1, di_] < h then
            FAntMateriaDiaMaxHora[m1, di_] := h;
          if FAntMateriaDiaMinHora[m1, di_] > h then
            FAntMateriaDiaMinHora[m1, di_] := h;
        end;
      end;
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
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
      if s >= 0 then
      begin
        for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
        begin
          di_ := FPeriodoADia[j_];
          h := FPeriodoAHora[j_];
          if FAntMateriaDiaMaxHora[m, di_] < h then
            FAntMateriaDiaMaxHora[m, di_] := h;
          if FAntMateriaDiaMinHora[m, di_] > h then
            FAntMateriaDiaMinHora[m, di_] := h;
        end;
      end;
      for j_ := APeriodo1 + d1 to FPeriodoCant - 1 do
      begin
        s_ := q[j_];
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
    with ModeloHorario do
    begin
      Result := 0;
      j_ := hl;
      Normalizar(AParalelo, j_);
      if j_ <> hl then
        Inc(j_, FSesionADuracion[q[j_]]);
      while j_ <= hl1 do
      begin
        s_ := q[j_];
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
      j_ := hl;
      Normalizar(AParalelo, j_);
      if j_ <> hl then
        Inc(j_, FSesionADuracion[q[j_]]);
      while j_ < APeriodo do
      begin
        s_ := q[j_];
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
      if s1 >= 0 then
      begin
        di_ := FPeriodoADia[APeriodo];
        t := FAntMateriaDiaMaxHora[m1, di_] - FAntMateriaDiaMinHora[m1, di_];
        if t >= 0 then
        begin
          Inc(Result, Abs(t + 1 - d1));
        end
      end;
      Inc(j_, d);
      while j_ < APeriodo1 do
      begin
        s_ := q[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FPeriodoADia[j_ + d1 - d];
          m_ := FSesionAMateria[s_];
          t := FAntMateriaDiaMaxHora[m_, di_] - FAntMateriaDiaMinHora[m_, di_];
          if t >= 0 then
          begin
            Inc(Result, Abs(t + 1 - d_));
          end
        end;
        Inc(j_, d_);
      end;
      if s >= 0 then
      begin
        di_ := FPeriodoADia[APeriodo1 + d1 - d];
        t := FAntMateriaDiaMaxHora[m, di_] - FAntMateriaDiaMinHora[m, di_];
        if t >= 0 then
        begin
          Inc(Result, Abs(t + 1 - d));
        end
      end;
      Inc(j_, d1);
      while j_ <= hl1 do
      begin
        s_ := q[j_];
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
    with FModeloHorario do
    begin
      if s >= 0 then
        a := FSesionAAulaTipo[s]
      else
        a := -1;
      if s1 >= 0 then
        a1 := FSesionAAulaTipo[s1]
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
          for l := d - 1 downto 0 do
          begin
            if AulaTipoPeriodoCant[a, APeriodo1 + l] >= c then
              Inc(Result);
            if AulaTipoPeriodoCant[a, APeriodo + l] > c then
              Dec(Result);
          end;
        end;
        if a1 >= 0 then
        begin
          c1 := FAulaTipoACantidad[a1];
          for l := d - 1 downto 0 do
          begin
            if AulaTipoPeriodoCant[a1, APeriodo + l] >= c1 then
              Inc(Result);
            if AulaTipoPeriodoCant[a1, APeriodo1 + l] > c1 then
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
    with FModeloHorario do
    begin
      Result := 0;
      c := 0;
      c1 := 0;
      if s1 >= 0 then
      begin
        a1 := FSesionAAulaTipo[s1];
        c1 := FAulaTipoACantidad[a1];
      end
      else
        a1 := -1;
      for j_ := APeriodo to APeriodo + d1 - 1 do
      begin
        s_ := q[j_];
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
      if s >= 0 then
      begin
        a := FSesionAAulaTipo[s];
        c := FAulaTipoACantidad[a];
      end
      else
        a := -1;
      for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
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
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s1_ := q[j_];
        if s1_ >= 0 then
        begin
          a1 := FSesionAAulaTipo[s1_];
          c1 := FAulaTipoACantidad[a1];
        end
        else
          a1 := -1;
        s_ := q[j_ + d - d1];
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
    with ModeloHorario do
      if s <> s1 then
      begin
        if s < 0 then
        begin
          for k := 0 to d - 1 do
          begin
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo + k] then
              Dec(Result);
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo1 + k] then
              Inc(Result);
          end;
        end
        else if s1 < 0 then
        begin
          for k := 0 to d - 1 do
          begin
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo + k] then
              Inc(Result);
            if FHoraCant - 1 <> FPeriodoAHora[APeriodo1 + k] then
              Dec(Result);
          end;
        end;
      end;
  end;
  function _EvaluarHoraHuecaDesubicadaMovido: Smallint;
  var
    j_, s_: Smallint;
  begin
    with FModeloHorario do
    begin
      Result := 0;
      for j_ := APeriodo to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if (s_ < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Dec(Result);
      end;
      for j_ := APeriodo to APeriodo + d1 - 1 do
      begin
        if (s1 < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Inc(Result);
      end;
      for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
      begin
        if (s < 0) and (FHoraCant - 1 <> FPeriodoAHora[j_]) then
          Inc(Result);
      end;
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
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
    with ModeloHorario do
    begin
      Result := 0;
      if s <> s1 then
      begin
        if s >= 0 then
        begin
          for k := 0 to d - 1 do
          begin
            mp := FMateriaPeriodoAMateriaProhibicionTipo[m, APeriodo + k];
            mp1 := FMateriaPeriodoAMateriaProhibicionTipo[m, APeriodo1 + k];
            if mp <> mp1 then
            begin
              if mp >= 0 then
                Result := Result - FMateriaProhibicionTipoAValor[mp];
              if mp1 >= 0 then
                Result := Result + FMateriaProhibicionTipoAValor[mp1];
            end;
          end;
        end;
        if s1 >= 0 then
        begin
          for k := 0 to d - 1 do
          begin
            mp1 := FMateriaPeriodoAMateriaProhibicionTipo[m1, APeriodo1 + k];
            mp := FMateriaPeriodoAMateriaProhibicionTipo[m1, APeriodo + k];
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
    with ModeloHorario do
    begin
      Result := 0;
      for j_ := APeriodo to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          mp := FMateriaPeriodoAMateriaProhibicionTipo[m_, j_];
          if mp >= 0 then
            Result := Result - FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if s1 >= 0 then
      begin
        for j_ := APeriodo to APeriodo + d1 - 1 do
        begin
          mp := FMateriaPeriodoAMateriaProhibicionTipo[m1, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if s >= 0 then
      begin
        for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
        begin
          mp := FMateriaPeriodoAMateriaProhibicionTipo[m, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
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
    with ModeloHorario do
    begin
      Result := 0;
      if s <> s1 then
      begin
        if s >= 0 then
        begin
          p := r[m];
          for k := 0 to d - 1 do
          begin
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p, APeriodo + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p, APeriodo1 + k];
            if pp >= 0 then
              Result := Result + FProfesorProhibicionTipoAValor[pp];
          end;
        end;
        if s1 >= 0 then
        begin
          p1 := r[m1];
          for k := 0 to d - 1 do
          begin
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p1, APeriodo1 + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorPeriodoAProfesorProhibicionTipo[p1, APeriodo + k];
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
    with ModeloHorario do
    begin
      Result := 0;
      for j_ := APeriodo to APeriodo1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          p_ := r[FSesionAMateria[s_]];
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result - FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if s1 >= 0 then
      begin
        p_ := r[m1];
        for j_ := APeriodo to APeriodo + d1 - 1 do
        begin
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if s >= 0 then
      begin
        p_ := r[m];
        for j_ := APeriodo1 + d1 - d to APeriodo1 + d1 - 1 do
        begin
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      for j_ := APeriodo + d1 to APeriodo1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
        if s_ >= 0 then
        begin
          p_ := r[FSesionAMateria[s_]];
          pp := FProfesorPeriodoAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
    end;
  end;

begin
  with FModeloHorario do
  begin
    q := @ParaleloPeriodoASesion[AParalelo, 0];
    r := @FParaleloMateriaAProfesor[AParalelo, 0];
    s := q[APeriodo];
    s1 := q[APeriodo1];
    d := FSesionADuracion[s];
    d1 := FSesionADuracion[s1];
    if s >= 0 then
    begin
      m := FSesionAMateria[s];
      p := r[m];
    end
    else
    begin
      m := -1;
      p := -1;
    end;
    if s1 >= 0 then
    begin
      m1 := FSesionAMateria[s1];
      p1 := r[m1];
    end
    else
    begin
      m1 := -1;
      p1 := -1;
    end;
    di := FPeriodoADia[APeriodo];
    hl := FDiaHoraAPeriodo[di, 0];
    di1 := FPeriodoADia[APeriodo1 + d1 - 1];
    hl1 := FDiaAMaxPeriodo[di1];
    SetLength(FIncDiaProfesorCantHora, FDiaCant, FProfesorCant);
    SetLength(FIncProfesorPeriodoCant, FProfesorCant, FPeriodoCant);
    ActMateriaDiaMinMaxEntraMovido;
    // ActDiaProfesorMinMaxEntraMovido;
    FAntListaCambios.Clear;
    if d = d1 then
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
  procedure TObjetoModeloHorario.Check(AParalelo: Smallint; s: string);
  var
  j, d: Smallint;
  p: PSmallintArray;
  q: PLongintArray;
  begin
  p := @FParaleloPeriodoASesion[AParalelo, 0];
  q := @FClaveAleatoria[AParalelo, 0];
  j := 0;
  with ModeloHorario do
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

  procedure TObjetoModeloHorario.Check(s: string);
  var
  i: Smallint;
  begin
  with ModeloHorario do
  begin
  for i := 0 to FParaleloCant - 1 do
  begin
  Check(i, s);
  end;
  end;
  end;
}

function TTimeTable.DescensoRapidoPuntualInterno
  (AParalelo: Smallint; var Delta: Double): Boolean;
var
  j, j1, d: Smallint;
  dk: Double;
  p: PSmallintArray;
begin
  with FModeloHorario do
  begin
    Result := True;
    j := 0;
    p := @FParaleloPeriodoASesion[AParalelo, 0];
    while j < FPeriodoCant do
    begin
      j1 := j + FSesionADuracion[p[j]];
      while j1 < FPeriodoCant do
      begin
        d := FSesionADuracion[p[j1]];
        dk := EvaluarIntercambioInterno(AParalelo, j, j1);
        if Delta + dk < 0 then
        begin
          IntercambiarInterno(AParalelo, j, j1, True);
          Delta := Delta + dk;
          Result := False;
          Exit;
        end;
        Inc(j1, d);
      end;
      Inc(j, FSesionADuracion[p[j]]);
    end;
  end;
end;

function TTimeTable.DescensoRapidoPuntualInterno(var Delta: Double): Boolean;
var
  ci, I, j, j1, d: Smallint;
  dk: Double;
  RandomOrdersi: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  p: PSmallintArray;
begin
  with FModeloHorario do
  begin
    Result := True;
    for ci := 0 to FParaleloCant - 1 do
    begin
      RandomOrdersi[ci] := ci;
      RandomValues[ci] := rand32;
    end;
    SortLongint(RandomValues, RandomOrdersi, 0, FParaleloCant - 1);
    ci := 0;
    while ci < FParaleloCant do
    begin
      I := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[I, 0];
      while j < FPeriodoCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FPeriodoCant do
        begin
          d := FSesionADuracion[p[j1]];
          dk := EvaluarIntercambioInterno(I, j, j1);
          if Delta + dk < 0 then
          begin
            IntercambiarInterno(I, j, j1, True);
            Delta := Delta + dk;
            Result := False;
            Exit;
          end;
          Inc(j1, d);
        end;
        Inc(j, FSesionADuracion[p[j]]);
      end;
      Inc(ci);
    end;
  end;
end;

function TTimeTable.DescensoRapidoOptimizadoInterno(Step: Integer): Boolean;
var
  j, j1, d, d1, ci, I, k, s, l: Smallint;
  dk, v1: Double;
  RandomOrdersi: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  p: PSmallintArray;
  Stop: Boolean;
  { Continuar: Boolean; }
begin
  Actualizar;
  DoGetValor;
  with ModeloHorario do
  begin
    for ci := 0 to FParaleloCant - 1 do
    begin
      RandomOrdersi[ci] := ci;
      RandomValues[ci] := $7FFFFFFF;
    end;
    for I := 0 to FProfesorCant - 1 do
    begin
      for j := 0 to FPeriodoCant - 1 do
      begin
        if FProfesorPeriodoCant[I, j] > 1 then
        begin
          for k := 0 to FParaleloCant - 1 do
          begin
            s := FParaleloPeriodoASesion[k, j];
            if (s >= 0) and (FParaleloMateriaAProfesor[k, FSesionAMateria[s]]
                = I) then
              RandomValues[k] := rand32 div 2;
          end;
        end;
      end;
    end;
    SortLongint(RandomValues, RandomOrdersi, 0, FParaleloCant - 1);
    Result := True;
    l := 0;
    while (l < FParaleloCant) and (RandomValues[l] <> $7FFFFFFF) do
    begin
      Inc(l);
    end;
    ci := 0;
    v1 := Valor;
    while ci < l do
    begin
      { Continuar := True; }
      I := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[I, 0];
      while j < FPeriodoCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FPeriodoCant do
        begin
          Stop := False;
          // Max := l * Sqr(FPeriodoCant);
          DoProgress((j + ci * FPeriodoCant) * FPeriodoCant + j1, Step, Self,
            Stop);
          if Stop then
            Exit;
          dk := EvaluarIntercambioInterno(I, j, j1);
          d := FSesionADuracion[p[j]];
          d1 := FSesionADuracion[p[j1]];
          IntercambiarInterno(I, j, j1, True);
          if dk < 0 then
          begin
            Result := False;
          end
          else
          begin
            if DescensoRapidoPuntualInterno(I, dk) then
            begin
              IntercambiarInterno(I, j, j1 + d1 - d);
              dk := 0;
            end
            else
            begin
              Normalizar(I, j);
              Result := False;
            end;
          end;
          v1 := v1 + dk;
          Normalizar(I, j1);
          Inc(j1, FSesionADuracion[p[j1]]);
        end;
        Normalizar(I, j);
        Inc(j, FSesionADuracion[p[j]]);
      end;
      { if Continuar then }
      Inc(ci);
    end;
  end;
end;

function TTimeTable.DescensoRapidoDobleInterno(Step: Integer): Boolean;
var
  j, j1, d, d1, ci, I { , k } : Smallint;
  dk, v1: Double;
  Position: Integer;
  RandomOrdersi: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  p: PSmallintArray;
  Stop: Boolean;
  { Continuar: Boolean; }
begin
  Actualizar;
  DoGetValor;
  with ModeloHorario do
  begin
    for ci := 0 to FParaleloCant - 1 do
    begin
      RandomOrdersi[ci] := ci;
      RandomValues[ci] := rand32;
    end;
    SortLongint(RandomValues, RandomOrdersi, 0, FParaleloCant - 1);
    Result := True;
    ci := 0;
    v1 := Valor;
    Position := 0;
    while ci < FParaleloCant do
    begin
      { Continuar := True; }
      I := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[I, 0];
      while j < FPeriodoCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        // k := j1;
        while j1 < FPeriodoCant do
        begin
          Stop := False;
          // Position := ci * FPeriodoCant * (FPeriodoCant - 1) div 2
          // + j * (FPeriodoCant - 1) - j * (j - 1) div 2 + j1 - k
          DoProgress(Position, Step, Self, Stop);
          if Stop then
            Exit;
          Inc(Position);
          dk := EvaluarIntercambioInterno(I, j, j1);
          d := FSesionADuracion[p[j]];
          d1 := FSesionADuracion[p[j1]];
          IntercambiarInterno(I, j, j1, True);
          if dk < 0 then
          begin
            Result := False;
          end
          else
          begin
            if DescensoRapidoPuntualInterno(dk) then
            begin
              IntercambiarInterno(I, j, j1 + d1 - d);
              dk := 0;
            end
            else
            begin
              Normalizar(I, j);
              Result := False;
            end;
          end;
          v1 := v1 + dk;
          Normalizar(I, j1);
          Inc(j1, FSesionADuracion[p[j1]]);
        end;
        Normalizar(I, j);
        Inc(j, FSesionADuracion[p[j]]);
      end;
      { if Continuar then }
      Inc(ci);
    end;
  end;
end;

{ Retorna verdadero cuando no ha descendido }

function TTimeTable.DescensoRapidoInterno: Boolean;
begin
  Result := DescensoRapidoInterno(0);
end;

function TTimeTable.DescensoRapidoInterno(Delta: Double): Boolean;
var
  ci, I, j, j1, d1: Smallint;
  dk1 {$IFDEF DEBUG}, v1, v2 {$ENDIF}: Double;
  RandomOrdersi: array [0 .. 4095] of Smallint;
  RandomValues: array [0 .. 4095] of Longint;
  p: PSmallintArray;
  { Continuar: Boolean; }
begin
  with ModeloHorario do
  begin
    for ci := 0 to FParaleloCant - 1 do
    begin
      RandomOrdersi[ci] := ci;
      RandomValues[ci] := rand32;
    end;
    SortLongint(RandomValues, RandomOrdersi, 0, FParaleloCant - 1);
    Result := True;
    ci := 0;
    while ci < FParaleloCant do
    begin
      { Continuar := True; }
      I := RandomOrdersi[ci];
      p := @FParaleloPeriodoASesion[I, 0];
      j := 0;
      while j < FPeriodoCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FPeriodoCant do
        begin
          d1 := FSesionADuracion[p[j1]];
{$IFDEF DEBUG}
          Actualizar;
          DoGetValor;
          v1 := Valor;
{$ENDIF}
          dk1 := EvaluarIntercambioInterno(I, j, j1);
          if (dk1 < Delta) { or ((dk1 = 0) and ((rand32 mod 4) = 0)) } then
          begin
            IntercambiarInterno(I, j, j1, True);
{$IFDEF DEBUG}
            Actualizar;
            DoGetValor;
            v2 := Valor;
            if Abs((v2 - v1) - dk1) > 0.00001 then
              raise Exception.Create('Problemas');
{$ENDIF}
            Result := False;
          end;
          { Continuar := Continuar and (dk1 >= 0); }
          Inc(j1, d1);
        end;
        Inc(j, FSesionADuracion[p[j]]);
      end;
      { if Continuar then }
      Inc(ci);
    end;
  end;
end;

function TTimeTable.DescensoRapido: Boolean;
begin
  // Check('DescensoRapidoAntes');
  Result := DescensoRapidoInterno;
  RecalcularValor := True;
  // Check('DescensoRapidoDespues');
end;

function TTimeTable.DescensoRapidoDoble(Step: Integer): Boolean;
begin
  Result := DescensoRapidoDobleInterno(Step);
  RecalcularValor := True;
end;

procedure TTimeTable.DescensoRapidoOptimizadoForzado(Step: Integer);
begin
  repeat
  until DescensoRapidoOptimizadoInterno(Step);
  RecalcularValor := True;
end;

procedure TTimeTable.DescensoRapidoDobleForzado(Step: Integer);
begin
  repeat
    // Application.ProcessMessages;
  until DescensoRapidoDobleInterno(Step);
  RecalcularValor := True;
end;

procedure TTimeTable.DescensoRapidoForzado;
begin
  repeat
    // Application.ProcessMessages;
  until DescensoRapidoInterno;
  RecalcularValor := True;
end;

{ procedure TObjetoModeloHorario.DescensoRapido2(CallBack: TCountFunc);
  begin
  DescensoRapidoInterno2(CallBack);
  RecalcularValor := True;
  end; }

destructor TTimeTable.Destroy;
begin
  FModeloHorario := nil;
  FAntListaCambios.Free;
  inherited Destroy;
end;

procedure TTimeTable.Assign(ATimeTable: TTimeTable);
var
  I, m, p, a, d: Smallint;
begin
  with ModeloHorario do
  begin
    for I := 0 to FParaleloCant - 1 do
    begin
      Move(ATimeTable.ParaleloPeriodoASesion[I, 0],
        ParaleloPeriodoASesion[I, 0], FPeriodoCant * SizeOf(Smallint));
    end;
    if ATimeTable.RecalcularValor then
      RecalcularValor := True
    else
    begin
      FCruceProfesor := ATimeTable.FCruceProfesor;
      FProfesorFraccionamiento := ATimeTable.FProfesorFraccionamiento;
      FCruceAulaTipo := ATimeTable.FCruceAulaTipo;
      FHoraHuecaDesubicada := ATimeTable.FHoraHuecaDesubicada;
      FSesionCortada := ATimeTable.FSesionCortada;
      FMateriaNoDispersa := ATimeTable.FMateriaNoDispersa;
      FMateriaProhibicion := ATimeTable.FMateriaProhibicion;
      FProfesorProhibicion := ATimeTable.FProfesorProhibicion;
      FMateriaProhibicionValor := ATimeTable.FMateriaProhibicionValor;
      FProfesorProhibicionValor := ATimeTable.FProfesorProhibicionValor;
      FValor := ATimeTable.FValor;
      RecalcularValor := False;
    end;
    Move(ATimeTable.FParaleloMateriaNoDispersa[0],
      FParaleloMateriaNoDispersa[0], FParaleloCant * SizeOf(Smallint));
    for I := 0 to FParaleloCant - 1 do
    begin
      for m := 0 to FMateriaCant - 1 do
      begin
        Move(ATimeTable.FParaleloMateriaDiaMinHora[I, m, 0],
          FParaleloMateriaDiaMinHora[I, m, 0], FDiaCant * SizeOf(Smallint));
        Move(ATimeTable.FParaleloMateriaDiaMaxHora[I, m, 0],
          FParaleloMateriaDiaMaxHora[I, m, 0], FDiaCant * SizeOf(Smallint));
      end;
    end;
    for m := 0 to FMateriaCant - 1 do
      Move(ATimeTable.FMateriaPeriodoCant[m, 0], FMateriaPeriodoCant[m, 0],
        FPeriodoCant * SizeOf(Smallint));
    for p := 0 to FProfesorCant - 1 do
      Move(ATimeTable.FProfesorPeriodoCant[p, 0], FProfesorPeriodoCant[p, 0],
        FPeriodoCant * SizeOf(Smallint));
    for d := 0 to FDiaCant - 1 do
    begin
      Move(ATimeTable.FDiaProfesorFraccionamiento[d, 0],
        FDiaProfesorFraccionamiento[d, 0], FProfesorCant * SizeOf(Smallint));

      { Move(AObjetoModeloHorario.FDiaProfesorSumaHora[d, 0],
        FDiaProfesorSumaHora[d, 0], FProfesorCant * SizeOf(Smallint));
        Move(AObjetoModeloHorario.FDiaProfesorSumaCuadradoHora[d, 0],
        FDiaProfesorSumaCuadradoHora[d, 0], FProfesorCant * SizeOf(Smallint)); }
    end;
    for a := 0 to FAulaTipoCant - 1 do
      Move(ATimeTable.FAulaTipoPeriodoCant[a, 0], FAulaTipoPeriodoCant[a, 0],
        FPeriodoCant * SizeOf(Smallint));
  end;
end;

procedure TTimeTable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  I, j: Integer;
begin
  VStrings := TStringList.Create;
  with ModeloHorario do
    try
      for I := 0 to FParaleloCant - 1 do
      begin
        VStrings.Add(Format('Paralelo %d %d %d',
            [FNivelACodNivel[FParaleloANivel[I]],
            FEspecializacionACodEspecializacion[FParaleloAEspecializacion[I]],
            FParaleloIdACodParaleloId[FParaleloAParaleloId[I]]]));
        for j := 0 to FPeriodoCant - 1 do
        begin
          VStrings.Add(Format(' Dia %d Hora %d Materia %d', [FPeriodoADia[j],
              FPeriodoAHora[j],
              FMateriaACodMateria[FSesionAMateria[ParaleloPeriodoASesion[I, j]]]
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
  I: Smallint;
begin
  with FModeloHorario do
    for I := 0 to FParaleloCant - 1 do
    begin
      Stream.Write(ParaleloPeriodoASesion[I, 0], FPeriodoCant * SizeOf(Smallint)
        );
    end;
end;

procedure TTimeTable.LoadFromStream(Stream: TStream);
var
  I: Smallint;
begin
  with FModeloHorario do
    for I := 0 to FParaleloCant - 1 do
    begin
      Stream.Read(ParaleloPeriodoASesion[I, 0], FPeriodoCant * SizeOf(Smallint)
        );
    end;
  Actualizar;
  FRecalcularValor := True;
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
    FieldHorario, FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia,
      FieldHora, FieldMateria, FieldSesion: TField;
    I, j, k, l, m, s: Integer;
  begin
    with ModeloHorario, SourceDataModule.TbHorarioDetalle do
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
        for I := 0 to FParaleloCant - 1 do
        begin
          k := FNivelACodNivel[FParaleloANivel[I]];
          l := FParaleloIdACodParaleloId[FParaleloAParaleloId[I]];
          m := FEspecializacionACodEspecializacion
            [FParaleloAEspecializacion[I]];
          for j := 0 to FPeriodoCant - 1 do
          begin
            s := ParaleloPeriodoASesion[I, j];
            if s >= 0 then
            begin
              Append;
              FieldHorario.AsInteger := CodHorario;
              FieldNivel.AsInteger := k;
              FieldParaleloId.AsInteger := l;
              FieldEspecializacion.AsInteger := m;
              FieldDia.AsInteger := FDiaACodDia[FPeriodoADia[j]];
              FieldHora.AsInteger := FHoraACodHora[FPeriodoAHora[j]];
              FieldMateria.AsInteger := FMateriaACodMateria[FSesionAMateria[s]];
              FieldSesion.AsInteger := s;
              Post;
            end;
          end;
        end;
      finally
        EnableControls;
      end;
    end;
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

function TTimeTable.GetDiaProfesorFraccionamiento(di, p: Smallint): Smallint;
var
  h_, iMax, iMin, iCant, n: Smallint;
  q: PSmallintArray;
  r: PShortintArray;
begin
  iCant := 0;
  iMax := -1;
  iMin := 32767;
  with ModeloHorario do
  begin
    n := FDiaAMaxPeriodo[di];
    q := @FProfesorPeriodoCant[p, 0];
    r := @FProfesorPeriodoAProfesorProhibicionTipo[p, 0];
    for h_ := FDiaHoraAPeriodo[di, 0] to n do
    begin
      if (q[h_] > 0) or (FProfesorProhibicionTipoAValor[r[h_]] =
          FMaxProfesorProhibicionTipoValor) then
      begin
        iMax := FPeriodoAHora[h_];
        Inc(iCant);
        if iMin > iMax then
          iMin := iMax;
      end;
    end;
  end;
  if iCant = 0 then
    Result := 0
  else
    Result := iMax - iMin + 1 - iCant;
end;

procedure TTimeTable.LoadFromDataModule(CodHorario: Integer);
var
  FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia, FieldHora,
    FieldSesion: TLongintField;
  I, j: Smallint;
begin
  with SourceDataModule, ModeloHorario, TbHorarioDetalle do
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
      for I := 0 to FParaleloCant - 1 do
        FillChar(FParaleloPeriodoASesion[I, 0], FPeriodoCant * SizeOf(Smallint)
            , #$FF);
      First;
      while not Eof do
      begin
        I := FCursoParaleloIdAParalelo[FNivelEspecializacionACurso
          [FCodNivelANivel[FieldNivel.AsInteger - FMinCodNivel],
          FCodEspecializacionAEspecializacion[FieldEspecializacion.AsInteger -
          FMinCodEspecializacion]],
          FCodParaleloIdAParaleloId[FieldParaleloId.AsInteger -
          FMinCodParaleloId]];
        j := FDiaHoraAPeriodo[FCodDiaADia[FieldDia.AsInteger - FMinCodDia],
          FCodHoraAHora[FieldHora.AsInteger - FMinCodHora]];
        FParaleloPeriodoASesion[I, j] := FieldSesion.AsInteger;
        Next;
      end;
    finally
      MasterSource := nil;
      MasterFields := '';
      LinkedFields := '';
    end;
  end;
  Actualizar;
  RecalcularValor := True;
end;

procedure TTimeTable.Actualizar;
begin
  ActualizarAulaTipoPeriodoCant;
  ActualizarProfesorPeriodoCant;
  ActualizarMateriaPeriodoCant;
  ActualizarParaleloMateriaDiaMinMaxHora;
  ActualizarDiaProfesorFraccionamiento;
end;

procedure TModeloHorario.DoProgress(I, Step: Integer; Horario: TTimeTable;
  var Stop: Boolean);
begin
  if Assigned(FOnProgress) then
    FOnProgress(I, Step, Horario, Stop);
end;

destructor TModeloHorario.Destroy;
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
