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
    procedure TbProfesorCalcFields(DataSet: TDataSet);
    procedure TbDistributivoBeforePost(DataSet: TDataSet);
    procedure TbDistributivoCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FFlags : TkbmMemTableSaveFlags;
    // procedure SaveToFile(const AFileName: TFileName);
    // procedure SaveToStream(AStream: TStream);
    // procedure SaveUnCompToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    procedure LoadUnCompFromStream(AStream: TStream);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure SaveToStrings(AStrings: TStrings); override;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); override;
    procedure SaveToTextDir(const ADirName: TFileName); override;
    procedure LoadFromFile(const AFileName: TFileName);
    procedure NewDatabase;
    procedure FillDefaultData;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$R *.DFM}
uses
  SGHCUtls, BZip2, FConfig, Variants, DBase;

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

(*
procedure TSourceDataModule.SaveToStream(AStream: TStream);
var
  Stream, BZip2Stream: TStream;
  TTDFileHeader: TTTDFileHeader;
begin
  TTDFileHeader.GenHeader := 'TTD' + ^Z;
  TTDFileHeader.VersionNumber := pfhVersionNumber;
  AStream.Write(TTDFileHeader, SizeOf(TTDFileHeader));
  Stream := TMemoryStream.Create;
  try
    SaveUncompToStream(Stream);
    BZip2Stream := TBZCompressionStream.Create(bs9, AStream);
    // Stream: Datos descomprimidos
    try
      BZip2Stream.CopyFrom(Stream, 0);
    finally
      BZip2Stream.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TSourceDataModule.SaveUnCompToStream(AStream: TStream);
var
  StreamConfig: TStream;
  n: Longint;
begin
  SaveToBinaryStream(AStream, FFlags);
  StreamConfig := TFileStream.Create(ConfiguracionForm.FormStorage.IniFileName,
    fmOpenRead or fmShareDenyWrite);
  try
    n := StreamConfig.Size;
    AStream.Write(n, SizeOf(n));
    AStream.CopyFrom(StreamConfig, n);
  finally
    StreamConfig.Free;
  end;
end;
*)

procedure TSourceDataModule.NewDatabase;
begin
  try
    SourceDataModule.EmptyTables;
  finally
    FillDefaultData;
  end;
end;

procedure TSourceDataModule.LoadFromStream(AStream: TStream);
const
  BufferSize = 65536;
var
  Count: Integer;
  Buffer: array[0..BufferSize - 1] of Byte;
  MemoryStream, BZip2Stream: TStream;
  TTDFileHeader: TTTDFileHeader;
begin
  AStream.Read(TTDFileHeader, SizeOf(TTDFileHeader));
  if TTDFileHeader.GenHeader <> 'TTD' + ^Z then
    raise EMainDataModuleError.Create(SNotTTDFile);
  if TTDFileHeader.VersionNumber <> pfhVersionNumber then
    raise EMainDataModuleError.Create(SInvalidTTDVersion);
  MemoryStream := TMemoryStream.Create;
  try
    BZip2Stream := TBZDecompressionStream.Create(AStream);
    try
      while True do
      begin
        Count := BZip2Stream.Read(Buffer, BufferSize);
        if Count <> 0 then MemoryStream.WriteBuffer(Buffer, Count) else Break;
      end;
    finally
      BZip2Stream.Free;
    end;
    MemoryStream.Position := 0;
    LoadUncompFromStream(MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

procedure TSourceDataModule.LoadUnCompFromStream(AStream: TStream);
var
  n: Longint;
begin
  SourceDataModule.EmptyTables;
  SourceDataModule.LoadFromBinaryStream(AStream);
  AStream.Read(n, SizeOf(n));
  with TFileStream.Create(ConfiguracionForm.FormStorage.IniFileName, fmCreate) do
  try
    CopyFrom(AStream, n);
  finally
    Free;
  end;
end;

procedure TSourceDataModule.LoadFromFile(const AFileName: TFileName);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead + fmShareDenyNone);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
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
var
  IniStrings: TStrings;
begin
  IniStrings := TStringList.Create;
  try
    ConfiguracionForm.FormStorage.SaveFormPlacement;
    IniStrings.LoadFromFile(ConfiguracionForm.FormStorage.IniFileName);
    AStrings.Add(IntToStr(IniStrings.Count));
    AStrings.AddStrings(IniStrings);
  finally
    IniStrings.Free;
  end;
end;

procedure TSourceDataModule.LoadIniStrings(AStrings: TStrings; var APosition: Integer);
var
  IniStrings: TStrings;
  Count, Limit: Integer;
begin
  IniStrings := TStringList.Create;
  try
    Count := StrToInt(AStrings.Strings[APosition]);
    Inc(APosition);
    Limit := APosition + Count;
    while APosition < Limit do
    begin
      IniStrings.Add(AStrings[APosition]);
      Inc(APosition);
    end;
    AStrings.Add(IntToStr(IniStrings.Count));
    AStrings.AddStrings(IniStrings);
    IniStrings.SaveToFile(ConfiguracionForm.FormStorage.IniFileName);
    ConfiguracionForm.FormStorage.RestoreFormPlacement;
  finally
    IniStrings.Free;
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
  ConfiguracionForm.FormStorage.IniFileName := ADirName + '\config.ini';
  ConfiguracionForm.FormStorage.SaveFormPlacement;
  inherited;
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

end.

