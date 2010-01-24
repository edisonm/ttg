unit DSrcBase;
(*
  lunes, 25 de enero de 2010 0:38:41

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, KbmMemTable;

type
  TSourceBaseDataModule = class(TDataModule)
    kbmAulaTipo: TkbmMemTable;
    kbmAulaTipoCodAulaTipo:TAutoIncField;
    kbmAulaTipoNomAulaTipo:TStringField;
    kbmAulaTipoAbrAulaTipo:TStringField;
    kbmAulaTipoCantidad:TIntegerField;
    dsAulaTipo: TDataSource;
    kbmEspecializacion: TkbmMemTable;
    kbmEspecializacionCodEspecializacion:TAutoIncField;
    kbmEspecializacionNomEspecializacion:TStringField;
    kbmEspecializacionAbrEspecializacion:TStringField;
    dsEspecializacion: TDataSource;
    kbmDia: TkbmMemTable;
    kbmDiaCodDia:TAutoIncField;
    kbmDiaNomDia:TStringField;
    dsDia: TDataSource;
    kbmMateria: TkbmMemTable;
    kbmMateriaCodMateria:TAutoIncField;
    kbmMateriaNomMateria:TStringField;
    dsMateria: TDataSource;
    kbmNivel: TkbmMemTable;
    kbmNivelCodNivel:TAutoIncField;
    kbmNivelNomNivel:TStringField;
    kbmNivelAbrNivel:TStringField;
    dsNivel: TDataSource;
    kbmHora: TkbmMemTable;
    kbmHoraCodHora:TAutoIncField;
    kbmHoraNomHora:TStringField;
    kbmHoraIntervalo:TStringField;
    dsHora: TDataSource;
    kbmHorario: TkbmMemTable;
    kbmHorarioCodHorario:TAutoIncField;
    kbmHorarioMomentoInicial:TDateTimeField;
    kbmHorarioMomentoFinal:TDateTimeField;
    kbmHorarioInforme:TMemoField;
    dsHorario: TDataSource;
    kbmCurso: TkbmMemTable;
    kbmCursoCodNivel:TIntegerField;
    kbmCursoCodEspecializacion:TIntegerField;
    dsCurso: TDataSource;
    kbmParaleloId: TkbmMemTable;
    kbmParaleloIdCodParaleloId:TAutoIncField;
    kbmParaleloIdNomParaleloId:TStringField;
    dsParaleloId: TDataSource;
    kbmMateriaProhibicionTipo: TkbmMemTable;
    kbmMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    kbmMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    kbmMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    kbmMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    dsMateriaProhibicionTipo: TDataSource;
    kbmPeriodo: TkbmMemTable;
    kbmPeriodoCodDia:TIntegerField;
    kbmPeriodoCodHora:TIntegerField;
    dsPeriodo: TDataSource;
    kbmParalelo: TkbmMemTable;
    kbmParaleloCodNivel:TIntegerField;
    kbmParaleloCodEspecializacion:TIntegerField;
    kbmParaleloCodParaleloId:TIntegerField;
    dsParalelo: TDataSource;
    kbmProfesor: TkbmMemTable;
    kbmProfesorCodProfesor:TAutoIncField;
    kbmProfesorCedProfesor:TStringField;
    kbmProfesorApeProfesor:TStringField;
    kbmProfesorNomProfesor:TStringField;
    dsProfesor: TDataSource;
    kbmMateriaProhibicion: TkbmMemTable;
    kbmMateriaProhibicionCodMateria:TIntegerField;
    kbmMateriaProhibicionCodDia:TIntegerField;
    kbmMateriaProhibicionCodHora:TIntegerField;
    kbmMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    dsMateriaProhibicion: TDataSource;
    kbmDistributivo: TkbmMemTable;
    kbmDistributivoCodMateria:TIntegerField;
    kbmDistributivoCodNivel:TIntegerField;
    kbmDistributivoCodEspecializacion:TIntegerField;
    kbmDistributivoCodParaleloId:TIntegerField;
    kbmDistributivoCodProfesor:TIntegerField;
    kbmDistributivoCodAulaTipo:TIntegerField;
    kbmDistributivoComposicion:TStringField;
    dsDistributivo: TDataSource;
    kbmHorarioDetalle: TkbmMemTable;
    kbmHorarioDetalleCodHorario:TIntegerField;
    kbmHorarioDetalleCodMateria:TIntegerField;
    kbmHorarioDetalleCodNivel:TIntegerField;
    kbmHorarioDetalleCodEspecializacion:TIntegerField;
    kbmHorarioDetalleCodParaleloId:TIntegerField;
    kbmHorarioDetalleCodDia:TIntegerField;
    kbmHorarioDetalleCodHora:TIntegerField;
    kbmHorarioDetalleSesion:TIntegerField;
    dsHorarioDetalle: TDataSource;
    kbmProfesorProhibicionTipo: TkbmMemTable;
    kbmProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField;
    kbmProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    kbmProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    kbmProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    dsProfesorProhibicionTipo: TDataSource;
    kbmProfesorProhibicion: TkbmMemTable;
    kbmProfesorProhibicionCodProfesor:TIntegerField;
    kbmProfesorProhibicionCodDia:TIntegerField;
    kbmProfesorProhibicionCodHora:TIntegerField;
    kbmProfesorProhibicionCodProfProhibicionTipo:TIntegerField;
    dsProfesorProhibicion: TDataSource;

    procedure kbmAulaTipoBeforePost(DataSet: TDataSet);
    procedure kbmAulaTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmEspecializacionBeforePost(DataSet: TDataSet);
    procedure kbmEspecializacionBeforeDelete(DataSet: TDataSet);
    procedure kbmDiaBeforePost(DataSet: TDataSet);
    procedure kbmDiaBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaBeforePost(DataSet: TDataSet);
    procedure kbmMateriaBeforeDelete(DataSet: TDataSet);
    procedure kbmNivelBeforePost(DataSet: TDataSet);
    procedure kbmNivelBeforeDelete(DataSet: TDataSet);
    procedure kbmHoraBeforePost(DataSet: TDataSet);
    procedure kbmHoraBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioBeforePost(DataSet: TDataSet);
    procedure kbmHorarioBeforeDelete(DataSet: TDataSet);
    procedure kbmCursoBeforePost(DataSet: TDataSet);
    procedure kbmCursoBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloIdBeforePost(DataSet: TDataSet);
    procedure kbmParaleloIdBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmPeriodoBeforePost(DataSet: TDataSet);
    procedure kbmPeriodoBeforeDelete(DataSet: TDataSet);
    procedure kbmParaleloBeforePost(DataSet: TDataSet);
    procedure kbmParaleloBeforeDelete(DataSet: TDataSet);
    procedure kbmProfesorBeforePost(DataSet: TDataSet);
    procedure kbmProfesorBeforeDelete(DataSet: TDataSet);
    procedure kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoBeforePost(DataSet: TDataSet);
    procedure kbmDistributivoBeforeDelete(DataSet: TDataSet);
    procedure kbmHorarioDetalleBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
    procedure kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
    procedure kbmProfesorProhibicionBeforePost(DataSet: TDataSet);

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDataSetNameList: TStrings;
    FDataSetDescList: TStrings;
    FCheckRelations: Boolean;
    FBeforePostLocks: array[0..17] of Boolean;
    function GetDescription(ADataSet: TDataSet): string;
    function GetName(ADataSet: TDataSet): string;
  public
    procedure LoadFromBinaryStream(AStream: TStream);
    procedure LoadFromBinaryFile(const AFileName: string);
    procedure LoadFromTextDir(const ADirName: string);
    procedure SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
    procedure SaveToBinaryFile(const AFileName: string; flags:TkbmMemTableSaveFlags);
    procedure SaveToTextDir(const ADirName: string; flags:TkbmMemTableSaveFlags);
    procedure EmptyTables;
    procedure OpenTables;
    procedure CloseTables;
    property CheckRelations: Boolean read FCheckRelations write FCheckRelations;
    property DataSetNameList: TStrings read FDataSetNameList;
    property DataSetDescList: TStrings read FDataSetDescList;
    property Description[ADataSet: TDataSet]: string read GetDescription;
    property Name[ADataSet: TDataSet]: string read GetName;
  end;
var
  SourceBaseDataModule: TSourceBaseDataModule;

implementation

{$R *.DFM}

uses RelUtils;

procedure TSourceBaseDataModule.kbmAulaTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[0] then
  begin
    FBeforePostLocks[0] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
      end;
    finally
      FBeforePostLocks[0] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmAulaTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodAulaTipo', 'CodAulaTipo', False);
  end;
end;

procedure TSourceBaseDataModule.kbmEspecializacionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[1] then
  begin
    FBeforePostLocks[1] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmCurso, 'CodEspecializacion', 'CodEspecializacion', False);
      end;
    finally
      FBeforePostLocks[1] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmEspecializacionBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmCurso, 'CodEspecializacion', 'CodEspecializacion', False);
  end;
end;

procedure TSourceBaseDataModule.kbmDiaBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[2] then
  begin
    FBeforePostLocks[2] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodDia', 'CodDia', False);
      end;
    finally
      FBeforePostLocks[2] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmDiaBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodDia', 'CodDia', False);
  end;
end;

procedure TSourceBaseDataModule.kbmMateriaBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[3] then
  begin
    FBeforePostLocks[3] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodMateria', 'CodMateria', False);
        CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
      end;
    finally
      FBeforePostLocks[3] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmMateriaBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodMateria', 'CodMateria', False);
    CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateria', 'CodMateria', False);
  end;
end;

procedure TSourceBaseDataModule.kbmNivelBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[4] then
  begin
    FBeforePostLocks[4] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmCurso, 'CodNivel', 'CodNivel', False);
      end;
    finally
      FBeforePostLocks[4] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmNivelBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmCurso, 'CodNivel', 'CodNivel', False);
  end;
end;

procedure TSourceBaseDataModule.kbmHoraBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[5] then
  begin
    FBeforePostLocks[5] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodHora', 'CodHora', False);
      end;
    finally
      FBeforePostLocks[5] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmHoraBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodHora', 'CodHora', False);
  end;
end;

procedure TSourceBaseDataModule.kbmHorarioBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[6] then
  begin
    FBeforePostLocks[6] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', True);
      end;
    finally
      FBeforePostLocks[6] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmHorarioBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodHorario', 'CodHorario', True);
  end;
end;

procedure TSourceBaseDataModule.kbmCursoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[7] then
  begin
    FBeforePostLocks[7] := True;
    try
      CheckDetailRelation(kbmEspecializacion, DataSet, 'CodEspecializacion', 'CodEspecializacion');
      CheckDetailRelation(kbmNivel, DataSet, 'CodNivel', 'CodNivel');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
      end;
    finally
      FBeforePostLocks[7] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmCursoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion', False);
  end;
end;

procedure TSourceBaseDataModule.kbmParaleloIdBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[8] then
  begin
    FBeforePostLocks[8] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[8] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmParaleloIdBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmParalelo, 'CodParaleloId', 'CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.kbmMateriaProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[9] then
  begin
    FBeforePostLocks[9] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
      end;
    finally
      FBeforePostLocks[9] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmMateriaProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo', False);
  end;
end;

procedure TSourceBaseDataModule.kbmPeriodoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[10] then
  begin
    FBeforePostLocks[10] := True;
    try
      CheckDetailRelation(kbmDia, DataSet, 'CodDia', 'CodDia');
      CheckDetailRelation(kbmHora, DataSet, 'CodHora', 'CodHora');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
        CheckMasterRelationUpdate(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
        CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
      end;
    finally
      FBeforePostLocks[10] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmPeriodoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodDia;CodHora', 'CodDia;CodHora', False);
    CheckMasterRelationDelete(DataSet, kbmMateriaProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
    CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodDia;CodHora', 'CodDia;CodHora', False);
  end;
end;

procedure TSourceBaseDataModule.kbmParaleloBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[11] then
  begin
    FBeforePostLocks[11] := True;
    try
      CheckDetailRelation(kbmCurso, DataSet, 'CodNivel;CodEspecializacion', 'CodNivel;CodEspecializacion');
      CheckDetailRelation(kbmParaleloId, DataSet, 'CodParaleloId', 'CodParaleloId');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[11] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmParaleloBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.kbmProfesorBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[12] then
  begin
    FBeforePostLocks[12] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmDistributivo, 'CodProfesor', 'CodProfesor', False);
        CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
      end;
    finally
      FBeforePostLocks[12] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmProfesorBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmDistributivo, 'CodProfesor', 'CodProfesor', False);
    CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfesor', 'CodProfesor', False);
  end;
end;

procedure TSourceBaseDataModule.kbmMateriaProhibicionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[13] then
  begin
    FBeforePostLocks[13] := True;
    try
      CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
      CheckDetailRelation(kbmMateriaProhibicionTipo, DataSet, 'CodMateProhibicionTipo', 'CodMateProhibicionTipo');
      CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      if DataSet.State = dsEdit then
      begin
      end;
    finally
      FBeforePostLocks[13] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmDistributivoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[14] then
  begin
    FBeforePostLocks[14] := True;
    try
      CheckDetailRelation(kbmAulaTipo, DataSet, 'CodAulaTipo', 'CodAulaTipo');
      CheckDetailRelation(kbmMateria, DataSet, 'CodMateria', 'CodMateria');
      CheckDetailRelation(kbmParalelo, DataSet, 'CodNivel;CodEspecializacion;CodParaleloId', 'CodNivel;CodEspecializacion;CodParaleloId');
      CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
      end;
    finally
      FBeforePostLocks[14] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmDistributivoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmHorarioDetalle, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', False);
  end;
end;

procedure TSourceBaseDataModule.kbmHorarioDetalleBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[15] then
  begin
    FBeforePostLocks[15] := True;
    try
      CheckDetailRelation(kbmDistributivo, DataSet, 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId', 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId');
      CheckDetailRelation(kbmHorario, DataSet, 'CodHorario', 'CodHorario');
      CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      if DataSet.State = dsEdit then
      begin
      end;
    finally
      FBeforePostLocks[15] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmProfesorProhibicionTipoBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[16] then
  begin
    FBeforePostLocks[16] := True;
    try
      if DataSet.State = dsEdit then
      begin
        CheckMasterRelationUpdate(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
      end;
    finally
      FBeforePostLocks[16] := False
    end;
  end;
end;

procedure TSourceBaseDataModule.kbmProfesorProhibicionTipoBeforeDelete(DataSet: TDataSet);
begin
  if CheckRelations then
  begin
    CheckMasterRelationDelete(DataSet, kbmProfesorProhibicion, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo', False);
  end;
end;

procedure TSourceBaseDataModule.kbmProfesorProhibicionBeforePost(DataSet: TDataSet);
begin
  if CheckRelations and not FBeforePostLocks[17] then
  begin
    FBeforePostLocks[17] := True;
    try
      CheckDetailRelation(kbmPeriodo, DataSet, 'CodDia;CodHora', 'CodDia;CodHora');
      CheckDetailRelation(kbmProfesor, DataSet, 'CodProfesor', 'CodProfesor');
      CheckDetailRelation(kbmProfesorProhibicionTipo, DataSet, 'CodProfProhibicionTipo', 'CodProfProhibicionTipo');
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
  FDataSetNameList := TStringList.Create;
  FDataSetDescList := TStringList.Create;
  FCheckRelations := True;
  with FDataSetNameList do
  begin
    Add('kbmAulaTipo=AulaTipo');
    Add('kbmEspecializacion=Especializacion');
    Add('kbmDia=Dia');
    Add('kbmMateria=Materia');
    Add('kbmNivel=Nivel');
    Add('kbmHora=Hora');
    Add('kbmHorario=Horario');
    Add('kbmCurso=Curso');
    Add('kbmParaleloId=ParaleloId');
    Add('kbmMateriaProhibicionTipo=MateriaProhibicionTipo');
    Add('kbmPeriodo=Periodo');
    Add('kbmParalelo=Paralelo');
    Add('kbmProfesor=Profesor');
    Add('kbmMateriaProhibicion=MateriaProhibicion');
    Add('kbmDistributivo=Distributivo');
    Add('kbmHorarioDetalle=HorarioDetalle');
    Add('kbmProfesorProhibicionTipo=ProfesorProhibicionTipo');
    Add('kbmProfesorProhibicion=ProfesorProhibicion');
  end;
  with FDataSetDescList do
  begin
    Add('kbmAulaTipo=Tipos de aula');
    Add('kbmEspecializacion=Especializaciones');
    Add('kbmDia=Días laborables');
    Add('kbmMateria=Materias');
    Add('kbmNivel=Niveles');
    Add('kbmHora=Horas académicas');
    Add('kbmHorario=Horarios del colegio');
    Add('kbmCurso=Cursos');
    Add('kbmParaleloId=Identificadores de paralelo');
    Add('kbmMateriaProhibicionTipo=Tipos de prohibición de materia');
    Add('kbmPeriodo=Períodos laborables');
    Add('kbmParalelo=Paralelos');
    Add('kbmProfesor=Profesores');
    Add('kbmMateriaProhibicion=Prohibiciones de materia');
    Add('kbmDistributivo=Distributivo');
    Add('kbmHorarioDetalle=Detalle de los horarios');
    Add('kbmProfesorProhibicionTipo=Tipos de prohibición de profesor');
    Add('kbmProfesorProhibicion=Prohibiciones de profesor');
  end;
end;

procedure TSourceBaseDataModule.DataModuleDestroy(Sender: TObject);
begin
  FDataSetNameList.Free;
  FDataSetDescList.Free;
  CloseTables;
end;

function TSourceBaseDataModule.GetDescription(ADataSet: TDataSet): string;
begin
  result := FDataSetDescList.Values[ADataSet.Name];
end;

function TSourceBaseDataModule.GetName(ADataSet: TDataSet): string;
begin
  result := FDataSetNameList.Values[ADataSet.Name];
end;

procedure TSourceBaseDataModule.LoadFromBinaryStream(AStream: TStream);
begin
  FCheckRelations := False;
  try
    kbmAulaTipo.LoadFromBinaryStream(AStream);
    kbmEspecializacion.LoadFromBinaryStream(AStream);
    kbmDia.LoadFromBinaryStream(AStream);
    kbmMateria.LoadFromBinaryStream(AStream);
    kbmNivel.LoadFromBinaryStream(AStream);
    kbmHora.LoadFromBinaryStream(AStream);
    kbmHorario.LoadFromBinaryStream(AStream);
    kbmCurso.LoadFromBinaryStream(AStream);
    kbmParaleloId.LoadFromBinaryStream(AStream);
    kbmMateriaProhibicionTipo.LoadFromBinaryStream(AStream);
    kbmPeriodo.LoadFromBinaryStream(AStream);
    kbmParalelo.LoadFromBinaryStream(AStream);
    kbmProfesor.LoadFromBinaryStream(AStream);
    kbmMateriaProhibicion.LoadFromBinaryStream(AStream);
    kbmDistributivo.LoadFromBinaryStream(AStream);
    kbmHorarioDetalle.LoadFromBinaryStream(AStream);
    kbmProfesorProhibicionTipo.LoadFromBinaryStream(AStream);
    kbmProfesorProhibicion.LoadFromBinaryStream(AStream);
  finally
    FCheckRelations := True;
  end;
end;

procedure TSourceBaseDataModule.LoadFromBinaryFile(const AFileName: string);
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

procedure TSourceBaseDataModule.LoadFromTextDir(const ADirName: string);
begin
  FCheckRelations := False;
  try
    LoadDataSetFromCSVFile(kbmAulaTipo, ADirName + '\AulaTipo.csv');
    LoadDataSetFromCSVFile(kbmEspecializacion, ADirName + '\Especializacion.csv');
    LoadDataSetFromCSVFile(kbmDia, ADirName + '\Dia.csv');
    LoadDataSetFromCSVFile(kbmMateria, ADirName + '\Materia.csv');
    LoadDataSetFromCSVFile(kbmNivel, ADirName + '\Nivel.csv');
    LoadDataSetFromCSVFile(kbmHora, ADirName + '\Hora.csv');
    LoadDataSetFromCSVFile(kbmHorario, ADirName + '\Horario.csv');
    LoadDataSetFromCSVFile(kbmCurso, ADirName + '\Curso.csv');
    LoadDataSetFromCSVFile(kbmParaleloId, ADirName + '\ParaleloId.csv');
    LoadDataSetFromCSVFile(kbmMateriaProhibicionTipo, ADirName + '\MateriaProhibicionTipo.csv');
    LoadDataSetFromCSVFile(kbmPeriodo, ADirName + '\Periodo.csv');
    LoadDataSetFromCSVFile(kbmParalelo, ADirName + '\Paralelo.csv');
    LoadDataSetFromCSVFile(kbmProfesor, ADirName + '\Profesor.csv');
    LoadDataSetFromCSVFile(kbmMateriaProhibicion, ADirName + '\MateriaProhibicion.csv');
    LoadDataSetFromCSVFile(kbmDistributivo, ADirName + '\Distributivo.csv');
    LoadDataSetFromCSVFile(kbmHorarioDetalle, ADirName + '\HorarioDetalle.csv');
    LoadDataSetFromCSVFile(kbmProfesorProhibicionTipo, ADirName + '\ProfesorProhibicionTipo.csv');
    LoadDataSetFromCSVFile(kbmProfesorProhibicion, ADirName + '\ProfesorProhibicion.csv');
  finally
    FCheckRelations := True;
  end;
end;

procedure TSourceBaseDataModule.SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
begin
  kbmAulaTipo.SaveToBinaryStream(AStream, flags);
  kbmEspecializacion.SaveToBinaryStream(AStream, flags);
  kbmDia.SaveToBinaryStream(AStream, flags);
  kbmMateria.SaveToBinaryStream(AStream, flags);
  kbmNivel.SaveToBinaryStream(AStream, flags);
  kbmHora.SaveToBinaryStream(AStream, flags);
  kbmHorario.SaveToBinaryStream(AStream, flags);
  kbmCurso.SaveToBinaryStream(AStream, flags);
  kbmParaleloId.SaveToBinaryStream(AStream, flags);
  kbmMateriaProhibicionTipo.SaveToBinaryStream(AStream, flags);
  kbmPeriodo.SaveToBinaryStream(AStream, flags);
  kbmParalelo.SaveToBinaryStream(AStream, flags);
  kbmProfesor.SaveToBinaryStream(AStream, flags);
  kbmMateriaProhibicion.SaveToBinaryStream(AStream, flags);
  kbmDistributivo.SaveToBinaryStream(AStream, flags);
  kbmHorarioDetalle.SaveToBinaryStream(AStream, flags);
  kbmProfesorProhibicionTipo.SaveToBinaryStream(AStream, flags);
  kbmProfesorProhibicion.SaveToBinaryStream(AStream, flags);
end;

procedure TSourceBaseDataModule.SaveToBinaryFile(const AFileName: string; flags:TkbmMemTableSaveFlags);
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

procedure TSourceBaseDataModule.SaveToTextDir(const ADirName: string; flags:TkbmMemTableSaveFlags);
begin
  SaveDataSetToCSVFile(kbmAulaTipo, ADirName + '\AulaTipo.csv');
  SaveDataSetToCSVFile(kbmEspecializacion, ADirName + '\Especializacion.csv');
  SaveDataSetToCSVFile(kbmDia, ADirName + '\Dia.csv');
  SaveDataSetToCSVFile(kbmMateria, ADirName + '\Materia.csv');
  SaveDataSetToCSVFile(kbmNivel, ADirName + '\Nivel.csv');
  SaveDataSetToCSVFile(kbmHora, ADirName + '\Hora.csv');
  SaveDataSetToCSVFile(kbmHorario, ADirName + '\Horario.csv');
  SaveDataSetToCSVFile(kbmCurso, ADirName + '\Curso.csv');
  SaveDataSetToCSVFile(kbmParaleloId, ADirName + '\ParaleloId.csv');
  SaveDataSetToCSVFile(kbmMateriaProhibicionTipo, ADirName + '\MateriaProhibicionTipo.csv');
  SaveDataSetToCSVFile(kbmPeriodo, ADirName + '\Periodo.csv');
  SaveDataSetToCSVFile(kbmParalelo, ADirName + '\Paralelo.csv');
  SaveDataSetToCSVFile(kbmProfesor, ADirName + '\Profesor.csv');
  SaveDataSetToCSVFile(kbmMateriaProhibicion, ADirName + '\MateriaProhibicion.csv');
  SaveDataSetToCSVFile(kbmDistributivo, ADirName + '\Distributivo.csv');
  SaveDataSetToCSVFile(kbmHorarioDetalle, ADirName + '\HorarioDetalle.csv');
  SaveDataSetToCSVFile(kbmProfesorProhibicionTipo, ADirName + '\ProfesorProhibicionTipo.csv');
  SaveDataSetToCSVFile(kbmProfesorProhibicion, ADirName + '\ProfesorProhibicion.csv');
end;

procedure TSourceBaseDataModule.EmptyTables;
begin
  kbmAulaTipo.EmptyTable;
  kbmEspecializacion.EmptyTable;
  kbmDia.EmptyTable;
  kbmMateria.EmptyTable;
  kbmNivel.EmptyTable;
  kbmHora.EmptyTable;
  kbmHorario.EmptyTable;
  kbmCurso.EmptyTable;
  kbmParaleloId.EmptyTable;
  kbmMateriaProhibicionTipo.EmptyTable;
  kbmPeriodo.EmptyTable;
  kbmParalelo.EmptyTable;
  kbmProfesor.EmptyTable;
  kbmMateriaProhibicion.EmptyTable;
  kbmDistributivo.EmptyTable;
  kbmHorarioDetalle.EmptyTable;
  kbmProfesorProhibicionTipo.EmptyTable;
  kbmProfesorProhibicion.EmptyTable;
end;

procedure TSourceBaseDataModule.OpenTables;
begin
  kbmAulaTipo.Open;
  kbmEspecializacion.Open;
  kbmDia.Open;
  kbmMateria.Open;
  kbmNivel.Open;
  kbmHora.Open;
  kbmHorario.Open;
  kbmCurso.Open;
  kbmParaleloId.Open;
  kbmMateriaProhibicionTipo.Open;
  kbmPeriodo.Open;
  kbmParalelo.Open;
  kbmProfesor.Open;
  kbmMateriaProhibicion.Open;
  kbmDistributivo.Open;
  kbmHorarioDetalle.Open;
  kbmProfesorProhibicionTipo.Open;
  kbmProfesorProhibicion.Open;
end;

procedure TSourceBaseDataModule.CloseTables;
begin
  kbmAulaTipo.Close;
  kbmEspecializacion.Close;
  kbmDia.Close;
  kbmMateria.Close;
  kbmNivel.Close;
  kbmHora.Close;
  kbmHorario.Close;
  kbmCurso.Close;
  kbmParaleloId.Close;
  kbmMateriaProhibicionTipo.Close;
  kbmPeriodo.Close;
  kbmParalelo.Close;
  kbmProfesor.Close;
  kbmMateriaProhibicion.Close;
  kbmDistributivo.Close;
  kbmHorarioDetalle.Close;
  kbmProfesorProhibicionTipo.Close;
  kbmProfesorProhibicion.Close;
end;
end.

