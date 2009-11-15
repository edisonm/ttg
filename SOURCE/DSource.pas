unit DSource;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DSrcBase, Db, kbmMemTable;

type
  TSourceDataModule = class(TSourceBaseDataModule)
    kbmCursoAbrNivel: TStringField;
    kbmCursoAbrEspecializacion: TStringField;
    kbmCursoAbrCurso: TStringField;
    kbmProfesorApeNomProfesor: TStringField;
    kbmCargaAcademicaApeNomProfesor: TStringField;
    kbmCargaAcademicaNomMateria: TStringField;
    kbmCargaAcademicaAbrNivel: TStringField;
    kbmCargaAcademicaAbrEspecializacion: TStringField;
    kbmCargaAcademicaNomParaleloId: TStringField;
    kbmCargaAcademicaComposicion: TStringField;
    kbmCargaAcademicaDuracion: TIntegerField;
    kbmHorarioTiempo: TTimeField;
    kbmHorarioDetalleNomMateria: TStringField;
    TbProfesorProhibicionNomProfProhibicionTipo: TStringField;
    TbMateriaProhibicionNomMateProhibicionTipo: TStringField;
    kbmAsignaturaNomMateria: TStringField;
    kbmParaleloAbrNivel: TStringField;
    kbmParaleloAbrEspecializacion: TStringField;
    kbmParaleloNomParaleloId: TStringField;
    procedure kbmEspecializacionBeforePost(DataSet: TDataSet);
    procedure kbmCursoCalcFields(DataSet: TDataSet);
    procedure kbmProfesorCalcFields(DataSet: TDataSet);
    procedure kbmCargaAcademicaCalcFields(DataSet: TDataSet);
    procedure kbmHorarioCalcFields(DataSet: TDataSet);
    procedure kbmAsignaturaBeforePost(DataSet: TDataSet);
    procedure kbmCargaAcademicaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$R *.DFM}
uses
  SGHCUtls;

procedure TSourceDataModule.kbmEspecializacionBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSetBeforePost(DataSet);
end;

procedure TSourceDataModule.kbmCursoCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['AbrCurso'] := DataSet['AbrNivel'] + ' ' +
    DataSet['AbrEspecializacion'];
end;

procedure TSourceDataModule.kbmProfesorCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
    FieldValues['ApeNomProfesor'] := FieldValues['ApeProfesor'] + ' ' +
      FieldValues['NomProfesor'];
end;

procedure TSourceDataModule.kbmCargaAcademicaCalcFields(DataSet: TDataSet);
var
  v: Variant;
begin
  inherited;
  try
    v := kbmAsignatura.Lookup('CodMateria;CodNivel;CodEspecializacion',
      VarArrayOf([kbmCargaAcademicaCodMateria.AsInteger,
      kbmCargaAcademicaCodNivel.AsInteger,
        kbmCargaAcademicaCodEspecializacion.AsInteger]),
        'Composicion');
    DataSet['Composicion'] := v;
    DataSet['Duracion'] := ComposicionADuracion(VarToStr(v));
  except
  end;
end;

procedure TSourceDataModule.kbmHorarioCalcFields(DataSet: TDataSet);
begin
  inherited;
  kbmHorarioTiempo.Value := kbmHorarioMomentoFinal.Value -
    kbmHorarioMomentoInicial.Value;
end;

procedure TSourceDataModule.kbmAsignaturaBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited;
  s := kbmAsignaturaComposicion.Value;
  if ComposicionADuracion(s) <= 0 then
    raise Exception.CreateFmt('Composición no válida: "%s"', [s]);
  kbmAsignaturaCodMateria.DefaultExpression :=
    kbmAsignaturaCodMateria.AsString;
  kbmAsignaturaCodNivel.DefaultExpression :=
    kbmAsignaturaCodNivel.AsString;
  kbmAsignaturaCodEspecializacion.DefaultExpression :=
    kbmAsignaturaCodEspecializacion.AsString;
  kbmAsignaturaCodAulaTipo.DefaultExpression :=
    kbmAsignaturaCodAulaTipo.AsString;
end;

procedure TSourceDataModule.kbmCargaAcademicaBeforePost(DataSet: TDataSet);
begin
  inherited;
  if VarIsNull(DataSet['Composicion']) then
    raise Exception.Create('Materia no asignada a este Paralelo');
  kbmCargaAcademicaCodMateria.DefaultExpression :=
    kbmCargaAcademicaCodMateria.AsString;
  kbmCargaAcademicaCodNivel.DefaultExpression :=
    kbmCargaAcademicaCodNivel.AsString;
  kbmCargaAcademicaCodEspecializacion.DefaultExpression :=
    kbmCargaAcademicaCodEspecializacion.AsString;
  kbmCargaAcademicaCodParaleloId.DefaultExpression :=
    kbmCargaAcademicaCodParaleloId.AsString;
end;

end.

