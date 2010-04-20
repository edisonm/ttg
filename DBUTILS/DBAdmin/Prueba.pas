unit Prueba;
(*
  Advertencia:

    Este módulo ha sido generado automáticamente.
    No lo modifique manualmente, ya que los cambios se perderán la próxima
    vez que se genere.


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, KbmMemTable;

type
  TDMPrueba = class(TDataModule)
    kbmAulaTipo: TkbmMemTable;
    tbmAulaTipoCodAulaTipo:TIntegerField;
    tbmAulaTipoNomAulaTipo:TStringField;
    tbmAulaTipoCantidad:TIntegerField;
    kbmCurso: TkbmMemTable;
    tbmCursoCodCurso:TIntegerField;
    tbmCursoNomCurso:TStringField;
    kbmDia: TkbmMemTable;
    tbmDiaCodDia:TIntegerField;
    tbmDiaNomDia:TStringField;
    kbmMateria: TkbmMemTable;
    tbmMateriaCodMateria:TIntegerField;
    tbmMateriaNomMateria:TStringField;
    kbmParaleloId: TkbmMemTable;
    tbmParaleloIdCodParaleloId:TIntegerField;
    tbmParaleloIdNomParaleloId:TStringField;
    kbmParalelo: TkbmMemTable;
    tbmParaleloCodCurso:TIntegerField;
    tbmParaleloCodParaleloId:TIntegerField;
    kbmHora: TkbmMemTable;
    tbmHoraCodHora:TIntegerField;
    tbmHoraNomHora:TStringField;
    kbmHorario: TkbmMemTable;
    tbmHorarioCodHorario:TIntegerField;
    tbmHorarioMomentoInicial:TDateField;
    tbmHorarioMomentoFinal:TDateField;
    tbmHorarioInforme:TMemoField;
    kbmPeriodo: TkbmMemTable;
    tbmPeriodoCodDia:TIntegerField;
    tbmPeriodoCodHora:TIntegerField;
    kbmDistributivo: TkbmMemTable;
    tbmDistributivoCodMateria:TIntegerField;
    tbmDistributivoCodCurso:TIntegerField;
    tbmDistributivoCodParaleloId:TIntegerField;
    tbmDistributivoCodAulaTipo:TIntegerField;
    tbmDistributivoComposicion:TStringField;
    kbmMateriaProhibicionTipo: TkbmMemTable;
    tbmMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    tbmMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    tbmMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    tbmMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    kbmMateriaProhibicion: TkbmMemTable;
    tbmMateriaProhibicionCodMateria:TIntegerField;
    tbmMateriaProhibicionCodDia:TIntegerField;
    tbmMateriaProhibicionCodHora:TIntegerField;
    tbmMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    kbmDistributivoVinculo: TkbmMemTable;
    tbmDistributivoVinculoCodMateria1:TIntegerField;
    tbmDistributivoVinculoCodCurso1:TIntegerField;
    tbmDistributivoVinculoCodParaleloId1:TIntegerField;
    tbmDistributivoVinculoCodMateria2:TIntegerField;
    tbmDistributivoVinculoCodCurso2:TIntegerField;
    tbmDistributivoVinculoCodParaleloId2:TIntegerField;
    kbmProfesor: TkbmMemTable;
    tbmProfesorCodProfesor:TIntegerField;
    tbmProfesorApeProfesor:TStringField;
    tbmProfesorNomProfesor:TStringField;
    kbmParaleloProhibicionTipo: TkbmMemTable;
    tbmParaleloProhibicionTipoCodParaProhibicionTipo:TIntegerField;
    tbmParaleloProhibicionTipoNomParaProhibicionTipo:TStringField;
    tbmParaleloProhibicionTipoColParaProhibicionTipo:TIntegerField;
    tbmParaleloProhibicionTipoValParaProhibicionTipo:TFloatField;
    kbmParaleloProhibicion: TkbmMemTable;
    tbmParaleloProhibicionCodCurso:TIntegerField;
    tbmParaleloProhibicionCodParaleloId:TIntegerField;
    tbmParaleloProhibicionCodDia:TIntegerField;
    tbmParaleloProhibicionCodHora:TIntegerField;
    tbmParaleloProhibicionCodParaProhibicionTipo:TIntegerField;
    kbmHorarioDetalle: TkbmMemTable;
    tbmHorarioDetalleCodHorario:TIntegerField;
    tbmHorarioDetalleCodCurso:TIntegerField;
    tbmHorarioDetalleCodParaleloId:TIntegerField;
    tbmHorarioDetalleCodDia:TIntegerField;
    tbmHorarioDetalleCodHora:TIntegerField;
    tbmHorarioDetalleCodMateria:TIntegerField;
    tbmHorarioDetalleSesion:TIntegerField;
    kbmDistributivoProfesor: TkbmMemTable;
    tbmDistributivoProfesorCodMateria:TIntegerField;
    tbmDistributivoProfesorCodCurso:TIntegerField;
    tbmDistributivoProfesorCodParaleloId:TIntegerField;
    tbmDistributivoProfesorCodProfesor:TIntegerField;
    kbmProfesorProhibicionTipo: TkbmMemTable;
    tbmProfesorProhibicionTipoCodProfProhibicionTipo:TIntegerField;
    tbmProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    tbmProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    tbmProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    kbmProfesorProhibicion: TkbmMemTable;
    tbmProfesorProhibicionCodProfesor:TIntegerField;
    tbmProfesorProhibicionCodDia:TIntegerField;
    tbmProfesorProhibicionCodHora:TIntegerField;
    tbmProfesorProhibicionCodProfProhibicionTipo:TIntegerField;

    procedure kbmAulaTipoBeforePost(DataSet: TDataSet);
    procedure kbmAulaTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmCursoBeforePost(DataSet: TDataSet);
    procedure kbmCursoBeforeDelete(DataSet: TDataSet);
    procedure kbmDiaBeforePost(DataSet: TDataSet);
    procedure kbmDiaBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaBeforePost(DataSet: TDataSet);
    procedure kbmMateriaBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloIdBeforePost(DataSet: TDataSet);
    procedure kbmParaleloIdBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloBeforePost(DataSet: TDataSet);
    procedure kbmParaleloBeforeDelete(DataSet: TDataSet);
    procedure kbmHoraBeforePost(DataSet: TDataSet);
    procedure kbmHoraBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioBeforePost(DataSet: TDataSet);
    procedure kbmHorarioBeforeDelete(DataSet: TDataSet);
    procedure kbmPeriodoBeforePost(DataSet: TDataSet);
    procedure kbmPeriodoBeforeDelete(DataSet: TDataSet);
    procedure kbmDistributivoBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoVinculoBeforePost(DataSet: TDataSet);
    procedure kbmProfesorBeforePost(DataSet: TDataSet);
    procedure kbmProfesorBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmParaleloProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloProhibicionBeforePost(DataSet: TDataSet);
    procedure kbmHorarioDetalleBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoProfesorBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmProfesorProhibicionBeforePost(DataSet: TDataSet);
  end;
implementation

{$R *.DFM}

uses RelUtils;

procedure TDMPrueba.kbmAulaTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
end;

procedure TDMPrueba.kbmAulaTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
end;

procedure TDMPrueba.kbmCursoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodCurso', 'CodCurso', False);
end;

procedure TDMPrueba.kbmCursoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodCurso', 'CodCurso', False);
end;

procedure TDMPrueba.kbmDiaBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodDia', 'CodDia', False);
end;

procedure TDMPrueba.kbmDiaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodDia', 'CodDia', False);
end;

procedure TDMPrueba.kbmMateriaBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
end;

procedure TDMPrueba.kbmMateriaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
end;

procedure TDMPrueba.kbmParaleloIdBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
end;

procedure TDMPrueba.kbmParaleloIdBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
end;

procedure TDMPrueba.kbmParaleloBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmCurso, DataSet, 'CodCurso', 'CodCurso');
  CheckDetailRelation(kbmParaleloId, DataSet, 'CodParaleloId', 'CodParaleloId');
  CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId', False);
  CheckMasterRelationUpdate(DataSet, kbmParaleloProhibicion, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId', False);
end;

procedure TDMPrueba.kbmParaleloBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId', False);
  CheckMasterRelationDelete(DataSet, kbmParaleloProhibicion, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId', True);
end;

procedure TDMPrueba.kbmHoraBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodHora', 'CodHora', False);
end;

procedure TDMPrueba.kbmHoraBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodHora', 'CodHora', False);
end;

procedure TDMPrueba.kbmHorarioBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', True);
end;

procedure TDMPrueba.kbmHorarioBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', False);
end;

procedure TDMPrueba.kbmPeriodoBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDia, DataSet, 'CodDia', 'CodDia');
  CheckDetailRelation(kbmHora, DataSet, 'CodHora', 'CodHora');
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationUpdate(DataSet, kbmParaleloProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
end;

procedure TDMPrueba.kbmPeriodoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationDelete(DataSet, kbmParaleloProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
end;

procedure TDMPrueba.kbmDistributivoBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmAulaTipo, DataSet, 'CodAulaTipo', 'CodAulaTipo');
  CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
  CheckDetailRelation(kbmParalelo, DataSet, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId');
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId', False);
  CheckMasterRelationUpdate(DataSet, kbmDistributivoProfesor, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId', False);
  CheckMasterRelationUpdate(DataSet, kbmDistributivoVinculo, 'CodMateria1;CodCurso1;CodParaleloId1', 'CodMateria;CodCurso;CodParaleloId', False);
  CheckMasterRelationUpdate(DataSet, kbmDistributivoVinculo, 'CodMateria2;CodCurso2;CodParaleloId2', 'CodMateria;CodCurso;CodParaleloId', False);
end;

procedure TDMPrueba.kbmDistributivoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId', False);
  CheckMasterRelationDelete(DataSet, kbmDistributivoProfesor, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId', True);
  CheckMasterRelationDelete(DataSet, kbmDistributivoVinculo, 'CodMateria1;CodCurso1;CodParaleloId1', 'CodMateria;CodCurso;CodParaleloId', True);
  CheckMasterRelationDelete(DataSet, kbmDistributivoVinculo, 'CodMateria2;CodCurso2;CodParaleloId2', 'CodMateria;CodCurso;CodParaleloId', True);
end;

procedure TDMPrueba.kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
end;

procedure TDMPrueba.kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', True);
end;

procedure TDMPrueba.kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
  CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
  CheckDetailRelation(kbmMateriaProhibicionTipo, DataSet, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo');
end;

procedure TDMPrueba.kbmDistributivoVinculoBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDistributivo, DataSet, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria1;CodCurso1;CodParaleloId1');
  CheckDetailRelation(kbmDistributivo, DataSet, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria2;CodCurso2;CodParaleloId2');
end;

procedure TDMPrueba.kbmProfesorBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmDistributivoProfesor, 'CodProfesor', 'CodProfesor', False);
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
end;

procedure TDMPrueba.kbmProfesorBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmDistributivoProfesor, 'CodProfesor', 'CodProfesor', True);
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', True);
end;

procedure TDMPrueba.kbmParaleloProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmParaleloProhibicion, 'CodParaProhibicionTipo', 'CodParaProhibicionTipo', False);
end;

procedure TDMPrueba.kbmParaleloProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmParaleloProhibicion, 'CodParaProhibicionTipo', 'CodParaProhibicionTipo', False);
end;

procedure TDMPrueba.kbmParaleloProhibicionBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
  CheckDetailRelation(kbmParalelo, DataSet, 'CodCurso;CodParaleloId', 'CodCurso;CodParaleloId');
  CheckDetailRelation(kbmParaleloProhibicionTipo, DataSet, 'CodParaProhibicionTipo', 'CodParaProhibicionTipo');
end;

procedure TDMPrueba.kbmHorarioDetalleBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDistributivo, DataSet, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId');
  CheckDetailRelation(kbmHorario, DataSet, 'CodHorario', 'CodHorario');
  CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
end;

procedure TDMPrueba.kbmDistributivoProfesorBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDistributivo, DataSet, 'CodMateria;CodCurso;CodParaleloId', 'CodMateria;CodCurso;CodParaleloId');
  CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
end;

procedure TDMPrueba.kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
end;

procedure TDMPrueba.kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
end;

procedure TDMPrueba.kbmProfesorProhibicionBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
  CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
  CheckDetailRelation(kbmProfesorProhibicionTipo, DataSet, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo');
end;

end.
