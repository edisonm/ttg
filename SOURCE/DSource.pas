unit DSource;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DSrcBase, Db, kbmMemTable, UConfig;

type
  TSourceDataModule = class(TSourceBaseDataModule)
    TbCursoAbrNivel: TStringField;
    TbCursoAbrEspecializacion: TStringField;
    TbProfesorApeNomProfesor: TStringField;
    TbHorarioDetalleNomMateria: TStringField;
    TbProfesorProhibicionNomProfProhibicionTipo: TStringField;
    TbMateriaProhibicionNomMateProhibicionTipo: TStringField;
    TbDistributivoNomMateria: TStringField;
    TbDistributivoDuracion: TIntegerField;
    TbDistributivoApeNomProfesor: TStringField;
    TbDistributivoAbrNivel: TStringField;
    TbDistributivoNomParaleloId: TStringField;
    TbDistributivoAbrEspecializacion: TStringField;
    TbDistributivoAbrAulaTipo: TStringField;
    TbParaleloAbrNivel: TStringField;
    TbParaleloAbrEspecializacion: TStringField;
    TbParaleloNomParaleloId: TStringField;
    TbParaleloCodParalelo: TAutoIncField;
    TbParaleloNomParalelo: TStringField;
    procedure TbProfesorCalcFields(DataSet: TDataSet);
    procedure TbDistributivoBeforePost(DataSet: TDataSet);
    procedure TbDistributivoCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TbParaleloCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FFlags : TkbmMemTableSaveFlags;
    FConfigStorage: TConfigStorage;
    // procedure SaveToFile(const AFileName: TFileName);
    // procedure SaveToStream(AStream: TStream);
    // procedure SaveUnCompToStream(AStream: TStream);
    // procedure LoadFromStream(AStream: TStream);
    // procedure LoadUnCompFromStream(AStream: TStream);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);

    function GetNomColegio: string;
    procedure SetNomColegio(const Value: string);
    function GetAnioLectivo: string;
    procedure SetAnioLectivo(const Value: string);
    function GetNomAutoridad: string;
    procedure SetNomAutoridad(const Value: string);
    function GetCarAutoridad: string;
    procedure SetCarAutoridad(const Value: string);
    function GetNomResponsable: string;
    procedure SetNomResponsable(const Value: string);
    function GetCarResponsable: string;
    procedure SetCarResponsable(const Value: string);
    function GetMaxCargaProfesor: Integer;
    procedure SetMaxCargaProfesor(Value: Integer);
    function GetHorarioSeleccionado: Integer;
    procedure SetHorarioSeleccionado(Value: Integer);
    function GetComentarios: string;
    procedure SetComentarios(const Value: string);
    function GetRandomize: Boolean;
    procedure SetRandomize(Value: Boolean);
    function GetSeed1: Integer;
    procedure SetSeed1(Value: Integer);
    function GetSeed2: Integer;
    procedure SetSeed2(Value: Integer);
    function GetSeed3: Integer;
    procedure SetSeed3(Value: Integer);
    function GetSeed4: Integer;
    procedure SetSeed4(Value: Integer);
    function GetNumIteraciones: Integer;
    procedure SetNumIteraciones(Value: Integer);
    function GetCruceProfesor: Extended;
    procedure SetCruceProfesor(Value: Extended);
    function GetProfesorFraccionamiento: Extended;
    procedure SetProfesorFraccionamiento(Value: Extended);
    function GetCruceAulaTipo: Extended;
    procedure SetCruceAulaTipo(Value: Extended);
    function GetHoraHueca: Extended;
    procedure SetHoraHueca(Value: Extended);
    function GetSesionCortada: Extended;
    procedure SetSesionCortada(Value: Extended);
    function GetMateriaNoDispersa: Extended;
    procedure SetMateriaNoDispersa(Value: Extended);
    function GetTamPoblacion: Integer;
    procedure SetTamPoblacion(Value: Integer);
    function GetNumMaxGeneracion: Integer;
    procedure SetNumMaxGeneracion(Value: Integer);
    function GetProbCruzamiento: Extended;
    procedure SetProbCruzamiento(Value: Extended);
    function GetProbMutacion1: Extended;
    procedure SetProbMutacion1(Value: Extended);
    function GetOrdenMutacion1: Integer;
    procedure SetOrdenMutacion1(Value: Integer);
    function GetProbMutacion2: Extended;
    procedure SetProbMutacion2(Value: Extended);
    function GetProbReparacion: Extended;
    procedure SetProbReparacion(Value: Extended);
    function GetMostrarProfesorHorarioTexto: string;
    procedure SetMostrarProfesorHorarioTexto(const Value: string);
    function GetMostrarProfesorHorarioLongitud: Integer;
    procedure SetMostrarProfesorHorarioLongitud(Value: Integer);
    function GetProfesorHorarioExcluirProfProhibicion: string;
    procedure SetProfesorHorarioExcluirProfProhibicion(const Value: string);
    function GetHorarioIni: string;
    procedure SetHorarioIni(const Value: string);
    function GetCompartir: string;
    procedure SetCompartir(const Value: string);
    function GetRangoPolinizacion: Integer;
    procedure SetRangoPolinizacion(Value: Integer);

  public
    { Public declarations }
    procedure SaveToStrings(AStrings: TStrings); override;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); override;
    procedure SaveToTextDir(const ADirName: TFileName); override;
    // procedure LoadFromFile(const AFileName: TFileName);
    procedure NewDatabase;
    procedure FillDefaultData;
    property ConfigStorage: TConfigStorage read FConfigStorage;
    procedure InitRandom;
    procedure SeleccionarHorario;

    property NomColegio: string read GetNomColegio write SetNomColegio;
    property AnioLectivo: string read GetAnioLectivo write SetAnioLectivo;
    property NomAutoridad: string read GetNomAutoridad write SetNomAutoridad;
    property CarAutoridad: string read GetCarAutoridad write SetCarAutoridad;
    property NomResponsable: string read GetNomResponsable write SetNomResponsable;
    property CarResponsable: string read GetCarResponsable write SetCarResponsable;
    property MaxCargaProfesor: Integer read GetMaxCargaProfesor write SetMaxCargaProfesor;
    property HorarioSeleccionado: Integer read GetHorarioSeleccionado write SetHorarioSeleccionado;
    property Comentarios: string read GetComentarios write SetComentarios;
    property Randomize: Boolean read GetRandomize write SetRandomize;
    property Seed1: Integer read GetSeed1 write SetSeed1;
    property Seed2: Integer read GetSeed2 write SetSeed2;
    property Seed3: Integer read GetSeed3 write SetSeed3;
    property Seed4: Integer read GetSeed4 write SetSeed4;
    property NumIteraciones: Integer read GetNumIteraciones write SetNumIteraciones;
    property CruceProfesor: Extended read GetCruceProfesor write SetCruceProfesor;
    property ProfesorFraccionamiento: Extended read GetProfesorFraccionamiento write SetProfesorFraccionamiento;
    property CruceAulaTipo: Extended read GetCruceAulaTipo write SetCruceAulaTipo;
    property HoraHueca: Extended read GetHoraHueca write SetHoraHueca;
    property SesionCortada: Extended read GetSesionCortada write SetSesionCortada;
    property MateriaNoDispersa: Extended read GetMateriaNoDispersa write SetMateriaNoDispersa;
    property TamPoblacion: Integer read GetTamPoblacion write SetTamPoblacion;
    property NumMaxGeneracion: Integer read GetNumMaxGeneracion write SetNumMaxGeneracion;
    property ProbCruzamiento: Extended read GetProbCruzamiento write SetProbCruzamiento;
    property ProbMutacion1: Extended read GetProbMutacion1 write SetProbMutacion1;
    property OrdenMutacion1: Integer read GetOrdenMutacion1 write SetOrdenMutacion1;
    property ProbMutacion2: Extended read GetProbMutacion2 write SetProbMutacion2;
    property ProbReparacion: Extended read GetProbReparacion write SetProbReparacion;
    property MostrarProfesorHorarioTexto: string read GetMostrarProfesorHorarioTexto write SetMostrarProfesorHorarioTexto;
    property MostrarProfesorHorarioLongitud: Integer read GetMostrarProfesorHorarioLongitud write SetMostrarProfesorHorarioLongitud;
    property ProfesorHorarioExcluirProfProhibicion: string read GetProfesorHorarioExcluirProfProhibicion write SetProfesorHorarioExcluirProfProhibicion;
    property HorarioIni: string read GetHorarioIni write SetHorarioIni;
    property Compartir: string read GetCompartir write SetCompartir;
    property RangoPolinizacion: Integer read GetRangoPolinizacion write SetRangoPolinizacion;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$R *.DFM}
uses
  SGHCUtls, rand, Variants, DBase, RelUtils, FConfig;

type
  EMainDataModuleError = class(Exception);

const
  pfhVersionNumber = $00000122;

resourcestring

  SNotTTDFile = 'No es un archivo TTD';
  SInvalidTTDVersion = 'Versión archivo TTD inválida';
  //SInvalidTTDFile = 'Archivo TTD no válido';

procedure TSourceDataModule.TbProfesorCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
    FieldValues['ApeNomProfesor'] := FieldValues['ApeProfesor'] + ' ' +
      FieldValues['NomProfesor'];
end;

procedure TSourceDataModule.TbDistributivoBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited;
  s := TbDistributivoComposicion.Value;
  if ComposicionADuracion(s) <= 0 then
    raise Exception.CreateFmt('Composición no válida: "%s"', [s]);
  with TbDistributivoCodMateria do DefaultExpression := AsString;
  with TbDistributivoCodNivel do DefaultExpression := AsString;
  with TbDistributivoCodEspecializacion do DefaultExpression := AsString;
  with TbDistributivoCodParaleloId do DefaultExpression := AsString;
  with TbDistributivoCodAulaTipo do DefaultExpression := AsString;
end;

procedure TSourceDataModule.TbDistributivoCalcFields(DataSet: TDataSet);
var
  v: Variant;
begin
  inherited;
  try
    v := DataSet['Composicion'];
    if VarIsNull(v) then
      DataSet['Duracion'] := 0
    else
      DataSet['Duracion'] := ComposicionADuracion(v);
  except
    DataSet['Duracion'] := 0;
  end
end;

procedure TSourceDataModule.NewDatabase;
begin
  SourceDataModule.EmptyTables;
  ConfigStorage.ConfigStrings.Clear;
  FillDefaultData;
end;

procedure TSourceDataModule.FillDefaultData;
const
  SNomHora: array[1..9] of string = (
    'Primera',
    'Segunda',
    'Tercera',
    'Cuarta',
    'Recreo',
    'Quinta',
    'Sexta',
    'Séptima',
    'Octava'
    );
  SNomMateProhibicionTipo: array[0..1] of string = (
    'Inadecuado',
    'Imposible'
    );
  SNomProfProhibicionTipo: array[0..1] of string = (
    'No gusta',
    'No puede'
    );
  EColMateProhibicionTipo: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EColProfProhibicionTipo: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EValMateProhibicionTipo: array[0..1] of Double = (
    50,
    500
    );
  EValProfProhibicionTipo: array[0..1] of Double = (
    50,
    500
    );
var
  t: TDateTime;
  i, j: Integer;
  s: string;
begin
  // Default configuration
  NomColegio := '';
  AnioLectivo := '';
  NomAutoridad := '';
  CarAutoridad := '';
  NomResponsable := '';
  CarResponsable := '';
  MaxCargaProfesor := 20;
  HorarioSeleccionado := -1;
  Comentarios := '';
  Randomize := True;
  Seed1 := 1;
  Seed2 := 1;
  Seed3 := 1;
  Seed4 := 1;
  NumIteraciones := 1;
  CruceProfesor := 200;
  ProfesorFraccionamiento := 50;
  CruceAulaTipo := 200;
  HoraHueca := 100;
  SesionCortada := 150;
  MateriaNoDispersa := 5;
  TamPoblacion := 10;
  NumMaxGeneracion := 10000;
  ProbCruzamiento := 0.3;
  ProbMutacion1 := 0.2;
  OrdenMutacion1 := 3;
  ProbMutacion2 := 0.2;
  ProbReparacion := 0.2;
  MostrarProfesorHorarioTexto :=
    'AbrNivel + " " + NomParaleloId + " " + AbrEspecializacion + " " + NomMateria';
  MostrarProfesorHorarioLongitud := 20;
  ProfesorHorarioExcluirProfProhibicion :=
    'ProfesorProhibicion.CodProfProhibicionTipo NOT IN (0,1)';
  HorarioIni := '';
  Compartir := '';
  RangoPolinizacion := 1;
  
  // Días laborables por defecto, excepto sábados y domingos:
  CheckRelations := False;
  try
    with TbDia do
    begin
      for i := Low(LongDayNames) + 1 to High(LongDayNames) - 1 do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := LongDayNames[i];
        Post;
      end;
    end;
    // Horas por defecto:
    with TbHora do
    begin
      t := 7 / 24;
      for i := Low(SNomHora) to High(SNomHora) do
      begin
        Append;
        Fields[0].AsInteger := i;
        s := FormatDateTime(ShortTimeFormat, t);
        if i = 5 then
          t := t + 1 / 48
        else
          t := t + 1 / 32;
        Fields[1].AsString := SNomHora[i];
        Fields[2].AsString := s + '-' + FormatDateTime(ShortTimeFormat, t);
        Post;
      end;
    end;
    // Generar todos los períodos, exceptuando el sábado, domingo y el recreo:
    with TbPeriodo do
    begin
      for i := Low(LongDayNames) + 1 to High(LongDayNames) - 1 do
      begin
        for j := Low(SNomHora) to High(SNomHora) do
        begin
          if j <> 5 then
          begin
            Append;
            Fields[0].AsInteger := i;
            Fields[1].AsInteger := j;
            Post;
          end;
        end;
      end;
    end;
    with TbMateriaProhibicionTipo do
    begin
      for i := Low(SNomMateProhibicionTipo) to High(SNomMateProhibicionTipo) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNomMateProhibicionTipo[i];
        Fields[2].AsInteger := EColMateProhibicionTipo[i];
        Fields[3].AsFloat := EValMateProhibicionTipo[i];
        Post;
      end;
    end;
    with TbProfesorProhibicionTipo do
    begin
      for i := Low(SNomProfProhibicionTipo) to High(SNomProfProhibicionTipo) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNomProfProhibicionTipo[i];
        Fields[2].AsInteger := EColProfProhibicionTipo[i];
        Fields[3].AsFloat := EValProfProhibicionTipo[i];
        Post;
      end;
    end;
  finally
    CheckRelations := True;
  end;
end;

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FConfigStorage := TConfigStorage.Create;
  OpenTables;
  FFlags :=
    [mtfSaveData,
      mtfSaveNonVisible,
      mtfSaveBlobs,
      mtfSaveFiltered,
      mtfSaveIgnoreRange,
      mtfSkipRest,
      mtfSaveInLocalFormat,
      mtfSaveIgnoreMasterDetail];
//      mtfSaveDeltas];
  NewDataBase;
end;

procedure TSourceDataModule.SaveToStrings(AStrings: TStrings);
begin
  AStrings.Add('TTD ' + IntToStr(pfhVersionNumber));
  inherited;
  SaveIniStrings(AStrings);
end;

procedure TSourceDataModule.SaveIniStrings(AStrings: TStrings);
begin
  AStrings.Add(IntToStr(FConfigStorage.ConfigStrings.Count));
  AStrings.AddStrings(FConfigStorage.ConfigStrings);
end;

procedure TSourceDataModule.LoadIniStrings(AStrings: TStrings; var APosition: Integer);
var
  Count, Limit: Integer;
begin
  Count := StrToInt(AStrings.Strings[APosition]);
  Inc(APosition);
  Limit := APosition + Count;
  FConfigStorage.ConfigStrings.Clear;
  FConfigStorage.ConfigStrings.Capacity := Count;
  while APosition < Limit do
  begin
    FConfigStorage.ConfigStrings.Add(AStrings[APosition]);
    Inc(APosition);
  end;
end;

procedure TSourceDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
begin
  // version stored in AStrings.Strings[APosition];
  Inc(APosition);
  inherited;
  LoadIniStrings(AStrings, APosition);
end;

procedure TSourceDataModule.SaveToTextDir(const ADirName: TFileName);
begin
  inherited;
  FConfigStorage.ConfigStrings.SaveToFile(ADirName + '\config.ini');
end;

(*
procedure TSourceDataModule.SaveToFile(const AFileName: TFileName);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;
*)

procedure TSourceDataModule.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FConfigStorage.Free;
end;

procedure TSourceDataModule.TbParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
    FieldValues['NomParalelo'] := FieldValues['AbrNivel'] + ' ' +
      FieldValues['AbrEspecializacion'] + ' ' + FieldValues['NomParaleloId'];
end;

function TSourceDataModule.GetNomColegio: string;
begin
   Result := ConfigStorage.Values['edtNomColegio_Text'];
end;

procedure TSourceDataModule.SetNomColegio(const Value: string);
begin
   ConfigStorage.Values['edtNomColegio_Text'] := Value;
end;

function TSourceDataModule.GetAnioLectivo: string;
begin
   Result := ConfigStorage.Values['edtAnioLectivo_Text'];
end;

procedure TSourceDataModule.SetAnioLectivo(const Value: string);
begin
   ConfigStorage.Values['edtAnioLectivo_Text'] := Value;
end;

function TSourceDataModule.GetNomAutoridad: string;
begin
   Result := ConfigStorage.Values['edtNomAutoridad_Text'];
end;

procedure TSourceDataModule.SetNomAutoridad(const Value: string);
begin
   ConfigStorage.Values['edtNomAutoridad_Text'] := Value;
end;

function TSourceDataModule.GetCarAutoridad: string;
begin
   Result := ConfigStorage.Values['edtCarAutoridad_Text'];
end;

procedure TSourceDataModule.SetCarAutoridad(const Value: string);
begin
   ConfigStorage.Values['edtCarAutoridad_Text'] := Value;
end;

function TSourceDataModule.GetNomResponsable: string;
begin
   Result := ConfigStorage.Values['edtNomResponsable_Text'];
end;

procedure TSourceDataModule.SetNomResponsable(const Value: string);
begin
   ConfigStorage.Values['edtNomResponsable_Text'] := Value;
end;

function TSourceDataModule.GetCarResponsable: string;
begin
   Result := ConfigStorage.Values['edtCarResponsable_Text'];
end;

procedure TSourceDataModule.SetCarResponsable(const Value: string);
begin
   ConfigStorage.Values['edtCarResponsable_Text'] := Value;
end;

function TSourceDataModule.GetMaxCargaProfesor: Integer;
begin
   Result := ConfigStorage.Integers['speMaxCargaProfesor_Value'];
end;

procedure TSourceDataModule.SetMaxCargaProfesor(Value: Integer);
begin
   ConfigStorage.Integers['speMaxCargaProfesor_Value'] := Value;
end;

function TSourceDataModule.GetHorarioSeleccionado: Integer;
begin
   Result := ConfigStorage.Integers['lblHorarioSeleccionado_Caption'];
end;

procedure TSourceDataModule.SetHorarioSeleccionado(Value: Integer);
begin
  ConfigStorage.Integers['lblHorarioSeleccionado_Caption'] := Value;
end;

function TSourceDataModule.GetComentarios: string;
begin
   Result := ConfigStorage.Texts['MemComentarios_Lines'];
end;

procedure TSourceDataModule.SetComentarios(const Value: string);
begin
  ConfigStorage.Texts['MemComentarios_Lines'] := Value;
end;

function TSourceDataModule.GetRandomize: Boolean;
begin
   Result := ConfigStorage.Booleans['CBRandomize_Checked'];
end;

procedure TSourceDataModule.SetRandomize(Value: Boolean);
begin
  ConfigStorage.Booleans['CBRandomize_Checked'] := Value;
end;

function TSourceDataModule.GetSeed1: Integer;
begin
  Result := ConfigStorage.Integers['speSeed1_Value'];
end;

procedure TSourceDataModule.SetSeed1(Value: Integer);
begin
  ConfigStorage.Integers['speSeed1_Value'] := Value;
end;

function TSourceDataModule.GetSeed2: Integer;
begin
  Result := ConfigStorage.Integers['speSeed2_Value'];
end;

procedure TSourceDataModule.SetSeed2(Value: Integer);
begin
  ConfigStorage.Integers['speSeed2_Value'] := Value;
end;

function TSourceDataModule.GetSeed3: Integer;
begin
  Result := ConfigStorage.Integers['speSeed3_Value'];
end;

procedure TSourceDataModule.SetSeed3(Value: Integer);
begin
  ConfigStorage.Integers['speSeed3_Value'] := Value;
end;

function TSourceDataModule.GetSeed4: Integer;
begin
  Result := ConfigStorage.Integers['speSeed4_Value'];
end;

procedure TSourceDataModule.SetSeed4(Value: Integer);
begin
  ConfigStorage.Integers['speSeed4_Value'] := Value;
end;

function TSourceDataModule.GetNumIteraciones: Integer;
begin
  Result := ConfigStorage.Integers['speNumIteraciones_Value'];
end;

procedure TSourceDataModule.SetNumIteraciones(Value: Integer);
begin
  ConfigStorage.Integers['speNumIteraciones_Value'] := Value;
end;

function TSourceDataModule.GetCruceProfesor: Extended;
begin
  Result := ConfigStorage.Floats['creCruceProfesor_Value'];
end;

procedure TSourceDataModule.SetCruceProfesor(Value: Extended);
begin
  ConfigStorage.Floats['creCruceProfesor_Value'] := Value;
end;

function TSourceDataModule.GetProfesorFraccionamiento: Extended;
begin
  Result := ConfigStorage.Floats['creProfesorFraccionamiento_Value'];
end;

procedure TSourceDataModule.SetProfesorFraccionamiento(Value: Extended);
begin
  ConfigStorage.Floats['creProfesorFraccionamiento_Value'] := Value;
end;

function TSourceDataModule.GetCruceAulaTipo: Extended;
begin
  Result := ConfigStorage.Floats['creCruceAulaTipo_Value'];
end;

procedure TSourceDataModule.SetCruceAulaTipo(Value: Extended);
begin
  ConfigStorage.Floats['creCruceAulaTipo_Value'] := Value;
end;

function TSourceDataModule.GetHoraHueca: Extended;
begin
  Result := ConfigStorage.Floats['creHoraHueca_Value'];
end;

procedure TSourceDataModule.SetHoraHueca(Value: Extended);
begin
  ConfigStorage.Floats['creHoraHueca_Value'] := Value;
end;

function TSourceDataModule.GetSesionCortada: Extended;
begin
  Result := ConfigStorage.Floats['creSesionCortada_Value'];
end;

procedure TSourceDataModule.SetSesionCortada(Value: Extended);
begin
  ConfigStorage.Floats['creSesionCortada_Value'] := Value;
end;

function TSourceDataModule.GetMateriaNoDispersa: Extended;
begin
  Result := ConfigStorage.Floats['creMateriaNoDispersa_Value'];
end;

procedure TSourceDataModule.SetMateriaNoDispersa(Value: Extended);
begin
  ConfigStorage.Floats['creMateriaNoDispersa_Value'] := Value;
end;

function TSourceDataModule.GetTamPoblacion: Integer;
begin
  Result := ConfigStorage.Integers['speTamPoblacion_Value'];
end;

procedure TSourceDataModule.SetTamPoblacion(Value: Integer);
begin
  ConfigStorage.Integers['speTamPoblacion_Value'] := Value;
end;

function TSourceDataModule.GetNumMaxGeneracion: Integer;
begin
  Result := ConfigStorage.Integers['speNumMaxGeneracion_Value'];
end;

procedure TSourceDataModule.SetNumMaxGeneracion(Value: Integer);
begin
  ConfigStorage.Integers['speNumMaxGeneracion_Value'] := Value;
end;

function TSourceDataModule.GetProbCruzamiento: Extended;
begin
  Result := ConfigStorage.Floats['creProbCruzamiento_Value'];
end;

procedure TSourceDataModule.SetProbCruzamiento(Value: Extended);
begin
  ConfigStorage.Floats['creProbCruzamiento_Value'] := Value;
end;

function TSourceDataModule.GetProbMutacion1: Extended;
begin
  Result := ConfigStorage.Floats['creProbMutacion1_Value'];
end;

procedure TSourceDataModule.SetProbMutacion1(Value: Extended);
begin
  ConfigStorage.Floats['creProbMutacion1_Value'] := Value;
end;

function TSourceDataModule.GetOrdenMutacion1: Integer;
begin
  Result := ConfigStorage.Integers['speOrdenMutacion1_Value'];
end;

procedure TSourceDataModule.SetOrdenMutacion1(Value: Integer);
begin
  ConfigStorage.Integers['speOrdenMutacion1_Value'] := Value;
end;

function TSourceDataModule.GetProbMutacion2: Extended;
begin
  Result := ConfigStorage.Floats['creProbMutacion2_Value'];
end;

procedure TSourceDataModule.SetProbMutacion2(Value: Extended);
begin
  ConfigStorage.Floats['creProbMutacion2_Value'] := Value;
end;

function TSourceDataModule.GetProbReparacion: Extended;
begin
  Result := ConfigStorage.Floats['creProbReparacion_Value'];
end;

procedure TSourceDataModule.SetProbReparacion(Value: Extended);
begin
  ConfigStorage.Floats['creProbReparacion_Value'] := Value;
end;

function TSourceDataModule.GetMostrarProfesorHorarioTexto: string;
begin
  Result := ConfigStorage.Values['edtMostrarProfesorHorarioTexto_Text'];
end;

procedure TSourceDataModule.SetMostrarProfesorHorarioTexto(const Value: string);
begin
  ConfigStorage.Values['edtMostrarProfesorHorarioTexto_Text'] := Value;
end;

function TSourceDataModule.GetMostrarProfesorHorarioLongitud: Integer;
begin
  Result := ConfigStorage.Integers['speMostrarProfesorHorarioLongitud_Value'];
end;

procedure TSourceDataModule.SetMostrarProfesorHorarioLongitud(Value: Integer);
begin
  ConfigStorage.Integers['speMostrarProfesorHorarioLongitud_Value'] := Value;
end;

function TSourceDataModule.GetProfesorHorarioExcluirProfProhibicion: string;
begin
  Result := ConfigStorage.Values['edtProfesorHorarioExcluirProfProhibicion_Text'];
end;

procedure TSourceDataModule.SetProfesorHorarioExcluirProfProhibicion(const Value: string);
begin
  ConfigStorage.Values['edtProfesorHorarioExcluirProfProhibicion_Text'] := Value;
end;

function TSourceDataModule.GetHorarioIni: string;
begin
  Result := ConfigStorage.Values['edtHorarioIni_Text'];
end;

procedure TSourceDataModule.SetHorarioIni(const Value: string);
begin
  ConfigStorage.Values['edtHorarioIni_Text'] := Value;
end;

function TSourceDataModule.GetCompartir: string;
begin
  Result := ConfigStorage.Values['dedCompartir_Text'];
end;

procedure TSourceDataModule.SetCompartir(const Value: string);
begin
  ConfigStorage.Values['dedCompartir_Text'] := Value;
end;

function TSourceDataModule.GetRangoPolinizacion: Integer;
begin
  Result := ConfigStorage.Integers['speRangoPolinizacion_Value'];
end;

procedure TSourceDataModule.SetRangoPolinizacion(Value: Integer);
begin
  ConfigStorage.Integers['speRangoPolinizacion_Value'] := Value;
end;

procedure TSourceDataModule.InitRandom;
begin
  if Randomize then
    srandom
  else
    setseeds(Seed1, Seed2, Seed3, Seed4);
end;

procedure TSourceDataModule.SeleccionarHorario;
begin
  HorarioSeleccionado := SourceDataModule.TbHorarioCodHorario.Value;
end;

end.

