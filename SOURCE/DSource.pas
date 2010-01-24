unit DSource;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DSrcBase, Db, kbmMemTable;

type
  TSourceDataModule = class(TSourceBaseDataModule)
    kbmCursoAbrNivel: TStringField;
    kbmCursoAbrEspecializacion: TStringField;
    kbmProfesorApeNomProfesor: TStringField;
    kbmHorarioDetalleNomMateria: TStringField;
    TbProfesorProhibicionNomProfProhibicionTipo: TStringField;
    TbMateriaProhibicionNomMateProhibicionTipo: TStringField;
    kbmDistributivoNomMateria: TStringField;
    kbmDistributivoDuracion: TIntegerField;
    kbmDistributivoApeNomProfesor: TStringField;
    kbmDistributivoAbrNivel: TStringField;
    kbmDistributivoNomParaleloId: TStringField;
    kbmDistributivoAbrEspecializacion: TStringField;
    kbmDistributivoAbrAulaTipo: TStringField;
    kbmParaleloAbrNivel: TStringField;
    kbmParaleloAbrEspecializacion: TStringField;
    kbmParaleloNomParaleloId: TStringField;
    procedure kbmProfesorCalcFields(DataSet: TDataSet);
    procedure kbmDistributivoBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FFlags : TkbmMemTableSaveFlags;
    procedure SaveToStream(AStream: TStream);
    procedure SaveUnCompToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    procedure LoadUnCompFromStream(AStream: TStream);
  public
    { Public declarations }
    procedure SaveToFile(const AFileName: TFileName);
    procedure LoadFromFile(const AFileName: TFileName);
    procedure SaveToTextDir(const AFileName: TFileName); overload;
    procedure NewDatabase;
    procedure FillDefaultData;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$R *.DFM}
uses
  SGHCUtls, BZip2, FConfig;

type
  EMainDataModuleError = class(Exception);
  THPCFileHeader = packed record
    GenHeader: array[1..4] of Char;
    VersionNumber: Integer;
  end;

const
  pfhVersionNumber = $00000121;

resourcestring

  SNotHPCFile = 'No es un archivo HPC';
  SInvalidHPCVersion = 'Versión archivo HPC inválida';
  //SInvalidHPCFile = 'Archivo HPC no válido';

procedure TSourceDataModule.kbmProfesorCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
    FieldValues['ApeNomProfesor'] := FieldValues['ApeProfesor'] + ' ' +
      FieldValues['NomProfesor'];
end;

procedure TSourceDataModule.kbmDistributivoBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited;
  s := kbmDistributivoComposicion.Value;
  if ComposicionADuracion(s) <= 0 then
    raise Exception.CreateFmt('Composición no válida: "%s"', [s]);
  with kbmDistributivoCodMateria do DefaultExpression := AsString;
  with kbmDistributivoCodNivel do DefaultExpression := AsString;
  with kbmDistributivoCodEspecializacion do DefaultExpression := AsString;
  with kbmDistributivoCodParaleloId do DefaultExpression := AsString;
  with kbmDistributivoCodAulaTipo do DefaultExpression := AsString;
end;

procedure TSourceDataModule.kbmDistributivoCalcFields(DataSet: TDataSet);
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

procedure TSourceDataModule.SaveToStream(AStream: TStream);
var
  Stream, BZip2Stream: TStream;
  HPCFileHeader: THPCFileHeader;
begin
  HPCFileHeader.GenHeader := 'HPC' + ^Z;
  HPCFileHeader.VersionNumber := pfhVersionNumber;
  AStream.Write(HPCFileHeader, SizeOf(HPCFileHeader));
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
  HPCFileHeader: THPCFileHeader;
begin
  AStream.Read(HPCFileHeader, SizeOf(HPCFileHeader));
  if HPCFileHeader.GenHeader <> 'HPC' + ^Z then
    raise EMainDataModuleError.Create(SNotHPCFile);
  if HPCFileHeader.VersionNumber <> pfhVersionNumber then
    raise EMainDataModuleError.Create(SInvalidHPCVersion);
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
      with kbmDia do
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
      with kbmHora do
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
      with kbmPeriodo do
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
      with kbmMateriaProhibicionTipo do
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
      with kbmProfesorProhibicionTipo do
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

procedure TSourceDataModule.SaveToTextDir(const AFileName: TFileName);
begin
  SaveToTextDir(AFileName, FFlags);
end;

end.

