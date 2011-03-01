unit KerEvolE;
{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}cthreads, cmem, {$ENDIF}MTProcs, Classes, SysUtils, DB, KerModel;

type
  TTimeTableArray = array of TTimeTable;

  {
    Clase TEvolElitista
    Descripcion:
    Implementa el algoritmo evolutivo, utilizando el modelo elitista.
    Miembros privados:
    Los parametros de configuracion del algoritmo evolutivo, y las funciones
    de uso interno.
    Miembros protegidos:
    No los hay.
    Miembros publicos:
    propiedades que devuelven el valor de cada componente de la evaluacion
    de la funcion objetivo en la mejor solucion encontrada,
    el valor de la funcion objetivo, el constructor, funciones que
    permiten guardar el horario encontrado en una base de datos, metodos que
    consisten en los operadores geneticos aplicados sobre la poblacion, como
    son cruce, mutacion, etc., ModeloHorario al que se aplica el algoritmo
    evolutivo, metodo que permite ejecutar el algoritmo evolutivo, Eventos que
    se disparan cada cierto numero de generaciones y cuando mejora la solucion.
    }

  { TEvolElitista }

  TEvolElitista = class
  private
    function GetFileName: string;
    function GetSyncFileName: string;
  private
    FModeloHorario: TModeloHorario;
    FSyncDirectory: string;
    FSemilla1, FSemilla2, FSemilla3, FSemilla4, FTamPoblacion, FNumGeneracion,
      FNumMaxGeneracion, FNumImportacion, FNumExportacion, FNumColision,
      FRangoPolinizacion, FOrdenMutacion1: Longint;
    FProbCruzamiento, FProbMutacion1, FProbMutacion2, FProbReparacion: Double;
    FPoblacion, FNuevaPoblacion: TTimeTableArray;
    FValorArray, FAptitudArray, FNuevoValorArray, FNuevoAptitudArray,
      FRAptitudArray, FCAptitudArray: TDynamicDoubleArray;
    FSesionCortadaArray, FNuevoSesionCortadaArray, FCruceProfesorArray,
      FNuevoCruceProfesorArray, FCruceAulaTipoArray,
      FNuevoCruceAulaTipoArray: TDynamicLongintArray;
    FHorariosPrefijados: TDynamicLongintArray;
    FOnRegistrarMejor: TNotifyEvent;
    procedure DoParallelGetValor(Index: PtrInt; Data: Pointer;
      Item: TMultiThreadProcItem);
    procedure Inicializar;
    procedure Evaluar;
    procedure TomarElMejor;
    procedure Elitista;
    procedure Seleccionar;
    procedure Cruzar;
    procedure Mutar;
    procedure Polinizar;
    procedure CruzarIndividuosInterno(Uno, Dos: Integer);
    function GetMejorValor: Double;
    function GetPromedioValor: Double;
    function GetMejorHoraHuecaDesubicada: Integer;
    function GetMejorCruceProfesor: Integer;
    function GetMejorProfesorFraccionamiento: Double;
    function GetMejorCruceAulaTipo: Integer;
    function GetMejorSesionCortada: Integer;
    function GetMejorProfesorProhibicionValor: Double;
    function GetMejorMateriaProhibicionValor: Double;
    function GetMejorHoraHuecaDesubicadaValor: Double;
    function GetMejorCruceProfesorValor: Double;
    function GetMejorProfesorFraccionamientoValor: Double;
    function GetMejorSesionCortadaValor: Double;
    function GetMejorCruceAulaTipoValor: Double;
    function GetMejorProfesorProhibicion: Integer;
    function GetMejorMateriaProhibicion: Integer;
    function GetMejorMateriaNoDispersa: Integer;
    function GetMejorMateriaNoDispersaValor: Double;
    procedure CopiarIndividuo(Destino, Fuente: Integer);
    function GetBestTimeTable: TTimeTable;
  protected
  public
    procedure ReportParameters(AInforme: TStrings);
    constructor CrearDesdeModelo(AModeloHorario: TModeloHorario;
      ATamPoblacion: Longint);
    procedure PrefijarHorarios(const Horarios: string);
    procedure InvalidarValores;
    procedure Actualizar;
    procedure Configurar(ATamPoblacion: Integer);
    destructor Destroy; override;
    procedure SaveBestToDatabase(CodHorario: Integer; MomentoInicial,
      MomentoFinal: TDateTime; Report: TStrings);
    procedure SaveMejorToStream(AStream: TStream);
    procedure Execute(RefreshInterval: Integer);
    procedure DescensoRapidoForzado;
    function DescensoRapido: Boolean;
    procedure Reparar;
    property OnRegistrarMejor
      : TNotifyEvent read FOnRegistrarMejor write FOnRegistrarMejor;
    property NumMaxGeneracion
      : Longint read FNumMaxGeneracion write FNumMaxGeneracion;
    property ProbCruzamiento
      : Double read FProbCruzamiento write FProbCruzamiento;
    property ProbMutacion1: Double read FProbMutacion1 write FProbMutacion1;
    property OrdenMutacion1: Integer read FOrdenMutacion1 write FOrdenMutacion1;
    property ProbMutacion2: Double read FProbMutacion2 write FProbMutacion2;
    property ProbReparacion: Double read FProbReparacion write FProbReparacion;
    property MejorValor: Double read GetMejorValor;
    property MejorCruceProfesor: Integer read GetMejorCruceProfesor;
    property MejorProfesorFraccionamiento
      : Double read GetMejorProfesorFraccionamiento;
    property MejorCruceAulaTipo: Integer read GetMejorCruceAulaTipo;
    property MejorHoraHuecaDesubicada: Integer read GetMejorHoraHuecaDesubicada;
    property MejorSesionCortada: Integer read GetMejorSesionCortada;
    property MejorMateriaProhibicion: Integer read GetMejorMateriaProhibicion;
    property MejorProfesorProhibicion: Integer read GetMejorProfesorProhibicion;
    property NumImportacion: Integer read FNumImportacion;
    property NumExportacion: Integer read FNumExportacion;
    property NumColision: Integer read FNumColision;
    property MejorMateriaProhibicionValor
      : Double read GetMejorMateriaProhibicionValor;
    property MejorDisponiblidadValor: Double read
      GetMejorProfesorProhibicionValor;
    property MejorCruceProfesorValor: Double read GetMejorCruceProfesorValor;
    property MejorProfesorFraccionamientoValor
      : Double read GetMejorProfesorFraccionamientoValor;
    property MejorCruceAulaTipoValor: Double read GetMejorCruceAulaTipoValor;
    property MejorMateriaNoDispersaValor
      : Double read GetMejorMateriaNoDispersaValor;
    property MejorMateriaNoDispersa: Integer read GetMejorMateriaNoDispersa;
    property MejorHoraHuecaDesubicadaValor
      : Double read GetMejorHoraHuecaDesubicadaValor;
    property MejorSesionCortadaValor: Double read GetMejorSesionCortadaValor;
    property PromedioValor: Double read GetPromedioValor;
    property BestTimeTable
      : TTimeTable read GetBestTimeTable;
    property ModeloHorario: TModeloHorario read FModeloHorario;
    property SyncDirectory: string read FSyncDirectory write FSyncDirectory;
    property FileName: string read GetFileName;
    property SyncFileName: string read GetSyncFileName;
    property RangoPolinizacion
      : Integer read FRangoPolinizacion write FRangoPolinizacion;
  end;

implementation

uses
  Rand, HorColCm;

procedure TEvolElitista.Configurar(ATamPoblacion: Longint);
var
  i: Integer;
begin
  FTamPoblacion := ATamPoblacion;
  SetLength(FPoblacion, FTamPoblacion + 4);
  SetLength(FNuevaPoblacion, Length(FPoblacion));
  SetLength(FValorArray, Length(FPoblacion));
  SetLength(FNuevoValorArray, Length(FPoblacion));
  SetLength(FSesionCortadaArray, Length(FPoblacion));
  SetLength(FNuevoSesionCortadaArray, Length(FPoblacion));
  SetLength(FCruceProfesorArray, Length(FPoblacion));
  SetLength(FNuevoCruceProfesorArray, Length(FPoblacion));
  SetLength(FCruceAulaTipoArray, Length(FPoblacion));
  SetLength(FNuevoCruceAulaTipoArray, Length(FPoblacion));
  SetLength(FAptitudArray, Length(FPoblacion));
  SetLength(FNuevoAptitudArray, Length(FPoblacion));
  SetLength(FRAptitudArray, Length(FPoblacion));
  SetLength(FCAptitudArray, Length(FPoblacion));
  for i := 0 to High(FPoblacion) do
  begin
    if not Assigned(FNuevaPoblacion[i]) then
      FNuevaPoblacion[i] := TTimeTable.CrearDesdeModelo
        (FModeloHorario);
  end;
end;

constructor TEvolElitista.CrearDesdeModelo(AModeloHorario: TModeloHorario;
  ATamPoblacion: Longint);
begin
  inherited Create;
  FModeloHorario := AModeloHorario;
  Configurar(ATamPoblacion);
end;

destructor TEvolElitista.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].Free;
    FNuevaPoblacion[i].Free;
  end;
  FModeloHorario := nil;
  inherited Destroy;
end;

procedure TEvolElitista.Inicializar;
var
  i: Integer;
begin
  for i := 0 to High(FHorariosPrefijados) do
    CargarPrefijadoDesdeModelo(FPoblacion[i], FModeloHorario,
      FHorariosPrefijados[i]);
  for i := Length(FHorariosPrefijados) to High(FPoblacion) do
  begin
    CrearAleatorioDesdeModelo(FPoblacion[i], FModeloHorario);
  end;
  for i := Length(FHorariosPrefijados) to FTamPoblacion - 1 do
  begin
    FPoblacion[i].DescensoRapido;
  end;
end;

procedure TEvolElitista.Reparar;
var
  i: Integer;
begin
  for i := 0 to FTamPoblacion - 1 do
  begin
    if randl < FProbReparacion then
    begin
      FPoblacion[i].DescensoRapido;
    end;
  end;
end;

procedure TEvolElitista.InvalidarValores;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].InvalidarValor;
  end;
end;

procedure TEvolElitista.Actualizar;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].Actualizar;
  end;
end;

procedure TEvolElitista.DoParallelGetValor(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
begin
  FValorArray[Index] := FPoblacion[Index].Valor;
  FSesionCortadaArray[Index] := FPoblacion[Index].SesionCortada;
  FCruceProfesorArray[Index] := FPoblacion[Index].CruceProfesor;
  FCruceAulaTipoArray[Index] := FPoblacion[Index].CruceAulaTipo;
end;

procedure TEvolElitista.Evaluar;
var
  i: Integer;
  d, VMinValue, VMaxValue: Double;
begin
  VMinValue := 1.7E308;
  VMaxValue := -1.7E308;
  ProcThreadPool.DoParallel(DoParallelGetValor, 0, High(FPoblacion), nil);
  for i := 0 to High(FPoblacion) do
  begin
    // DoParallelGetValor(i, nil, nil);
    d := FValorArray[i];
    if VMinValue > d then
      VMinValue := d;
    if VMaxValue < d then
      VMaxValue := d;
  end;
  for i := 0 to High(FPoblacion) do
  begin
    FAptitudArray[i] := 1 + VMaxValue - FValorArray[i];
  end;
end;

procedure TEvolElitista.TomarElMejor;
var
  i, iMejor, iMejorSesionCortada, iMejorCruceProfesor,
    iMejorCruceAulaTipo: Integer;
begin
  iMejor := 0;
  iMejorSesionCortada := 0;
  iMejorCruceProfesor := 0;
  iMejorCruceAulaTipo := 0;
  for i := 0 to FTamPoblacion - 1 do
  begin
    if FValorArray[i] < FValorArray[iMejor] then
    begin
      iMejor := i;
    end;
    if (FSesionCortadaArray[i] < FSesionCortadaArray[iMejorSesionCortada]) or
      ((FSesionCortadaArray[i] = FSesionCortadaArray[iMejorSesionCortada]) and
        (FValorArray[i] < FValorArray[iMejorSesionCortada])) then
    begin
      iMejorSesionCortada := i;
    end;
    if (FCruceProfesorArray[i] < FCruceProfesorArray[iMejorCruceProfesor]) or
      ((FCruceProfesorArray[i] = FCruceProfesorArray[iMejorCruceProfesor]) and
        (FValorArray[i] < FValorArray[iMejorCruceProfesor])) then
    begin
      iMejorCruceProfesor := i;
    end;
    if (FCruceAulaTipoArray[i] < FCruceAulaTipoArray[iMejorCruceAulaTipo]) or
      ((FCruceAulaTipoArray[i] = FCruceAulaTipoArray[iMejorCruceAulaTipo]) and
        (FValorArray[i] < FValorArray[iMejorCruceAulaTipo])) then
    begin
      iMejorCruceAulaTipo := i;
    end
  end;
  CopiarIndividuo(FTamPoblacion, iMejor);
  CopiarIndividuo(FTamPoblacion + 1, iMejorSesionCortada);
  CopiarIndividuo(FTamPoblacion + 2, iMejorCruceProfesor);
  CopiarIndividuo(FTamPoblacion + 3, iMejorCruceAulaTipo);
end;

procedure TEvolElitista.CopiarIndividuo(Destino, Fuente: Integer);
begin
  FPoblacion[Destino].Assign(FPoblacion[Fuente]);
  FAptitudArray[Destino] := FAptitudArray[Fuente];
  FValorArray[Destino] := FValorArray[Fuente];
  FSesionCortadaArray[Destino] := FSesionCortadaArray[Fuente];
  FCruceProfesorArray[Destino] := FCruceProfesorArray[Fuente];
  FCruceAulaTipoArray[Destino] := FCruceAulaTipoArray[Fuente];
end;

procedure TEvolElitista.Elitista;
var
  VMejorValor, VWorstValue: Double;
  i, iMejor, iWorst, iMejorSesionCortada, iMejorCruceProfesor,
    iMejorCruceAulaTipo: Longint;
  // AStream: TStream;
  FindMejor: Boolean;
begin
  VMejorValor := FValorArray[0];
  VWorstValue := VMejorValor;
  iMejor := 0;
  iWorst := 0;
  iMejorSesionCortada := FTamPoblacion + 1;
  iMejorCruceProfesor := FTamPoblacion + 2;
  iMejorCruceAulaTipo := FTamPoblacion + 3;
  for i := 0 to FTamPoblacion - 1 do
  begin
    if (FSesionCortadaArray[i] < FSesionCortadaArray[iMejorSesionCortada]) or
      ((FSesionCortadaArray[i] = FSesionCortadaArray[iMejorSesionCortada]) and
        (FValorArray[i] <= FValorArray[iMejorSesionCortada])) then
    begin
      iMejorSesionCortada := i;
    end;
    if (FCruceProfesorArray[i] < FCruceProfesorArray[iMejorCruceProfesor]) or
      ((FCruceProfesorArray[i] = FCruceProfesorArray[iMejorCruceProfesor]) and
        (FValorArray[i] <= FValorArray[iMejorCruceProfesor])) then
    begin
      iMejorCruceProfesor := i;
    end;
    if (FCruceAulaTipoArray[i] < FCruceAulaTipoArray[iMejorCruceAulaTipo]) or
      ((FCruceAulaTipoArray[i] = FCruceAulaTipoArray[iMejorCruceAulaTipo]) and
        (FValorArray[i] <= FValorArray[iMejorCruceAulaTipo])) then
    begin
      iMejorCruceAulaTipo := i;
    end;
    if FValorArray[i] <= VMejorValor then
    begin
      VMejorValor := FValorArray[i];
      iMejor := i;
    end;
    if FValorArray[i] >= VWorstValue then
    begin
      VWorstValue := FValorArray[i];
      iWorst := i;
    end;
  end;
  if iMejorSesionCortada <> FTamPoblacion + 1 then
  begin
    CopiarIndividuo(FTamPoblacion + 1, iMejorSesionCortada);
  end;
  if iMejorCruceProfesor <> FTamPoblacion + 2 then
  begin
    CopiarIndividuo(FTamPoblacion + 2, iMejorCruceProfesor);
  end;
  if iMejorCruceAulaTipo <> FTamPoblacion + 3 then
  begin
    CopiarIndividuo(FTamPoblacion + 3, iMejorCruceAulaTipo);
  end;
  if VMejorValor <= FValorArray[FTamPoblacion] then
  begin
    FindMejor := VMejorValor < FValorArray[FTamPoblacion];
    CopiarIndividuo(FTamPoblacion, iMejor);
    if FindMejor and Assigned(OnRegistrarMejor) then
      OnRegistrarMejor(Self);
  end
  else
  begin
    CopiarIndividuo(iWorst, FTamPoblacion + crand32 mod 4);
  end;
end;

procedure TEvolElitista.Polinizar;
  procedure ExportarInterno;
  var
    Stream: TStream;
  begin
    Stream := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
    try
      SaveMejorToStream(Stream);
      Inc(FNumExportacion);
    finally
      Stream.Free;
    end;
  end;
  procedure Importar;
  var
    Stream: TStream;
  begin
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      FPoblacion[FTamPoblacion].LoadFromStream(Stream);
      Inc(FNumImportacion);
    finally
      Stream.Free;
    end;
  end;
  procedure Exportar;
  var
    SyncStream: TStream;
  begin
    SyncStream := TFileStream.Create
      (SyncFileName, fmCreate or fmShareExclusive);
    try
      SyncStream.write(FValorArray[FTamPoblacion], SizeOf(Double));
      ExportarInterno;
    finally
      SyncStream.Free;
    end;
  end;
var
  SyncStream: TStream;
  dValor: Double;
begin
  try
    if FileExists(SyncFileName) then
    begin
      SyncStream := TFileStream.Create
        (SyncFileName, fmOpenRead or fmShareDenyWrite);
      try
        SyncStream.read(dValor, SizeOf(Double));
      finally
        SyncStream.Free;
      end;
      if dValor < FValorArray[FTamPoblacion] then
        Importar
      else if dValor > FValorArray[FTamPoblacion] then
        Exportar;
    end
    else
    begin
      Exportar;
    end;
  except
    Inc(FNumColision);
  end;
end;

procedure TEvolElitista.Seleccionar;
var
  mem, i, j: Longint;
  sum: Double;
  p: Extended;
  VTmpPoblacion: TTimeTableArray;
  VTmpAptitudArray, VTmpValorArray: TDynamicDoubleArray;
  VTmpSesionCortadaArray, VTmpCruceProfesorArray,
    VTmpCruceAulaTipoArray: TDynamicLongintArray;
begin
  sum := 0;
  for mem := 0 to FTamPoblacion - 1 do
  begin
    sum := sum + FAptitudArray[mem];
  end;
  for mem := 0 to FTamPoblacion - 1 do
  begin
    FRAptitudArray[mem] := FAptitudArray[mem] / sum;
  end;
  FCAptitudArray[0] := FRAptitudArray[0];
  for mem := 1 to FTamPoblacion - 1 do
  begin
    FCAptitudArray[mem] := FCAptitudArray[mem - 1] + FRAptitudArray[mem];
  end;
  for i := 0 to FTamPoblacion - 1 do
  begin
    p := randl;
    if p < FCAptitudArray[0] then
    begin
      FNuevaPoblacion[i].Assign(FPoblacion[0]);
      FNuevoAptitudArray[i] := FAptitudArray[0];
      FNuevoValorArray[i] := FValorArray[0];
      FNuevoSesionCortadaArray[i] := FSesionCortadaArray[0];
      FNuevoCruceProfesorArray[i] := FCruceProfesorArray[0];
      FNuevoCruceAulaTipoArray[i] := FCruceAulaTipoArray[0];
    end
    else
    begin
      for j := 0 to FTamPoblacion - 1 do
        if (p >= FCAptitudArray[j]) and (p < FCAptitudArray[j + 1]) then
        begin
          FNuevaPoblacion[i].Assign(FPoblacion[j + 1]);
          FNuevoAptitudArray[i] := FAptitudArray[j + 1];
          FNuevoValorArray[i] := FValorArray[j + 1];
          FNuevoSesionCortadaArray[i] := FSesionCortadaArray[j + 1];
          FNuevoCruceProfesorArray[i] := FCruceProfesorArray[j + 1];
          FNuevoCruceAulaTipoArray[i] := FCruceAulaTipoArray[j + 1];
        end;
    end;
  end;
  VTmpPoblacion := FPoblacion;
  FPoblacion := FNuevaPoblacion;
  FNuevaPoblacion := VTmpPoblacion;

  VTmpAptitudArray := FAptitudArray;
  FAptitudArray := FNuevoAptitudArray;
  FNuevoAptitudArray := VTmpAptitudArray;

  VTmpValorArray := FValorArray;
  FValorArray := FNuevoValorArray;
  FNuevoValorArray := VTmpValorArray;

  VTmpSesionCortadaArray := FSesionCortadaArray;
  FSesionCortadaArray := FNuevoSesionCortadaArray;
  FNuevoSesionCortadaArray := VTmpSesionCortadaArray;

  VTmpCruceProfesorArray := FCruceProfesorArray;
  FCruceProfesorArray := FNuevoCruceProfesorArray;
  FNuevoCruceProfesorArray := VTmpCruceProfesorArray;

  VTmpCruceAulaTipoArray := FCruceAulaTipoArray;
  FCruceAulaTipoArray := FNuevoCruceAulaTipoArray;
  FNuevoCruceAulaTipoArray := VTmpCruceAulaTipoArray;

  for i := FTamPoblacion to High(FPoblacion) do
  begin
    FPoblacion[i].Assign(FNuevaPoblacion[i]);
    FAptitudArray[i] := FNuevoAptitudArray[i];
    FValorArray[i] := FNuevoValorArray[i];
    FSesionCortadaArray[i] := FNuevoSesionCortadaArray[i];
    FCruceProfesorArray[i] := FNuevoCruceProfesorArray[i];
    FCruceAulaTipoArray[i] := FNuevoCruceAulaTipoArray[i];
  end;
end;

procedure TEvolElitista.Cruzar;
var
  mem, one, First: Longint;
  x: Double;
begin
  First := 0;
  one := 0;
  for mem := 0 to FTamPoblacion - 1 do
  begin
    x := randl;
    if x < FProbCruzamiento then
    begin
      Inc(First);
      if First mod 2 = 0 then
        CruzarIndividuosInterno(one, mem)
      else
        one := mem;
    end;
  end;
end;

procedure TEvolElitista.CruzarIndividuosInterno(Uno, Dos: Integer);
begin
  CruzarIndividuos(FPoblacion[Uno], FPoblacion[Dos]);
end;

procedure TEvolElitista.Mutar;
var
  i: Integer;
begin
  for i := 0 to FTamPoblacion - 1 do
  begin
    if randl < FProbMutacion1 then
      FPoblacion[i].Mutar(FOrdenMutacion1);
    if randl < FProbMutacion2 then
      FPoblacion[i].MutarDia;
  end;
end;

procedure TEvolElitista.Execute(RefreshInterval: Integer);
var
  Stop: Boolean;
  NumGeneracion: Integer;
begin
  getseeds(FSemilla1, FSemilla2, FSemilla3, FSemilla4);
  Inicializar;
  Evaluar;
  TomarElMejor;
  FNumGeneracion := 0;
  FNumImportacion := 0;
  FNumExportacion := 0;
  FNumColision := 0;
  Stop := False;
  NumGeneracion := 0;
  while (NumGeneracion < FNumMaxGeneracion) and not Stop do
  begin
    FModeloHorario.DoProgress(NumGeneracion, RefreshInterval, BestTimeTable, Stop);
    Seleccionar;
    Cruzar;
    Mutar;
    Reparar;
    if ((NumGeneracion mod FRangoPolinizacion) = 0)
       and (FSyncDirectory <> '') then
      Polinizar;
    Evaluar;
    Elitista;
    Inc(NumGeneracion);
  end;
  if Stop then FNumMaxGeneracion := NumGeneracion; // Preserve the maximum in case of cancel
end;

procedure TEvolElitista.DescensoRapidoForzado;
begin
  FPoblacion[FTamPoblacion].DescensoRapidoForzado;
  if Assigned(OnRegistrarMejor) then
    OnRegistrarMejor(Self);
end;

function TEvolElitista.DescensoRapido: Boolean;
begin
  Result := FPoblacion[FTamPoblacion].DescensoRapido;
end;

procedure TEvolElitista.SaveBestToDatabase(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Report: TStrings);
begin
  BestTimeTable.SaveToDataModule(CodHorario, MomentoInicial, MomentoFinal, Report);
end;

procedure TEvolElitista.SaveMejorToStream(AStream: TStream);
begin
  BestTimeTable.SaveToStream(AStream);
end;

function TEvolElitista.GetPromedioValor: Double;
var
  i: Integer;
  sum: Double;
begin
  sum := 0;
  for i := 0 to FTamPoblacion - 1 do
  begin
    sum := sum + FValorArray[i];
  end;
  Result := sum / FTamPoblacion;
end;

function TEvolElitista.GetBestTimeTable: TTimeTable;
begin
  Result := FPoblacion[FTamPoblacion];
end;

function TEvolElitista.GetMejorValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].Valor;
end;

function TEvolElitista.GetMejorCruceProfesor: Integer;
begin
  Result := FPoblacion[FTamPoblacion].CruceProfesor;
end;

function TEvolElitista.GetMejorProfesorFraccionamiento: Double;
begin
  Result := FPoblacion[FTamPoblacion].ProfesorFraccionamiento;
end;

function TEvolElitista.GetMejorCruceAulaTipo: Integer;
begin
  Result := FPoblacion[FTamPoblacion].CruceAulaTipo;
end;

function TEvolElitista.GetMejorHoraHuecaDesubicada: Integer;
begin
  Result := FPoblacion[FTamPoblacion].HoraHuecaDesubicada;
end;

function TEvolElitista.GetMejorSesionCortada: Integer;
begin
  Result := FPoblacion[FTamPoblacion].SesionCortada;
end;

function TEvolElitista.GetMejorMateriaProhibicion: Integer;
begin
  Result := FPoblacion[FTamPoblacion].MateriaProhibicion;
end;

function TEvolElitista.GetMejorProfesorProhibicion: Integer;
begin
  Result := FPoblacion[FTamPoblacion].ProfesorProhibicion;
end;

function TEvolElitista.GetMejorMateriaNoDispersa: Integer;
begin
  Result := FPoblacion[FTamPoblacion].MateriaNoDispersa;
end;

function TEvolElitista.GetMejorCruceProfesorValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].CruceProfesorValor;
end;

function TEvolElitista.GetMejorProfesorFraccionamientoValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].ProfesorFraccionamientoValor;
end;

function TEvolElitista.GetMejorCruceAulaTipoValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].CruceAulaTipoValor;
end;

function TEvolElitista.GetMejorHoraHuecaDesubicadaValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].HoraHuecaDesubicadaValor;
end;

function TEvolElitista.GetMejorSesionCortadaValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].SesionCortadaValor;
end;

function TEvolElitista.GetMejorMateriaProhibicionValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].MateriaProhibicionValor;
end;

function TEvolElitista.GetMejorMateriaNoDispersaValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].MateriaNoDispersaValor;
end;

function TEvolElitista.GetMejorProfesorProhibicionValor: Double;
begin
  Result := FPoblacion[FTamPoblacion].ProfesorProhibicionValor;
end;

procedure TEvolElitista.ReportParameters(AInforme: TStrings);
begin
  with AInforme do
  begin
    Add('Semillas del generador de numeros aleatorios:');
    Add(Format('  %d, %d, %d, %d', [FSemilla1, FSemilla2, FSemilla3, FSemilla4]));
    Add(Format('Numero de individuos:       %5.d', [FTamPoblacion]));
    Add(Format('Maximo de generaciones:     %5.d', [FNumMaxGeneracion]));
    Add(Format('Probabilidad de cruce:      %1.3f', [FProbCruzamiento]));
    Add(Format('Probabilidad de Mutacion 1: %1.3f', [FProbMutacion1]));
    Add(Format('Orden de la Mutacion 1:     %5.d', [FOrdenMutacion1]));
    Add(Format('Probabilidad de Mutacion 1: %1.3f', [FProbMutacion2]));
    Add(Format('Probabilidad de Reparacion: %1.3f', [FProbReparacion]));
    Add(Format('Rango de polinizacion:      %5.d', [FRangoPolinizacion]));
  end;
end;

procedure TEvolElitista.PrefijarHorarios(const Horarios: string);
var
  iPos, j: Integer;
begin
  SetLength(FHorariosPrefijados, Length(Horarios));
  iPos := 1;
  j := 0;
  while iPos <= Length(Horarios) do
  begin
    FHorariosPrefijados[j] := StrToInt(ExtractString(Horarios, iPos, ','));
    Inc(j);
  end;
  SetLength(FHorariosPrefijados, j);
end;

function TEvolElitista.GetFileName: string;
begin
  Result := FSyncDirectory + '\horario.dat';
end;

function TEvolElitista.GetSyncFileName: string;
begin
  Result := FSyncDirectory + '\syncron.dat';
end;

end.
