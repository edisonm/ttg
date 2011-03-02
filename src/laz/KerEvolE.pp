unit KerEvolE;
{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}cthreads, cmem, {$ENDIF}MTProcs, Classes, SysUtils, DB, Dialogs,
  KerModel;

type
  TTimeTableArray = array of TTimeTable;

  {
    Clase TEvolElitist
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
    son cruce, mutacion, etc., TimeTableModel al que se aplica el algoritmo
    evolutivo, metodo que permite ejecutar el algoritmo evolutivo, Eventos que
    se disparan cada cierto numero de generaciones y cuando mejora la solucion.
    }

  { TEvolElitist }

  TEvolElitist = class
  private
    function GetFileName: string;
    function GetSyncFileName: string;
  private
    FTimeTableModel: TTimeTableModel;
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
    FFixedTimeTables: TDynamicLongintArray;
    FOnRecordBest: TNotifyEvent;
    procedure DoParallelGetValue(Index: PtrInt; Data: Pointer;
      Item: TMultiThreadProcItem);
    procedure Initialize;
    procedure Evaluate;
    procedure SelectTheBest;
    procedure Elitista;
    procedure Select;
    procedure Cross;
    procedure Mutate;
    procedure Pollinate;
    procedure InternalCrossIndividuals(Uno, Dos: Integer);
    function GetAverageValue: Double;
    procedure CopyIndividual(Target, Source: Integer);
    function GetBestTimeTable: TTimeTable;
  protected
  public
    procedure ReportParameters(AInforme: TStrings);
    constructor CreateFromModel(ATimeTableModel: TTimeTableModel;
      ATamPoblacion: Longint);
    procedure PrefijarHorarios(const Horarios: string);
    {procedure InvalidarValores;}
    procedure Update;
    procedure Configure(ATamPoblacion: Integer);
    destructor Destroy; override;
    procedure SaveBestToDatabase(CodHorario: Integer; MomentoInicial,
      MomentoFinal: TDateTime; Report: TStrings);
    procedure SaveBestToStream(AStream: TStream);
    procedure Execute(RefreshInterval: Integer);
    procedure ForcedDownHill;
    function DownHill: Boolean;
    procedure Repair;
    property OnRecordBest: TNotifyEvent read FOnRecordBest write FOnRecordBest;
    property NumMaxGeneracion
      : Longint read FNumMaxGeneracion write FNumMaxGeneracion;
    property ProbCruzamiento
      : Double read FProbCruzamiento write FProbCruzamiento;
    property ProbMutacion1: Double read FProbMutacion1 write FProbMutacion1;
    property OrdenMutacion1: Integer read FOrdenMutacion1 write FOrdenMutacion1;
    property ProbMutacion2: Double read FProbMutacion2 write FProbMutacion2;
    property ProbReparacion: Double read FProbReparacion write FProbReparacion;
    property NumImportacion: Integer read FNumImportacion;
    property NumExportacion: Integer read FNumExportacion;
    property NumColision: Integer read FNumColision;
    property AverageValue: Double read GetAverageValue;
    property BestTimeTable: TTimeTable read GetBestTimeTable;
    property TimeTableModel: TTimeTableModel read FTimeTableModel;
    property SyncDirectory: string read FSyncDirectory write FSyncDirectory;
    property FileName: string read GetFileName;
    property SyncFileName: string read GetSyncFileName;
    property RangoPolinizacion
      : Integer read FRangoPolinizacion write FRangoPolinizacion;
  end;

implementation

uses
  Rand, HorColCm;

procedure TEvolElitist.Configure(ATamPoblacion: Longint);
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
      FNuevaPoblacion[i] := TTimeTable.CreateFromModel
        (FTimeTableModel);
  end;
end;

constructor TEvolElitist.CreateFromModel(ATimeTableModel: TTimeTableModel;
  ATamPoblacion: Longint);
begin
  inherited Create;
  FTimeTableModel := ATimeTableModel;
  Configure(ATamPoblacion);
end;

destructor TEvolElitist.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].Free;
    FNuevaPoblacion[i].Free;
  end;
  FTimeTableModel := nil;
  inherited Destroy;
end;

procedure TEvolElitist.Initialize;
var
  i: Integer;
begin
  for i := 0 to High(FFixedTimeTables) do
    CargarPrefijadoDesdeModelo(FPoblacion[i], FTimeTableModel,
      FFixedTimeTables[i]);
  for i := Length(FFixedTimeTables) to High(FPoblacion) do
  begin
    CrearAleatorioDesdeModelo(FPoblacion[i], FTimeTableModel);
  end;
  for i := Length(FFixedTimeTables) to FTamPoblacion - 1 do
  begin
    FPoblacion[i].DownHill;
  end;
end;

procedure TEvolElitist.Repair;
var
  i: Integer;
begin
  for i := 0 to FTamPoblacion - 1 do
  begin
    if randl < FProbReparacion then
    begin
      FPoblacion[i].DownHill;
    end;
  end;
end;

{
procedure TEvolElitist.InvalidarValores;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].InvalidarValor;
  end;
end;
}

procedure TEvolElitist.Update;
var
  i: Integer;
begin
  for i := 0 to High(FPoblacion) do
  begin
    FPoblacion[i].Update;
  end;
end;

procedure TEvolElitist.DoParallelGetValue(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
begin
  FPoblacion[Index].UpdateValue;
  FValorArray[Index] := FPoblacion[Index].Value;
  FSesionCortadaArray[Index] := FPoblacion[Index].SesionCortada;
  FCruceProfesorArray[Index] := FPoblacion[Index].CruceProfesor;
  FCruceAulaTipoArray[Index] := FPoblacion[Index].CruceAulaTipo;
end;

procedure TEvolElitist.Evaluate;
var
  i: Integer;
  d, VMinValue, VMaxValue: Double;
begin
  VMinValue := 1.7E308;
  VMaxValue := -1.7E308;
  //ProcThreadPool.DoParallel(DoParallelGetValue, 0, High(FPoblacion), nil);
  for i := 0 to High(FPoblacion) do
  begin
    DoParallelGetValue(i, nil, nil);
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

procedure TEvolElitist.SelectTheBest;
var
  i, Best, BestSesionCortada, BestCruceProfesor,
    BestCruceAulaTipo: Integer;
begin
  Best := 0;
  BestSesionCortada := 0;
  BestCruceProfesor := 0;
  BestCruceAulaTipo := 0;
  for i := 0 to FTamPoblacion - 1 do
  begin
    if FValorArray[i] < FValorArray[Best] then
    begin
      Best := i;
    end;
    if (FSesionCortadaArray[i] < FSesionCortadaArray[BestSesionCortada]) or
      ((FSesionCortadaArray[i] = FSesionCortadaArray[BestSesionCortada]) and
        (FValorArray[i] < FValorArray[BestSesionCortada])) then
    begin
      BestSesionCortada := i;
    end;
    if (FCruceProfesorArray[i] < FCruceProfesorArray[BestCruceProfesor]) or
      ((FCruceProfesorArray[i] = FCruceProfesorArray[BestCruceProfesor]) and
        (FValorArray[i] < FValorArray[BestCruceProfesor])) then
    begin
      BestCruceProfesor := i;
    end;
    if (FCruceAulaTipoArray[i] < FCruceAulaTipoArray[BestCruceAulaTipo]) or
      ((FCruceAulaTipoArray[i] = FCruceAulaTipoArray[BestCruceAulaTipo]) and
        (FValorArray[i] < FValorArray[BestCruceAulaTipo])) then
    begin
      BestCruceAulaTipo := i;
    end
  end;
  CopyIndividual(FTamPoblacion, Best);
  CopyIndividual(FTamPoblacion + 1, BestSesionCortada);
  CopyIndividual(FTamPoblacion + 2, BestCruceProfesor);
  CopyIndividual(FTamPoblacion + 3, BestCruceAulaTipo);
end;

procedure TEvolElitist.CopyIndividual(Target, Source: Integer);
begin
  FPoblacion[Target].Assign(FPoblacion[Source]);
  FAptitudArray[Target] := FAptitudArray[Source];
  FValorArray[Target] := FValorArray[Source];
  FSesionCortadaArray[Target] := FSesionCortadaArray[Source];
  FCruceProfesorArray[Target] := FCruceProfesorArray[Source];
  FCruceAulaTipoArray[Target] := FCruceAulaTipoArray[Source];
end;

procedure TEvolElitist.Elitista;
var
  BestValue, WorstValue: Double;
  i, Best, Worst, BestSesionCortada, BestCruceProfesor,
    BestCruceAulaTipo: Longint;
  // AStream: TStream;
  FindMejor: Boolean;
begin
  BestValue := FValorArray[0];
  WorstValue := BestValue;
  Best := 0;
  Worst := 0;
  BestSesionCortada := FTamPoblacion + 1;
  BestCruceProfesor := FTamPoblacion + 2;
  BestCruceAulaTipo := FTamPoblacion + 3;
  for i := 0 to FTamPoblacion - 1 do
  begin
    if (FSesionCortadaArray[i] < FSesionCortadaArray[BestSesionCortada]) or
      ((FSesionCortadaArray[i] = FSesionCortadaArray[BestSesionCortada]) and
        (FValorArray[i] <= FValorArray[BestSesionCortada])) then
    begin
      BestSesionCortada := i;
    end;
    if (FCruceProfesorArray[i] < FCruceProfesorArray[BestCruceProfesor]) or
      ((FCruceProfesorArray[i] = FCruceProfesorArray[BestCruceProfesor]) and
        (FValorArray[i] <= FValorArray[BestCruceProfesor])) then
    begin
      BestCruceProfesor := i;
    end;
    if (FCruceAulaTipoArray[i] < FCruceAulaTipoArray[BestCruceAulaTipo]) or
      ((FCruceAulaTipoArray[i] = FCruceAulaTipoArray[BestCruceAulaTipo]) and
        (FValorArray[i] <= FValorArray[BestCruceAulaTipo])) then
    begin
      BestCruceAulaTipo := i;
    end;
    if FValorArray[i] <= BestValue then
    begin
      BestValue := FValorArray[i];
      Best := i;
    end;
    if FValorArray[i] >= WorstValue then
    begin
      WorstValue := FValorArray[i];
      Worst := i;
    end;
  end;
  if BestSesionCortada <> FTamPoblacion + 1 then
  begin
    CopyIndividual(FTamPoblacion + 1, BestSesionCortada);
  end;
  if BestCruceProfesor <> FTamPoblacion + 2 then
  begin
    CopyIndividual(FTamPoblacion + 2, BestCruceProfesor);
  end;
  if BestCruceAulaTipo <> FTamPoblacion + 3 then
  begin
    CopyIndividual(FTamPoblacion + 3, BestCruceAulaTipo);
  end;
  if BestValue <= FValorArray[FTamPoblacion] then
  begin
    FindMejor := BestValue < FValorArray[FTamPoblacion];
    CopyIndividual(FTamPoblacion, Best);
    if FindMejor and Assigned(OnRecordBest) then
      OnRecordBest(Self);
  end
  else
  begin
    CopyIndividual(Worst, FTamPoblacion + crand32 mod 4);
  end;
end;

procedure TEvolElitist.Pollinate;
  procedure ExportarInterno;
  var
    Stream: TStream;
  begin
    Stream := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
    try
      SaveBestToStream(Stream);
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

procedure TEvolElitist.Select;
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

procedure TEvolElitist.Cross;
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
        InternalCrossIndividuals(one, mem)
      else
        one := mem;
    end;
  end;
end;

procedure TEvolElitist.InternalCrossIndividuals(Uno, Dos: Integer);
begin
  CruzarIndividuos(FPoblacion[Uno], FPoblacion[Dos]);
end;

procedure TEvolElitist.Mutate;
var
  i: Integer;
begin
  for i := 0 to FTamPoblacion - 1 do
  begin
    if randl < FProbMutacion1 then
      FPoblacion[i].Mutate(FOrdenMutacion1);
    if randl < FProbMutacion2 then
      FPoblacion[i].MutateDia;
  end;
end;

procedure TEvolElitist.Execute(RefreshInterval: Integer);
var
  Stop: Boolean;
  NumGeneracion: Integer;
begin
  getseeds(FSemilla1, FSemilla2, FSemilla3, FSemilla4);
  Initialize;
  Evaluate;
  SelectTheBest;
  FNumGeneracion := 0;
  FNumImportacion := 0;
  FNumExportacion := 0;
  FNumColision := 0;
  Stop := False;
  NumGeneracion := 0;
  while (NumGeneracion < FNumMaxGeneracion) and not Stop do
  begin
    FTimeTableModel.DoProgress(NumGeneracion, RefreshInterval, BestTimeTable, Stop);
    Select;
    Cross;
    Mutate;
    Repair;
    if ((NumGeneracion mod FRangoPolinizacion) = 0)
       and (FSyncDirectory <> '') then
      Pollinate;
    Evaluate;
    Elitista;
    Inc(NumGeneracion);
  end;
  if Stop then FNumMaxGeneracion := NumGeneracion; // Preserve the maximum in case of cancel
end;

procedure TEvolElitist.ForcedDownHill;
begin
  FPoblacion[FTamPoblacion].DownHillForced;
  if Assigned(OnRecordBest) then
    OnRecordBest(Self);
end;

function TEvolElitist.DownHill: Boolean;
begin
  Result := FPoblacion[FTamPoblacion].DownHill;
end;

procedure TEvolElitist.SaveBestToDatabase(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Report: TStrings);
begin
  BestTimeTable.SaveToDataModule(CodHorario, MomentoInicial, MomentoFinal, Report);
end;

procedure TEvolElitist.SaveBestToStream(AStream: TStream);
begin
  BestTimeTable.SaveToStream(AStream);
end;

function TEvolElitist.GetAverageValue: Double;
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

function TEvolElitist.GetBestTimeTable: TTimeTable;
begin
  Result := FPoblacion[FTamPoblacion];
end;

procedure TEvolElitist.ReportParameters(AInforme: TStrings);
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

procedure TEvolElitist.PrefijarHorarios(const Horarios: string);
var
  iPos, j: Integer;
begin
  SetLength(FFixedTimeTables, Length(Horarios));
  iPos := 1;
  j := 0;
  while iPos <= Length(Horarios) do
  begin
    FFixedTimeTables[j] := StrToInt(ExtractString(Horarios, iPos, ','));
    Inc(j);
  end;
  SetLength(FFixedTimeTables, j);
end;

function TEvolElitist.GetFileName: string;
begin
  Result := FSyncDirectory + '\horario.dat';
end;

function TEvolElitist.GetSyncFileName: string;
begin
  Result := FSyncDirectory + '\syncron.dat';
end;

end.
