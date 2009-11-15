unit KerModel;

interface

uses
  Classes, DB, DBTables, Dialogs, SysConst, Math, Forms;
type
  TProgressEvent = procedure(I, Max: Integer; Value: Double; var Stop: Boolean) of object;
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
  TLongintArray = array[0..16383] of Longint;
  PSmallintArray = ^TSmallintArray;
  TSmallintArray = array[0..16383] of Smallint;
  PSmallintArrayArray = ^TSmallintArrayArray;
  TSmallintArrayArray = array[0..0] of PSmallintArray;
  PShortintArray = ^TShortintArray;
  TShortintArray = array[0..32767] of Shortint;
  PDoubleArray = ^TDoubleArray;
  TDoubleArray = array[0..0] of Double;
  PBooleanArray = ^TBooleanArray;
  TBooleanArray = array[0..16383] of Boolean;
{
  Clase TModeloHorario
  Descripción:
    Implementa la carga de la información desde la base de datos a la memoria
    RAM.
    Miembros privados:
      Todos los arreglos dinámicos que contienen la información, los campos que
      contienen los pesos de la función objetivo y las funciones de uso interno.
    Miembros protegidos:
      Arreglo dinámico que contiene el molde de un horario, que facilita la
      construcción de soluciones.
    Miembros públicos:
      El constructor, la función que permite configurar los pesos y los pesos
      de cada restricción.
}
  TModeloHorario = class
  private
    FOnProgress: TProgressEvent;
    FQuHorarioDetalle: TQuery;
    FCruceProfesorValor,
      FCruceAulaTipoValor,
      FHoraHuecaDesubicadaValor,
      FSesionCortadaValor,
      FProfesorFraccionamientoValor,
      FMateriaNoDispersaValor: Double;
    FHorarioLaborableADia,
      FHorarioLaborableAHora,
      FDiaAMaxHorarioLaborable,
      FSesionAAsignatura,
      FSesionAMateria,
      FSesionAAulaTipo,
      FAulaTipoACantidad,
      FMateriaProhibicionAMateria,
      FMateriaProhibicionAHorarioLaborable,
      FMateriaProhibicionAMateriaProhibicionTipo,
      FProfesorProhibicionAProfesor,
      FProfesorProhibicionAHorarioLaborable,
      FProfesorProhibicionAProfesorProhibicionTipo,
      FAsignaturaAAulaTipo,
      FParaleloACurso,
      FParaleloANivel,
      FParaleloAParaleloId,
      FParaleloAEspecializacion,
      FCursoADuracion,
      FProfesorCantHora,
      FParaleloASesionCant: TDynamicSmallintArray;
    FSesionADuracion: array[-1..16382] of Smallint;
    FDiaHoraAHorarioLaborable,
      FNivelEspecializacionACurso,
      FCursoParaleloIdAParalelo,
      FParaleloMateriaAProfesor,
      FMateriaCursoAAsignatura,
      FMoldeHorarioDetalle,
      FAsignaturaASesiones: TDynamicSmallintArrayArray;
    FProfesorHorarioLaborableAProfesorProhibicionTipo,
      FMateriaHorarioLaborableAMateriaProhibicionTipo:
      TDynamicShortintArrayArray;
    FMateriaProhibicionTipoAValor,
      FProfesorProhibicionTipoAValor: array[-1..4094] of Double;
    FMateriaProhibicionAValor,
      FProfesorProhibicionAValor: TDynamicDoubleArray;
    FParaleloCant,
      FMateriaCant,
      FDiaCant,
      FHoraCant,
      FHorarioLaborableCant,
      FProfesorCant,
      FNivelCant,
      FEspecializacionCant,
      FCursoCant,
      FAulaTipoCant,
      FMaxProfesorProhibicionTipo,
      FMaxMateriaProhibicionTipo: Smallint;
    FMaxProfesorProhibicionTipoValor: Double;
    FParaleloIdACodParaleloId,
      FMateriaACodMateria,
      FDiaACodDia,
      FHoraACodHora,
      FNivelACodNivel,
      FEspecializacionACodEspecializacion: TDynamicLongintArray;
    FCodNivelANivel,
      FCodEspecializacionAEspecializacion,
      FCodParaleloIdAParaleloId,
      FCodDiaADia,
      FCodHoraAHora: TDynamicSmallintArray;
    FMinCodNivel,
      FMinCodEspecializacion,
      FMinCodParaleloId,
      FMinCodDia,
      FMinCodHora: Longint;
    FDatabase: TDatabase;
    function GetDiaAMaxHorarioLaborable(d: Smallint): Smallint;
  protected
    procedure DoProgress(I, Max: Integer; Value: Double; var Stop: Boolean); dynamic;
    property MoldeHorarioDetalle: TDynamicSmallintArrayArray read
      FMoldeHorarioDetalle;
  public
    property HorarioLaborableCant: Smallint read FHorarioLaborableCant;
    property ParaleloCant: Smallint read FParaleloCant;
    procedure Configurar(
      ACruceProfesorValor,
      AProfesorFraccionamientoValor,
      ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor,
      ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    constructor CrearDesdeDatabase(
      ADatabase: TDatabase;
      ACruceProfesorValor,
      AProfesorFraccionamientoValor,
      ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor,
      ASesionCortadaValor,
      AMateriaNoDispersaValor: Double);
    destructor Destroy; override;
    property CruceProfesorValor: Double read FCruceProfesorValor;
    property ProfesorFraccionamientoValor: Double
      read FProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read FCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read FHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read FSesionCortadaValor;
    property MateriaNoDispersaValor: Double read FMateriaNoDispersaValor;
    property Database: TDatabase read FDatabase;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;
//type
  //TCountFunc = procedure(Count, Cant: Integer) of object;
{
  Clase TObjetoModeloHorario
  Descripción:
    Implementa una solución del problema.
    Miembros privados:
      Todos los arreglos dinámicos que contienen la información consistentes en
      el horario, las claves aleatorias y datos temporales que aceleran la
      evaluación de la función objetivo, los campos que contienen los valores
      de cada parte de la función objetivo y las funciones de uso interno.
    Miembros protegidos:
      Propiedad que forza a que se reevalúe toda la función objetivo.
    Miembros públicos:
      propiedades que devuelven el valor de cada componente de la función
      objetivo, el valor de la función objetivo, el constructor, funciones que
      permiten guardar el horario en una base de datos, métodos que consisten
      en los operadores genéticos, como son cruce, mutación, etc., ModeloHorario
      al que pertenece esta solución.
}
  TObjetoModeloHorario = class
  private
    FModeloHorario: TModeloHorario;
    FParaleloPeriodoASesion,
      FMateriaHorarioLaborableCant,
      FProfesorHorarioLaborableCant,
      FAulaTipoHorarioLaborableCant,
      FAntMateriaDiaMinHora,
      FAntMateriaDiaMaxHora,
      FAntDiaProfesorMinHora,
      FAntDiaProfesorMaxHora: TDynamicSmallintArrayArray;
    FParaleloMateriaDiaMinHora,
      FParaleloMateriaDiaMaxHora
      : TDynamicSmallintArrayArrayArray;
    FAntListaCambios: TList;
    FParaleloMateriaNoDispersa: TDynamicSmallintArray;
    FDiaProfesorFraccionamiento: TDynamicSmallintArrayArray;
    FCruceProfesor,
      FCruceAulaTipo,
      FHoraHuecaDesubicada,
      FSesionCortada,
      FMateriaNoDispersa,
      FMateriaProhibicion,
      FProfesorProhibicion,
      FAntMateriaNoDispersa: Integer;
    FProfesorFraccionamiento: Integer;
    FMateriaProhibicionValor,
      FProfesorProhibicionValor,
      FValor: Double;
    FRecalcularValor: Boolean;
    function GetValor: Double;
    procedure DoGetValor;
    procedure Normalizar(AParalelo: Smallint; var AHorarioLaborable: Smallint);
{
    procedure SetClaveAleatoriaInterno(AParalelo, AHorarioLaborable: Smallint;
      AClaveAleatoria: Integer); overload;
    procedure SetClaveAleatoriaInterno(AParalelo, AHorarioLaborable, ADuracion: Smallint;
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
    function DescensoRapidoInterno(Delta: double): Boolean; overload;
    function DescensoRapidoInterno: Boolean; overload;
    procedure IntercambiarInterno(AParalelo, AHorarioLaborable, AHorarioLaborable1: Smallint;
      FueEvaluado: Boolean = False);
    procedure Intercambiar(AParalelo, AHorarioLaborable, AHorarioLaborable1: Smallint);
    function EvaluarIntercambioInterno(AParalelo, AHorarioLaborable,
      AHorarioLaborable1: Smallint): Double;
    property ProfesorHorarioLaborableCant: TDynamicSmallintArrayArray read
      FProfesorHorarioLaborableCant;
    property MateriaHorarioLaborableCant: TDynamicSmallintArrayArray read
      FMateriaHorarioLaborableCant;
    property AulaTipoHorarioLaborableCant: TDynamicSmallintArrayArray read
      FAulaTipoHorarioLaborableCant;
    procedure DoGetCruceProfesor;
    procedure DoGetCruceAulaTipo;
    procedure ActualizarAulaTipoHorarioLaborableCant;
    procedure ActualizarProfesorHorarioLaborableCant;
    procedure ActualizarMateriaHorarioLaborableCant;
    procedure ActualizarParaleloMateriaDiaMinMaxHora; overload;
    procedure ActualizarParaleloMateriaDiaMinMaxHora(AParalelo: Smallint);
      overload;
    function GetParaleloMateriaNoDispersa(AParalelo: Smallint;
      var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
    procedure DoGetProfesorFraccionamiento;
    procedure ActualizarDiaProfesorFraccionamiento;
    function GetDiaProfesorFraccionamiento(di, p: Smallint): Smallint;
    function DescensoRapidoDobleInterno: Boolean;
    function DescensoRapidoPuntualInterno(var Delta: Double): Boolean; overload;
    function DescensoRapidoPuntualInterno(AParalelo: Smallint;
      var Delta: Double): Boolean; overload;
    //procedure Check(s: string); overload;
    //procedure Check(AParalelo: Smallint; s: string); overload;
  protected
    property RecalcularValor: boolean read FRecalcularValor write
      FRecalcularValor;
  public

    function DescensoRapido: Boolean;
    function DescensoRapidoDoble: Boolean;
    procedure DescensoRapidoDobleForzado;
    procedure DescensoRapidoForzado;
    function DescensoRapidoOptimizadoInterno: Boolean;
    procedure DescensoRapidoOptimizadoForzado;
    procedure InvalidarValor;
    procedure Actualizar;
    procedure SaveToFile(const AFileName: string);
    procedure SaveToDatabase(CodHorario: Integer; MomentoInicial,
      MomentoFinal: TDateTime; Informe: TStrings);
    procedure LoadFromDatabase(CodHorario: Integer);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    constructor CrearDesdeModelo(AModeloHorario: TModeloHorario);
    destructor Destroy; override;
    procedure HacerAleatorio;
    procedure Mutar; overload;
    procedure Mutar(Orden: Integer); overload;
    procedure MutarDia;
    procedure Assign(AObjetoModeloHorario: TObjetoModeloHorario);
    property Valor: Double read GetValor;
    property CruceProfesor: Integer read FCruceProfesor;
    property CruceAulaTipo: Integer read FCruceAulaTipo;
    property HoraHuecaDesubicada: Integer read GetHoraHuecaDesubicada;
    property SesionCortada: Integer read GetSesionCortada;
    property CruceProfesorValor: Double read GetCruceProfesorValor;
    property ProfesorFraccionamientoValor: Double
      read GetProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read GetCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read GetHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read GetSesionCortadaValor;
    property MateriaProhibicion: Integer read GetMateriaProhibicion;
    property ProfesorProhibicion: Integer read GetProfesorProhibicion;
    property MateriaProhibicionValor: Double read GetMateriaProhibicionValor;
    property ProfesorProhibicionValor: Double read GetProfesorProhibicionValor;
    property MateriaNoDispersa: Integer read GetMateriaNoDispersa;
    property MateriaNoDispersaValor: Double read GetMateriaNoDispersaValor;
    property ParaleloPeriodoASesion: TDynamicSmallintArrayArray read FParaleloPeriodoASesion
      write FParaleloPeriodoASesion;
    property ModeloHorario: TModeloHorario read FModeloHorario;
    property ProfesorFraccionamiento: Integer read FProfesorFraccionamiento;
  end;

// Procedimiento que crea una solución aleatoria de un TModeloHorario
procedure CrearAleatorioDesdeModelo(var AObjetoModeloHorario:
  TObjetoModeloHorario; AModeloHorario: TModeloHorario);
procedure CargarPrefijadoDesdeModelo(var AObjetoModeloHorario:
  TObjetoModeloHorario; AModeloHorario: TModeloHorario; CodHorario: Integer);

// Procedimiento que aplica el operador de cruzamiento sobre dos TObjetoModeloHorario
procedure CruzarIndividuos(var Uno, Dos: TObjetoModeloHorario);

implementation

uses
  SysUtils, SortAlgs, rand, ArDBUtls;
var
  SortLongint: procedure(var List1: array of Longint;
    var List2: array of Smallint; min, max: Longint);
  SortSmallint: procedure(var List1: array of Smallint;
    var List2: array of Longint; min, max: Longint);
  lSort: procedure(var List1: array of Longint; min, max: Longint);

constructor TModeloHorario.CrearDesdeDatabase(
  ADatabase: TDatabase;
  ACruceProfesorValor,
  AProfesorFraccionamientoValor,
  ACruceAulaTipoValor,
  AHoraHuecaDesubicadaValor,
  ASesionCortadaValor,
  AMateriaNoDispersaValor: Double);
var
  VTable: TTable;
  iMax: Integer;
  FMinCodProfesor,
    FMinCodMateria,
    FMinCodAulaTipo,
    FMinCodProfProhibicionTipo,
    FMinCodMateProhibicionTipo: Longint;
  FAsignaturaAMateria,
    FCodMateriaAMateria,

  FCodProfesorAProfesor,
    FCodAulaTipoAAulaTipo,
    FCodProfProhibicionTipoAProfesorProhibicionTipo,
    FCodMateProhibicionTipoAMateriaProhibicionTipo,
    FParaleloADuracion,
    FCargaAcademicaAAsignatura,
    FCargaAcademicaAProfesor,
    FCargaAcademicaAParalelo: TDynamicSmallintArray;
  FProfesorACodProfesor,
    FProfesorProhibicionTipoACodProfProhibicionTipo,
    FAulaTipoACodAulaTipo,
    FMateriaProhibicionTipoACodMateProhibicionTipo: TDynamicLongintArray;
  procedure Cargar(const ATableName, ALstName: string; var FMinCodLst:
    Integer; var FCodLstALst: TDynamicSmallintArray; var FLstACodLst:
    TDynamicLongintArray);
  var
    VField: TField;
    i, v: Integer;
  begin
    with VTable do
    begin
      TableName := ATableName;
      IndexFieldNames := ALstName;
      Open;
      VField := FindField(ALstName);
      FMinCodLst := VField.AsInteger;
      iMax := VField.AsInteger;
      SetLength(FLstACodLst, RecordCount);
      for i := 0 to RecordCount - 1 do
      begin
        v := VField.AsInteger;
        if iMax < v then iMax := v;
        if FMinCodLst > v then FMinCodLst := v;
        FLstACodLst[i] := v;
        Next;
      end;
      First;
      SetLength(FCodLstALst, iMax - FMinCodLst + 1);
      for i := 0 to RecordCount - 1 do
      begin
        FCodLstALst[VField.AsInteger - FMinCodLst] := i;
        Next;
      end;
      First;
      Close;
    end;
  end;
  procedure CargarCurso;
  var
    i, j, k: Integer;
    VFieldNivel, VFieldEspecializacion: TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'Curso';
      IndexFieldNames := 'CodNivel;CodEspecializacion';
      Open;
      FCursoCant := RecordCount;
      SetLength(FNivelEspecializacionACurso, FNivelCant, FEspecializacionCant);
      for i := 0 to FNivelCant - 1 do
      begin
        FillChar(FNivelEspecializacionACurso[i, 0], FEspecializacionCant *
          SizeOf(Smallint), #$FF);
      end;
      VFieldNivel := FindField('CodNivel') as TIntegerField;
      VFieldEspecializacion := FindField('CodEspecializacion') as TIntegerField;
      for i := 0 to FCursoCant - 1 do
      begin
        j := FCodNivelANivel[VFieldNivel.Value - FMinCodNivel];
        k := FCodEspecializacionAEspecializacion[VFieldEspecializacion.Value -
          FMinCodEspecializacion];
        FNivelEspecializacionACurso[j, k] := i;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarHorarioLaborable;
  var
    i, j, k: Integer;
    VFieldDia, VFieldHora: TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'HorarioLaborable';
      IndexFieldNames := 'CodDia;CodHora';
      Open;
      FHorarioLaborableCant := RecordCount;
      SetLength(FHorarioLaborableADia, FHorarioLaborableCant);
      SetLength(FDiaAMaxHorarioLaborable, FDiaCant);
      SetLength(FHorarioLaborableAHora, FHorarioLaborableCant);
      SetLength(FDiaHoraAHorarioLaborable, FDiaCant, FHoraCant);
      for i := 0 to FDiaCant - 1 do
      begin
        FillChar(FDiaHoraAHorarioLaborable[i, 0], FHoraCant * SizeOf(Smallint),
          #$FF);
      end;
      VFieldDia := FindField('CodDia') as TIntegerField;
      VFieldHora := FindField('CodHora') as TIntegerField;
      for i := 0 to FHorarioLaborableCant - 1 do
      begin
        j := FCodDiaADia[VFieldDia.Value - FMinCodDia];
        k := FCodHoraAHora[VFieldHora.Value - FMinCodHora];
        FHorarioLaborableADia[i] := j;
        FHorarioLaborableAHora[i] := k;
        FDiaHoraAHorarioLaborable[j, k] := i;
        Next;
      end;
      for i := 0 to FDiaCant - 1 do
      begin
        FDiaAMaxHorarioLaborable[i] := GetDiaAMaxHorarioLaborable(i);
      end;
      Close;
    end;
  end;
  procedure CargarAsignatura;
  var
    i, j, k, l, t, VPos, ss, m, a: Integer;
    VFieldMateria, VFieldNivel, VFieldEspecializacion, VFieldAulaTipo:
      TIntegerField;
    VFieldComposicion: TStringField;
    VSesionADuracion,
      VSesionAAsignatura: array[0..16383] of Smallint;
    s: string;
  begin
    inherited Create;
    with VTable do
    begin
      TableName := 'Asignatura';
      IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion';
      Open;
      SetLength(FAsignaturaAMateria, RecordCount);
      SetLength(FAsignaturaASesiones, RecordCount);
      SetLength(FAsignaturaAAulaTipo, RecordCount);
      SetLength(FCursoADuracion, FCursoCant);
      SetLength(FMateriaCursoAAsignatura, FMateriaCant, FCursoCant);
      for i := 0 to FMateriaCant - 1 do
        FillChar(FMateriaCursoAAsignatura[i, 0], FCursoCant * SizeOf(Smallint),
          #$FF);
      VFieldNivel := FindField('CodNivel') as TIntegerField;
      VFieldEspecializacion := FindField('CodEspecializacion') as TIntegerField;
      VFieldMateria := FindField('CodMateria') as TIntegerField;
      VFieldAulaTipo := FindField('CodAulaTipo') as TIntegerField;
      VFieldComposicion := FindField('Composicion') as TStringField;
      ss := 0;
      for i := 0 to RecordCount - 1 do
      begin
        j := FCodMateriaAMateria[VFieldMateria.Value - FMinCodMateria];
        k := FNivelEspecializacionACurso[
          FCodNivelANivel[VFieldNivel.Value - FMinCodNivel],
          FCodEspecializacionAEspecializacion[VFieldEspecializacion.Value -
          FMinCodEspecializacion]];
        FAsignaturaAMateria[i] := j;
        FAsignaturaAAulaTipo[i] := FCodAulaTipoAAulaTipo[VFieldAulaTipo.Value -
          FMinCodAulaTipo];
        s := VFieldComposicion.Value;
        FMateriaCursoAAsignatura[j, k] := i;
        VPos := 1;
        l := ss;
        t := 0;
        while VPos <= Length(s) do
        begin
          VSesionADuracion[ss] := StrToInt(ExtractString(s, VPos, '.'));
          VSesionAAsignatura[ss] := i;
          Inc(t, VSesionADuracion[ss]);
          Inc(ss);
        end;
        SetLength(FAsignaturaASesiones[i], ss - l);
        for m := l to ss - 1 do
        begin
          FAsignaturaASesiones[i, m - l] := m
        end;
        FCursoADuracion[k] := FCursoADuracion[k] + t;
        Next;
      end;
      SetLength(FSesionAAsignatura, ss);
      SetLength(FSesionAMateria, ss);
      SetLength(FSesionAAulaTipo, ss);
      Move(VSesionADuracion[0], FSesionADuracion[0], ss * SizeOf(Smallint));
      FSesionADuracion[-1] := 1;
      Move(VSesionAAsignatura[0], FSesionAAsignatura[0], ss * SizeOf(Smallint));
      for i := 0 to ss - 1 do
      begin
        a := FSesionAAsignatura[i];
        FSesionAMateria[i] := FAsignaturaAMateria[a];
        FSesionAAulaTipo[i] := FAsignaturaAAulaTipo[a];
      end;
      Close;
    end;
  end;
  procedure CargarParalelo;
  var
    i, j, k, l, m: Integer;
    VFieldNivel, VFieldEspecializacion, VFieldParaleloId: TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'Paralelo';
      IndexFieldNames := 'CodNivel;CodEspecializacion;CodParaleloId';
      Open;
      FParaleloCant := RecordCount;
      SetLength(FParaleloACurso, FParaleloCant);
      SetLength(FParaleloAParaleloId, FParaleloCant);
      SetLength(FParaleloANivel, FParaleloCant);
      SetLength(FParaleloAEspecializacion, FParaleloCant);
      SetLength(FCursoParaleloIdAParalelo, FCursoCant,
        Length(FParaleloIdACodParaleloId));
      VFieldNivel := FindField('CodNivel') as TIntegerField;
      VFieldEspecializacion := FindField('CodEspecializacion') as TIntegerField;
      VFieldParaleloId := FindField('CodParaleloId') as TIntegerField;
      for i := 0 to FParaleloCant - 1 do
      begin
        l := FCodNivelANivel[VFieldNivel.Value - FMinCodNivel];
        m := FCodEspecializacionAEspecializacion[VFieldEspecializacion.Value -
          FMinCodEspecializacion];
        j := FNivelEspecializacionACurso[l, m];
        k := FCodParaleloIdAParaleloId[VFieldParaleloId.Value -
          FMinCodParaleloId];
        FParaleloACurso[i] := j;
        FParaleloANivel[i] := l;
        FParaleloAParaleloId[i] := k;
        FParaleloAEspecializacion[i] := m;
        FCursoParaleloIdAParalelo[j, k] := i;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarAulaTipo;
  var
    i: Integer;
    VFieldCantidad: TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'AulaTipo';
      IndexFieldNames := 'CodAulaTipo';
      Open;
      SetLength(FAulaTipoACantidad, RecordCount);
      VFieldCantidad := FindField('Cantidad') as TIntegerField;
      for i := 0 to RecordCount - 1 do
      begin
        FAulaTipoACantidad[i] := VFieldCantidad.Value;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarMateriaProhibicionTipo;
  var
    i: Integer;
    VFieldValor: TFloatField;
    dMaxMateriaProhibicionTipoValor: Double;
  begin
    with VTable do
    begin
      TableName := 'MateriaProhibicionTipo';
      IndexFieldNames := 'CodMateProhibicionTipo';
      Open;
      VFieldValor := FindField('ValMateProhibicionTipo') as TFloatField;
      FMaxMateriaProhibicionTipo := -1;
      dMaxMateriaProhibicionTipoValor := -1.7E308;
      FMateriaProhibicionTipoAValor[-1] := 0;
      for i := 0 to RecordCount - 1 do
      begin
        FMateriaProhibicionTipoAValor[i] := VFieldValor.Value;
        if dMaxMateriaProhibicionTipoValor < FMateriaProhibicionTipoAValor[i]
          then
        begin
          dMaxMateriaProhibicionTipoValor := FMateriaProhibicionTipoAValor[i];
          FMaxMateriaProhibicionTipo := i;
        end;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarProfesorProhibicionTipo;
  var
    i: Integer;
    VFieldValor: TFloatField;
  begin
    with VTable do
    begin
      TableName := 'ProfesorProhibicionTipo';
      IndexFieldNames := 'CodProfProhibicionTipo';
      Open;
      VFieldValor := FindField('ValProfProhibicionTipo') as TFloatField;
      FMaxProfesorProhibicionTipo := -1;
      FMaxProfesorProhibicionTipoValor := -1.7E308;
      FProfesorProhibicionTipoAValor[-1] := 0;
      for i := 0 to RecordCount - 1 do
      begin
        FProfesorProhibicionTipoAValor[i] := VFieldValor.Value;
        if FMaxProfesorProhibicionTipoValor < FProfesorProhibicionTipoAValor[i]
          then
        begin
          FMaxProfesorProhibicionTipoValor := FProfesorProhibicionTipoAValor[i];
          FMaxProfesorProhibicionTipo := i;
        end;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarMateriaProhibicion;
  var
    i, j, k, l: Integer;
    VFieldMateria, VFieldDia, VFieldHora, VFieldMateriaProhibicionTipo:
      TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'MateriaProhibicion';
      IndexFieldNames := 'CodMateria;CodDia;CodHora';
      Open;
      SetLength(FMateriaProhibicionAMateria, RecordCount);
      SetLength(FMateriaProhibicionAHorarioLaborable, RecordCount);
      SetLength(FMateriaProhibicionAMateriaProhibicionTipo, RecordCount);
      SetLength(FMateriaProhibicionAValor, RecordCount);
      SetLength(FMateriaHorarioLaborableAMateriaProhibicionTipo,
        FMateriaCant, FHorarioLaborableCant);
      for i := 0 to FMateriaCant - 1 do
        FillChar(FMateriaHorarioLaborableAMateriaProhibicionTipo[i, 0],
          FHorarioLaborableCant * sizeof(Shortint), #$FF);
      VFieldMateria := FindField('CodMateria') as TIntegerField;
      VFieldDia := FindField('CodDia') as TIntegerField;
      VFieldHora := FindField('CodHora') as TIntegerField;
      VFieldMateriaProhibicionTipo := FindField('CodMateProhibicionTipo') as
        TIntegerField;
      for i := 0 to RecordCount - 1 do
      begin
        j := FCodMateriaAMateria[VFieldMateria.Value - FMinCodMateria];
        k := FDiaHoraAHorarioLaborable[FCodDiaADia[VFieldDia.Value -
          FMinCodDia], FCodHoraAHora[VFieldHora.Value - FMinCodHora]];
        l :=
          FCodMateProhibicionTipoAMateriaProhibicionTipo[VFieldMateriaProhibicionTipo.Value
          - FMinCodMateProhibicionTipo];
        FMateriaProhibicionAMateria[i] := j;
        FMateriaProhibicionAHorarioLaborable[i] := k;
        FMateriaProhibicionAMateriaProhibicionTipo[i] := l;
        FMateriaProhibicionAValor[i] := FMateriaProhibicionTipoAValor[l];
        FMateriaHorarioLaborableAMateriaProhibicionTipo[j, k] := l;
        Next;
      end;
      Close;
      Filtered := false;
    end;
  end;
  procedure CargarProfesorProhibicion;
  var
    i, j, k, l: Integer;
    v: Double;
    p, h, d: Smallint;
    VFieldProfesor, VFieldDia, VFieldHora, VFieldProfesorProhibicionTipo:
      TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'ProfesorProhibicion';
      IndexFieldNames := 'CodProfesor;CodDia;CodHora';
      Open;
      SetLength(FProfesorProhibicionAProfesor, RecordCount);
      SetLength(FProfesorProhibicionAHorarioLaborable, RecordCount);
      SetLength(FProfesorProhibicionAProfesorProhibicionTipo, RecordCount);
      SetLength(FProfesorProhibicionAValor, RecordCount);
      SetLength(FProfesorHorarioLaborableAProfesorProhibicionTipo,
        FProfesorCant, FHorarioLaborableCant);
      for p := 0 to FProfesorCant - 1 do
        FillChar(FProfesorHorarioLaborableAProfesorProhibicionTipo[p, 0],
          FHorarioLaborableCant * sizeof(Shortint), #$FF);
      VFieldProfesor := FindField('CodProfesor') as TIntegerField;
      VFieldDia := FindField('CodDia') as TIntegerField;
      VFieldHora := FindField('CodHora') as TIntegerField;
      VFieldProfesorProhibicionTipo := FindField('CodProfProhibicionTipo') as
        TIntegerField;
      for i := 0 to RecordCount - 1 do
      begin
        j := FCodProfesorAProfesor[VFieldProfesor.AsInteger - FMinCodProfesor];
        d := FCodDiaADia[VFieldDia.AsInteger - FMinCodDia];
        h := FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora];
        k := FDiaHoraAHorarioLaborable[d, h];
        l := FCodProfProhibicionTipoAProfesorProhibicionTipo[
          VFieldProfesorProhibicionTipo.AsInteger - FMinCodProfProhibicionTipo];
        FProfesorProhibicionAProfesor[i] := j;
        FProfesorProhibicionAHorarioLaborable[i] := k;
        FProfesorProhibicionAProfesorProhibicionTipo[i] := l;
        v := FProfesorProhibicionTipoAValor[l];
        FProfesorProhibicionAValor[i] := v;
        if v = FMaxProfesorProhibicionTipoValor then
        begin
          Inc(FProfesorCantHora[j]);
        end;
        FProfesorHorarioLaborableAProfesorProhibicionTipo[j, k] := l;
        Next;
      end;
      Close;
      Filter := '';
      Filtered := false;
    end;
  end;
  procedure CargarCargaAcademica;
  var
    i, j, k, l, m, n, o, p, q: Integer;
    VFieldMateria, VFieldNivel, VFieldParaleloId, VFieldProfesor,
      VFieldEspecializacion: TIntegerField;
  begin
    with VTable do
    begin
      TableName := 'CargaAcademica';
      IndexFieldNames :=
        'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      Open;
      First;
      VFieldMateria := FindField('CodMateria') as TIntegerField;
      VFieldNivel := FindField('CodNivel') as TIntegerField;
      VFieldParaleloId := FindField('CodParaleloId') as TIntegerField;
      VFieldProfesor := FindField('CodProfesor') as TIntegerField;
      VFieldEspecializacion := FindField('CodEspecializacion') as TIntegerField;
      SetLength(FCargaAcademicaAAsignatura, RecordCount);
      SetLength(FCargaAcademicaAParalelo, RecordCount);
      SetLength(FCargaAcademicaAProfesor, RecordCount);
      SetLength(FParaleloMateriaAProfesor, FParaleloCant, FMateriaCant);
      for i := 0 to FParaleloCant - 1 do
      begin
        FillChar(FParaleloMateriaAProfesor[i, 0], FMateriaCant
          * SizeOf(Smallint), #$FF);
      end;
      for i := 0 to RecordCount - 1 do
      begin
        j := FCodMateriaAMateria[VFieldMateria.Value - FMinCodMateria];
        k := FCodNivelANivel[VFieldNivel.Value - FMinCodNivel];
        l := FCodParaleloIdAParaleloId[VFieldParaleloId.Value -
          FMinCodParaleloId];
        q := FCodEspecializacionAEspecializacion[VFieldEspecializacion.Value -
          FMinCodEspecializacion];
        p := FNivelEspecializacionACurso[k, q];
        n := FCursoParaleloIdAParalelo[p, l];
        m := FMateriaCursoAAsignatura[j, p];
        o := FCodProfesorAProfesor[VFieldProfesor.Value - FMinCodProfesor];
        FCargaAcademicaAAsignatura[i] := m;
        FCargaAcademicaAParalelo[i] := n;
        FCargaAcademicaAProfesor[i] := o;
        FParaleloMateriaAProfesor[n, j] := o;
        Next;
      end;
      Close;
    end;
  end;
  procedure CargarMoldeHorarioDetalle;
  var
    d, i, j, k, m, n, o, p, q, r, s: Integer;
  begin
    SetLength(FMoldeHorarioDetalle, FParaleloCant, FHorarioLaborableCant);
    SetLength(FParaleloADuracion, FParaleloCant);
    SetLength(FParaleloASesionCant, FParaleloCant);
    r := FHorarioLaborableCant;
    for i := 0 to FParaleloCant - 1 do
      FillChar(FMoldeHorarioDetalle[i, 0], r * SizeOf(Smallint), #$FF);
    p := High(FCargaAcademicaAAsignatura);
    for i := p downto 0 do
    begin
      j := FCargaAcademicaAAsignatura[i];
      k := FCargaAcademicaAParalelo[i];
      for m := High(FAsignaturaASesiones[j]) downto 0 do
      begin
        n := FSesionADuracion[FAsignaturaASesiones[j, m]];
        d := FParaleloADuracion[k];
        for o := n - 1 downto 0 do
        begin
          q := d + o;
          if (q < 0) or (q >= r) then
            raise
              Exception.CreateFmt('Se desbordó Molde de ParaleloPeriodoASesion: ' +
              'Paralelo %d-%d Duración %d', [FParaleloANivel[k],
              FParaleloAParaleloId[k],
                q]);
          FMoldeHorarioDetalle[k, r - 1 - q] := FAsignaturaASesiones[j, m];
        end;
        Inc(FParaleloADuracion[k], n);
      end;
    end;
    for i := 0 to FParaleloCant - 1 do
    begin
      j := 0;
      while j < FHorarioLaborableCant do
      begin
        s := FMoldeHorarioDetalle[i, j];
        d := FSesionADuracion[s];
        Inc(j, d);
        Inc(FParaleloASesionCant[i]);
        if s >= 0 then
          Inc(FProfesorCantHora[FParaleloMateriaAProfesor[i,
            FSesionAMateria[s]]], d);
      end;
    end;
  end;
begin
  inherited Create;
  FDatabase := ADatabase;
  FQuHorarioDetalle := TQuery.Create(nil);
  with FQuHorarioDetalle do
  begin
    DatabaseName := FDatabase.DatabaseName;
    SessionName := FDatabase.SessionName;
    SQL.Add('SELECT CodNivel, CodParaleloId, CodEspecializacion, CodDia, ' +
      'CodHora, Sesion FROM HorarioDetalle WHERE CodHorario=:CodHorario');
  end;
  Configurar(ACruceProfesorValor, AProfesorFraccionamientoValor,
    ACruceAulaTipoValor, AHoraHuecaDesubicadaValor, ASesionCortadaValor,
    AMateriaNoDispersaValor);
  VTable := TTable.Create(nil);
  with VTable do
  try
    DatabaseName := ADatabase.DatabaseName;
    SessionName := FDatabase.SessionName;
    Cargar('Profesor', 'CodProfesor', FMinCodProfesor, FCodProfesorAProfesor,
      FProfesorACodProfesor);
    FProfesorCant := Length(FProfesorACodProfesor);
    SetLength(FProfesorCantHora, FProfesorCant);
    Cargar('Nivel', 'CodNivel', FMinCodNivel, FCodNivelANivel, FNivelACodNivel);
    FNivelCant := Length(FNivelACodNivel);
    Cargar('Especializacion', 'CodEspecializacion', FMinCodEspecializacion,
      FCodEspecializacionAEspecializacion,
      FEspecializacionACodEspecializacion);
    FEspecializacionCant := Length(FEspecializacionACodEspecializacion);
    CargarCurso;
    Cargar('ParaleloId', 'CodParaleloId', FMinCodParaleloId,
      FCodParaleloIdAParaleloId,
      FParaleloIdACodParaleloId);
    Cargar('Materia', 'CodMateria', FMinCodMateria, FCodMateriaAMateria,
      FMateriaACodMateria);
    FMateriaCant := Length(FMateriaACodMateria);
    Cargar('Dia', 'CodDia', FMinCodDia, FCodDiaADia, FDiaACodDia);
    FDiaCant := Length(FDiaACodDia);
    Cargar('Hora', 'CodHora', FMinCodHora, FCodHoraAHora, FHoraACodHora);
    FHoraCant := Length(FHoraACodHora);
    Cargar('MateriaProhibicionTipo', 'CodMateProhibicionTipo',
      FMinCodMateProhibicionTipo,
      FCodMateProhibicionTipoAMateriaProhibicionTipo,
      FMateriaProhibicionTipoACodMateProhibicionTipo);
    Cargar('ProfesorProhibicionTipo', 'CodProfProhibicionTipo',
      FMinCodProfProhibicionTipo,
      FCodProfProhibicionTipoAProfesorProhibicionTipo,
      FProfesorProhibicionTipoACodProfProhibicionTipo);
    Cargar('AulaTipo', 'CodAulaTipo', FMinCodAulaTipo,
      FCodAulaTipoAAulaTipo,
      FAulaTipoACodAulaTipo);
    FAulaTipoCant := Length(FAulaTipoACodAulaTipo);
    CargarHorarioLaborable;
    CargarAsignatura;
    CargarParalelo;
    CargarAulaTipo;
    CargarMateriaProhibicionTipo;
    CargarProfesorProhibicionTipo;
    CargarMateriaProhibicion;
    CargarProfesorProhibicion;
    CargarCargaAcademica;
    CargarMoldeHorarioDetalle;
  finally
    Free;
  end;
end;

procedure TModeloHorario.Configurar(
  ACruceProfesorValor,
  AProfesorFraccionamientoValor,
  ACruceAulaTipoValor,
  AHoraHuecaDesubicadaValor,
  ASesionCortadaValor,
  AMateriaNoDispersaValor: Double);
begin
  FCruceProfesorValor := ACruceProfesorValor;
  FProfesorFraccionamientoValor := AProfesorFraccionamientoValor;
  FCruceAulaTipoValor := ACruceAulaTipoValor;
  FHoraHuecaDesubicadaValor := AHoraHuecaDesubicadaValor;
  FSesionCortadaValor := ASesionCortadaValor;
  FMateriaNoDispersaValor := AMateriaNoDispersaValor;
end;

function TModeloHorario.GetDiaAMaxHorarioLaborable(d: Smallint): Smallint;
begin
  if d = FDiaCant - 1 then
    Result := FHorarioLaborableCant - 1
  else
    Result := FDiaHoraAHorarioLaborable[d + 1, 0] - 1;
end;

procedure CrearAleatorioDesdeModelo(var AObjetoModeloHorario:
  TObjetoModeloHorario; AModeloHorario: TModeloHorario);
begin
  if not Assigned(AObjetoModeloHorario) then
    AObjetoModeloHorario :=
      TObjetoModeloHorario.CrearDesdeModelo(AModeloHorario);
  AObjetoModeloHorario.HacerAleatorio;
end;

procedure CargarPrefijadoDesdeModelo(var AObjetoModeloHorario:
  TObjetoModeloHorario; AModeloHorario: TModeloHorario; CodHorario: Integer);
begin
  if not Assigned(AObjetoModeloHorario) then
    AObjetoModeloHorario :=
      TObjetoModeloHorario.CrearDesdeModelo(AModeloHorario);
  AObjetoModeloHorario.LoadFromDataBase(CodHorario);
end;

procedure CruzarIndividuosPunto(var Uno, Dos: TObjetoModeloHorario; AParalelo:
  Smallint);
var
  s, j, d: Smallint;
  k1, k2, l: Longint;
  ClaveAleatoria1, ClaveAleatoria2: TDynamicLongintArray;
  procedure AleatorizarClave(AObjetoModeloHorario: TObjetoModeloHorario;
    var AClaveAleatoria: TDynamicLongintArray);
  var
    j, d, k, l: Smallint;
    NumberList: array[0..4095] of Longint;
    p: PSmallintArray;
    q: PLongintArray;
  begin
    with AObjetoModeloHorario.ModeloHorario do
    begin
    //Check(AParalelo, 'AleatorizarClaveAntes');
      Fillcrand32(NumberList, FParaleloASesionCant[AParalelo]);
      lSort(NumberList, 0, FParaleloASesionCant[AParalelo] - 1);
      p := @AObjetoModeloHorario.ParaleloPeriodoASesion[AParalelo, 0];
      q := @AClaveAleatoria[0];
      j := 0;
      k := 0;
      while j < FHorarioLaborableCant do
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
    SetLength(ClaveAleatoria1, FHorarioLaborableCant);
    SetLength(ClaveAleatoria2, FHorarioLaborableCant);
    AleatorizarClave(Uno, ClaveAleatoria1);
    AleatorizarClave(Dos, ClaveAleatoria2);
    SortSmallint(Uno.ParaleloPeriodoASesion[AParalelo],
      ClaveAleatoria1, 0, FHorarioLaborableCant - 1);
    SortSmallint(Dos.ParaleloPeriodoASesion[AParalelo],
      ClaveAleatoria2, 0, FHorarioLaborableCant - 1);
    j := 0;
    while j < FHorarioLaborableCant do
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
    SortLongint(ClaveAleatoria1, Uno.ParaleloPeriodoASesion[AParalelo], 0, FHorarioLaborableCant - 1);
    SortLongint(ClaveAleatoria2, Dos.ParaleloPeriodoASesion[AParalelo], 0, FHorarioLaborableCant - 1);
  end;
end;

procedure CruzarIndividuos(var Uno, Dos: TObjetoModeloHorario);
var
  i: Smallint;
begin
  with Uno.ModeloHorario do
  begin
    for i := 0 to FParaleloCant - 1 do
    begin
      CruzarIndividuosPunto(Uno, Dos, i);
    end;
    Uno.Actualizar;
    Dos.Actualizar;
    Uno.RecalcularValor := True;
    Dos.RecalcularValor := True;
    //Uno.Check('CruzarIndividuosUnoDespues');
    //Dos.Check('CruzarIndividuosDosDespues');
  end;
end;

constructor TObjetoModeloHorario.CrearDesdeModelo(AModeloHorario:
  TModeloHorario);
begin
  inherited Create;
  FAntListaCambios := TList.Create;
  FModeloHorario := AModeloHorario;
  FRecalcularValor := True;
  with ModeloHorario do
  begin
    SetLength(FParaleloPeriodoASesion, FParaleloCant, FHorarioLaborableCant);
    SetLength(FMateriaHorarioLaborableCant, FMateriaCant,
      FHorarioLaborableCant);
    SetLength(FProfesorHorarioLaborableCant, FProfesorCant,
      FHorarioLaborableCant);
    SetLength(FAulaTipoHorarioLaborableCant, FAulaTipoCant,
      FHorarioLaborableCant);
    SetLength(FParaleloMateriaDiaMinHora, FParaleloCant,
      FMateriaCant, FDiaCant);
    SetLength(FParaleloMateriaDiaMaxHora, FParaleloCant,
      FMateriaCant, FDiaCant);
    SetLength(FDiaProfesorFraccionamiento, FDiaCant, FProfesorCant);
    SetLength(FParaleloMateriaNoDispersa, FParaleloCant);
    SetLength(FAntMateriaDiaMinHora, FMateriaCant, FDiaCant);
    SetLength(FAntMateriaDiaMaxHora, FMateriaCant, FDiaCant);
    SetLength(FAntDiaProfesorMinHora, FDiaCant, FProfesorCant);
    SetLength(FAntDiaProfesorMaxHora, FDiaCant, FProfesorCant);
  end;
end;

procedure TObjetoModeloHorario.HacerAleatorio;
var
  i, j, d, l: Smallint;
  r: Longint;
  p: PSmallintArray;
  q: PLongintArray;
  ClaveAleatoria: TDynamicLongintArray;
begin
  with ModeloHorario do
  begin
    SetLength(ClaveAleatoria, FHorarioLaborableCant);
    for i := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[i, 0];
      q := @ClaveAleatoria[0];
      Move(FMoldeHorarioDetalle[i, 0], p[0], FHorarioLaborableCant *
        SizeOf(Smallint));
      j := 0;
      while j < FHorarioLaborableCant do
      begin
        d := FSesionADuracion[p[j]];
        r := crand32;
        for l := j + d - 1 downto j do
          q[l] := r;
        Inc(j, d);
      end;
      SortLongint(q^, p^, 0, FHorarioLaborableCant - 1);
    end;
  end;
  Actualizar;
  RecalcularValor := True;
end;

procedure TObjetoModeloHorario.ActualizarMateriaHorarioLaborableCant;
var
  i, j, m, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for m := 0 to FMateriaCant - 1 do
    begin
      FillChar(FMateriaHorarioLaborableCant[m, 0], FHorarioLaborableCant *
        SizeOf(Smallint), #0);
    end;
    for i := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[i, 0];
      for j := 0 to FHorarioLaborablecant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          m := FSesionAMateria[s];
          Inc(FMateriaHorarioLaborableCant[m, j]);
        end;
      end;
    end;
  end;
end;

procedure TObjetoModeloHorario.ActualizarParaleloMateriaDiaMinMaxHora;
var
  i: Smallint;
begin
  with ModeloHorario do
    for i := 0 to FParaleloCant - 1 do
      ActualizarParaleloMateriaDiaMinMaxHora(i);
end;

procedure TObjetoModeloHorario.ActualizarParaleloMateriaDiaMinMaxHora(AParalelo:
  Smallint);
var
  j, di, h, m, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for j := 0 to FMateriaCant - 1 do
    begin
      FillChar(FParaleloMateriaDiaMaxHora[AParalelo, j, 0], FDiaCant *
        SizeOf(Smallint),
        #$FF);
      FillChar(FParaleloMateriaDiaMinHora[AParalelo, j, 0], FDiaCant *
        SizeOf(Smallint), #$3F);
    end;
    q := @ParaleloPeriodoASesion[AParalelo, 0];
    for j := 0 to FHorarioLaborableCant - 1 do
    begin
      s := q[j];
      if s >= 0 then
      begin
        m := FSesionAMateria[s];
        di := FHorarioLaborableADia[j];
        h := FHorarioLaborableAHora[j];
        if FParaleloMateriaDiaMaxHora[AParalelo, m, di] < h then
          FParaleloMateriaDiaMaxHora[AParalelo, m, di] := h;
        if FParaleloMateriaDiaMinHora[AParalelo, m, di] > h then
          FParaleloMateriaDiaMinHora[AParalelo, m, di] := h;
      end;
    end;
    FParaleloMateriaNoDispersa[AParalelo] :=
      GetParaleloMateriaNoDispersa(AParalelo,
      FParaleloMateriaDiaMaxHora[AParalelo]);
  end;
end;

procedure TObjetoModeloHorario.ActualizarDiaProfesorFraccionamiento;
var
  d, p: Smallint;
begin
  with FModeloHorario do
  begin
    for d := 0 to FDiaCant - 1 do
    begin
      for p := 0 to FProfesorCant - 1 do
      begin
        FDiaProfesorFraccionamiento[d, p] := GetDiaProfesorFraccionamiento(d,
          p);
      end;
    end;
  end;
end;

procedure TObjetoModeloHorario.InvalidarValor;
begin
  Actualizar;
  RecalcularValor := True;
end;

{
procedure TObjetoModeloHorario.SetClaveAleatoriaInterno(AParalelo,
  AHorarioLaborable: Smallint; AClaveAleatoria: Longint);
begin
  SetClaveAleatoriaInterno(AParalelo, AHorarioLaborable,
    ModeloHorario.FSesionADuracion[ParaleloPeriodoASesion[AParalelo, AHorarioLaborable]],
    AClaveAleatoria);
end;

procedure TObjetoModeloHorario.SetClaveAleatoriaInterno(AParalelo, AHorarioLaborable,
  ADuracion: Smallint; AClaveAleatoria: Longint);
var
  l: Smallint;
begin
  for l := AHorarioLaborable + ADuracion - 1 downto AHorarioLaborable do
    FClaveAleatoria[AParalelo, l] := AClaveAleatoria;
end;
}

procedure TObjetoModeloHorario.Intercambiar(AParalelo, AHorarioLaborable,
  AHorarioLaborable1: Smallint);
begin
  Normalizar(AParalelo, AHorarioLaborable);
  Normalizar(AParalelo, AHorarioLaborable1);
  if AHorarioLaborable < AHorarioLaborable1 then
    IntercambiarInterno(AParalelo, AHorarioLaborable, AHorarioLaborable1)
  else if AHorarioLaborable1 < AHorarioLaborable then
    IntercambiarInterno(AParalelo, AHorarioLaborable1, AHorarioLaborable);
end;

procedure TObjetoModeloHorario.IntercambiarInterno(AParalelo, AHorarioLaborable,
  AHorarioLaborable1: Smallint; FueEvaluado: Boolean = False);
var
  m, m1, d, d1, s, s1, p, p1, a, a1, j_, s_, p_, a_, m_, {h, h1, h_, } hl, hl1:
    Smallint;
  k, k1: Longint;
  q, r: PSmallintArray;
  TmpMateriaDiaMinMaxHora: TDynamicSmallintArrayArray;
  TmpMateriaNoDispersa: Integer;
  procedure RealizarMovimiento;
  var
    l: Smallint;
  begin
    Move(q[AHorarioLaborable + d], q[AHorarioLaborable + d1], (AHorarioLaborable1 - AHorarioLaborable - d) *
      SizeOf(Smallint));
    for l := d - 1 downto 0 do
    begin
      q[AHorarioLaborable1 + d1 - d + l] := s;
    end;
    for l := d1 - 1 downto 0 do
    begin
      q[AHorarioLaborable + l] := s1;
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
    s := q[AHorarioLaborable];
    s1 := q[AHorarioLaborable1];
    d := FSesionADuracion[s];
    d1 := FSesionADuracion[s1];
    if d = d1 then
    begin
      for l := d - 1 downto 0 do
      begin
        q[AHorarioLaborable + l] := s1;
        q[AHorarioLaborable1 + l] := s;
      end;
      if s >= 0 then
      begin
        m := FSesionAMateria[s];
        p := r[m];
        a := FSesionAAulaTipo[s];
        for l := d - 1 downto 0 do
        begin
          hl := AHorarioLaborable + l;
          hl1 := AHorarioLaborable1 + l;
          Dec(ProfesorHorarioLaborableCant[p, hl]);
          Inc(ProfesorHorarioLaborableCant[p, hl1]);
          Dec(MateriaHorarioLaborableCant[m, hl]);
          Inc(MateriaHorarioLaborableCant[m, hl1]);
          Dec(AulaTipoHorarioLaborableCant[a, hl]);
          Inc(AulaTipoHorarioLaborableCant[a, hl1]);
        end;
      end;
      if s1 >= 0 then
      begin
        m1 := FSesionAMateria[s1];
        p1 := r[m1];
        a1 := FSesionAAulaTipo[s1];
        for l := d - 1 downto 0 do
        begin
          hl := AHorarioLaborable + l;
          hl1 := AHorarioLaborable1 + l;
          Dec(ProfesorHorarioLaborableCant[p1, hl1]);
          Inc(ProfesorHorarioLaborableCant[p1, hl]);
          Dec(MateriaHorarioLaborableCant[m1, hl1]);
          Inc(MateriaHorarioLaborableCant[m1, hl]);
          Dec(AulaTipoHorarioLaborableCant[a1, hl1]);
          Inc(AulaTipoHorarioLaborableCant[a1, hl]);
        end;
      end;
    end
    else
    begin
      for j_ := AHorarioLaborable to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          p_ := r[m_];
          a_ := FSesionAAulaTipo[s_];
          Dec(ProfesorHorarioLaborableCant[p_, j_]);
          Dec(MateriaHorarioLaborableCant[m_, j_]);
          Dec(AulaTipoHorarioLaborableCant[a_, j_]);
        end;
      end;
      RealizarMovimiento;
      for j_ := AHorarioLaborable to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          p_ := r[m_];
          a_ := FSesionAAulaTipo[s_];
          Inc(ProfesorHorarioLaborableCant[p_, j_]);
          Inc(MateriaHorarioLaborableCant[m_, j_]);
          Inc(AulaTipoHorarioLaborableCant[a_, j_]);
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
        pd := Longword(FAntListaCambios.Items[l]);
        p := Smallint(pd);
        d := Smallint(pd shr 16);
        FDiaProfesorFraccionamiento[d, p] :=
          GetDiaProfesorFraccionamiento(d, p);
      end;
      //ActualizarDiaProfesorFraccionamiento;
    end
    else
    begin
      ActualizarParaleloMateriaDiaMinMaxHora(AParalelo);
      ActualizarDiaProfesorFraccionamiento;
    end;
  end;
end;

{
  Versión en Pascal del procedimiento Normalizar.  No borrar, ya que es la base
  de la versión en ensamblador
}
(*
procedure TObjetoModeloHorario.Normalizar(AParalelo: Smallint;
  var AHorarioLaborable: Smallint);
var
  k: Smallint;
  l: PSmallintArray;
begin
  l := @FParaleloPeriodoASesion[AParalelo, 0];
  k := l[j];
  if k >= 0 then
    while (j > 0) and (k = l[j - 1]) do
      Dec(j);
end;
*)

procedure TObjetoModeloHorario.Normalizar(AParalelo: Smallint;
  var AHorarioLaborable: Smallint); assembler;
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

procedure TObjetoModeloHorario.MutarInterno;
var
  l: Longint;
  i, j, j1: Smallint;
begin
  with ModeloHorario do
  begin
    l := crand32 mod (FParaleloCant * Sqr(FHorarioLaborableCant));
    j := l mod FHorarioLaborableCant;
    l := l div FHorarioLaborableCant;
    i := l div FHorarioLaborableCant;
    j1 := l mod FHorarioLaborableCant;
    if ParaleloPeriodoASesion[i, j] <> ParaleloPeriodoASesion[i, j1] then
      Intercambiar(i, j, j1);
  end;
end;

procedure TObjetoModeloHorario.Mutar;
begin
  //Check('MutarAntes');
  MutarInterno;
  RecalcularValor := True;
  //Check('MutarDespues');
end;

procedure TObjetoModeloHorario.Mutar(Orden: Integer);
var
  c: Integer;
begin
  //Check('MutarAntes(...)');
  for c := crand32 mod Orden downto 0 do
    MutarInterno;
  RecalcularValor := True;
  //Check('MutarDespues(...)');
end;

procedure TObjetoModeloHorario.MutarDia;
var
  i, j1, j2, n1, n2, d1, d2, m1, m2: Smallint;
  b: array[0..16383] of Smallint;
  p: PSmallintArray;
begin
  //Check('MutarDiaAntes');
  with ModeloHorario do
  begin
    j1 := crand32 mod FDiaCant;
    repeat
      j2 := crand32 mod FDiaCant;
    until j1 <> j2;
    for i := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[i, 0];
      n1 := FDiaHoraAHorarioLaborable[j1, 0];
      n2 := FDiaHoraAHorarioLaborable[j2, 0];
      m1 := FDiaAMaxHorarioLaborable[j1];
      m2 := FDiaAMaxHorarioLaborable[j2];
      d1 := m1 - n1;
      d2 := m2 - n2;
      if (d1 = d2) and ((n1 = 0) or (p[n1 - 1] < 0)
        or (p[n1 - 1] <> p[n1])) and ((n2 = 0)
        or (p[n2 - 1] < 0) or (p[n2 - 1] <> p[n2]))
        and ((m1 = FHorarioLaborableCant - 1) or (p[m1] < 0)
        or (p[m1] <> p[m1 + 1]))
        and ((m2 = FHorarioLaborableCant - 1) or (p[m2] < 0)
        or (p[m2] <> p[m2 + 1])) then
      begin
        Move(p[n1], b[0], (d1 + 1) * SizeOf(Smallint));
        Move(p[n2], p[n1], (d1 + 1) * SizeOf(Smallint));
        Move(b[0], p[n2], (d1 + 1) * SizeOf(Smallint));
      end;
    end;
  end;
  Actualizar;
  FRecalcularValor := True;
  //Check('MutarDiaDespues');
end;

function TObjetoModeloHorario.GetValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FValor;
end;

function TObjetoModeloHorario.GetHoraHuecaDesubicadaValor: Double;
begin
  Result := ModeloHorario.FHoraHuecaDesubicadaValor *
    GetHoraHuecaDesubicada;
end;

function TObjetoModeloHorario.GetHoraHuecaDesubicada: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FHoraHuecaDesubicada;
end;

procedure TObjetoModeloHorario.DoGetHoraHuecaDesubicada;
var
  i, j, s: Integer;
  p: PSmallintArray;
begin
  FHoraHuecaDesubicada := 0;
  with ModeloHorario do
    for i := 0 to FParaleloCant - 1 do
    begin
      p := @ParaleloPeriodoASesion[i, 0];
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        s := p[j];
        if (s < 0) and (FHoraCant - 1 <> FHorarioLaborableAHora[j]) then
          Inc(FHoraHuecaDesubicada);
      end;
    end;
end;

function TObjetoModeloHorario.GetSesionCortadaValor: Double;
begin
  Result := GetSesionCortada * ModeloHorario.FSesionCortadaValor;
end;

function TObjetoModeloHorario.GetSesionCortada: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FSesionCortada;
end;

procedure TObjetoModeloHorario.DoGetSesionCortada;
var
  i, j, d, s: Integer;
  l, m, k, t: Smallint;
begin
  FSesionCortada := 0;
  with ModeloHorario do
    for i := 0 to FParaleloCant - 1 do
    begin
      j := 0;
      while j < FHorarioLaborableCant do
      begin
        s := ParaleloPeriodoASesion[i, j];
        l := FSesionADuracion[s];
        if s >= 0 then
        begin
          d := FHorarioLaborableADia[j];
          m := FSesionAMateria[s];
          t := FParaleloMateriaDiaMaxHora[i, m, d] -
            FParaleloMateriaDiaMinHora[i, m, d];
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

function TObjetoModeloHorario.GetMateriaNoDispersaValor: Double;
begin
  Result := ModeloHorario.FMateriaNoDispersaValor * GetMateriaNoDispersa;
end;

function TObjetoModeloHorario.GetMateriaNoDispersa: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaNoDispersa;
end;

function TObjetoModeloHorario.GetParaleloMateriaNoDispersa(AParalelo: Smallint;
  var AMateriaDiaMaxHora: TDynamicSmallintArrayArray): Smallint;
var
  m, n, l, k, ns, ns1: Smallint;
  pm: PSmallintArray;
begin
  Result := 0;
  with ModeloHorario do
    for m := 0 to FMateriaCant - 1 do
    begin
      n := FMateriaCursoAAsignatura[m, FParaleloACurso[AParalelo]];
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
        ns1 := Length(FAsignaturaASesiones[n]);
        ns := 2 * Min(ns1, FDiaCant + 1 - ns1);
        Inc(Result, Abs(ns - l))
      end;
    end;
end;

procedure TObjetoModeloHorario.DoGetMateriaNoDispersa;
var
  i: Smallint;
begin
  FMateriaNoDispersa := 0;
  with ModeloHorario do
  begin
    for i := 0 to FParaleloCant - 1 do
    begin
      Inc(FMateriaNoDispersa, FParaleloMateriaNoDispersa[i]);
    end;
  end;
end;

procedure TObjetoModeloHorario.DoGetProfesorFraccionamiento;
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

function TObjetoModeloHorario.GetMateriaProhibicion: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaProhibicion;
end;

function TObjetoModeloHorario.GetMateriaProhibicionValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FMateriaProhibicionValor;
end;

procedure TObjetoModeloHorario.DoGetMateriaProhibicionValor;
var
  i, m, j, c: Integer;
  d: Double;
begin
  FMateriaProhibicionValor := 0;
  FMateriaProhibicion := 0;
  with ModeloHorario do
    for i := 0 to High(FMateriaProhibicionAMateria) do
    begin
      m := FMateriaProhibicionAMateria[i];
      j := FMateriaProhibicionAHorarioLaborable[i];
      c := FMateriaHorarioLaborableCant[m, j];
      d := c * FMateriaProhibicionAValor[i];
      FMateriaProhibicionValor := FMateriaProhibicionValor + d;
      Inc(FMateriaProhibicion, c);
    end;
end;

function TObjetoModeloHorario.GetProfesorProhibicion: Integer;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FProfesorProhibicion;
end;

function TObjetoModeloHorario.GetProfesorProhibicionValor: Double;
begin
  if FRecalcularValor then
    DoGetValor;
  Result := FProfesorProhibicionValor;
end;

procedure TObjetoModeloHorario.DoGetProfesorProhibicionValor;
var
  i, p, j, c: Smallint;
  d: Double;
begin
  FProfesorProhibicionValor := 0;
  FProfesorProhibicion := 0;
  with ModeloHorario do
    for i := 0 to High(FProfesorProhibicionAProfesor) do
    begin
      p := FProfesorProhibicionAProfesor[i];
      j := FProfesorProhibicionAHorarioLaborable[i];
      c := FProfesorHorarioLaborableCant[p, j];
      d := c * FProfesorProhibicionAValor[i];
      FProfesorProhibicionValor := FProfesorProhibicionValor + d;
      Inc(FProfesorProhibicion, c);
    end;
end;

procedure TObjetoModeloHorario.DoGetCruceProfesor;
var
  j, p, c: Smallint;
  r: PSmallintArray;
begin
  FCruceProfesor := 0;
  with ModeloHorario do
  begin
    for p := 0 to FProfesorCant - 1 do
    begin
      r := @FProfesorHorarioLaborableCant[p, 0];
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        c := r[j];
        if c > 1 then
          Inc(FCruceProfesor, c - 1);
      end;
    end;
  end;
end;

procedure TObjetoModeloHorario.DoGetCruceAulaTipo;
var
  j, a, c: Smallint;
  r: PSmallintArray;
begin
  FCruceAulaTipo := 0;
  with ModeloHorario do
  begin
    for a := 0 to FAulaTipoCant - 1 do
    begin
      r := @FAulaTipoHorarioLaborableCant[a, 0];
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        c := r[j] - FAulaTipoACantidad[a];
        if c > 0 then
          Inc(FCruceAulaTipo, c);
      end;
    end;
  end;
end;

function TObjetoModeloHorario.GetCruceProfesorValor: Double;
begin
  Result := ModeloHorario.FCruceProfesorValor * FCruceProfesor;
end;

function TObjetoModeloHorario.GetProfesorFraccionamientoValor: Double;
begin
  Result := ModeloHorario.FProfesorFraccionamientoValor
    * FProfesorFraccionamiento;
end;

function TObjetoModeloHorario.GetCruceAulaTipoValor: Double;
begin
  Result := ModeloHorario.FCruceAulaTipoValor * FCruceAulaTipo;
end;

procedure TObjetoModeloHorario.DoGetValor;
begin
  RecalcularValor := false;
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
    FValor := Self.CruceProfesorValor + Self.CruceAulaTipoValor
      + FMateriaProhibicionValor + FProfesorProhibicionValor
      + FMateriaNoDispersa * FMateriaNoDispersaValor + FSesionCortada
      * FSesionCortadaValor + FHoraHuecaDesubicada * FHoraHuecaDesubicadaValor
      + FProfesorFraccionamiento * FProfesorFraccionamientoValor;
  end;
end;

procedure TObjetoModeloHorario.ActualizarProfesorHorarioLaborableCant;
var
  i, j, p, s: Smallint;
  q, r: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for i := 0 to FProfesorCant - 1 do
      FillChar(FProfesorHorarioLaborableCant[i, 0], FHorarioLaborableCant *
        SizeOf(Smallint), #0);
    for i := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[i, 0];
      r := @FParaleloMateriaAProfesor[i, 0];
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          p := r[FSesionAMateria[s]];
          Inc(FProfesorHorarioLaborableCant[p, j]);
        end;
      end;
    end;
  end;
end;

procedure TObjetoModeloHorario.ActualizarAulaTipoHorarioLaborableCant;
var
  i, j, a, s: Smallint;
  q: PSmallintArray;
begin
  with ModeloHorario do
  begin
    for i := 0 to FAulaTipoCant - 1 do
      FillChar(FAulaTipoHorarioLaborableCant[i, 0], FHorarioLaborableCant *
        SizeOf(Smallint), #0);
    for i := 0 to FParaleloCant - 1 do
    begin
      q := @ParaleloPeriodoASesion[i, 0];
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        s := q[j];
        if s >= 0 then
        begin
          a := FSesionAAulaTipo[s];
          Inc(FAulaTipoHorarioLaborableCant[a, j]);
        end;
      end;
    end;
  end;
end;

function TObjetoModeloHorario.EvaluarIntercambioInterno(AParalelo, AHorarioLaborable,
  AHorarioLaborable1: Smallint): Double;
var
  d, d1, s, s1, di, di1, hl, hl1, m, m1, p, p1: Smallint;
  q, r: PSmallintArray;
  FIncDiaProfesorCantHora,
    FIncProfesorHorarioLaborableCant: TDynamicSmallintArrayArray;
  // TList será usado como arreglo de enteros de 32 bits, no de punteros!
  procedure InsertarCambio(d, p: Smallint);
  var
    v: Longword;
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
            if ProfesorHorarioLaborableCant[p, AHorarioLaborable1 + l] >= 1 then
            begin
              Inc(Result);
            end;
            if ProfesorHorarioLaborableCant[p, AHorarioLaborable + l] > 1 then
            begin
              Dec(Result);
            end;
            di_ := FHorarioLaborableADia[AHorarioLaborable + l];
            di1_ := FHorarioLaborableADia[AHorarioLaborable1 + l];
            Inc(FIncProfesorHorarioLaborableCant[p, AHorarioLaborable1 + l]);
            Inc(FIncDiaProfesorCantHora[di1_, p]);
            InsertarCambio(di1_, p);
            Dec(FIncDiaProfesorCantHora[di_, p]);
            Dec(FIncProfesorHorarioLaborableCant[p, AHorarioLaborable + l]);
            InsertarCambio(di_, p);
          end;
        end;
        if p1 >= 0 then
        begin
          for l := d - 1 downto 0 do
          begin
            if ProfesorHorarioLaborableCant[p1, AHorarioLaborable + l] >= 1 then
              Inc(Result);
            if ProfesorHorarioLaborableCant[p1, AHorarioLaborable1 + l] > 1 then
              Dec(Result);
            di_ := FHorarioLaborableADia[AHorarioLaborable + l];
            di1_ := FHorarioLaborableADia[AHorarioLaborable1 + l];
            Inc(FIncProfesorHorarioLaborableCant[p1, AHorarioLaborable + l]);
            Inc(FIncDiaProfesorCantHora[di_, p1]);
            InsertarCambio(di_, p1);
            Dec(FIncProfesorHorarioLaborableCant[p1, AHorarioLaborable1 + l]);
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
      for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
          p_ := r[FSesionAMateria[s_]]
        else
          p_ := -1;
        if p_ <> p1 then
        begin
          di_ := FHorarioLaborableADia[j_];
          if (p_ >= 0) then
          begin
            if ProfesorHorarioLaborableCant[p_, j_] > 1 then
            begin
              Dec(Result);
            end;
            Dec(FIncProfesorHorarioLaborableCant[p_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p_]);
            InsertarCambio(di_, p_);
          end;
          if (p1 >= 0) then
          begin
            if ProfesorHorarioLaborableCant[p1, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorHorarioLaborableCant[p1, j_]);
            Inc(FIncDiaProfesorCantHora[di_, p1]);
            InsertarCambio(di_, p1);
          end;
        end;
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
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
          di_ := FHorarioLaborableADia[j_];
          if p1_ >= 0 then
          begin
            if ProfesorHorarioLaborableCant[p1_, j_] > 1 then
              Dec(Result);
            Dec(FIncProfesorHorarioLaborableCant[p1_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p1_]);
            InsertarCambio(di_, p1_);
          end;
          if p_ >= 0 then
          begin
            if ProfesorHorarioLaborableCant[p_, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorHorarioLaborableCant[p_, j_]);
            Inc(FIncDiaProfesorCantHora[di_, p_]);
            InsertarCambio(di_, p_);
          end;
        end;
      end;
      for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
          p1_ := r[FSesionAMateria[s_]]
        else
          p1_ := -1;
        if p <> p1_ then
        begin
          di_ := FHorarioLaborableADia[j_];
          if p1_ >= 0 then
          begin
            if (ProfesorHorarioLaborableCant[p1_, j_] > 1) then
              Dec(Result);
            Dec(FIncProfesorHorarioLaborableCant[p1_, j_]);
            Dec(FIncDiaProfesorCantHora[di_, p1_]);
            InsertarCambio(di_, p1_);
          end;
          if p >= 0 then
          begin
            if ProfesorHorarioLaborableCant[p, j_] > 0 then
              Inc(Result);
            Inc(FIncProfesorHorarioLaborableCant[p, j_]);
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
        for h_ := FDiaHoraAHorarioLaborable[di, 0] to
          FDiaAMaxHorarioLaborable[di] do
        begin
          if (FIncProfesorHorarioLaborableCant[p, h_] +
            FProfesorHorarioLaborableCant[p, h_] > 0) or
            (FProfesorProhibicionTipoAValor[
            FProfesorHorarioLaborableAProfesorProhibicionTipo[p, h_]] =
              FMaxProfesorProhibicionTipoValor) then
          begin
            iMax := FHorarioLaborableAHora[h_];
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
    pd: Longword;
    i: Integer;
  begin
    Result := 0;
    with FModeloHorario do
      for i := FAntListaCambios.Count - 1 downto 0 do
      begin
        pd := Longword(FAntListaCambios.Items[i]);
        p := Smallint(pd);
        di := Smallint(pd shr 16);
        Inc(Result, GetAntDiaProfesorFraccionamiento(di, p) -
          FDiaProfesorFraccionamiento[di, p]);
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
      for j_ := 0 to AHorarioLaborable - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FHorarioLaborableADia[j_];
          h := FHorarioLaborableAHora[j_];
          if FAntMateriaDiaMaxHora[m_, di_] < h then
            FAntMateriaDiaMaxHora[m_, di_] := h;
          if FAntMateriaDiaMinHora[m_, di_] > h then
            FAntMateriaDiaMinHora[m_, di_] := h;
        end;
      end;
      if s1 >= 0 then
      begin
        for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
        begin
          di_ := FHorarioLaborableADia[j_];
          h := FHorarioLaborableAHora[j_];
          if FAntMateriaDiaMaxHora[m1, di_] < h then
            FAntMateriaDiaMaxHora[m1, di_] := h;
          if FAntMateriaDiaMinHora[m1, di_] > h then
            FAntMateriaDiaMinHora[m1, di_] := h;
        end;
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FHorarioLaborableADia[j_];
          h := FHorarioLaborableAHora[j_];
          if FAntMateriaDiaMaxHora[m_, di_] < h then
            FAntMateriaDiaMaxHora[m_, di_] := h;
          if FAntMateriaDiaMinHora[m_, di_] > h then
            FAntMateriaDiaMinHora[m_, di_] := h;
        end;
      end;
      if s >= 0 then
      begin
        for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
        begin
          di_ := FHorarioLaborableADia[j_];
          h := FHorarioLaborableAHora[j_];
          if FAntMateriaDiaMaxHora[m, di_] < h then
            FAntMateriaDiaMaxHora[m, di_] := h;
          if FAntMateriaDiaMinHora[m, di_] > h then
            FAntMateriaDiaMinHora[m, di_] := h;
        end;
      end;
      for j_ := AHorarioLaborable1 + d1 to FHorarioLaborableCant - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          di_ := FHorarioLaborableADia[j_];
          h := FHorarioLaborableAHora[j_];
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
          di_ := FHorarioLaborableADia[j_];
          m_ := FSesionAMateria[s_];
          t := FParaleloMateriaDiaMaxHora[AParalelo, m_, di_]
            - FParaleloMateriaDiaMinHora[AParalelo, m_, di_];
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
      while j_ < AHorarioLaborable do
      begin
        s_ := q[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FHorarioLaborableADia[j_];
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
        di_ := FHorarioLaborableADia[AHorarioLaborable];
        t := FAntMateriaDiaMaxHora[m1, di_] - FAntMateriaDiaMinHora[m1, di_];
        if t >= 0 then
        begin
          Inc(Result, Abs(t + 1 - d1));
        end
      end;
      Inc(j_, d);
      while j_ < AHorarioLaborable1 do
      begin
        s_ := q[j_];
        d_ := FSesionADuracion[s_];
        if s_ >= 0 then
        begin
          di_ := FHorarioLaborableADia[j_ + d1 - d];
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
        di_ := FHorarioLaborableADia[AHorarioLaborable1 + d1 - d];
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
          di_ := FHorarioLaborableADia[j_];
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
        a := FSesionAAulaTipo[s] else
        a := -1;
      if s1 >= 0 then
        a1 := FSesionAAulaTipo[s1] else
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
            if AulaTipoHorarioLaborableCant[a, AHorarioLaborable1 + l] >= c then
              Inc(Result);
            if AulaTipoHorarioLaborableCant[a, AHorarioLaborable + l] > c
              then
              Dec(Result);
          end;
        end;
        if a1 >= 0 then
        begin
          c1 := FAulaTipoACantidad[a1];
          for l := d - 1 downto 0 do
          begin
            if AulaTipoHorarioLaborableCant[a1, AHorarioLaborable + l] >= c1 then
              Inc(Result);
            if AulaTipoHorarioLaborableCant[a1, AHorarioLaborable1 + l] > c1 then
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
      if s1 >= 0 then
      begin
        a1 := FSesionAAulaTipo[s1];
        c1 := FAulaTipoACantidad[a1];
      end
      else
        a1 := -1;
      for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
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
            if AulaTipoHorarioLaborableCant[a, j_] > c then
              Dec(Result);
          end;
          if a1 >= 0 then
          begin
            if AulaTipoHorarioLaborableCant[a1, j_] >= c1 then
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
      for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
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
            if AulaTipoHorarioLaborableCant[a1, j_] > c1 then
              Dec(Result);
          end;
          if (a >= 0) then
          begin
            if AulaTipoHorarioLaborableCant[a, j_] >= c then
              Inc(Result);
          end;
        end;
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
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
            if AulaTipoHorarioLaborableCant[a1, j_] > c1 then
              Dec(Result);
          end;
          if a >= 0 then
          begin
            if AulaTipoHorarioLaborableCant[a, j_] >= c then
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
            if FHoraCant - 1 <> FHorarioLaborableAHora[AHorarioLaborable + k] then
              Dec(Result);
            if FHoraCant - 1 <> FHorarioLaborableAHora[AHorarioLaborable1 + k] then
              Inc(Result);
          end;
        end
        else if s1 < 0 then
        begin
          for k := 0 to d - 1 do
          begin
            if FHoraCant - 1 <> FHorarioLaborableAHora[AHorarioLaborable + k] then
              Inc(Result);
            if FHoraCant - 1 <> FHorarioLaborableAHora[AHorarioLaborable1 + k] then
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
      for j_ := AHorarioLaborable to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if (s_ < 0) and (FHoraCant - 1 <> FHorarioLaborableAHora[j_]) then
          Dec(Result);
      end;
      for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
      begin
        if (s1 < 0) and (FHoraCant - 1 <> FHorarioLaborableAHora[j_]) then
          Inc(Result);
      end;
      for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
      begin
        if (s < 0) and (FHoraCant - 1 <> FHorarioLaborableAHora[j_]) then
          Inc(Result);
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
        if (s_ < 0) and (FHoraCant - 1 <> FHorarioLaborableAHora[j_]) then
          Inc(Result);
      end;
    end;
  end;
  function _EvaluarMateriaNoDispersaMovido: Smallint;
  begin
    FAntMateriaNoDispersa := GetParaleloMateriaNoDispersa(AParalelo,
      FAntMateriaDiaMaxHora);
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
            mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m,
              AHorarioLaborable + k];
            mp1 := FMateriaHorarioLaborableAMateriaProhibicionTipo[m,
              AHorarioLaborable1 + k];
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
            mp1 := FMateriaHorarioLaborableAMateriaProhibicionTipo[m1,
              AHorarioLaborable1 + k];
            mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m1,
              AHorarioLaborable + k];
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
      for j_ := AHorarioLaborable to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m_, j_];
          if mp >= 0 then
            Result := Result - FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if s1 >= 0 then
      begin
        for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
        begin
          mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m1, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      if s >= 0 then
      begin
        for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
        begin
          mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m, j_];
          if mp >= 0 then
            Result := Result + FMateriaProhibicionTipoAValor[mp];
        end;
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
        if s_ >= 0 then
        begin
          m_ := FSesionAMateria[s_];
          mp := FMateriaHorarioLaborableAMateriaProhibicionTipo[m_, j_];
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
            pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p,
              AHorarioLaborable + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p,
              AHorarioLaborable1 + k];
            if pp >= 0 then
              Result := Result + FProfesorProhibicionTipoAValor[pp];
          end;
        end;
        if s1 >= 0 then
        begin
          p1 := r[m1];
          for k := 0 to d - 1 do
          begin
            pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p1,
              AHorarioLaborable1 + k];
            if pp >= 0 then
              Result := Result - FProfesorProhibicionTipoAValor[pp];
            pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p1,
              AHorarioLaborable + k];
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
      for j_ := AHorarioLaborable to AHorarioLaborable1 + d1 - 1 do
      begin
        s_ := q[j_];
        if s_ >= 0 then
        begin
          p_ := r[FSesionAMateria[s_]];
          pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result - FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if s1 >= 0 then
      begin
        p_ := r[m1];
        for j_ := AHorarioLaborable to AHorarioLaborable + d1 - 1 do
        begin
          pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      if s >= 0 then
      begin
        p_ := r[m];
        for j_ := AHorarioLaborable1 + d1 - d to AHorarioLaborable1 + d1 - 1 do
        begin
          pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p_, j_];
          if pp >= 0 then
            Result := Result + FProfesorProhibicionTipoAValor[pp];
        end;
      end;
      for j_ := AHorarioLaborable + d1 to AHorarioLaborable1 + d1 - d - 1 do
      begin
        s_ := q[j_ + d - d1];
        if s_ >= 0 then
        begin
          p_ := r[FSesionAMateria[s_]];
          pp := FProfesorHorarioLaborableAProfesorProhibicionTipo[p_, j_];
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
    s := q[AHorarioLaborable];
    s1 := q[AHorarioLaborable1];
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
    di := FHorarioLaborableADia[AHorarioLaborable];
    hl := FDiaHoraAHorarioLaborable[di, 0];
    di1 := FHorarioLaborableADia[AHorarioLaborable1 + d1 - 1];
    hl1 := FDiaAMaxHorarioLaborable[di1];
    SetLength(FIncDiaProfesorCantHora, FDiaCant, FProfesorCant);
    SetLength(FIncProfesorHorarioLaborableCant, FProfesorCant,
      FHorarioLaborableCant);
    ActMateriaDiaMinMaxEntraMovido;
      //ActDiaProfesorMinMaxEntraMovido;
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

{ $DEFINE DEBUG}
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
    while j < FHorarioLaborableCant do
    begin
      d := FSesionADuracion[p[j]];
      if q[j] <> q[j + d - 1] then
        raise Exception.Create('Error de sincronización entre clave aleatoria, duración y períodos ' + s);
      if p[j] <> p[j + d - 1] then
        raise Exception.Create('Error de sincronización entre sesión, duración y períodos ' + s);
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

function TObjetoModeloHorario.DescensoRapidoPuntualInterno(AParalelo: Smallint;
  var Delta: Double): Boolean;
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
    while j < FHorarioLaborableCant do
    begin
      j1 := j + FSesionADuracion[p[j]];
      while j1 < FHorarioLaborableCant do
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

function TObjetoModeloHorario.DescensoRapidoPuntualInterno(var Delta: Double): Boolean;
var
  ci, i, j, j1, d: Smallint;
  dk: Double;
  RandomOrdersi: array[0..4095] of Smallint;
  RandomValues: array[0..4095] of Longint;
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
      i := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[i, 0];
      while j < FHorarioLaborableCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FHorarioLaborableCant do
        begin
          d := FSesionADuracion[p[j1]];
          dk := EvaluarIntercambioInterno(i, j, j1);
          if Delta + dk < 0 then
          begin
            IntercambiarInterno(i, j, j1, True);
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

function TObjetoModeloHorario.DescensoRapidoOptimizadoInterno: Boolean;
var
  j, j1, d, d1, ci, i, k, s, l: Smallint;
  dk, v1: Double;
  RandomOrdersi: array[0..4095] of Smallint;
  RandomValues: array[0..4095] of Longint;
  p: PSmallintArray;
  Stop: Boolean;
  {Continuar: Boolean;}
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
    for i := 0 to FProfesorCant - 1 do
    begin
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        if FProfesorHorarioLaborableCant[i, j] > 1 then
        begin
          for k := 0 to FParaleloCant - 1 do
          begin
            s := FParaleloPeriodoASesion[k, j];
            if (s >= 0) and (FParaleloMateriaAProfesor[k, FSesionAMateria[s]] = i) then
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
      {Continuar := True;}
      i := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[i, 0];
      while j < FHorarioLaborableCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FHorarioLaborableCant do
        begin
          Stop := False;
          DoProgress((j + ci * FHorarioLaborableCant) * FHorarioLaborableCant + j1,
            l * Sqr(FHorarioLaborableCant), v1, Stop);
          if Stop then
            Exit;
          dk := EvaluarIntercambioInterno(i, j, j1);
          d := FSesionADuracion[p[j]];
          d1 := FSesionADuracion[p[j1]];
          IntercambiarInterno(i, j, j1, True);
          if dk < 0 then
          begin
            Result := False;
          end
          else
          begin
            if DescensoRapidoPuntualInterno(i, dk) then
            begin
              IntercambiarInterno(i, j, j1 + d1 - d);
              dk := 0;
            end
            else
            begin
              Normalizar(i, j);
              Result := False;
            end;
          end;
          v1 := v1 + dk;
          Normalizar(i, j1);
          Inc(j1, FSesionADuracion[p[j1]]);
        end;
        Normalizar(i, j);
        Inc(j, FSesionADuracion[p[j]]);
      end;
      {if Continuar then}
      Inc(ci);
    end;
  end;
end;

function TObjetoModeloHorario.DescensoRapidoDobleInterno: Boolean;
var
  j, j1, d, d1, ci, i, k: Smallint;
  dk, v1: Double;
  RandomOrdersi: array[0..4095] of Smallint;
  RandomValues: array[0..4095] of Longint;
  p: PSmallintArray;
  Stop: Boolean;
  {Continuar: Boolean;}
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
    while ci < FParaleloCant do
    begin
      {Continuar := True;}
      i := RandomOrdersi[ci];
      j := 0;
      p := @FParaleloPeriodoASesion[i, 0];
      while j < FHorarioLaborableCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        k := j1;
        while j1 < FHorarioLaborableCant do
        begin
          Stop := False;
          DoProgress(ci * FHorarioLaborableCant * (FHorarioLaborableCant - 1) div 2
            + j * (FHorarioLaborableCant - 1) - j * (j - 1) div 2 + j1 - k,
            FParaleloCant * FHorarioLaborableCant * (FHorarioLaborableCant - 1) div 2, v1, Stop);
          if Stop then
            Exit;
          dk := EvaluarIntercambioInterno(i, j, j1);
          d := FSesionADuracion[p[j]];
          d1 := FSesionADuracion[p[j1]];
          IntercambiarInterno(i, j, j1, True);
          if dk < 0 then
          begin
            Result := False;
          end
          else
          begin
            if DescensoRapidoPuntualInterno(dk) then
            begin
              IntercambiarInterno(i, j, j1 + d1 - d);
              dk := 0;
            end
            else
            begin
              Normalizar(i, j);
              Result := False;
            end;
          end;
          v1 := v1 + dk;
          Normalizar(i, j1);
          Inc(j1, FSesionADuracion[p[j1]]);
        end;
        Normalizar(i, j);
        Inc(j, FSesionADuracion[p[j]]);
      end;
      {if Continuar then}
      Inc(ci);
    end;
  end;
end;

{Retorna verdadero cuando no ha descendido}

function TObjetoModeloHorario.DescensoRapidoInterno: Boolean;
begin
  result := DescensoRapidoInterno(0);
end;

function TObjetoModeloHorario.DescensoRapidoInterno(Delta: Double): Boolean;
var
  ci, i, j, j1, d1: Smallint;
  dk1{$IFDEF DEBUG}, v1, v2{$ENDIF}: Double;
  RandomOrdersi: array[0..4095] of Smallint;
  RandomValues: array[0..4095] of Longint;
  p: PSmallintArray;
  {Continuar: Boolean;}
begin
  with ModeloHorario do
  begin
    for ci := 0 to FParaleloCant - 1 do
    begin
      RandomOrdersi[ci] := ci;
      Randomvalues[ci] := rand32;
    end;
    SortLongint(RandomValues, RandomOrdersi, 0, FParaleloCant - 1);
    Result := True;
    ci := 0;
    while ci < FParaleloCant do
    begin
      {Continuar := True;}
      i := RandomOrdersi[ci];
      p := @FParaleloPeriodoASesion[i, 0];
      j := 0;
      while j < FHorarioLaborableCant do
      begin
        j1 := j + FSesionADuracion[p[j]];
        while j1 < FHorarioLaborableCant do
        begin
          d1 := FSesionADuracion[p[j1]];
{$IFDEF DEBUG}
          Actualizar;
          DoGetValor;
          v1 := Valor;
{$ENDIF}
          dk1 := EvaluarIntercambioInterno(i, j, j1);
          if (dk1 < Delta) {or ((dk1 = 0) and ((rand32 mod 4) = 0))} then
          begin
            IntercambiarInterno(i, j, j1, True);
{$IFDEF DEBUG}
            Actualizar;
            DoGetValor;
            v2 := Valor;
            if Abs((v2 - v1) - dk1) > 0.00001 then
              raise Exception.Create('Problemas');
{$ENDIF}
            Result := False;
          end;
          {Continuar := Continuar and (dk1 >= 0);}
          Inc(j1, d1);
        end;
        Inc(j, FSesionADuracion[p[j]]);
      end;
      {if Continuar then}
      Inc(ci);
    end;
  end;
end;

function TObjetoModeloHorario.DescensoRapido: Boolean;
begin
  //Check('DescensoRapidoAntes');
  Result := DescensoRapidoInterno;
  RecalcularValor := True;
  //Check('DescensoRapidoDespues');
end;

function TObjetoModeloHorario.DescensoRapidoDoble: Boolean;
begin
  Result := DescensoRapidoDobleInterno;
  RecalcularValor := True;
end;

procedure TObjetoModeloHorario.DescensoRapidoOptimizadoForzado;
begin
  repeat
  until DescensoRapidoOptimizadoInterno;
  RecalcularValor := True;
end;

procedure TObjetoModeloHorario.DescensoRapidoDobleForzado;
begin
  repeat
    //Application.ProcessMessages;
  until DescensoRapidoDobleInterno;
  RecalcularValor := True;
end;

procedure TObjetoModeloHorario.DescensoRapidoForzado;
begin
  repeat
    //Application.ProcessMessages;
  until DescensoRapidoInterno;
  RecalcularValor := True;
end;

{procedure TObjetoModeloHorario.DescensoRapido2(CallBack: TCountFunc);
begin
  DescensoRapidoInterno2(CallBack);
  RecalcularValor := True;
end;}

destructor TObjetoModeloHorario.Destroy;
begin
  FModeloHorario := nil;
  FAntListaCambios.Free;
  inherited Destroy;
end;

procedure TObjetoModeloHorario.Assign(AObjetoModeloHorario:
  TObjetoModeloHorario);
var
  i, m, p, a, d: Smallint;
begin
  with ModeloHorario do
  begin
    for i := 0 to FParaleloCant - 1 do
    begin
      Move(AObjetoModeloHorario.ParaleloPeriodoASesion[i, 0], ParaleloPeriodoASesion[i, 0],
        FHorarioLaborableCant * SizeOf(Smallint));
    end;
    if AObjetoModeloHorario.RecalcularValor then
      RecalcularValor := True
    else
    begin
      FCruceProfesor := AObjetoModeloHorario.FCruceProfesor;
      FProfesorFraccionamiento := AObjetoModeloHorario.FProfesorFraccionamiento;
      FCruceAulaTipo := AObjetoModeloHorario.FCruceAulaTipo;
      FHoraHuecaDesubicada := AObjetoModeloHorario.FHoraHuecaDesubicada;
      FSesionCortada := AObjetoModeloHorario.FSesionCortada;
      FMateriaNoDispersa := AObjetoModeloHorario.FMateriaNoDispersa;
      FMateriaProhibicion := AObjetoModeloHorario.FMateriaProhibicion;
      FProfesorProhibicion := AObjetoModeloHorario.FProfesorProhibicion;
      FMateriaProhibicionValor := AObjetoModeloHorario.FMateriaProhibicionValor;
      FProfesorProhibicionValor :=
        AObjetoModeloHorario.FProfesorProhibicionValor;
      FValor := AObjetoModeloHorario.FValor;
      RecalcularValor := False;
    end;
    Move(AObjetoModeloHorario.FParaleloMateriaNoDispersa[0],
      FParaleloMateriaNoDispersa[0], FParaleloCant * SizeOf(Smallint));
    for i := 0 to FParaleloCant - 1 do
    begin
      for m := 0 to FMateriaCant - 1 do
      begin
        Move(AObjetoModeloHorario.FParaleloMateriaDiaMinHora[i, m, 0],
          FParaleloMateriaDiaMinHora[i, m, 0], FDiaCant * SizeOf(Smallint));
        Move(AObjetoModeloHorario.FParaleloMateriaDiaMaxHora[i, m, 0],
          FParaleloMateriaDiaMaxHora[i, m, 0], FDiaCant * SizeOf(Smallint));
      end;
    end;
    for m := 0 to FMateriaCant - 1 do
      Move(AObjetoModeloHorario.FMateriaHorarioLaborableCant[m, 0],
        FMateriaHorarioLaborableCant[m, 0], FHorarioLaborableCant *
        SizeOf(Smallint));
    for p := 0 to FProfesorCant - 1 do
      Move(AObjetoModeloHorario.FProfesorHorarioLaborableCant[p, 0],
        FProfesorHorarioLaborableCant[p, 0], FHorarioLaborableCant *
        SizeOf(Smallint));
    for d := 0 to FDiaCant - 1 do
    begin
      Move(AObjetoModeloHorario.FDiaProfesorFraccionamiento[d, 0],
        FDiaProfesorFraccionamiento[d, 0], FProfesorCant * SizeOf(Smallint));

      {Move(AObjetoModeloHorario.FDiaProfesorSumaHora[d, 0],
        FDiaProfesorSumaHora[d, 0], FProfesorCant * SizeOf(Smallint));
      Move(AObjetoModeloHorario.FDiaProfesorSumaCuadradoHora[d, 0],
        FDiaProfesorSumaCuadradoHora[d, 0], FProfesorCant * SizeOf(Smallint));}
    end;
    for a := 0 to FAulaTipoCant - 1 do
      Move(AObjetoModeloHorario.FAulaTipoHorarioLaborableCant[a, 0],
        FAulaTipoHorarioLaborableCant[a, 0], FHorarioLaborableCant *
        SizeOf(Smallint));
  end;
end;

procedure TObjetoModeloHorario.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  i, j: Integer;
begin
  VStrings := TStringList.Create;
  with ModeloHorario do
  try
    for i := 0 to FParaleloCant - 1 do
    begin
      VStrings.Add(Format('Paralelo %d %d %d',
        [FNivelACodNivel[FParaleloANivel[i]],
        FEspecializacionACodEspecializacion[FParaleloAEspecializacion[i]],
          FParaleloIdACodParaleloId[FParaleloAParaleloId[i]]]));
      for j := 0 to FHorarioLaborableCant - 1 do
      begin
        VStrings.Add(Format(' Dia %d Hora %d Materia %d',
          [FHorarioLaborableADia[j], FHorarioLaborableAHora[j],
          FMateriaACodMateria[FSesionAMateria[ParaleloPeriodoASesion[i, j]]]]));
      end;
    end;
    VStrings.SaveToFile(AFileName);
  finally
    VStrings.Free;
  end;
end;

procedure TObjetoModeloHorario.SaveToStream(Stream: TStream);
var
  i: Smallint;
begin
  with FModeloHorario do
    for i := 0 to FParaleloCant - 1 do
    begin
      Stream.Write(ParaleloPeriodoASesion[i, 0], FHorarioLaborableCant *
        SizeOf(Smallint));
    end;
end;

procedure TObjetoModeloHorario.LoadFromStream(Stream: TStream);
var
  i: Smallint;
begin
  with FModeloHorario do
    for i := 0 to FParaleloCant - 1 do
    begin
      Stream.Read(ParaleloPeriodoASesion[i, 0], FHorarioLaborableCant *
        SizeOf(Smallint));
    end;
  Actualizar;
  FRecalcularValor := True;
end;

procedure TObjetoModeloHorario.SaveToDatabase(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
var
  Stream: TStream;
  procedure SaveHorario;
  var
    TbHorario: TTable;
  begin
    TbHorario := TTable.Create(nil);
    try
      with TbHorario do
      begin
        DatabaseName := ModeloHorario.Database.DatabaseName;
        SessionName := ModeloHorario.Database.SessionName;
        TableName := 'Horario';
        IndexFieldNames := 'CodHorario';
        Open;
        Append;
        FindField('CodHorario').AsInteger := CodHorario;
        FindField('MomentoInicial').AsDateTime := MomentoInicial;
        FindField('MomentoFinal').AsDateTime := MomentoFinal;
        Stream := TBlobStream.Create(TMemoField(FindField('Informe')), bmWrite);
        try
          Informe.SaveToStream(Stream);
        finally
          Stream.Free;
        end;
        TbHorario.FlushBuffers;
      end;
    finally
      TbHorario.Free;
    end;
  end;
  procedure SaveHorarioDetalle;
  var
    TbHorarioDetalle: TTable;
  var
    FieldHorario, FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia,
      FieldHora, FieldMateria, FieldSesion: TIntegerField;
    i, j, k, l, m, s: Integer;
  begin
    TbHorarioDetalle := TTable.Create(nil);
    try
      with ModeloHorario, TbHorarioDetalle do
      begin
        DatabaseName := ModeloHorario.Database.DatabaseName;
        SessionName := ModeloHorario.Database.SessionName;
        TableName := 'HorarioDetalle';
        Open;
        FieldHorario := FindField('CodHorario') as TIntegerField;
        FieldNivel := FindField('CodNivel') as TIntegerField;
        FieldParaleloId := FindField('CodParaleloId') as TIntegerField;
        FieldEspecializacion := FindField('CodEspecializacion') as
          TIntegerField;
        FieldDia := FindField('CodDia') as TIntegerField;
        FieldHora := FindField('CodHora') as TIntegerField;
        FieldMateria := FindField('CodMateria') as TIntegerField;
        FieldSesion := FindField('Sesion') as TIntegerField;
        for i := 0 to FParaleloCant - 1 do
        begin
          k := FNivelACodNivel[FParaleloANivel[i]];
          l := FParaleloIdACodParaleloId[FParaleloAParaleloId[i]];
          m :=
            FEspecializacionACodEspecializacion[FParaleloAEspecializacion[i]];
          for j := 0 to FHorarioLaborableCant - 1 do
          begin
            s := ParaleloPeriodoASesion[i, j];
            if s >= 0 then
            begin
              Append;
              FieldHorario.Value := CodHorario;
              FieldNivel.Value := k;
              FieldParaleloId.Value := l;
              FieldEspecializacion.Value := m;
              FieldDia.Value := FDiaACodDia[FHorarioLaborableADia[j]];
              FieldHora.Value := FHoraACodHora[FHorarioLaborableAHora[j]];
              FieldMateria.Value := FMateriaACodMateria[FSesionAMateria[s]];
              FieldSesion.Value := s;
              Post;
            end;
          end;
        end;
        FlushBuffers;
      end;
    finally
      TbHorarioDetalle.Free;
    end;
  end;
begin
  SaveHorario;
  SaveHorarioDetalle;
end;

function TObjetoModeloHorario.GetDiaProfesorFraccionamiento(di, p: Smallint):
  Smallint;
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
    n := FDiaAMaxHorarioLaborable[di];
    q := @FProfesorHorarioLaborableCant[p, 0];
    r := @FProfesorHorarioLaborableAProfesorProhibicionTipo[p, 0];
    for h_ := FDiaHoraAHorarioLaborable[di, 0] to n do
    begin
      if (q[h_] > 0) or (FProfesorProhibicionTipoAValor[r[h_]] =
        FMaxProfesorProhibicionTipoValor) then
      begin
        iMax := FHorarioLaborableAHora[h_];
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


procedure TObjetoModeloHorario.LoadFromDatabase(CodHorario: Integer);
var
  FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia,
    FieldHora, FieldSesion: TIntegerField;
  i, j: Smallint;
begin
  with ModeloHorario, FQuHorarioDetalle do
  begin
    Close;
    ParamByName('CodHorario').AsInteger := CodHorario;
    Open;
    try
      FieldNivel := FindField('CodNivel') as TIntegerField;
      FieldParaleloId := FindField('CodParaleloId') as TIntegerField;
      FieldEspecializacion := FindField('CodEspecializacion') as TIntegerField;
      FieldDia := FindField('CodDia') as TIntegerField;
      FieldHora := FindField('CodHora') as TIntegerField;
      FieldSesion := FindField('Sesion') as TIntegerField;
      for i := 0 to FParaleloCant - 1 do
        FillChar(FParaleloPeriodoASesion[i, 0], FHorarioLaborableCant *
          SizeOf(Smallint), #$FF);
      while not Eof do
      begin
        i := FCursoParaleloIdAParalelo[FNivelEspecializacionACurso[
          FCodNivelANivel[FieldNivel.AsInteger - FMinCodNivel],
          FCodEspecializacionAEspecializacion[FieldEspecializacion.AsInteger
          - FMinCodEspecializacion]],
          FCodParaleloIdAParaleloId[FieldParaleloId.AsInteger -
          FMinCodParaleloId]];
        j := FDiaHoraAHorarioLaborable[FCodDiaADia[FieldDia.AsInteger -
          FMinCodDia], FCodHoraAHora[FieldHora.AsInteger - FMinCodHora]];
        FParaleloPeriodoASesion[i, j] := FieldSesion.AsInteger;
        Next;
      end;
    finally
      Close;
    end;
  end;
  Actualizar;
  RecalcularValor := True;
end;

procedure TObjetoModeloHorario.Actualizar;
begin
  ActualizarAulaTipoHorarioLaborableCant;
  ActualizarProfesorHorarioLaborableCant;
  ActualizarMateriaHorarioLaborableCant;
  ActualizarParaleloMateriaDiaMinMaxHora;
  ActualizarDiaProfesorFraccionamiento;
end;

procedure TModeloHorario.DoProgress(I, Max: Integer; Value: Double; var Stop: Boolean);
begin
  if Assigned(FOnProgress) then
    FOnProgress(I, Max, Value, Stop);
end;

destructor TModeloHorario.Destroy;
begin
  FQuHorarioDetalle.Close;
  FQuHorarioDetalle.Free;
  FQuHorarioDetalle := nil;
  inherited Destroy;
end;


initialization
  //SortLongint := QuicksortLongint;
  //SortSmallint := QuicksortSmallint;
  //lSort := lQuicksort;
  SortLongint := BubblesortLongint;
  SortSmallint := BubblesortSmallint;
  lSort := lBubblesort;
end.

