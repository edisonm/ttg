unit FProfesr;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingEdt, Db, Grids, StdCtrls, Buttons, DBCtrls,
  RelUtils, Variants, ExtCtrls, ComCtrls, Printers, ImgList, ToolWin, ActnList,
  FCrsMMER, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TProfesorForm	= class(TSingleEditorForm)
    BtnProfesorProhibicion: TToolButton;
    BtnDistributivo: TToolButton;
    ActDistributivo: TAction;
    ActProfesorProhibicion: TAction;
    QuProfesorProhibicion: TZQuery;
    QuDistributivo: TZQuery;
    procedure ActProfesorProhibicionExecute(Sender: TObject);
    procedure ActDistributivoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuDistributivoCalcFields(DataSet: TDataSet);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    FDistributivoForm: TSingleEditorForm;
    FProfesorProhibicionForm: TCrossManyToManyEditorRForm;
    procedure PrepareDistributivoExtraFields;
    function GetCargaActual: Integer;
  public
    { Public declarations }
  end;

var
  ProfesorForm: TProfesorForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor, TTGUtls;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TProfesorForm.ActProfesorProhibicionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FProfesorProhibicionForm,
    ConfigStorage, ActProfesorProhibicion) then
  with FProfesorProhibicionForm do
  begin
    Tag := TbProfesor.FindField('CodProfesor').AsInteger;
    QuProfesorProhibicion.Open;
    Caption := Format('%s %s %s - Editando %s', [NameDataSet[TbProfesor],
      TbProfesor.FindField('ApeProfesor').AsString,
      TbProfesor.FindField('NomProfesor').AsString,
      Description[TbProfesorProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbProfesorProhibicion], Description[TbDia], Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [NameDataSet[TbProfesorProhibicionTipo], Description[TbProfesorProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbProfesorProhibicionTipo, QuProfesorProhibicion,
	    TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora', 'NomHora',
      'CodHora', 'CodHora', 'CodProfProhibicionTipo', 'NomProfProhibicionTipo',
      'ColProfProhibicionTipo', 'CodProfProhibicionTipo');
  end;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  Caption := FSuperTitle + Format(' - Carga: %d', [GetCargaActual]);
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
end;

procedure TProfesorForm.ActDistributivoExecute(Sender: TObject);
begin
  with SourceDataModule do
    if TSingleEditorForm.ToggleSingleEditor(Self, FDistributivoForm,
			ConfigStorage, ActDistributivo,	QuDistributivo) then
    begin
      DataSourceDataChange(nil, nil);
    end
end;

function TProfesorForm.GetCargaActual: Integer;
var
  VBookmark: TBookmark;
  FieldComposicion: TField;
begin
  Result := 0;
  with SourceDataModule, QuDistributivo do if Active then
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      FieldComposicion := FindField('Composicion');
      while not Eof do
      begin
        Inc(Result, ComposicionADuracion(FieldComposicion.AsString));
        Next;
      end;
    finally
      GotoBookmark(VBookmark);
      EnableControls;
    end;
  end;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do FSuperTitle := Description[TbProfesor];
  with QuDistributivo do
  begin
    PrepareDataSetFields(QuDistributivo);
    FindField('CodMateria').Visible := False;
    FindField('CodNivel').Visible := False;
    FindField('CodEspecializacion').Visible := False;
    FindField('CodParaleloId').Visible := False;
    FindField('CodProfesor').Visible := False;
    FindField('CodAulaTipo').Visible := False;
    PrepareDistributivoExtraFields;
    Open;
  end;
end;

procedure TProfesorForm.PrepareDistributivoExtraFields;
var
  Field: TField;
begin
  Field := TStringField.Create(QuDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Nivel';
    FieldKind := fkLookup;
    FieldName := 'AbrNivel';
    LookupDataSet := SourceDataModule.TbNivel;
    LookupKeyFields := 'CodNivel';
    LookupResultField := 'AbrNivel';
    KeyFields := 'CodNivel';
    Size := 5;
    Lookup := True;
    DataSet := QuDistributivo;
  end;
  Field := TStringField.Create(QuDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Especializacion';
    FieldKind := fkLookup;
    FieldName := 'AbrEspecializacion';
    LookupDataSet := SourceDataModule.TbEspecializacion;
    LookupKeyFields := 'CodEspecializacion';
    LookupResultField := 'AbrEspecializacion';
    KeyFields := 'CodEspecializacion';
    Size := 10;
    Lookup := True;
    DataSet := QuDistributivo;
  end;
  Field := TStringField.Create(QuDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Paralelo';
    FieldKind := fkLookup;
    FieldName := 'NomParaleloId';
    LookupDataSet := SourceDataModule.TbParaleloId;
    LookupKeyFields := 'CodParaleloId';
    LookupResultField := 'NomParaleloId';
    KeyFields := 'CodParaleloId';
    Size := 5;
    Lookup := True;
    DataSet := QuDistributivo;
  end;
  Field := TStringField.Create(QuDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Materia';
    DisplayWidth := 15;
    FieldKind := fkLookup;
    FieldName := 'NomMateria';
    LookupDataSet := SourceDataModule.TbMateria;
    LookupKeyFields := 'CodMateria';
    LookupResultField := 'NomMateria';
    KeyFields := 'CodMateria';
    Size := 15;
    Lookup := True;
    DataSet := QuDistributivo;
  end;
  Field := TStringField.Create(QuDistributivo.Owner);
  with Field do
  begin
    DisplayLabel := 'Tipo aula';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'AbrAulaTipo';
    LookupDataSet := SourceDataModule.TbAulaTipo;
    LookupKeyFields := 'CodAulaTipo';
    LookupResultField := 'AbrAulaTipo';
    KeyFields := 'CodAulaTipo';
    Size := 10;
    Lookup := True;
    DataSet := QuDistributivo;
  end;
  Field := TLongintField.Create(QuDistributivo.Owner);
  with Field do
  begin
    FieldKind := fkCalculated;
    FieldName := 'Duracion';
    DataSet := QuDistributivo;
  end;
end;

procedure TProfesorForm.QuDistributivoCalcFields(DataSet: TDataSet);
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

initialization

{$IFDEF FPC}
  {$i FProfesr.lrs}
{$ENDIF}

end.
