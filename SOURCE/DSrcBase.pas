unit DSrcBase;
(*
  lunes, 25 de enero de 2010 0:38:41

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  KbmMemTable;

type
  TSourceBaseDataModule = class(TDataModule)
    TbAulaTipo: TkbmMemTable;
    TbAulaTipoCodAulaTipo:TAutoIncField;
    TbAulaTipoNomAulaTipo:TStringField;
    TbAulaTipoAbrAulaTipo:TStringField;
    TbAulaTipoCantidad:TIntegerField;
    dsAulaTipo: TDataSource;
    TbEspecializacion: TkbmMemTable;
    TbEspecializacionCodEspecializacion:TAutoIncField;
    TbEspecializacionNomEspecializacion:TStringField;
    TbEspecializacionAbrEspecializacion:TStringField;
    dsEspecializacion: TDataSource;
    TbDia: TkbmMemTable;
    TbDiaCodDia:TAutoIncField;
    TbDiaNomDia:TStringField;
    dsDia: TDataSource;
    TbMateria: TkbmMemTable;
    TbMateriaCodMateria:TAutoIncField;
    TbMateriaNomMateria:TStringField;
    dsMateria: TDataSource;
    TbNivel: TkbmMemTable;
    TbNivelCodNivel:TAutoIncField;
    TbNivelNomNivel:TStringField;
    TbNivelAbrNivel:TStringField;
    dsNivel: TDataSource;
    TbHora: TkbmMemTable;
    TbHoraCodHora:TAutoIncField;
    TbHoraNomHora:TStringField;
    TbHoraIntervalo:TStringField;
    dsHora: TDataSource;
    TbHorario: TkbmMemTable;
    TbHorarioCodHorario:TAutoIncField;
    TbHorarioMomentoInicial:TDateTimeField;
    TbHorarioMomentoFinal:TDateTimeField;
    TbHorarioInforme:TMemoField;
    dsHorario: TDataSource;
    TbCurso: TkbmMemTable;
    TbCursoCodNivel:TIntegerField;
    TbCursoCodEspecializacion:TIntegerField;
    dsCurso: TDataSource;
    TbParaleloId: TkbmMemTable;
    TbParaleloIdCodParaleloId:TAutoIncField;
    TbParaleloIdNomParaleloId:TStringField;
    dsParaleloId: TDataSource;
    TbMateriaProhibicionTipo: TkbmMemTable;
    TbMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoNomMateProhibicionTipo:TStringField;
    TbMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField;
    TbMateriaProhibicionTipoValMateProhibicionTipo:TFloatField;
    dsMateriaProhibicionTipo: TDataSource;
    TbPeriodo: TkbmMemTable;
    TbPeriodoCodDia:TIntegerField;
    TbPeriodoCodHora:TIntegerField;
    dsPeriodo: TDataSource;
    TbParalelo: TkbmMemTable;
    TbParaleloCodNivel:TIntegerField;
    TbParaleloCodEspecializacion:TIntegerField;
    TbParaleloCodParaleloId:TIntegerField;
    dsParalelo: TDataSource;
    TbProfesor: TkbmMemTable;
    TbProfesorCodProfesor:TAutoIncField;
    TbProfesorCedProfesor:TStringField;
    TbProfesorApeProfesor:TStringField;
    TbProfesorNomProfesor:TStringField;
    dsProfesor: TDataSource;
    TbMateriaProhibicion: TkbmMemTable;
    TbMateriaProhibicionCodMateria:TIntegerField;
    TbMateriaProhibicionCodDia:TIntegerField;
    TbMateriaProhibicionCodHora:TIntegerField;
    TbMateriaProhibicionCodMateProhibicionTipo:TIntegerField;
    dsMateriaProhibicion: TDataSource;
    TbDistributivo: TkbmMemTable;
    TbDistributivoCodMateria:TIntegerField;
    TbDistributivoCodNivel:TIntegerField;
    TbDistributivoCodEspecializacion:TIntegerField;
    TbDistributivoCodParaleloId:TIntegerField;
    TbDistributivoCodProfesor:TIntegerField;
    TbDistributivoCodAulaTipo:TIntegerField;
    TbDistributivoComposicion:TStringField;
    dsDistributivo: TDataSource;
    TbHorarioDetalle: TkbmMemTable;
    TbHorarioDetalleCodHorario:TIntegerField;
    TbHorarioDetalleCodMateria:TIntegerField;
    TbHorarioDetalleCodNivel:TIntegerField;
    TbHorarioDetalleCodEspecializacion:TIntegerField;
    TbHorarioDetalleCodParaleloId:TIntegerField;
    TbHorarioDetalleCodDia:TIntegerField;
    TbHorarioDetalleCodHora:TIntegerField;
    TbHorarioDetalleSesion:TIntegerField;
    dsHorarioDetalle: TDataSource;
    TbProfesorProhibicionTipo: TkbmMemTable;
    TbProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField;
    TbProfesorProhibicionTipoNomProfProhibicionTipo:TStringField;
    TbProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField;
    TbProfesorProhibicionTipoValProfProhibicionTipo:TFloatField;
    dsProfesorProhibicionTipo: TDataSource;
    TbProfesorProhibicion: TkbmMemTable;
    TbProfesorProhibicionCodProfesor:TIntegerField;
    TbProfesorProhibicionCodDia:TIntegerField;
    TbProfesorProhibicionCodHora:TIntegerField;
    TbProfesorProhibicionCodProfProhibicionTipo:TIntegerField;
    dsProfesorProhibicion: TDataSource;

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
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer); virtual;
    procedure SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
    procedure SaveToBinaryFile(const AFileName: TFileName; flags:TkbmMemTableSaveFlags);
    procedure SaveToTextFile(const AFileName: TFileName);
    procedure SaveToStrings(AStrings: TStrings); virtual;
    procedure SaveToTextDir(const ADirName: TFileName); virtual;
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
  FDataSetNameList := TStringList.Create;
  FDataSetDescList := TStringList.Create;
  FCheckRelations := True;
  with FDataSetNameList do
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
  with FDataSetDescList do
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
    TbAulaTipo.LoadFromBinaryStream(AStream);
    TbEspecializacion.LoadFromBinaryStream(AStream);
    TbDia.LoadFromBinaryStream(AStream);
    TbMateria.LoadFromBinaryStream(AStream);
    TbNivel.LoadFromBinaryStream(AStream);
    TbHora.LoadFromBinaryStream(AStream);
    TbHorario.LoadFromBinaryStream(AStream);
    TbCurso.LoadFromBinaryStream(AStream);
    TbParaleloId.LoadFromBinaryStream(AStream);
    TbMateriaProhibicionTipo.LoadFromBinaryStream(AStream);
    TbPeriodo.LoadFromBinaryStream(AStream);
    TbParalelo.LoadFromBinaryStream(AStream);
    TbProfesor.LoadFromBinaryStream(AStream);
    TbMateriaProhibicion.LoadFromBinaryStream(AStream);
    TbDistributivo.LoadFromBinaryStream(AStream);
    TbHorarioDetalle.LoadFromBinaryStream(AStream);
    TbProfesorProhibicionTipo.LoadFromBinaryStream(AStream);
    TbProfesorProhibicion.LoadFromBinaryStream(AStream);
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

procedure TSourceBaseDataModule.LoadFromTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
  APosition: Integer;
begin
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromFile(AFileName);
    APosition := 0;
    LoadFromStrings(AStrings, APosition);
  finally
    AStrings.Free;
  end;
end;

procedure TSourceBaseDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
begin
  FCheckRelations := False;
  try
    LoadDataSetFromStrings(TbAulaTipo, AStrings, APosition);
    LoadDataSetFromStrings(TbEspecializacion, AStrings, APosition);
    LoadDataSetFromStrings(TbDia, AStrings, APosition);
    LoadDataSetFromStrings(TbMateria, AStrings, APosition);
    LoadDataSetFromStrings(TbNivel, AStrings, APosition);
    LoadDataSetFromStrings(TbHora, AStrings, APosition);
    LoadDataSetFromStrings(TbHorario, AStrings, APosition);
    LoadDataSetFromStrings(TbCurso, AStrings, APosition);
    LoadDataSetFromStrings(TbParaleloId, AStrings, APosition);
    LoadDataSetFromStrings(TbMateriaProhibicionTipo, AStrings, APosition);
    LoadDataSetFromStrings(TbPeriodo, AStrings, APosition);
    LoadDataSetFromStrings(TbParalelo, AStrings, APosition);
    LoadDataSetFromStrings(TbProfesor, AStrings, APosition);
    LoadDataSetFromStrings(TbMateriaProhibicion, AStrings, APosition);
    LoadDataSetFromStrings(TbDistributivo, AStrings, APosition);
    LoadDataSetFromStrings(TbHorarioDetalle, AStrings, APosition);
    LoadDataSetFromStrings(TbProfesorProhibicionTipo, AStrings, APosition);
    LoadDataSetFromStrings(TbProfesorProhibicion, AStrings, APosition);
  finally
    FCheckRelations := True;
  end;
end;

procedure TSourceBaseDataModule.LoadFromTextDir(const ADirName: string);
begin
  FCheckRelations := False;
  try
    LoadDataSetFromCSVFile(TbAulaTipo, ADirName + '\AulaTipo.csv');
    LoadDataSetFromCSVFile(TbEspecializacion, ADirName + '\Especializacion.csv');
    LoadDataSetFromCSVFile(TbDia, ADirName + '\Dia.csv');
    LoadDataSetFromCSVFile(TbMateria, ADirName + '\Materia.csv');
    LoadDataSetFromCSVFile(TbNivel, ADirName + '\Nivel.csv');
    LoadDataSetFromCSVFile(TbHora, ADirName + '\Hora.csv');
    LoadDataSetFromCSVFile(TbHorario, ADirName + '\Horario.csv');
    LoadDataSetFromCSVFile(TbCurso, ADirName + '\Curso.csv');
    LoadDataSetFromCSVFile(TbParaleloId, ADirName + '\ParaleloId.csv');
    LoadDataSetFromCSVFile(TbMateriaProhibicionTipo, ADirName + '\MateriaProhibicionTipo.csv');
    LoadDataSetFromCSVFile(TbPeriodo, ADirName + '\Periodo.csv');
    LoadDataSetFromCSVFile(TbParalelo, ADirName + '\Paralelo.csv');
    LoadDataSetFromCSVFile(TbProfesor, ADirName + '\Profesor.csv');
    LoadDataSetFromCSVFile(TbMateriaProhibicion, ADirName + '\MateriaProhibicion.csv');
    LoadDataSetFromCSVFile(TbDistributivo, ADirName + '\Distributivo.csv');
    LoadDataSetFromCSVFile(TbHorarioDetalle, ADirName + '\HorarioDetalle.csv');
    LoadDataSetFromCSVFile(TbProfesorProhibicionTipo, ADirName + '\ProfesorProhibicionTipo.csv');
    LoadDataSetFromCSVFile(TbProfesorProhibicion, ADirName + '\ProfesorProhibicion.csv');
  finally
    FCheckRelations := True;
  end;
end;

procedure TSourceBaseDataModule.SaveToBinaryStream(AStream: TStream; flags:TkbmMemTableSaveFlags);
begin
  TbAulaTipo.SaveToBinaryStream(AStream, flags);
  TbEspecializacion.SaveToBinaryStream(AStream, flags);
  TbDia.SaveToBinaryStream(AStream, flags);
  TbMateria.SaveToBinaryStream(AStream, flags);
  TbNivel.SaveToBinaryStream(AStream, flags);
  TbHora.SaveToBinaryStream(AStream, flags);
  TbHorario.SaveToBinaryStream(AStream, flags);
  TbCurso.SaveToBinaryStream(AStream, flags);
  TbParaleloId.SaveToBinaryStream(AStream, flags);
  TbMateriaProhibicionTipo.SaveToBinaryStream(AStream, flags);
  TbPeriodo.SaveToBinaryStream(AStream, flags);
  TbParalelo.SaveToBinaryStream(AStream, flags);
  TbProfesor.SaveToBinaryStream(AStream, flags);
  TbMateriaProhibicion.SaveToBinaryStream(AStream, flags);
  TbDistributivo.SaveToBinaryStream(AStream, flags);
  TbHorarioDetalle.SaveToBinaryStream(AStream, flags);
  TbProfesorProhibicionTipo.SaveToBinaryStream(AStream, flags);
  TbProfesorProhibicion.SaveToBinaryStream(AStream, flags);
end;

procedure TSourceBaseDataModule.SaveToBinaryFile(const AFileName: TFileName; flags:TkbmMemTableSaveFlags);
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

procedure TSourceBaseDataModule.SaveToStrings(AStrings: TStrings);
begin
  SaveDataSetToStrings(TbAulaTipo, AStrings);
  SaveDataSetToStrings(TbEspecializacion, AStrings);
  SaveDataSetToStrings(TbDia, AStrings);
  SaveDataSetToStrings(TbMateria, AStrings);
  SaveDataSetToStrings(TbNivel, AStrings);
  SaveDataSetToStrings(TbHora, AStrings);
  SaveDataSetToStrings(TbHorario, AStrings);
  SaveDataSetToStrings(TbCurso, AStrings);
  SaveDataSetToStrings(TbParaleloId, AStrings);
  SaveDataSetToStrings(TbMateriaProhibicionTipo, AStrings);
  SaveDataSetToStrings(TbPeriodo, AStrings);
  SaveDataSetToStrings(TbParalelo, AStrings);
  SaveDataSetToStrings(TbProfesor, AStrings);
  SaveDataSetToStrings(TbMateriaProhibicion, AStrings);
  SaveDataSetToStrings(TbDistributivo, AStrings);
  SaveDataSetToStrings(TbHorarioDetalle, AStrings);
  SaveDataSetToStrings(TbProfesorProhibicionTipo, AStrings);
  SaveDataSetToStrings(TbProfesorProhibicion, AStrings);
end;

procedure TSourceBaseDataModule.SaveToTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
begin
  AStrings := TStringList.Create;
  try
    SaveToStrings(AStrings);
    AStrings.SaveToFile(AFileName);
  finally
    AStrings.Free;
  end;
end;

procedure TSourceBaseDataModule.SaveToTextDir(const ADirName: TFileName);
begin
  SaveDataSetToCSVFile(TbAulaTipo, ADirName + '\AulaTipo.csv');
  SaveDataSetToCSVFile(TbEspecializacion, ADirName + '\Especializacion.csv');
  SaveDataSetToCSVFile(TbDia, ADirName + '\Dia.csv');
  SaveDataSetToCSVFile(TbMateria, ADirName + '\Materia.csv');
  SaveDataSetToCSVFile(TbNivel, ADirName + '\Nivel.csv');
  SaveDataSetToCSVFile(TbHora, ADirName + '\Hora.csv');
  SaveDataSetToCSVFile(TbHorario, ADirName + '\Horario.csv');
  SaveDataSetToCSVFile(TbCurso, ADirName + '\Curso.csv');
  SaveDataSetToCSVFile(TbParaleloId, ADirName + '\ParaleloId.csv');
  SaveDataSetToCSVFile(TbMateriaProhibicionTipo, ADirName + '\MateriaProhibicionTipo.csv');
  SaveDataSetToCSVFile(TbPeriodo, ADirName + '\Periodo.csv');
  SaveDataSetToCSVFile(TbParalelo, ADirName + '\Paralelo.csv');
  SaveDataSetToCSVFile(TbProfesor, ADirName + '\Profesor.csv');
  SaveDataSetToCSVFile(TbMateriaProhibicion, ADirName + '\MateriaProhibicion.csv');
  SaveDataSetToCSVFile(TbDistributivo, ADirName + '\Distributivo.csv');
  SaveDataSetToCSVFile(TbHorarioDetalle, ADirName + '\HorarioDetalle.csv');
  SaveDataSetToCSVFile(TbProfesorProhibicionTipo, ADirName + '\ProfesorProhibicionTipo.csv');
  SaveDataSetToCSVFile(TbProfesorProhibicion, ADirName + '\ProfesorProhibicion.csv');
end;

procedure TSourceBaseDataModule.EmptyTables;
begin
  TbAulaTipo.EmptyTable;
  TbEspecializacion.EmptyTable;
  TbDia.EmptyTable;
  TbMateria.EmptyTable;
  TbNivel.EmptyTable;
  TbHora.EmptyTable;
  TbHorario.EmptyTable;
  TbCurso.EmptyTable;
  TbParaleloId.EmptyTable;
  TbMateriaProhibicionTipo.EmptyTable;
  TbPeriodo.EmptyTable;
  TbParalelo.EmptyTable;
  TbProfesor.EmptyTable;
  TbMateriaProhibicion.EmptyTable;
  TbDistributivo.EmptyTable;
  TbHorarioDetalle.EmptyTable;
  TbProfesorProhibicionTipo.EmptyTable;
  TbProfesorProhibicion.EmptyTable;
end;

procedure TSourceBaseDataModule.OpenTables;
begin
  TbAulaTipo.Open;
  TbEspecializacion.Open;
  TbDia.Open;
  TbMateria.Open;
  TbNivel.Open;
  TbHora.Open;
  TbHorario.Open;
  TbCurso.Open;
  TbParaleloId.Open;
  TbMateriaProhibicionTipo.Open;
  TbPeriodo.Open;
  TbParalelo.Open;
  TbProfesor.Open;
  TbMateriaProhibicion.Open;
  TbDistributivo.Open;
  TbHorarioDetalle.Open;
  TbProfesorProhibicionTipo.Open;
  TbProfesorProhibicion.Open;
end;

procedure TSourceBaseDataModule.CloseTables;
begin
  TbAulaTipo.Close;
  TbEspecializacion.Close;
  TbDia.Close;
  TbMateria.Close;
  TbNivel.Close;
  TbHora.Close;
  TbHorario.Close;
  TbCurso.Close;
  TbParaleloId.Close;
  TbMateriaProhibicionTipo.Close;
  TbPeriodo.Close;
  TbParalelo.Close;
  TbProfesor.Close;
  TbMateriaProhibicion.Close;
  TbDistributivo.Close;
  TbHorarioDetalle.Close;
  TbProfesorProhibicionTipo.Close;
  TbProfesorProhibicion.Close;
end;

end.

