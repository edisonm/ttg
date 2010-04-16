unit DSrcBase;
(*
  viernes, 16 de abril de 2010 16:16:15

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, KbmMemTable,
  DBase;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbAulaTipo: TkbmMemTable;
    TbAulaTipoCodAulaTipo:TAutoIncField;
    TbAulaTipoNomAulaTipo:TStringField;
    TbAulaTipoAbrAulaTipo:TStringField;
    TbAulaTipoCantidad:TIntegerField;
    DSAulaTipo: TDataSource;
    TbEspecializacion: TkbmMemTable;
    TbEspecializacionCodEspecializacion:TAutoIncField;
    TbEspecializacionNomEspecializacion:TStringField;
    TbEspecializacionAbrEspecializacion:TStringField;
    DSEspecializacion: TDataSource;
    TbDia: TkbmMemTable;
    TbDiaCodDia:TAutoIncField;
    TbDiaNomDia:TStringField;
    DSDia: TDataSource;
    TbMateria: TkbmMemTable;
    TbMateriaCodMateria:TAutoIncField;
    TbMateriaNomMateria:TStringField;
    DSMateria: TDataSource;
    TbNivel: TkbmMemTable;
    TbNivelCodNivel:TAutoIncField;
    TbNivelNomNivel:TStringField;
    TbNivelAbrNivel:TStringField;
    DSNivel: TDataSource;
    TbHora: TkbmMemTable;
    TbHoraCodHora:TAutoIncField;
    TbHoraNomHora:TStringField;
    TbHoraIntervalo:TStringField;
    DSHora: TDataSource;
    TbHorario: TkbmMemTable;
    TbHorarioCodHorario:TAutoIncField;
    TbHorarioMomentoInicial:TDateTimeField;
    TbHorarioMomentoFinal:TDateTimeField;
    TbHorarioInforme:TMemoField;
    DSHorario: TDataSource;
    TbCurso: TkbmMemTable;
    TbCursoCodNivel:TIntegerField;
    TbCursoCodEspecializacion:TIntegerField;
    DSCurso: TDataSource;
    TbParaleloId: TkbmMemTable;
    TbParaleloIdCodParaleloId:TAutoIncField;
    TbParaleloIdNomParaleloId:TStringField;
    DSParaleloId: TDataSource;
    TbMateriaProhibicionTipo: TkbmMemTable;
    TbMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    TbMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    DSMateriaProhibicionTipo: TDataSource;
    TbPeriodo: TkbmMemTable;
    TbPeriodoCodDia:TIntegerField;
    TbPeriodoCodHora:TIntegerField;
    DSPeriodo: TDataSource;
    TbParalelo: TkbmMemTable;
    TbParaleloCodNivel:TIntegerField;
    TbParaleloCodEspecializacion:TIntegerField;
    TbParaleloCodParaleloId:TIntegerField;
    DSParalelo: TDataSource;
    TbProfesor: TkbmMemTable;
    TbProfesorCodProfesor:TAutoIncField;
    TbProfesorCedProfesor:TStringField;
    TbProfesorApeProfesor:TStringField;
    TbProfesorNomProfesor:TStringField;
    DSProfesor: TDataSource;
    TbMateriaProhibicion: TkbmMemTable;
    TbMateriaProhibicionCodMateria:TIntegerField;
    TbMateriaProhibicionCodDia:TIntegerField;
    TbMateriaProhibicionCodHora:TIntegerField;
    TbMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    DSMateriaProhibicion: TDataSource;
    TbDistributivo: TkbmMemTable;
    TbDistributivoCodMateria:TIntegerField;
    TbDistributivoCodNivel:TIntegerField;
    TbDistributivoCodEspecializacion:TIntegerField;
    TbDistributivoCodParaleloId:TIntegerField;
    TbDistributivoCodProfesor:TIntegerField;
    TbDistributivoCodAulaTipo:TIntegerField;
    TbDistributivoComposicion:TStringField;
    DSDistributivo: TDataSource;
    TbHorarioDetalle: TkbmMemTable;
    TbHorarioDetalleCodHorario:TIntegerField;
    TbHorarioDetalleCodMateria:TIntegerField;
    TbHorarioDetalleCodNivel:TIntegerField;
    TbHorarioDetalleCodEspecializacion:TIntegerField;
    TbHorarioDetalleCodParaleloId:TIntegerField;
    TbHorarioDetalleCodDia:TIntegerField;
    TbHorarioDetalleCodHora:TIntegerField;
    TbHorarioDetalleSesion:TIntegerField;
    DSHorarioDetalle: TDataSource;
    TbProfesorProhibicionTipo: TkbmMemTable;
    TbProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField;
    TbProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    TbProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    TbProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    DSProfesorProhibicionTipo: TDataSource;
    TbProfesorProhibicion: TkbmMemTable;
    TbProfesorProhibicionCodProfesor:TIntegerField;
    TbProfesorProhibicionCodDia:TIntegerField;
    TbProfesorProhibicionCodHora:TIntegerField;
    TbProfesorProhibicionCodProfProhibicionTipo:TIntegerField;
    DSProfesorProhibicion: TDataSource;

    procedure TbAulaTipoBeforePost(DataSet: TDataSet);
    procedure TbAulaTipoBeforeDelete(DataSet: TDataSet);
    procedure TbEspecializacionBeforePost(DataSet: TDataSet);
    procedure TbEspecializacionBeforeDelete(DataSet: TDataSet);
    procedure TbDiaBeforePost(DataSet: TDataSet);
    procedure TbDiaBeforeDelete(DataSet: TDataSet);
    procedure TbMateriaBeforePost(DataSet: TDataSet);
    procedure TbMateriaBeforeDelete(DataSet: TDataSet);
    procedure TbNivelBeforePost(DataSet: TDataSet);
    procedure TbNivelBeforeDelete(DataSet: TDataSet);
    procedure TbHoraBeforePost(DataSet: TDataSet);
    procedure TbHoraBeforeDelete(DataSet: TDataSet);
    procedure TbHorarioBeforePost(DataSet: TDataSet);
    procedure TbHorarioBeforeDelete(DataSet: TDataSet);
    procedure TbCursoBeforePost(DataSet: TDataSet);
    procedure TbCursoBeforeDelete(DataSet: TDataSet);
    procedure TbParaleloIdBeforePost(DataSet: TDataSet);
    procedure TbParaleloIdBeforeDelete(DataSet: TDataSet);
    procedure TbMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure TbMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure TbPeriodoBeforePost(DataSet: TDataSet);
    procedure TbPeriodoBeforeDelete(DataSet: TDataSet);
    procedure TbParaleloBeforePost(DataSet: TDataSet);
    procedure TbParaleloBeforeDelete(DataSet: TDataSet);
    procedure TbProfesorBeforePost(DataSet: TDataSet);
    procedure TbProfesorBeforeDelete(DataSet: TDataSet);
    procedure TbMateriaProhibicionBeforePost(DataSet: TDataSet);
    procedure TbDistributivoBeforePost(DataSet: TDataSet);
    procedure TbDistributivoBeforeDelete(DataSet: TDataSet);
    procedure TbHorarioDetalleBeforePost(DataSet: TDataSet);
    procedure TbProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure TbProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure TbProfesorProhibicionBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;
var
  SourceBaseDataModule: TSourceBaseDataModule;

implementation

{$R *.DFM}

uses RelUtils;

procedure TSourceBaseDataModule.TbAulaTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[0] then
  begin
    FBeforePostLocks[0] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
      end;
    finally
      FBeforePostLocks[0] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbAulaTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
  end;
end;

procedure TSourceBaseDataModule.TbEspecializacionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[1] then
  begin
    FBeforePostLocks[1] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbCurso, 'CodEspecializacion', 'CodEspecializacion', False);
      end;
    finally
      FBeforePostLocks[1] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbEspecializacionBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbCurso, 'CodEspecializacion', 'CodEspecializacion', False);
  end;
end;

procedure TSourceBaseDataModule.TbDiaBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[2] then
  begin
    FBeforePostLocks[2] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbPeriodo, 'CodDia', 'CodDia', False);
      end;
    finally
      FBeforePostLocks[2] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbDiaBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbPeriodo, 'CodDia', 'CodDia', False);
  end;
end;

procedure TSourceBaseDataModule.TbMateriaBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[3] then
  begin
    FBeforePostLocks[3] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbDistributivo, 'CodMateria', 'CodMateria', False);
        CheckMasterRelationUpdate(DataSet, TbMateriaProhibicion, 'CodMateria', 'CodMateria', False);
      end;
    finally
      FBeforePostLocks[3] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbMateriaBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbDistributivo, 'CodMateria', 'CodMateria', False);
    CheckMasterRelationDelete(DataSet, TbMateriaProhibicion, 'CodMateria', 'CodMateria', False);
  end;
end;

procedure TSourceBaseDataModule.TbNivelBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[4] then
  begin
    FBeforePostLocks[4] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbCurso, 'CodNivel', 'CodNivel', False);
      end;
    finally
      FBeforePostLocks[4] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbNivelBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbCurso, 'CodNivel', 'CodNivel', False);
  end;
end;

procedure TSourceBaseDataModule.TbHoraBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[5] then
  begin
    FBeforePostLocks[5] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbPeriodo, 'CodHora', 'CodHora', False);
      end;
    finally
      FBeforePostLocks[5] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbHoraBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbPeriodo, 'CodHora', 'CodHora', False);
  end;
end;

procedure TSourceBaseDataModule.TbHorarioBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[6] then
  begin
    FBeforePostLocks[6] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbHorarioDetalle, 'CodHorario', 'CodHorario', True);
      end;
    finally
      FBeforePostLocks[6] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbHorarioBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbHorarioDetalle, 'CodHorario', 'CodHorario', True);
  end;
end;

procedure TSourceBaseDataModule.TbCursoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[7] then
  begin
    FBeforePostLocks[7] := True;
    try
      CheckDetailRelation(TbEspecializacion, DataSet, 'CodEspecializacion', 'CodEspecializacion');
      CheckDetailRelation(TbNivel, DataSet, 'CodNivel', 'CodNivel');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
      end;
    finally
      FBeforePostLocks[7] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbCursoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
  end;
end;

procedure TSourceBaseDataModule.TbParaleloIdBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[8] then
  begin
    FBeforePostLocks[8] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbParalelo, 'CodParaleloId', 'CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[8] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbParaleloIdBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbParalelo, 'CodParaleloId', 'CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.TbMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[9] then
  begin
    FBeforePostLocks[9] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
      end;
    finally
      FBeforePostLocks[9] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
  end;
end;

procedure TSourceBaseDataModule.TbPeriodoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[10] then
  begin
    FBeforePostLocks[10] := True;
    try
      CheckDetailRelation(TbDia, DataSet, 'CodDia', 'CodDia');
      CheckDetailRelation(TbHora, DataSet, 'CodHora', 'CodHora');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
        CheckMasterRelationUpdate(DataSet, TbMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
        CheckMasterRelationUpdate(DataSet, TbProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
      end;
    finally
      FBeforePostLocks[10] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbPeriodoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
    CheckMasterRelationDelete(DataSet, TbMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
    CheckMasterRelationDelete(DataSet, TbProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  end;
end;

procedure TSourceBaseDataModule.TbParaleloBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[11] then
  begin
    FBeforePostLocks[11] := True;
    try
      CheckDetailRelation(TbCurso, DataSet, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion');
      CheckDetailRelation(TbParaleloId, DataSet, 'CodParaleloId', 'CodParaleloId');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbDistributivo, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[11] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbParaleloBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbDistributivo, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.TbProfesorBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[12] then
  begin
    FBeforePostLocks[12] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbDistributivo, 'CodProfesor', 'CodProfesor', False);
        CheckMasterRelationUpdate(DataSet, TbProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
      end;
    finally
      FBeforePostLocks[12] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbProfesorBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbDistributivo, 'CodProfesor', 'CodProfesor', False);
    CheckMasterRelationDelete(DataSet, TbProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
  end;
end;

procedure TSourceBaseDataModule.TbMateriaProhibicionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[13] then
  begin
    FBeforePostLocks[13] := True;
    try
      CheckDetailRelation(TbMateria, DataSet, 'CodMateria', 'CodMateria');
      CheckDetailRelation(TbMateriaProhibicionTipo, DataSet, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo');
      CheckDetailRelation(TbPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      if DataSet.State = dsEdit then
      begin
      end;
    finally
      FBeforePostLocks[13] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbDistributivoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[14] then
  begin
    FBeforePostLocks[14] := True;
    try
      CheckDetailRelation(TbAulaTipo, DataSet, 'CodAulaTipo', 'CodAulaTipo');
      CheckDetailRelation(TbMateria, DataSet, 'CodMateria', 'CodMateria');
      CheckDetailRelation(TbParalelo, DataSet, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId');
      CheckDetailRelation(TbProfesor, DataSet, 'CodProfesor', 'CodProfesor');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[14] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbDistributivoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.TbHorarioDetalleBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[15] then
  begin
    FBeforePostLocks[15] := True;
    try
      CheckDetailRelation(TbDistributivo, DataSet, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId');
      CheckDetailRelation(TbHorario, DataSet, 'CodHorario', 'CodHorario');
      CheckDetailRelation(TbPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      if DataSet.State = dsEdit then
      begin
      end;
    finally
      FBeforePostLocks[15] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[16] then
  begin
    FBeforePostLocks[16] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, TbProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
      end;
    finally
      FBeforePostLocks[16] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.TbProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, TbProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
  end;
end;

procedure TSourceBaseDataModule.TbProfesorProhibicionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[17] then
  begin
    FBeforePostLocks[17] := True;
    try
      CheckDetailRelation(TbPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      CheckDetailRelation(TbProfesor, DataSet, 'CodProfesor', 'CodProfesor');
      CheckDetailRelation(TbProfesorProhibicionTipo, DataSet, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo');
      if DataSet.State = dsEdit then
      begin
      end;
    finally
      FBeforePostLocks[17] := False
    end;
  end;
end;


procedure TSourceBaseDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetLength(FTables, 18);
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

