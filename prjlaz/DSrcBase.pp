unit DSrcBase;

(*
  jueves, 24 de febrero de 2011 1:42:42

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBase, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbAulaTipo: TZTable;
    DSAulaTipo: TDataSource;
    TbEspecializacion: TZTable;
    DSEspecializacion: TDataSource;
    TbDia: TZTable;
    DSDia: TDataSource;
    TbMateria: TZTable;
    DSMateria: TDataSource;
    TbNivel: TZTable;
    DSNivel: TDataSource;
    TbHora: TZTable;
    DSHora: TDataSource;
    TbHorario: TZTable;
    DSHorario: TDataSource;
    TbCurso: TZTable;
    DSCurso: TDataSource;
    TbParaleloId: TZTable;
    DSParaleloId: TDataSource;
    TbMateriaProhibicionTipo: TZTable;
    DSMateriaProhibicionTipo: TDataSource;
    TbPeriodo: TZTable;
    DSPeriodo: TDataSource;
    TbParalelo: TZTable;
    DSParalelo: TDataSource;
    TbProfesor: TZTable;
    DSProfesor: TDataSource;
    TbMateriaProhibicion: TZTable;
    DSMateriaProhibicion: TDataSource;
    TbDistributivo: TZTable;
    DSDistributivo: TDataSource;
    TbHorarioDetalle: TZTable;
    DSHorarioDetalle: TDataSource;
    TbProfesorProhibicionTipo: TZTable;
    DSProfesorProhibicionTipo: TDataSource;
    TbProfesorProhibicion: TZTable;
    DSProfesorProhibicion: TDataSource;

    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;
var
  SourceBaseDataModule: TSourceBaseDataModule;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

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
  SetLength(FMasterRels[0], 1);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbDistributivo;
    MasterFields := 'CodAulaTipo';
    DetailFields := 'CodAulaTipo';
    Cascade := False;
  end;
  SetLength(FMasterRels[1], 1);
  with FMasterRels[1, 0] do
  begin
    DetailDataSet := TbCurso;
    MasterFields := 'CodEspecializacion';
    DetailFields := 'CodEspecializacion';
    Cascade := False;
  end;
  SetLength(FMasterRels[2], 1);
  with FMasterRels[2, 0] do
  begin
    DetailDataSet := TbPeriodo;
    MasterFields := 'CodDia';
    DetailFields := 'CodDia';
    Cascade := False;
  end;
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
  SetLength(FMasterRels[4], 1);
  with FMasterRels[4, 0] do
  begin
    DetailDataSet := TbCurso;
    MasterFields := 'CodNivel';
    DetailFields := 'CodNivel';
    Cascade := False;
  end;
  SetLength(FMasterRels[5], 1);
  with FMasterRels[5, 0] do
  begin
    DetailDataSet := TbPeriodo;
    MasterFields := 'CodHora';
    DetailFields := 'CodHora';
    Cascade := False;
  end;
  SetLength(FMasterRels[6], 1);
  with FMasterRels[6, 0] do
  begin
    DetailDataSet := TbHorarioDetalle;
    MasterFields := 'CodHorario';
    DetailFields := 'CodHorario';
    Cascade := True;
  end;
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
  SetLength(FMasterRels[9], 1);
  with FMasterRels[9, 0] do
  begin
    DetailDataSet := TbMateriaProhibicion;
    MasterFields := 'CodMateProhibicionTipo';
    DetailFields := 'CodMateProhibicionTipo';
    Cascade := False;
  end;
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
  with FieldCaptionList do
  begin
    Add('TbAulaTipo.CodAulaTipo=Codigo');
    Add('TbAulaTipo.NomAulaTipo=Nombre');
    Add('TbAulaTipo.AbrAulaTipo=Abreviatura');
    Add('TbEspecializacion.CodEspecializacion=Codigo');
    Add('TbEspecializacion.NomEspecializacion=Nombre');
    Add('TbEspecializacion.AbrEspecializacion=Abreviatura');
    Add('TbDia.CodDia=Codigo');
    Add('TbDia.NomDia=Nombre');
    Add('TbMateria.CodMateria=Codigo');
    Add('TbMateria.NomMateria=Nombre');
    Add('TbNivel.CodNivel=Codigo');
    Add('TbNivel.NomNivel=Nombre');
    Add('TbNivel.AbrNivel=Abreviatura');
    Add('TbHora.CodHora=Codigo');
    Add('TbHora.NomHora=Nombre');
    Add('TbHorario.CodHorario=Codigo');
    Add('TbHorario.MomentoInicial=Momento Inicial');
    Add('TbHorario.MomentoFinal=Momento Final');
    Add('TbCurso.CodNivel=Nivel');
    Add('TbCurso.CodEspecializacion=Especialización');
    Add('TbParaleloId.CodParaleloId=Codigo');
    Add('TbParaleloId.NomParaleloId=Nombre');
    Add('TbMateriaProhibicionTipo.CodMateProhibicionTipo=Codigo');
    Add('TbMateriaProhibicionTipo.NomMateProhibicionTipo=Nombre');
    Add('TbMateriaProhibicionTipo.ColMateProhibicionTipo=Color');
    Add('TbMateriaProhibicionTipo.ValMateProhibicionTipo=Valor');
    Add('TbPeriodo.CodDia=Dia');
    Add('TbPeriodo.CodHora=Hora');
    Add('TbParalelo.CodNivel=Nivel');
    Add('TbParalelo.CodEspecializacion=Especializacion');
    Add('TbParalelo.CodParaleloId=Paralelo');
    Add('TbProfesor.CodProfesor=Codigo');
    Add('TbProfesor.CedProfesor=Cedula');
    Add('TbProfesor.ApeProfesor=Apellido');
    Add('TbProfesor.NomProfesor=Nombre');
    Add('TbMateriaProhibicion.CodMateria=Materia');
    Add('TbMateriaProhibicion.CodDia=Dia');
    Add('TbMateriaProhibicion.CodHora=Hora');
    Add('TbMateriaProhibicion.CodMateProhibicionTipo=Tipo de Prohibicion');
    Add('TbDistributivo.CodMateria=Materia');
    Add('TbDistributivo.CodNivel=Nivel');
    Add('TbDistributivo.CodEspecializacion=Especializacion');
    Add('TbDistributivo.CodParaleloId=Paralelo');
    Add('TbDistributivo.CodProfesor=Profesor');
    Add('TbDistributivo.CodAulaTipo=Tipo de Aula');
    Add('TbHorarioDetalle.CodHorario=Horario');
    Add('TbHorarioDetalle.CodMateria=Materia');
    Add('TbHorarioDetalle.CodNivel=Nivel');
    Add('TbHorarioDetalle.CodEspecializacion=Especializacion');
    Add('TbHorarioDetalle.CodParaleloId=Paralelo');
    Add('TbHorarioDetalle.CodDia=Dia');
    Add('TbHorarioDetalle.CodHora=Hora');
    Add('TbProfesorProhibicionTipo.CodProfProhibicionTipo=Codigo');
    Add('TbProfesorProhibicionTipo.NomProfProhibicionTipo=Nombre');
    Add('TbProfesorProhibicionTipo.ColProfProhibicionTipo=Color');
    Add('TbProfesorProhibicionTipo.ValProfProhibicionTipo=Valor');
    Add('TbProfesorProhibicion.CodProfesor=Profesor');
    Add('TbProfesorProhibicion.CodDia=Dia');
    Add('TbProfesorProhibicion.CodHora=Hora');
    Add('TbProfesorProhibicion.CodProfProhibicionTipo=Tipo de prohibicion');
  end;
  with DataSetDescList do
  begin
    Add('TbAulaTipo=Tipos de aula');
    Add('TbEspecializacion=Especializaciones');
    Add('TbDia=Dias laborables');
    Add('TbMateria=Materias');
    Add('TbNivel=Niveles');
    Add('TbHora=Horas academicas');
    Add('TbHorario=Horarios del colegio');
    Add('TbCurso=Cursos');
    Add('TbParaleloId=Identificadores de paralelo');
    Add('TbMateriaProhibicionTipo=Tipos de prohibicion de materia');
    Add('TbPeriodo=Periodos laborables');
    Add('TbParalelo=Paralelos');
    Add('TbProfesor=Profesores');
    Add('TbMateriaProhibicion=Prohibiciones de materia');
    Add('TbDistributivo=Distributivo');
    Add('TbHorarioDetalle=Detalle de los horarios');
    Add('TbProfesorProhibicionTipo=Tipos de prohibicion de profesor');
    Add('TbProfesorProhibicion=Prohibiciones de profesor');
  end;
end;

initialization
{$IFDEF FPC}
  {$i DSrcBase.lrs}
{$ENDIF}
end.

