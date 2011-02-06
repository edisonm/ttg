unit DSrcBase;

(*
  domingo, 06 de febrero de 2011 15:48:31

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  LResources, Sqlite3DS,
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBase;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbAulaTipo: TSqlite3Dataset;
    TbAulaTipoCodAulaTipo:TAutoIncField;
    TbAulaTipoNomAulaTipo:TStringField;
    TbAulaTipoAbrAulaTipo:TStringField;
    TbAulaTipoCantidad:TLongIntField;
    DSAulaTipo: TDataSource;
    TbEspecializacion: TSqlite3Dataset;
    TbEspecializacionCodEspecializacion:TAutoIncField;
    TbEspecializacionNomEspecializacion:TStringField;
    TbEspecializacionAbrEspecializacion:TStringField;
    DSEspecializacion: TDataSource;
    TbDia: TSqlite3Dataset;
    TbDiaCodDia:TAutoIncField;
    TbDiaNomDia:TStringField;
    DSDia: TDataSource;
    TbMateria: TSqlite3Dataset;
    TbMateriaCodMateria:TAutoIncField;
    TbMateriaNomMateria:TStringField;
    DSMateria: TDataSource;
    TbNivel: TSqlite3Dataset;
    TbNivelCodNivel:TAutoIncField;
    TbNivelNomNivel:TStringField;
    TbNivelAbrNivel:TStringField;
    DSNivel: TDataSource;
    TbHora: TSqlite3Dataset;
    TbHoraCodHora:TAutoIncField;
    TbHoraNomHora:TStringField;
    TbHoraIntervalo:TStringField;
    DSHora: TDataSource;
    TbHorario: TSqlite3Dataset;
    TbHorarioCodHorario:TAutoIncField;
    TbHorarioMomentoInicial:TDateTimeField;
    TbHorarioMomentoFinal:TDateTimeField;
    TbHorarioInforme:TMemoField;
    DSHorario: TDataSource;
    TbCurso: TSqlite3Dataset;
    TbCursoCodNivel:TLongIntField;
    TbCursoCodEspecializacion:TLongIntField;
    DSCurso: TDataSource;
    TbParaleloId: TSqlite3Dataset;
    TbParaleloIdCodParaleloId:TAutoIncField;
    TbParaleloIdNomParaleloId:TStringField;
    DSParaleloId: TDataSource;
    TbMateriaProhibicionTipo: TSqlite3Dataset;
    TbMateriaProhibicionTipoCodMateProhibicionTipo:TLongIntField;
    TbMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    TbMateriaProhibicionTipoColMateProhibicionTipo:TLongIntField;
    TbMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    DSMateriaProhibicionTipo: TDataSource;
    TbPeriodo: TSqlite3Dataset;
    TbPeriodoCodDia:TLongIntField;
    TbPeriodoCodHora:TLongIntField;
    DSPeriodo: TDataSource;
    TbParalelo: TSqlite3Dataset;
    TbParaleloCodParalelo:TAutoIncField;
    TbParaleloCodNivel:TLongIntField;
    TbParaleloCodEspecializacion:TLongIntField;
    TbParaleloCodParaleloId:TLongIntField;
    DSParalelo: TDataSource;
    TbProfesor: TSqlite3Dataset;
    TbProfesorCodProfesor:TAutoIncField;
    TbProfesorCedProfesor:TStringField;
    TbProfesorApeProfesor:TStringField;
    TbProfesorNomProfesor:TStringField;
    DSProfesor: TDataSource;
    TbMateriaProhibicion: TSqlite3Dataset;
    TbMateriaProhibicionCodMateria:TLongIntField;
    TbMateriaProhibicionCodDia:TLongIntField;
    TbMateriaProhibicionCodHora:TLongIntField;
    TbMateriaProhibicionCodMateProhibicionTipo:TLongIntField;
    DSMateriaProhibicion: TDataSource;
    TbDistributivo: TSqlite3Dataset;
    TbDistributivoCodMateria:TLongIntField;
    TbDistributivoCodNivel:TLongIntField;
    TbDistributivoCodEspecializacion:TLongIntField;
    TbDistributivoCodParaleloId:TLongIntField;
    TbDistributivoCodProfesor:TLongIntField;
    TbDistributivoCodAulaTipo:TLongIntField;
    TbDistributivoComposicion:TStringField;
    DSDistributivo: TDataSource;
    TbHorarioDetalle: TSqlite3Dataset;
    TbHorarioDetalleCodHorario:TLongIntField;
    TbHorarioDetalleCodMateria:TLongIntField;
    TbHorarioDetalleCodNivel:TLongIntField;
    TbHorarioDetalleCodEspecializacion:TLongIntField;
    TbHorarioDetalleCodParaleloId:TLongIntField;
    TbHorarioDetalleCodDia:TLongIntField;
    TbHorarioDetalleCodHora:TLongIntField;
    TbHorarioDetalleSesion:TLongIntField;
    DSHorarioDetalle: TDataSource;
    TbProfesorProhibicionTipo: TSqlite3Dataset;
    TbProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField;
    TbProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    TbProfesorProhibicionTipoColProfProhibicionTipo:TLongIntField;
    TbProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    DSProfesorProhibicionTipo: TDataSource;
    TbProfesorProhibicion: TSqlite3Dataset;
    TbProfesorProhibicionCodProfesor:TLongIntField;
    TbProfesorProhibicionCodDia:TLongIntField;
    TbProfesorProhibicionCodHora:TLongIntField;
    TbProfesorProhibicionCodProfProhibicionTipo:TLongIntField;
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

initialization
{$IFDEF FPC}
  {$i DSrcBase.lrs}
{$ENDIF}
end.

