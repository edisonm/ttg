unit DSource;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DSrcBase, Db, kbmMemTable;

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
    FConfigStrings: TStrings;
    // procedure SaveToFile(const AFileName: TFileName);
    // procedure SaveToStream(AStream: TStream);
    // procedure SaveUnCompToStream(AStream: TStream);
    // procedure LoadFromStream(AStream: TStream);
    // procedure LoadUnCompFromStream(AStream: TStream);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure SaveToStrings(AStrings: TStrings); override;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); override;
    procedure SaveToTextDir(const ADirName: TFileName); override;
    // procedure LoadFromFile(const AFileName: TFileName);
    procedure NewDatabase;
    procedure FillDefaultData;
    property ConfigStrings: TStrings read FConfigStrings;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$R *.DFM}
uses
  SGHCUtls, BZip2, Variants, DBase, RelUtils, FConfig;

type
  EMainDataModuleError = class(Exception);
  TTTDFileHeader = packed record
    GenHeader: array[1..4] of Char;
    VersionNumber: Integer;
  end;

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
  try
    SourceDataModule.EmptyTables;
  finally
    FillDefaultData;
  end;
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
  with SourceDataModule do
  begin
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
end;

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FConfigStrings := TStringList.Create;
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
  ConfiguracionForm.SaveToStrings(FConfigStrings);
  AStrings.Add(IntToStr(FConfigStrings.Count));
  AStrings.AddStrings(FConfigStrings);
end;

procedure TSourceDataModule.LoadIniStrings(AStrings: TStrings; var APosition: Integer);
var
  Count, Limit: Integer;
begin
  Count := StrToInt(AStrings.Strings[APosition]);
  Inc(APosition);
  Limit := APosition + Count;
  while APosition < Limit do
  begin
    FConfigStrings.Add(AStrings[APosition]);
    Inc(APosition);
  end;
  AStrings.Add(IntToStr(FConfigStrings.Count));
  AStrings.AddStrings(FConfigStrings);
  ConfiguracionForm.LoadFromStrings(FConfigStrings);
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
  FConfigStrings.SaveToFile(ADirName + '\config.ini');
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
  FConfigStrings.Free;
end;

procedure TSourceDataModule.TbParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
    FieldValues['NomParalelo'] := FieldValues['AbrNivel'] + ' ' +
      FieldValues['AbrEspecializacion'] + ' ' + FieldValues['NomParaleloId'];
end;

end.

