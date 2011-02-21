unit FProfesr;

{$I TTG.inc}

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
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QuDistributivoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FLbCarga: TLabel;
    FSuperTitle: string;
    FDistributivoForm: TSingleEditorForm;
    FProfesorProhibicionForm: TCrossManyToManyEditorRForm;
    procedure EdQuProfesorDistributivoDestroy(Sender: TObject);
    procedure LbCargaDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PrepareDistributivoExtraFields;
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
    Caption := Format('%s %s - Editando %s', [
    		      NameDataSet[TbProfesor],
		      TbProfesor.FindField('ApeNomProfesor').Value,
		      Description[TbProfesorProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ', [
			    Description[TbProfesorProhibicion],
			    Description[TbDia],
			    Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda', [
			   NameDataSet[TbProfesorProhibicionTipo],
			   Description[TbProfesorProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbProfesorProhibicionTipo, QuProfesorProhibicion,
	       TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
	       'NomHora', 'CodHora', 'CodHora', 'CodProfProhibicionTipo',
	       'NomProfProhibicionTipo', 'ColProfProhibicionTipo',
	       'CodProfProhibicionTipo');
    Tag := TbProfesor.FindField('CodProfesor').AsInteger;
    OnActivate := FormActivate;
  end;
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
end;

procedure TProfesorForm.ActDistributivoExecute(Sender: TObject);
begin
  with SourceDataModule do
    if TSingleEditorForm.ToggleSingleEditor(Self,
  				  FDistributivoForm,
					  ConfigStorage,
					  ActDistributivo,
					  QuDistributivo) then
    begin
      TbParalelo.First;
      QuDistributivo.First;
      Self.DataSource.OnDataChange := DataSourceDataChange;
      FLbCarga.Parent := FDistributivoForm.pnlStatus;
      FLbCarga.Top := 1;
      FLbCarga.Left := 400;
      FLbCarga.OnDblClick := LbCargaDblClick;
      FDistributivoForm.OnDestroy := EdQuProfesorDistributivoDestroy;
      FSuperTitle := FDistributivoForm.Caption;
      DataSourceDataChange(nil, nil);
    end
end;

procedure TProfesorForm.LbCargaDblClick(Sender: TObject);
begin
  DataSourceDataChange(nil, nil);
end;

procedure TProfesorForm.EdQuProfesorDistributivoDestroy(Sender: TObject);
begin
  (Sender as TEditorForm).FormDestroy(Sender);
  DataSource.OnDataChange := nil;
  FLbCarga.Parent := nil;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  FLbCarga.Caption := Format('Carga: %d', [MasterDataModule.GetCargaActual]);
  FDistributivoForm.Caption := FSuperTitle + ' - ' +
    SourceDataModule.TbProfesor.FindField('ApeNomProfesor').AsString;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  FLbCarga := TLabel.Create(Self);
  QuProfesorProhibicion.Open;
  PrepareDataSetFields(QuDistributivo);
  with QuDistributivo do
  begin
    FindField('CodMateria').Visible := False;
    FindField('CodNivel').Visible := False;
    FindField('CodEspecializacion').Visible := False;
    FindField('CodParaleloId').Visible := False;
    FindField('CodProfesor').Visible := False;
    FindField('CodAulaTipo').Visible := False;
  end;
  PrepareDistributivoExtraFields;
  QuDistributivo.Open;
end;

procedure TProfesorForm.PrepareDistributivoExtraFields;
var
  Field: TField;
begin
  Field := TWideStringField.Create(QuDistributivo);
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
  Field := TWideStringField.Create(QuDistributivo);
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
  Field := TWideStringField.Create(QuDistributivo);
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
  Field := TWideStringField.Create(QuDistributivo);
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
  Field := TWideStringField.Create(QuDistributivo);
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
  Field := TIntegerField.Create(QuDistributivo);
  with Field do
  begin
    FieldKind := fkCalculated;
    FieldName := 'Duracion';
    Calculated := True;
    DataSet := QuDistributivo;
  end;
end;

procedure TProfesorForm.QuDistributivoCalcFields(DataSet: TDataSet);
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

procedure TProfesorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FDistributivoForm) then
  begin
    FDistributivoForm.OnDestroy := nil;
    DataSource.OnDataChange := nil;
    FLbCarga.Free;
  end;
  inherited;
end;

initialization

{$IFDEF FPC}
  {$i FProfesr.lrs}
{$ENDIF}

end.
