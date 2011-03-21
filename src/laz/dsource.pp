{ -*- mode: Delphi -*- }
unit DSource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, DSourceBase, DBase, Db, ZConnection;

type

  { TSourceDataModule }

  TSourceDataModule = class(TSourceBaseDataModule)
    procedure TbDistributivoBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TbDistributivoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetFieldCaption(ADataSet: TDataSet);
    procedure PrepareLookupFields;
    procedure HideFields;
  public
    { Public declarations }
    procedure PrepareTables;
    procedure FillDefaultData;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  Variants, FConfiguracion, UTTGDBUtils;

procedure TSourceDataModule.TbDistributivoBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited DataSetBeforePost(DataSet);
  with DataSet do
  begin
    s := FindField('Composicion').AsString;
    if ComposicionADuracion(s) <= 0 then
      raise Exception.CreateFmt('Composicion no valida: "%s"', [s]);
    with FindField('CodMateria') do DefaultExpression := AsString;
    with FindField('CodNivel') do DefaultExpression := AsString;
    with FindField('CodEspecializacion') do DefaultExpression := AsString;
    with FindField('CodParaleloId') do DefaultExpression := AsString;
    with FindField('CodAulaTipo') do DefaultExpression := AsString;
  end;
end;

procedure TSourceDataModule.TbDistributivoCalcFields(DataSet: TDataSet);
var
  v: Variant;
begin
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

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

procedure TSourceDataModule.DataModuleDestroy(Sender: TObject);
begin
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
  EValMateProhibicionTipo: array[0..1] of Integer = (
    50,
    500
    );
  EValProfProhibicionTipo: array[0..1] of Integer = (
    50,
    500
    );
var
  t: TDateTime;
  i: Integer;
  s: string;
begin
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
  Field := TStringField.Create(TbDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Nivel';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'AbrNivel';
    LookupDataSet := SourceDataModule.TbNivel;
    LookupKeyFields := 'CodNivel';
    LookupResultField := 'AbrNivel';
    KeyFields := 'CodNivel';
    Size := 5;
    Lookup := True;
    DataSet := TbDistributivo;
  end;
  Field := TStringField.Create(TbDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Espec.';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'AbrEspecializacion';
    LookupDataSet := SourceDataModule.TbEspecializacion;
    LookupKeyFields := 'CodEspecializacion';
    LookupResultField := 'AbrEspecializacion';
    KeyFields := 'CodEspecializacion';
    Size := 10;
    Lookup := True;
    DataSet := TbDistributivo;
  end;
  Field := TStringField.Create(TbDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Par.';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'NomParaleloId';
    LookupDataSet := SourceDataModule.TbParaleloId;
    LookupKeyFields := 'CodParaleloId';
    LookupResultField := 'NomParaleloId';
    KeyFields := 'CodParaleloId';
    Size := 5;
    Lookup := True;
    DataSet := TbDistributivo;
  end;
  Field := TStringField.Create(TbDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Materia';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NomMateria';
    LookupDataSet := SourceDataModule.TbMateria;
    LookupKeyFields := 'CodMateria';
    LookupResultField := 'NomMateria';
    KeyFields := 'CodMateria';
    Size := 15;
    Lookup := True;
    DataSet := TbDistributivo;
  end;
  Field := TStringField.Create(TbDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Aula';
    DisplayWidth := 6;
    FieldKind := fkLookup;
    FieldName := 'AbrAulaTipo';
    LookupDataSet := SourceDataModule.TbAulaTipo;
    LookupKeyFields := 'CodAulaTipo';
    LookupResultField := 'AbrAulaTipo';
    KeyFields := 'CodAulaTipo';
    Size := 10;
    Lookup := True;
    DataSet := TbDistributivo;
  end;
  Field := TLongintField.Create(TbDistributivo.Owner);
  with Field do
  begin
    FieldKind := fkCalculated;
    DisplayWidth := 5;
    FieldName := 'Duracion';
    DataSet := TbDistributivo;
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
  with TbHorarioDetalle do
  begin
    FindField('CodHorario').Visible := False;
    FindField('CodMateria').Visible := False;
    FindField('CodNivel').Visible := False;
    FindField('CodEspecializacion').Visible := False;
    FindField('CodParaleloId').Visible := False;
    FindField('CodDia').Visible := False;
    FindField('CodHora').Visible := False;
  end;
  TbProfesorProhibicionTipo.FindField('CodProfProhibicionTipo').Visible := False;
  with TbDistributivo do
  begin
    FindField('CodMateria').Visible := False;
    FindField('CodNivel').Visible := False;
    FindField('CodEspecializacion').Visible := False;
    FindField('CodParaleloId').Visible := False;
    FindField('CodProfesor').Visible := False;
    FindField('CodAulaTipo').Visible := False;
  end;
end;

procedure TSourceDataModule.PrepareTables;
begin
  PrepareFields;
  TbDistributivo.FindField('Composicion').DisplayWidth := 10;
  ApplyOnTables(SetFieldCaption);
  PrepareLookupFields;
  HideFields;
end;

procedure TSourceDataModule.SetFieldCaption(ADataSet: TDataSet);
var
  i: Integer;
  DisplayLabel: string;
begin
  for i := 0 to ADataSet.Fields.Count - 1 do
  begin
    DisplayLabel := FieldCaption[ADataSet.Fields[i]];
    if DisplayLabel <> '' then
      ADataSet.Fields[i].DisplayLabel := DisplayLabel;
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsource.lrs}
{$ENDIF}

end.

