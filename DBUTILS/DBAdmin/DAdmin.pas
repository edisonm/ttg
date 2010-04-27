unit DAdmin;
(*
  Advertencia:

    Este módulo ha sido creado automáticamente.
    No lo modifique manualmente, ya que los cambios se perderán la próxima
    vez que se genere.


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, dbf;

type
  TAdminDM = class(TDataModule)
    kbmAulaTipo: TDbf;
    kbmAulaTipoCodAulaTipo:TIntegerField;
    kbmAulaTipoNomAulaTipo:TStringField;
    kbmAulaTipoAbrAulaTipo:TStringField;
    kbmAulaTipoCantidad:TIntegerField;
    dsAulaTipo: TDataSource;
    kbmEspecializacion: TDbf;
    kbmEspecializacionCodEspecializacion:TIntegerField;
    kbmEspecializacionNomEspecializacion:TStringField;
    kbmEspecializacionAbrEspecializacion:TStringField;
    dsEspecializacion: TDataSource;
    kbmMateria: TDbf;
    kbmMateriaCodMateria:TIntegerField;
    kbmMateriaNomMateria:TStringField;
    dsMateria: TDataSource;
    kbmNivel: TDbf;
    kbmNivelCodNivel:TIntegerField;
    kbmNivelNomNivel:TStringField;
    kbmNivelAbrNivel:TStringField;
    dsNivel: TDataSource;
    kbmDia: TDbf;
    kbmDiaCodDia:TIntegerField;
    kbmDiaNomDia:TStringField;
    dsDia: TDataSource;
    kbmCurso: TDbf;
    kbmCursoCodNivel:TIntegerField;
    kbmCursoCodEspecializacion:TIntegerField;
    dsCurso: TDataSource;
    kbmHora: TDbf;
    kbmHoraCodHora:TIntegerField;
    kbmHoraNomHora:TStringField;
    kbmHoraIntervalo:TStringField;
    dsHora: TDataSource;
    kbmHorario: TDbf;
    kbmHorarioCodHorario:TIntegerField;
    kbmHorarioMomentoInicial:TDateField;
    kbmHorarioMomentoFinal:TDateField;
    kbmHorarioInforme:TMemoField;
    dsHorario: TDataSource;
    kbmHorarioLaborable: TDbf;
    kbmHorarioLaborableCodDia:TIntegerField;
    kbmHorarioLaborableCodHora:TIntegerField;
    dsHorarioLaborable: TDataSource;
    kbmParaleloId: TDbf;
    kbmParaleloIdCodParaleloId:TIntegerField;
    kbmParaleloIdNomParaleloId:TStringField;
    dsParaleloId: TDataSource;
    kbmParalelo: TDbf;
    kbmParaleloCodNivel:TIntegerField;
    kbmParaleloCodEspecializacion:TIntegerField;
    kbmParaleloCodParaleloId:TIntegerField;
    dsParalelo: TDataSource;
    kbmMateriaProhibicionTipo: TDbf;
    kbmMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    kbmMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    kbmMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    kbmMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    dsMateriaProhibicionTipo: TDataSource;
    kbmMateriaProhibicion: TDbf;
    kbmMateriaProhibicionCodMateria:TIntegerField;
    kbmMateriaProhibicionCodDia:TIntegerField;
    kbmMateriaProhibicionCodHora:TIntegerField;
    kbmMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    dsMateriaProhibicion: TDataSource;
    kbmAsignatura: TDbf;
    kbmAsignaturaCodMateria:TIntegerField;
    kbmAsignaturaCodNivel:TIntegerField;
    kbmAsignaturaCodEspecializacion:TIntegerField;
    kbmAsignaturaCodAulaTipo:TIntegerField;
    kbmAsignaturaComposicion:TStringField;
    dsAsignatura: TDataSource;
    kbmProfesor: TDbf;
    kbmProfesorCodProfesor:TIntegerField;
    kbmProfesorCedProfesor:TStringField;
    kbmProfesorApeProfesor:TStringField;
    kbmProfesorNomProfesor:TStringField;
    dsProfesor: TDataSource;
    kbmCargaAcademica: TDbf;
    kbmCargaAcademicaCodMateria:TIntegerField;
    kbmCargaAcademicaCodNivel:TIntegerField;
    kbmCargaAcademicaCodEspecializacion:TIntegerField;
    kbmCargaAcademicaCodParaleloId:TIntegerField;
    kbmCargaAcademicaCodProfesor:TIntegerField;
    dsCargaAcademica: TDataSource;
    kbmHorarioDetalle: TDbf;
    kbmHorarioDetalleCodHorario:TIntegerField;
    kbmHorarioDetalleCodNivel:TIntegerField;
    kbmHorarioDetalleCodEspecializacion:TIntegerField;
    kbmHorarioDetalleCodParaleloId:TIntegerField;
    kbmHorarioDetalleCodDia:TIntegerField;
    kbmHorarioDetalleCodHora:TIntegerField;
    kbmHorarioDetalleCodMateria:TIntegerField;
    kbmHorarioDetalleSesion:TIntegerField;
    dsHorarioDetalle: TDataSource;
    kbmProfesorProhibicionTipo: TDbf;
    kbmProfesorProhibicionTipoCodProfProhibicionTipo:TIntegerField;
    kbmProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    kbmProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    kbmProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    dsProfesorProhibicionTipo: TDataSource;
    kbmProfesorProhibicion: TDbf;
    kbmProfesorProhibicionCodProfesor:TIntegerField;
    kbmProfesorProhibicionCodDia:TIntegerField;
    kbmProfesorProhibicionCodHora:TIntegerField;
    kbmProfesorProhibicionCodProfProhibicionTipo:TIntegerField;
    dsProfesorProhibicion: TDataSource;

    procedure kbmAulaTipoBeforePost(DataSet: TDataSet);
    procedure kbmAulaTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmEspecializacionBeforePost(DataSet: TDataSet);
    procedure kbmEspecializacionBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaBeforePost(DataSet: TDataSet);
    procedure kbmMateriaBeforeDelete(DataSet: TDataSet);
    procedure kbmNivelBeforePost(DataSet: TDataSet);
    procedure kbmNivelBeforeDelete(DataSet: TDataSet);
    procedure kbmDiaBeforePost(DataSet: TDataSet);
    procedure kbmDiaBeforeDelete(DataSet: TDataSet);
    procedure kbmCursoBeforePost(DataSet: TDataSet);
    procedure kbmCursoBeforeDelete(DataSet: TDataSet);
    procedure kbmHoraBeforePost(DataSet: TDataSet);
    procedure kbmHoraBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioBeforePost(DataSet: TDataSet);
    procedure kbmHorarioBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioLaborableBeforePost(DataSet: TDataSet);
    procedure kbmHorarioLaborableBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloIdBeforePost(DataSet: TDataSet);
    procedure kbmParaleloIdBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloBeforePost(DataSet: TDataSet);
    procedure kbmParaleloBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
    procedure kbmAsignaturaBeforePost(DataSet: TDataSet);
    procedure kbmProfesorBeforePost(DataSet: TDataSet);
    procedure kbmProfesorBeforeDelete(DataSet: TDataSet);
    procedure kbmCargaAcademicaBeforePost(DataSet: TDataSet);
    procedure kbmCargaAcademicaBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioDetalleBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmProfesorProhibicionBeforePost(DataSet: TDataSet);
  public
    procedure LoadFromBinaryStream(AStream: TStream);
    procedure LoadFromBinaryFile(const AFileName: string);
    procedure SaveToBinaryStream(AStream: TStream; flags:TDbfSaveFlags);
    procedure SaveToBinaryFile(const AFileName: string; flags:TDbfSaveFlags);
    procedure EmptyTables;
  end;
var
  AdminDM: TAdminDM;

implementation

{$R *.DFM}

uses RelUtils;

procedure TAdminDM.kbmAulaTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmAsignatura, 'CodAulaTipo', 'CodAulaTipo', False);
end;

procedure TAdminDM.kbmAulaTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmAsignatura, 'CodAulaTipo', 'CodAulaTipo', False);
end;

procedure TAdminDM.kbmEspecializacionBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmCurso, 'CodEspecializacion', 'CodEspecializacion', False);
end;

procedure TAdminDM.kbmEspecializacionBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmCurso, 'CodEspecializacion', 'CodEspecializacion', False);
end;

procedure TAdminDM.kbmMateriaBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmAsignatura, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationUpdate(DataSet, kbmCargaAcademica, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
end;

procedure TAdminDM.kbmMateriaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmAsignatura, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationDelete(DataSet, kbmCargaAcademica, 'CodMateria', 'CodMateria', False);
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
end;

procedure TAdminDM.kbmNivelBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmCurso, 'CodNivel', 'CodNivel', False);
end;

procedure TAdminDM.kbmNivelBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmCurso, 'CodNivel', 'CodNivel', False);
end;

procedure TAdminDM.kbmDiaBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmHorarioLaborable, 'CodDia', 'CodDia', False);
end;

procedure TAdminDM.kbmDiaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioLaborable, 'CodDia', 'CodDia', False);
end;

procedure TAdminDM.kbmCursoBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmEspecializacion, DataSet, 'CodEspecializacion', 'CodEspecializacion');
  CheckDetailRelation(kbmNivel, DataSet, 'CodNivel', 'CodNivel');
  CheckMasterRelationUpdate(DataSet, kbmAsignatura, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
  CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
end;

procedure TAdminDM.kbmCursoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmAsignatura, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
  CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
end;

procedure TAdminDM.kbmHoraBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmHorarioLaborable, 'CodHora', 'CodHora', False);
end;

procedure TAdminDM.kbmHoraBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioLaborable, 'CodHora', 'CodHora', False);
end;

procedure TAdminDM.kbmHorarioBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', False);
end;

procedure TAdminDM.kbmHorarioBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', False);
end;

procedure TAdminDM.kbmHorarioLaborableBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDia, DataSet, 'CodDia', 'CodDia');
  CheckDetailRelation(kbmHora, DataSet, 'CodHora', 'CodHora');
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
end;

procedure TAdminDM.kbmHorarioLaborableBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
end;

procedure TAdminDM.kbmParaleloIdBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
end;

procedure TAdminDM.kbmParaleloIdBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
end;

procedure TAdminDM.kbmParaleloBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmCurso, DataSet, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion');
  CheckDetailRelation(kbmParaleloId, DataSet, 'CodParaleloId', 'CodParaleloId');
  CheckMasterRelationUpdate(DataSet, kbmCargaAcademica, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
end;

procedure TAdminDM.kbmParaleloBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmCargaAcademica, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
end;

procedure TAdminDM.kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
end;

procedure TAdminDM.kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
end;

procedure TAdminDM.kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmHorarioLaborable, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
  CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
  CheckDetailRelation(kbmMateriaProhibicionTipo, DataSet, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo');
end;

procedure TAdminDM.kbmAsignaturaBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmAulaTipo, DataSet, 'CodAulaTipo', 'CodAulaTipo');
  CheckDetailRelation(kbmCurso, DataSet, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion');
  CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
end;

procedure TAdminDM.kbmProfesorBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmCargaAcademica, 'CodProfesor', 'CodProfesor', False);
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
end;

procedure TAdminDM.kbmProfesorBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmCargaAcademica, 'CodProfesor', 'CodProfesor', False);
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
end;

procedure TAdminDM.kbmCargaAcademicaBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
  CheckDetailRelation(kbmParalelo, DataSet, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId');
  CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
  CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
end;

procedure TAdminDM.kbmCargaAcademicaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
end;

procedure TAdminDM.kbmHorarioDetalleBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmCargaAcademica, DataSet, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId');
  CheckDetailRelation(kbmHorario, DataSet, 'CodHorario', 'CodHorario');
  CheckDetailRelation(kbmHorarioLaborable, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
end;

procedure TAdminDM.kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
end;

procedure TAdminDM.kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
end;

procedure TAdminDM.kbmProfesorProhibicionBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmHorarioLaborable, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
  CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
  CheckDetailRelation(kbmProfesorProhibicionTipo, DataSet, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo');
end;

procedure TAdminDM.LoadFromBinaryStream(AStream: TStream);
begin
  kbmAulaTipo.LoadFromBinaryStream(AStream);
  kbmEspecializacion.LoadFromBinaryStream(AStream);
  kbmMateria.LoadFromBinaryStream(AStream);
  kbmNivel.LoadFromBinaryStream(AStream);
  kbmDia.LoadFromBinaryStream(AStream);
  kbmCurso.LoadFromBinaryStream(AStream);
  kbmHora.LoadFromBinaryStream(AStream);
  kbmHorario.LoadFromBinaryStream(AStream);
  kbmHorarioLaborable.LoadFromBinaryStream(AStream);
  kbmParaleloId.LoadFromBinaryStream(AStream);
  kbmParalelo.LoadFromBinaryStream(AStream);
  kbmMateriaProhibicionTipo.LoadFromBinaryStream(AStream);
  kbmMateriaProhibicion.LoadFromBinaryStream(AStream);
  kbmAsignatura.LoadFromBinaryStream(AStream);
  kbmProfesor.LoadFromBinaryStream(AStream);
  kbmCargaAcademica.LoadFromBinaryStream(AStream);
  kbmHorarioDetalle.LoadFromBinaryStream(AStream);
  kbmProfesorProhibicionTipo.LoadFromBinaryStream(AStream);
  kbmProfesorProhibicion.LoadFromBinaryStream(AStream);
end;

procedure TAdminDM.LoadFromBinaryFile(const AFileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead + fmShareDenyNone);
  try
    LoadFromBinaryStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TAdminDM.SaveToBinaryStream(AStream: TStream; flags:TDbfSaveFlags);
begin
  kbmAulaTipo.SaveToBinaryStream(AStream, flags);
  kbmEspecializacion.SaveToBinaryStream(AStream, flags);
  kbmMateria.SaveToBinaryStream(AStream, flags);
  kbmNivel.SaveToBinaryStream(AStream, flags);
  kbmDia.SaveToBinaryStream(AStream, flags);
  kbmCurso.SaveToBinaryStream(AStream, flags);
  kbmHora.SaveToBinaryStream(AStream, flags);
  kbmHorario.SaveToBinaryStream(AStream, flags);
  kbmHorarioLaborable.SaveToBinaryStream(AStream, flags);
  kbmParaleloId.SaveToBinaryStream(AStream, flags);
  kbmParalelo.SaveToBinaryStream(AStream, flags);
  kbmMateriaProhibicionTipo.SaveToBinaryStream(AStream, flags);
  kbmMateriaProhibicion.SaveToBinaryStream(AStream, flags);
  kbmAsignatura.SaveToBinaryStream(AStream, flags);
  kbmProfesor.SaveToBinaryStream(AStream, flags);
  kbmCargaAcademica.SaveToBinaryStream(AStream, flags);
  kbmHorarioDetalle.SaveToBinaryStream(AStream, flags);
  kbmProfesorProhibicionTipo.SaveToBinaryStream(AStream, flags);
  kbmProfesorProhibicion.SaveToBinaryStream(AStream, flags);
end;

procedure TAdminDM.SaveToBinaryFile(const AFileName: string; flags:TDbfSaveFlags);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToBinaryStream(Stream, flags);
  finally
    Stream.Free;
  end;
end;

procedure TAdminDM.EmptyTables;
begin
  kbmAulaTipo.EmptyTable;
  kbmEspecializacion.EmptyTable;
  kbmMateria.EmptyTable;
  kbmNivel.EmptyTable;
  kbmDia.EmptyTable;
  kbmCurso.EmptyTable;
  kbmHora.EmptyTable;
  kbmHorario.EmptyTable;
  kbmHorarioLaborable.EmptyTable;
  kbmParaleloId.EmptyTable;
  kbmParalelo.EmptyTable;
  kbmMateriaProhibicionTipo.EmptyTable;
  kbmMateriaProhibicion.EmptyTable;
  kbmAsignatura.EmptyTable;
  kbmProfesor.EmptyTable;
  kbmCargaAcademica.EmptyTable;
  kbmHorarioDetalle.EmptyTable;
  kbmProfesorProhibicionTipo.EmptyTable;
  kbmProfesorProhibicion.EmptyTable;
end;
end.
