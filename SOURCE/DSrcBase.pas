unit DSrcBase;
(*
  miércoles, 28 de abril de 2010 1:02:18

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, dbf,
  DBase;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbAulaTipo: TDbf;
    TbAulaTipoCodAulaTipo:TAutoIncField;
    TbAulaTipoNomAulaTipo:TStringField;
    TbAulaTipoAbrAulaTipo:TStringField;
    TbAulaTipoCantidad:TIntegerField;
    DSAulaTipo: TDataSource;
    TbEspecializacion: TDbf;
    TbEspecializacionCodEspecializacion:TAutoIncField;
    TbEspecializacionNomEspecializacion:TStringField;
    TbEspecializacionAbrEspecializacion:TStringField;
    DSEspecializacion: TDataSource;
    TbDia: TDbf;
    TbDiaCodDia:TAutoIncField;
    TbDiaNomDia:TStringField;
    DSDia: TDataSource;
    TbMateria: TDbf;
    TbMateriaCodMateria:TAutoIncField;
    TbMateriaNomMateria:TStringField;
    DSMateria: TDataSource;
    TbNivel: TDbf;
    TbNivelCodNivel:TAutoIncField;
    TbNivelNomNivel:TStringField;
    TbNivelAbrNivel:TStringField;
    DSNivel: TDataSource;
    TbHora: TDbf;
    TbHoraCodHora:TAutoIncField;
    TbHoraNomHora:TStringField;
    TbHoraIntervalo:TStringField;
    DSHora: TDataSource;
    TbHorario: TDbf;
    TbHorarioCodHorario:TAutoIncField;
    TbHorarioMomentoInicial:TDateTimeField;
    TbHorarioMomentoFinal:TDateTimeField;
    TbHorarioInforme:TMemoField;
    DSHorario: TDataSource;
    TbCurso: TDbf;
    TbCursoCodNivel:TIntegerField;
    TbCursoCodEspecializacion:TIntegerField;
    DSCurso: TDataSource;
    TbParaleloId: TDbf;
    TbParaleloIdCodParaleloId:TAutoIncField;
    TbParaleloIdNomParaleloId:TStringField;
    DSParaleloId: TDataSource;
    TbMateriaProhibicionTipo: TDbf;
    TbMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    TbMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    DSMateriaProhibicionTipo: TDataSource;
    TbPeriodo: TDbf;
    TbPeriodoCodDia:TIntegerField;
    TbPeriodoCodHora:TIntegerField;
    DSPeriodo: TDataSource;
    TbParalelo: TDbf;
    TbParaleloCodNivel:TIntegerField;
    TbParaleloCodEspecializacion:TIntegerField;
    TbParaleloCodParaleloId:TIntegerField;
    DSParalelo: TDataSource;
    TbProfesor: TDbf;
    TbProfesorCodProfesor:TAutoIncField;
    TbProfesorCedProfesor:TStringField;
    TbProfesorApeProfesor:TStringField;
    TbProfesorNomProfesor:TStringField;
    DSProfesor: TDataSource;
    TbMateriaProhibicion: TDbf;
    TbMateriaProhibicionCodMateria:TIntegerField;
    TbMateriaProhibicionCodDia:TIntegerField;
    TbMateriaProhibicionCodHora:TIntegerField;
    TbMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    DSMateriaProhibicion: TDataSource;
    TbDistributivo: TDbf;
    TbDistributivoCodMateria:TIntegerField;
    TbDistributivoCodNivel:TIntegerField;
    TbDistributivoCodEspecializacion:TIntegerField;
    TbDistributivoCodParaleloId:TIntegerField;
    TbDistributivoCodProfesor:TIntegerField;
    TbDistributivoCodAulaTipo:TIntegerField;
    TbDistributivoComposicion:TStringField;
    DSDistributivo: TDataSource;
    TbHorarioDetalle: TDbf;
    TbHorarioDetalleCodHorario:TIntegerField;
    TbHorarioDetalleCodMateria:TIntegerField;
    TbHorarioDetalleCodNivel:TIntegerField;
    TbHorarioDetalleCodEspecializacion:TIntegerField;
    TbHorarioDetalleCodParaleloId:TIntegerField;
    TbHorarioDetalleCodDia:TIntegerField;
    TbHorarioDetalleCodHora:TIntegerField;
    TbHorarioDetalleSesion:TIntegerField;
    DSHorarioDetalle: TDataSource;
    TbProfesorProhibicionTipo: TDbf;
    TbProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField;
    TbProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    TbProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    TbProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    DSProfesorProhibicionTipo: TDataSource;
    TbProfesorProhibicion: TDbf;
    TbProfesorProhibicionCodProfesor:TIntegerField;
    TbProfesorProhibicionCodDia:TIntegerField;
    TbProfesorProhibicionCodHora:TIntegerField;
    TbProfesorProhibicionCodProfProhibicionTipo:TIntegerField;
    DSProfesorProhibicion: TDataSource;

    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;
var
  SourceBaseDataModule: TSourceBaseDataModule;

implementation

{$R *.DFM}

uses RelUtils;


procedure TSourceBaseDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetLength(FTables, 18);
  SetLength(FMasterRels, 18);
  SetLength(FDetailRels, 18);
  SetLength(FBeforePostLocks, 18);
  Tables[0] := TbAulaTipo;
  Tables[1] := TbEspecializacion;
  Tables[2] := TbDia;
  Tables[3] := TbMateria;
  Tables[4] := TbNivel;
  Tables[5] := TbHora;
  Tables[6] := TbHorario;
  Tables[7] := TbCurso;
  Tables[8] := TbParaleloId;
  Tables[9] := TbMateriaProhibicionTipo;
  Tables[10] := TbPeriodo;
  Tables[11] := TbParalelo;
  Tables[12] := TbProfesor;
  Tables[13] := TbMateriaProhibicion;
  Tables[14] := TbDistributivo;
  Tables[15] := TbHorarioDetalle;
  Tables[16] := TbProfesorProhibicionTipo;
  Tables[17] := TbProfesorProhibicion;
  with TbAulaTipo do
  begin
    AddIndex('TbAulaTipoixAbrAulaTipo', 'AbrAulaTipo', [ixUnique]);
    AddIndex('TbAulaTipoixNomAulaTipo', 'NomAulaTipo', [ixUnique]);
    AddIndex('TbAulaTipoPrimaryKey', 'CodAulaTipo', [ixPrimary, ixUnique]);
  end;
  with TbEspecializacion do
  begin
    AddIndex('TbEspecializacionixAbrEspecializacion', 'AbrEspecializacion', [ixUnique]);
    AddIndex('TbEspecializacionixNomEspecializacion', 'NomEspecializacion', [ixUnique]);
    AddIndex('TbEspecializacionPrimaryKey', 'CodEspecializacion', [ixPrimary, ixUnique]);
  end;
  with TbDia do
  begin
    AddIndex('TbDiaixNomDia', 'NomDia', [ixUnique]);
    AddIndex('TbDiaPrimaryKey', 'CodDia', [ixPrimary, ixUnique]);
  end;
  with TbMateria do
  begin
    AddIndex('TbMateriaixNomMateria', 'NomMateria', [ixUnique]);
    AddIndex('TbMateriaPrimaryKey', 'CodMateria', [ixPrimary, ixUnique]);
  end;
  with TbNivel do
  begin
    AddIndex('TbNivelixAbrNivel', 'AbrNivel', [ixUnique]);
    AddIndex('TbNivelixNomNivel', 'NomNivel', [ixUnique]);
    AddIndex('TbNivelPrimaryKey', 'CodNivel', [ixPrimary, ixUnique]);
  end;
  with TbHora do
  begin
    AddIndex('TbHoraixIntervalo', 'Intervalo', [ixUnique]);
    AddIndex('TbHoraixNomHora', 'NomHora', [ixUnique]);
    AddIndex('TbHoraPrimaryKey', 'CodHora', [ixPrimary, ixUnique]);
  end;
  with TbHorario do
  begin
    AddIndex('TbHorarioixMomentoFinal', 'MomentoFinal', []);
    AddIndex('TbHorarioixMomentoInicial', 'MomentoInicial', []);
    AddIndex('TbHorarioPrimaryKey', 'CodHorario', [ixPrimary, ixUnique]);
  end;
  with TbCurso do
  begin
    AddIndex('TbCursoEspecializacionCurso', 'CodEspecializacion', []);
    AddIndex('TbCursoNivelCurso', 'CodNivel', []);
    AddIndex('TbCursoPrimaryKey', 'CodNivel;CodEspecializacion', [ixPrimary, ixUnique]);
  end;
  with TbParaleloId do
  begin
    AddIndex('TbParaleloIdixNomParaleloId', 'NomParaleloId', [ixUnique]);
    AddIndex('TbParaleloIdPrimaryKey', 'CodParaleloId', [ixPrimary, ixUnique]);
  end;
  with TbMateriaProhibicionTipo do
  begin
    AddIndex('TbMateriaProhibicionTipoixNomMateProhibicionTipo', 'NomMateProhibicionTipo', [ixUnique]);
    AddIndex('TbMateriaProhibicionTipoPrimaryKey', 'CodMateProhibicionTipo', [ixPrimary, ixUnique]);
  end;
  with TbPeriodo do
  begin
    AddIndex('TbPeriodoDiaPeriodo', 'CodDia', []);
    AddIndex('TbPeriodoHoraPeriodo', 'CodHora', []);
    AddIndex('TbPeriodoPrimaryKey', 'CodDia;CodHora', [ixPrimary, ixUnique]);
  end;
  with TbParalelo do
  begin
    AddIndex('TbParaleloCursoParalelo', 'CodNivel;CodEspecializacion', []);
    AddIndex('TbParaleloParaleloIdParalelo', 'CodParaleloId', []);
    AddIndex('TbParaleloPrimaryKey', 'CodNivel;CodEspecializacion;CodParaleloId', [ixPrimary, ixUnique]);
  end;
  with TbProfesor do
  begin
    AddIndex('TbProfesorixApeNomProfesor', 'ApeProfesor;NomProfesor', [ixUnique]);
    AddIndex('TbProfesorixNomApeProfesor', 'NomProfesor;ApeProfesor', [ixUnique]);
    AddIndex('TbProfesorPrimaryKey', 'CodProfesor', [ixPrimary, ixUnique]);
  end;
  with TbMateriaProhibicion do
  begin
    AddIndex('TbMateriaProhibicionMateriaMateriaProhibicion', 'CodMateria', []);
    AddIndex('TbMateriaProhibicionMateriaProhibicionTipoMateriaProhibicion', 'CodMateProhibicionTipo', []);
    AddIndex('TbMateriaProhibicionPeriodoMateriaProhibicion', 'CodDia;CodHora', []);
    AddIndex('TbMateriaProhibicionPrimaryKey', 'CodMateria;CodDia;CodHora', [ixPrimary, ixUnique]);
  end;
  with TbDistributivo do
  begin
    AddIndex('TbDistributivoAulaTipoDistributivo', 'CodAulaTipo', []);
    AddIndex('TbDistributivoMateriaDistributivo', 'CodMateria', []);
    AddIndex('TbDistributivoParaleloDistributivo', 'CodNivel;CodEspecializacion;CodParaleloId', []);
    AddIndex('TbDistributivoPrimaryKey', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', [ixPrimary, ixUnique]);
    AddIndex('TbDistributivoProfesorDistributivo', 'CodProfesor', []);
  end;
  with TbHorarioDetalle do
  begin
    AddIndex('TbHorarioDetalleDistributivoHorarioDetalle', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', []);
    AddIndex('TbHorarioDetalleHorarioDetalleCodMateria', 'CodMateria', []);
    AddIndex('TbHorarioDetalleHorarioHorarioDetalle', 'CodHorario', []);
    AddIndex('TbHorarioDetalleixRestriccionMateria', 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora', [ixUnique]);
    AddIndex('TbHorarioDetallePeriodoHorarioDetalle', 'CodDia;CodHora', []);
    AddIndex('TbHorarioDetallePrimaryKey', 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora', [ixPrimary, ixUnique]);
  end;
  with TbProfesorProhibicionTipo do
  begin
    AddIndex('TbProfesorProhibicionTipoixNomProfProhibicionTipo', 'NomProfProhibicionTipo', [ixUnique]);
    AddIndex('TbProfesorProhibicionTipoPrimaryKey', 'CodProfProhibicionTipo', [ixPrimary, ixUnique]);
  end;
  with TbProfesorProhibicion do
  begin
    AddIndex('TbProfesorProhibicionPeriodoProfesorProhibicion', 'CodDia;CodHora', []);
    AddIndex('TbProfesorProhibicionPrimaryKey', 'CodProfesor;CodDia;CodHora', [ixPrimary, ixUnique]);
    AddIndex('TbProfesorProhibicionProfesorProfesorProhibicion', 'CodProfesor', []);
    AddIndex('TbProfesorProhibicionProfesorProhibicionTipoProfesorProhibicion', 'CodProfProhibicionTipo', []);
  end;
  SetLength(FMasterRels[0], 1);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbDistributivo;
    MasterFields := 'CodAulaTipo';
    DetailFields := 'CodAulaTipo';
    Cascade := False;
  end;
  SetLength(FDetailRels[0], 0);
  SetLength(FMasterRels[1], 1);
  with FMasterRels[1, 0] do
  begin
    DetailDataSet := TbCurso;
    MasterFields := 'CodEspecializacion';
    DetailFields := 'CodEspecializacion';
    Cascade := False;
  end;
  SetLength(FDetailRels[1], 0);
  SetLength(FMasterRels[2], 1);
  with FMasterRels[2, 0] do
  begin
    DetailDataSet := TbPeriodo;
    MasterFields := 'CodDia';
    DetailFields := 'CodDia';
    Cascade := False;
  end;
  SetLength(FDetailRels[2], 0);
  SetLength(FMasterRels[3], 2);
  with FMasterRels[3, 0] do
  begin
    DetailDataSet := TbDistributivo;
    MasterFields := 'CodMateria';
    DetailFields := 'CodMateria';
    Cascade := False;
  end;
  with FMasterRels[3, 1] do
  begin
    DetailDataSet := TbMateriaProhibicion;
    MasterFields := 'CodMateria';
    DetailFields := 'CodMateria';
    Cascade := False;
  end;
  SetLength(FDetailRels[3], 0);
  SetLength(FMasterRels[4], 1);
  with FMasterRels[4, 0] do
  begin
    DetailDataSet := TbCurso;
    MasterFields := 'CodNivel';
    DetailFields := 'CodNivel';
    Cascade := False;
  end;
  SetLength(FDetailRels[4], 0);
  SetLength(FMasterRels[5], 1);
  with FMasterRels[5, 0] do
  begin
    DetailDataSet := TbPeriodo;
    MasterFields := 'CodHora';
    DetailFields := 'CodHora';
    Cascade := False;
  end;
  SetLength(FDetailRels[5], 0);
  SetLength(FMasterRels[6], 1);
  with FMasterRels[6, 0] do
  begin
    DetailDataSet := TbHorarioDetalle;
    MasterFields := 'CodHorario';
    DetailFields := 'CodHorario';
    Cascade := True;
  end;
  SetLength(FDetailRels[6], 0);
  SetLength(FMasterRels[7], 1);
  with FMasterRels[7, 0] do
  begin
    DetailDataSet := TbParalelo;
    MasterFields := 'CodNivel;CodEspecializacion';
    DetailFields := 'CodNivel;CodEspecializacion';
    Cascade := False;
  end;
  SetLength(FDetailRels[7], 2);
  with FDetailRels[7, 0] do
  begin
    MasterDataSet := TbEspecializacion;
    MasterFields := 'CodEspecializacion';
    DetailFields := 'CodEspecializacion';
  end;
  with FDetailRels[7, 1] do
  begin
    MasterDataSet := TbNivel;
    MasterFields := 'CodNivel';
    DetailFields := 'CodNivel';
  end;
  SetLength(FMasterRels[8], 1);
  with FMasterRels[8, 0] do
  begin
    DetailDataSet := TbParalelo;
    MasterFields := 'CodParaleloId';
    DetailFields := 'CodParaleloId';
    Cascade := False;
  end;
  SetLength(FDetailRels[8], 0);
  SetLength(FMasterRels[9], 1);
  with FMasterRels[9, 0] do
  begin
    DetailDataSet := TbMateriaProhibicion;
    MasterFields := 'CodMateProhibicionTipo';
    DetailFields := 'CodMateProhibicionTipo';
    Cascade := False;
  end;
  SetLength(FDetailRels[9], 0);
  SetLength(FMasterRels[10], 3);
  with FMasterRels[10, 0] do
  begin
    DetailDataSet := TbHorarioDetalle;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
    Cascade := False;
  end;
  with FMasterRels[10, 1] do
  begin
    DetailDataSet := TbMateriaProhibicion;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
    Cascade := False;
  end;
  with FMasterRels[10, 2] do
  begin
    DetailDataSet := TbProfesorProhibicion;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
    Cascade := False;
  end;
  SetLength(FDetailRels[10], 2);
  with FDetailRels[10, 0] do
  begin
    MasterDataSet := TbDia;
    MasterFields := 'CodDia';
    DetailFields := 'CodDia';
  end;
  with FDetailRels[10, 1] do
  begin
    MasterDataSet := TbHora;
    MasterFields := 'CodHora';
    DetailFields := 'CodHora';
  end;
  SetLength(FMasterRels[11], 1);
  with FMasterRels[11, 0] do
  begin
    DetailDataSet := TbDistributivo;
    MasterFields := 'CodNivel;CodEspecializacion;CodParaleloId';
    DetailFields := 'CodNivel;CodEspecializacion;CodParaleloId';
    Cascade := False;
  end;
  SetLength(FDetailRels[11], 2);
  with FDetailRels[11, 0] do
  begin
    MasterDataSet := TbCurso;
    MasterFields := 'CodNivel;CodEspecializacion';
    DetailFields := 'CodNivel;CodEspecializacion';
  end;
  with FDetailRels[11, 1] do
  begin
    MasterDataSet := TbParaleloId;
    MasterFields := 'CodParaleloId';
    DetailFields := 'CodParaleloId';
  end;
  SetLength(FMasterRels[12], 2);
  with FMasterRels[12, 0] do
  begin
    DetailDataSet := TbDistributivo;
    MasterFields := 'CodProfesor';
    DetailFields := 'CodProfesor';
    Cascade := False;
  end;
  with FMasterRels[12, 1] do
  begin
    DetailDataSet := TbProfesorProhibicion;
    MasterFields := 'CodProfesor';
    DetailFields := 'CodProfesor';
    Cascade := False;
  end;
  SetLength(FDetailRels[12], 0);
  SetLength(FMasterRels[13], 0);
  SetLength(FDetailRels[13], 3);
  with FDetailRels[13, 0] do
  begin
    MasterDataSet := TbMateria;
    MasterFields := 'CodMateria';
    DetailFields := 'CodMateria';
  end;
  with FDetailRels[13, 1] do
  begin
    MasterDataSet := TbMateriaProhibicionTipo;
    MasterFields := 'CodMateProhibicionTipo';
    DetailFields := 'CodMateProhibicionTipo';
  end;
  with FDetailRels[13, 2] do
  begin
    MasterDataSet := TbPeriodo;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
  end;
  SetLength(FMasterRels[14], 1);
  with FMasterRels[14, 0] do
  begin
    DetailDataSet := TbHorarioDetalle;
    MasterFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    DetailFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    Cascade := False;
  end;
  SetLength(FDetailRels[14], 4);
  with FDetailRels[14, 0] do
  begin
    MasterDataSet := TbAulaTipo;
    MasterFields := 'CodAulaTipo';
    DetailFields := 'CodAulaTipo';
  end;
  with FDetailRels[14, 1] do
  begin
    MasterDataSet := TbMateria;
    MasterFields := 'CodMateria';
    DetailFields := 'CodMateria';
  end;
  with FDetailRels[14, 2] do
  begin
    MasterDataSet := TbParalelo;
    MasterFields := 'CodNivel;CodEspecializacion;CodParaleloId';
    DetailFields := 'CodNivel;CodEspecializacion;CodParaleloId';
  end;
  with FDetailRels[14, 3] do
  begin
    MasterDataSet := TbProfesor;
    MasterFields := 'CodProfesor';
    DetailFields := 'CodProfesor';
  end;
  SetLength(FMasterRels[15], 0);
  SetLength(FDetailRels[15], 3);
  with FDetailRels[15, 0] do
  begin
    MasterDataSet := TbDistributivo;
    MasterFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    DetailFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
  end;
  with FDetailRels[15, 1] do
  begin
    MasterDataSet := TbHorario;
    MasterFields := 'CodHorario';
    DetailFields := 'CodHorario';
  end;
  with FDetailRels[15, 2] do
  begin
    MasterDataSet := TbPeriodo;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
  end;
  SetLength(FMasterRels[16], 1);
  with FMasterRels[16, 0] do
  begin
    DetailDataSet := TbProfesorProhibicion;
    MasterFields := 'CodProfProhibicionTipo';
    DetailFields := 'CodProfProhibicionTipo';
    Cascade := False;
  end;
  SetLength(FDetailRels[16], 0);
  SetLength(FMasterRels[17], 0);
  SetLength(FDetailRels[17], 3);
  with FDetailRels[17, 0] do
  begin
    MasterDataSet := TbPeriodo;
    MasterFields := 'CodDia;CodHora';
    DetailFields := 'CodDia;CodHora';
  end;
  with FDetailRels[17, 1] do
  begin
    MasterDataSet := TbProfesor;
    MasterFields := 'CodProfesor';
    DetailFields := 'CodProfesor';
  end;
  with FDetailRels[17, 2] do
  begin
    MasterDataSet := TbProfesorProhibicionTipo;
    MasterFields := 'CodProfProhibicionTipo';
    DetailFields := 'CodProfProhibicionTipo';
  end;
  with DataSetNameList do
  begin
    Add('TbAulaTipo=AulaTipo');
    Add('TbEspecializacion=Especializacion');
    Add('TbDia=Dia');
    Add('TbMateria=Materia');
    Add('TbNivel=Nivel');
    Add('TbHora=Hora');
    Add('TbHorario=Horario');
    Add('TbCurso=Curso');
    Add('TbParaleloId=ParaleloId');
    Add('TbMateriaProhibicionTipo=MateriaProhibicionTipo');
    Add('TbPeriodo=Periodo');
    Add('TbParalelo=Paralelo');
    Add('TbProfesor=Profesor');
    Add('TbMateriaProhibicion=MateriaProhibicion');
    Add('TbDistributivo=Distributivo');
    Add('TbHorarioDetalle=HorarioDetalle');
    Add('TbProfesorProhibicionTipo=ProfesorProhibicionTipo');
    Add('TbProfesorProhibicion=ProfesorProhibicion');
  end;
  with DataSetDescList do
  begin
    Add('TbAulaTipo=Tipos de aula');
    Add('TbEspecializacion=Especializaciones');
    Add('TbDia=Días laborables');
    Add('TbMateria=Materias');
    Add('TbNivel=Niveles');
    Add('TbHora=Horas académicas');
    Add('TbHorario=Horarios del colegio');
    Add('TbCurso=Cursos');
    Add('TbParaleloId=Identificadores de paralelo');
    Add('TbMateriaProhibicionTipo=Tipos de prohibición de materia');
    Add('TbPeriodo=Períodos laborables');
    Add('TbParalelo=Paralelos');
    Add('TbProfesor=Profesores');
    Add('TbMateriaProhibicion=Prohibiciones de materia');
    Add('TbDistributivo=Distributivo');
    Add('TbHorarioDetalle=Detalle de los horarios');
    Add('TbProfesorProhibicionTipo=Tipos de prohibición de profesor');
    Add('TbProfesorProhibicion=Prohibiciones de profesor');
  end;
end;

end.

