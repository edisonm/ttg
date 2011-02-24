unit DSource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, DSrcBase, UConfig, Db, ZConnection, ZDataset,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable;

type
  TSourceDataModule = class(TSourceBaseDataModule)
    TbNivelCodNivel: TLongintField;
    TbNivelNomNivel: TStringField;
    TbNivelAbrNivel: TStringField;
    procedure TbDistributivoBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FConfigStorage: TConfigStorage;
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
    procedure SetFieldCaption(ADataSet: TDataSet);
    procedure PrepareLookupFields;
    procedure HideFields;
  public
    { Public declarations }
    procedure PrepareTables;
    procedure SaveToStrings(AStrings: TStrings); override;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); override;
    procedure SaveToTextDir(const ADirName: TFileName); override;
    // procedure LoadFromFile(const AFileName: TFileName);
    procedure NewDatabase;
    procedure FillDefaultData;
    property ConfigStorage: TConfigStorage read FConfigStorage;
    procedure InitRandom;

    property NomColegio: string read GetNomColegio write SetNomColegio;
    property AnioLectivo: string read GetAnioLectivo write SetAnioLectivo;
    property NomAutoridad: string read GetNomAutoridad write SetNomAutoridad;
    property CarAutoridad: string read GetCarAutoridad write SetCarAutoridad;
    property NomResponsable: string read GetNomResponsable write SetNomResponsable;
    property CarResponsable: string read GetCarResponsable write SetCarResponsable;
    property MaxCargaProfesor: Integer read GetMaxCargaProfesor write SetMaxCargaProfesor;
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

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  TTGUtls, rand, Variants, DBase, FConfig;

const
  pfhVersionNumber = 292;

procedure TSourceDataModule.TbDistributivoBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited;
  s := TbDistributivo.FindField('Composicion').AsString;
  if ComposicionADuracion(s) <= 0 then
    raise Exception.CreateFmt('Composicion no valida: "%s"', [s]);
  with TbDistributivo.FindField('CodMateria') do DefaultExpression := AsString;
  with TbDistributivo.FindField('CodNivel') do DefaultExpression := AsString;
  with TbDistributivo.FindField('CodEspecializacion') do DefaultExpression := AsString;
  with TbDistributivo.FindField('CodParaleloId') do DefaultExpression := AsString;
  with TbDistributivo.FindField('CodAulaTipo') do DefaultExpression := AsString;
end;

procedure TSourceDataModule.NewDatabase;
begin
  EmptyTables;
  ConfigStorage.ConfigStrings.Clear;
  FillDefaultData;
end;

procedure TSourceDataModule.DataModuleDestroy(Sender: TObject);
begin
  Database.Disconnect;
  inherited;
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
    'Septima',
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
  i: Integer;
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

  // Dias laborables por defecto, excepto sabados y domingos:
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
        s := FormatDateTime(ShortTimeFormat, t);
        if i = 5 then
          t := t + 1 / 48
        else
          t := t + 1 / 32;
        s := s + '-' + FormatDateTime(ShortTimeFormat, t);
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNomHora[i];
        Fields[2].AsString := s;
        Post;
      end;
    end;
    // Generar todos los periodos, exceptuando el sabado, domingo y el recreo:
    with TbPeriodo do
    begin
      TbDia.First;
      while not TbDia.Eof do
      begin
        TbHora.First;
        while not TbHora.Eof do
        begin
          if TbHora.FindField('NomHora').AsString <> 'Recreo' then
          begin
            Append;
            Fields[0].AsInteger := TbDia.FindField('CodDia').AsInteger;
            Fields[1].AsInteger := TbHora.FindField('CodHora').AsInteger;
            Post;
          end;
          TbHora.Next;
        end;
        TbDia.Next;
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

procedure TSourceDataModule.PrepareLookupFields;
var
  Field: TField;
begin
  Field := TStringField.Create(TbCurso);
  with Field do
  begin
    DisplayLabel := 'Nivel';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'AbrNivel';
    LookupDataSet := TbNivel;
    LookupKeyFields := 'CodNivel';
    LookupResultField := 'AbrNivel';
    KeyFields := 'CodNivel';
    Size := 10;
    Lookup := True;
    DataSet := TbCurso;
  end;
  Field := TStringField.Create(TbCurso);
  with Field do
  begin
    DisplayLabel := 'Espec.';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'AbrEspecializacion';
    LookupDataSet := TbEspecializacion;
    LookupKeyFields := 'CodEspecializacion';
    LookupResultField := 'AbrEspecializacion';
    KeyFields := 'CodEspecializacion';
    Size := 10;
    Lookup := True;
    DataSet := TbCurso;
  end;
  Field := TStringField.Create(TbParalelo);
  with Field do
  begin
    DisplayLabel := 'Nivel';
    FieldKind := fkLookup;
    FieldName := 'AbrNivel';
    LookupDataSet := TbNivel;
    LookupKeyFields := 'CodNivel';
    LookupResultField := 'AbrNivel';
    KeyFields := 'CodNivel';
    Size := 5;
    Lookup := True;
    DataSet := TbParalelo;
  end;
  Field := TStringField.Create(TbParalelo);
  with Field do
  begin
    DisplayLabel := 'Especializacion';
    FieldKind := fkLookup;
    FieldName := 'AbrEspecializacion';
    LookupDataSet := TbEspecializacion;
    LookupKeyFields := 'CodEspecializacion';
    LookupResultField := 'AbrEspecializacion';
    KeyFields := 'CodEspecializacion';
    Size := 10;
    Lookup := True;
    DataSet := TbParalelo;
  end;
  Field := TStringField.Create(TbParalelo);
  with Field do
  begin
    DisplayLabel := 'Paralelo';
    FieldKind := fkLookup;
    FieldName := 'NomParaleloId';
    LookupDataSet := TbParaleloId;
    LookupKeyFields := 'CodParaleloId';
    LookupResultField := 'NomParaleloId';
    KeyFields := 'CodParaleloId';
    Size := 5;
    Lookup := True;
    DataSet := TbParalelo;
  end;
  Field := TStringField.Create(TbMateriaProhibicion);
  with Field do
  begin
    DisplayLabel := 'Prohibicion';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NomMateProhibicionTipo';
    LookupDataSet := TbMateriaProhibicionTipo;
    LookupKeyFields := 'CodMateProhibicionTipo';
    LookupResultField := 'NomMateProhibicionTipo';
    KeyFields := 'CodMateProhibicionTipo';
    Size := 10;
    Lookup := True;
    DataSet := TbMateriaProhibicion;
  end;
  Field := TStringField.Create(TbHorarioDetalle);
  with Field do
  begin
    DisplayLabel := 'Materia';
    DisplayWidth := 15;
    FieldKind := fkLookup;
    FieldName := 'NomMateria';
    LookupDataSet := TbMateria;
    LookupKeyFields := 'CodMateria';
    LookupResultField := 'NomMateria';
    KeyFields := 'CodMateria';
    Size := 15;
    Lookup := True;
    DataSet := TbHorarioDetalle;
  end;
  Field := TStringField.Create(TbProfesorProhibicion);
  with Field do
  begin
    DisplayLabel := 'Prohibicion';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NomProfProhibicionTipo';
    LookupDataSet := TbProfesorProhibicionTipo;
    LookupKeyFields := 'CodProfProhibicionTipo';
    LookupResultField := 'NomProfProhibicionTipo';
    KeyFields := 'CodProfProhibicionTipo';
    Size := 10;
    Lookup := True;
    DataSet := TbProfesorProhibicion;
  end;
end;

procedure TSourceDataModule.HideFields;
begin
  TbAulaTipo.FindField('CodAulaTipo').Visible := False;
  TbEspecializacion.FindField('CodEspecializacion').Visible := False;
  TbDia.FindField('CodDia').Visible := False;
  TbMateria.FindField('CodMateria').Visible := False;
  TbNivel.FindField('CodNivel').Visible := False;
  TbHora.FindField('CodHora').Visible := False;
  TbCurso.FindField('CodNivel').Visible := False;
  TbCurso.FindField('CodEspecializacion').Visible := False;
  TbParaleloId.FindField('CodParaleloId').Visible := False;
  TbMateriaProhibicionTipo.FindField('CodMateProhibicionTipo').Visible := False;
  TbPeriodo.FindField('CodDia').Visible := False;
  TbPeriodo.FindField('CodHora').Visible := False;
  TbParalelo.FindField('CodNivel').Visible := False;
  TbParalelo.FindField('CodEspecializacion').Visible := False;
  TbParalelo.FindField('CodParaleloId').Visible := False;
  TbProfesor.FindField('CodProfesor').Visible := False;
  TbHorarioDetalle.FindField('CodHorario').Visible := False;
  TbHorarioDetalle.FindField('CodMateria').Visible := False;
  TbHorarioDetalle.FindField('CodNivel').Visible := False;
  TbHorarioDetalle.FindField('CodEspecializacion').Visible := False;
  TbHorarioDetalle.FindField('CodParaleloId').Visible := False;
  TbHorarioDetalle.FindField('CodDia').Visible := False;
  TbHorarioDetalle.FindField('CodHora').Visible := False;
  TbProfesorProhibicionTipo.FindField('CodProfProhibicionTipo').Visible := False;
end;

procedure TSourceDataModule.PrepareTables;
begin
  PrepareFields;
  PrepareLookupFields;
  ApplyOnTables(SetFieldCaption);
  HideFields;
end;

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
var
  Strings: TStrings;
begin
  inherited;
  FConfigStorage := TConfigStorage.Create(Self);
  Database.Connect;
  Strings := TStringList.Create;
  if Database.Database = ':memory:' then
  try
    Strings.LoadFromFile('../dat/ttg.sql');
    Database.ExecuteDirect('pragma journal_mode=off');
    Database.ExecuteDirect(Strings.GetText);
    PrepareTables;
    OpenTables;
    NewDatabase;
  finally
    Strings.Free;
  end
  else
  begin
    Database.ExecuteDirect('pragma journal_mode=off');
    PrepareTables;
    OpenTables;
  end;
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
  FConfigStorage.ConfigStrings.SaveToFile(ADirName + '/config.ini');
end;

function TSourceDataModule.GetNomColegio: string;
begin
   Result := ConfigStorage.Values['NomColegio'];
end;

procedure TSourceDataModule.SetNomColegio(const Value: string);
begin
   ConfigStorage.Values['NomColegio'] := Value;
end;

function TSourceDataModule.GetAnioLectivo: string;
begin
   Result := ConfigStorage.Values['AnioLectivo'];
end;

procedure TSourceDataModule.SetAnioLectivo(const Value: string);
begin
   ConfigStorage.Values['AnioLectivo'] := Value;
end;

function TSourceDataModule.GetNomAutoridad: string;
begin
   Result := ConfigStorage.Values['NomAutoridad'];
end;

procedure TSourceDataModule.SetNomAutoridad(const Value: string);
begin
   ConfigStorage.Values['NomAutoridad'] := Value;
end;

function TSourceDataModule.GetCarAutoridad: string;
begin
   Result := ConfigStorage.Values['CarAutoridad'];
end;

procedure TSourceDataModule.SetCarAutoridad(const Value: string);
begin
   ConfigStorage.Values['CarAutoridad'] := Value;
end;

function TSourceDataModule.GetNomResponsable: string;
begin
   Result := ConfigStorage.Values['NomResponsable'];
end;

procedure TSourceDataModule.SetNomResponsable(const Value: string);
begin
   ConfigStorage.Values['NomResponsable'] := Value;
end;

function TSourceDataModule.GetCarResponsable: string;
begin
   Result := ConfigStorage.Values['CarResponsable'];
end;

procedure TSourceDataModule.SetCarResponsable(const Value: string);
begin
   ConfigStorage.Values['CarResponsable'] := Value;
end;

function TSourceDataModule.GetMaxCargaProfesor: Integer;
begin
   Result := ConfigStorage.Integers['MaxCargaProfesor'];
end;

procedure TSourceDataModule.SetMaxCargaProfesor(Value: Integer);
begin
   ConfigStorage.Integers['MaxCargaProfesor'] := Value;
end;

function TSourceDataModule.GetComentarios: string;
begin
   Result := ConfigStorage.Texts['Comentarios'];
end;

procedure TSourceDataModule.SetComentarios(const Value: string);
begin
  ConfigStorage.Texts['Comentarios'] := Value;
end;

function TSourceDataModule.GetRandomize: Boolean;
begin
   Result := ConfigStorage.Booleans['Randomize'];
end;

procedure TSourceDataModule.SetRandomize(Value: Boolean);
begin
  ConfigStorage.Booleans['Randomize'] := Value;
end;

function TSourceDataModule.GetSeed1: Integer;
begin
  Result := ConfigStorage.Integers['Seed1'];
end;

procedure TSourceDataModule.SetSeed1(Value: Integer);
begin
  ConfigStorage.Integers['Seed1'] := Value;
end;

function TSourceDataModule.GetSeed2: Integer;
begin
  Result := ConfigStorage.Integers['Seed2'];
end;

procedure TSourceDataModule.SetSeed2(Value: Integer);
begin
  ConfigStorage.Integers['Seed2'] := Value;
end;

function TSourceDataModule.GetSeed3: Integer;
begin
  Result := ConfigStorage.Integers['Seed3'];
end;

procedure TSourceDataModule.SetSeed3(Value: Integer);
begin
  ConfigStorage.Integers['Seed3'] := Value;
end;

function TSourceDataModule.GetSeed4: Integer;
begin
  Result := ConfigStorage.Integers['Seed4'];
end;

procedure TSourceDataModule.SetSeed4(Value: Integer);
begin
  ConfigStorage.Integers['Seed4'] := Value;
end;

function TSourceDataModule.GetNumIteraciones: Integer;
begin
  Result := ConfigStorage.Integers['NumIteraciones'];
end;

procedure TSourceDataModule.SetNumIteraciones(Value: Integer);
begin
  ConfigStorage.Integers['NumIteraciones'] := Value;
end;

function TSourceDataModule.GetCruceProfesor: Extended;
begin
  Result := ConfigStorage.Floats['CruceProfesor'];
end;

procedure TSourceDataModule.SetCruceProfesor(Value: Extended);
begin
  ConfigStorage.Floats['CruceProfesor'] := Value;
end;

procedure TSourceDataModule.SetFieldCaption(ADataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to ADataSet.Fields.Count - 1 do
  begin
    ADataSet.Fields[i].DisplayLabel := FieldCaption[ADataSet.Fields[i]];
  end;
end;

function TSourceDataModule.GetProfesorFraccionamiento: Extended;
begin
  Result := ConfigStorage.Floats['ProfesorFraccionamiento'];
end;

procedure TSourceDataModule.SetProfesorFraccionamiento(Value: Extended);
begin
  ConfigStorage.Floats['ProfesorFraccionamiento'] := Value;
end;

function TSourceDataModule.GetCruceAulaTipo: Extended;
begin
  Result := ConfigStorage.Floats['CruceAulaTipo'];
end;

procedure TSourceDataModule.SetCruceAulaTipo(Value: Extended);
begin
  ConfigStorage.Floats['CruceAulaTipo'] := Value;
end;

function TSourceDataModule.GetHoraHueca: Extended;
begin
  Result := ConfigStorage.Floats['HoraHueca'];
end;

procedure TSourceDataModule.SetHoraHueca(Value: Extended);
begin
  ConfigStorage.Floats['HoraHueca'] := Value;
end;

function TSourceDataModule.GetSesionCortada: Extended;
begin
  Result := ConfigStorage.Floats['SesionCortada'];
end;

procedure TSourceDataModule.SetSesionCortada(Value: Extended);
begin
  ConfigStorage.Floats['SesionCortada'] := Value;
end;

function TSourceDataModule.GetMateriaNoDispersa: Extended;
begin
  Result := ConfigStorage.Floats['MateriaNoDispersa'];
end;

procedure TSourceDataModule.SetMateriaNoDispersa(Value: Extended);
begin
  ConfigStorage.Floats['MateriaNoDispersa'] := Value;
end;

function TSourceDataModule.GetTamPoblacion: Integer;
begin
  Result := ConfigStorage.Integers['TamPoblacion'];
end;

procedure TSourceDataModule.SetTamPoblacion(Value: Integer);
begin
  ConfigStorage.Integers['TamPoblacion'] := Value;
end;

function TSourceDataModule.GetNumMaxGeneracion: Integer;
begin
  Result := ConfigStorage.Integers['NumMaxGeneracion'];
end;

procedure TSourceDataModule.SetNumMaxGeneracion(Value: Integer);
begin
  ConfigStorage.Integers['NumMaxGeneracion'] := Value;
end;

function TSourceDataModule.GetProbCruzamiento: Extended;
begin
  Result := ConfigStorage.Floats['ProbCruzamiento'];
end;

procedure TSourceDataModule.SetProbCruzamiento(Value: Extended);
begin
  ConfigStorage.Floats['ProbCruzamiento'] := Value;
end;

function TSourceDataModule.GetProbMutacion1: Extended;
begin
  Result := ConfigStorage.Floats['ProbMutacion1'];
end;

procedure TSourceDataModule.SetProbMutacion1(Value: Extended);
begin
  ConfigStorage.Floats['ProbMutacion1'] := Value;
end;

function TSourceDataModule.GetOrdenMutacion1: Integer;
begin
  Result := ConfigStorage.Integers['OrdenMutacion1'];
end;

procedure TSourceDataModule.SetOrdenMutacion1(Value: Integer);
begin
  ConfigStorage.Integers['OrdenMutacion1'] := Value;
end;

function TSourceDataModule.GetProbMutacion2: Extended;
begin
  Result := ConfigStorage.Floats['ProbMutacion2'];
end;

procedure TSourceDataModule.SetProbMutacion2(Value: Extended);
begin
  ConfigStorage.Floats['ProbMutacion2'] := Value;
end;

function TSourceDataModule.GetProbReparacion: Extended;
begin
  Result := ConfigStorage.Floats['ProbReparacion'];
end;

procedure TSourceDataModule.SetProbReparacion(Value: Extended);
begin
  ConfigStorage.Floats['ProbReparacion'] := Value;
end;

function TSourceDataModule.GetMostrarProfesorHorarioTexto: string;
begin
  Result := ConfigStorage.Values['MostrarProfesorHorarioTexto'];
end;

procedure TSourceDataModule.SetMostrarProfesorHorarioTexto(const Value: string);
begin
  ConfigStorage.Values['MostrarProfesorHorarioTexto'] := Value;
end;

function TSourceDataModule.GetMostrarProfesorHorarioLongitud: Integer;
begin
  Result := ConfigStorage.Integers['MostrarProfesorHorarioLongitud'];
end;

procedure TSourceDataModule.SetMostrarProfesorHorarioLongitud(Value: Integer);
begin
  ConfigStorage.Integers['MostrarProfesorHorarioLongitud'] := Value;
end;

function TSourceDataModule.GetProfesorHorarioExcluirProfProhibicion: string;
begin
  Result := ConfigStorage.Values['ProfesorHorarioExcluirProfProhibicion'];
end;

procedure TSourceDataModule.SetProfesorHorarioExcluirProfProhibicion(const Value: string);
begin
  ConfigStorage.Values['ProfesorHorarioExcluirProfProhibicion'] := Value;
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
  Result := ConfigStorage.Integers['RangoPolinizacion'];
end;

procedure TSourceDataModule.SetRangoPolinizacion(Value: Integer);
begin
  ConfigStorage.Integers['RangoPolinizacion'] := Value;
end;

procedure TSourceDataModule.InitRandom;
begin
  if Randomize then
    srandom
  else
    setseeds(Seed1, Seed2, Seed3, Seed4);
end;

initialization
{$IFDEF FPC}
  {$i DSource.lrs}
{$ENDIF}

end.
