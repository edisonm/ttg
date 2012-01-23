unit DSourceBase;

(*
  martes, 01 de marzo de 2011 20:57:51

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBase, ZConnection, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbRoomType: TZTable;
    DSRoomType: TDataSource;
    TbSpecialization: TZTable;
    DSSpecialization: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbSubject: TZTable;
    DSSubject: TDataSource;
    TbLevel: TZTable;
    DSLevel: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbTimeTable: TZTable;
    DSTimeTable: TDataSource;
    TbCourse: TZTable;
    DSCourse: TDataSource;
    TbGroupId: TZTable;
    DSGroupId: TDataSource;
    TbSubjectRestrictionType: TZTable;
    DSSubjectRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbClass: TZTable;
    DSClass: TDataSource;
    TbTeacher: TZTable;
    DSTeacher: TDataSource;
    TbSubjectRestriction: TZTable;
    DSSubjectRestriction: TDataSource;
    TbDistribution: TZTable;
    DSDistribution: TDataSource;
    TbTimeTableDetail: TZTable;
    DSTimeTableDetail: TDataSource;
    TbTeacherRestrictionType: TZTable;
    DSTeacherRestrictionType: TDataSource;
    TbTeacherRestriction: TZTable;
    DSTeacherRestriction: TDataSource;

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

procedure TSourceBaseDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  OnDestroy := DataModuleDestroy;
  SetLength(FTables, 18);
  SetLength(FMasterRels, 18);
  SetLength(FDetailRels, 18);
  SetLength(FBeforePostLocks, 18);
  Tables[0] := TbRoomType;
  TbRoomType.BeforePost := DataSetBeforePost;
  TbRoomType.BeforeDelete := DataSetBeforeDelete;
  Tables[1] := TbSpecialization;
  TbSpecialization.BeforePost := DataSetBeforePost;
  TbSpecialization.BeforeDelete := DataSetBeforeDelete;
  Tables[2] := TbDay;
  TbDay.BeforePost := DataSetBeforePost;
  TbDay.BeforeDelete := DataSetBeforeDelete;
  Tables[3] := TbSubject;
  TbSubject.BeforePost := DataSetBeforePost;
  TbSubject.BeforeDelete := DataSetBeforeDelete;
  Tables[4] := TbLevel;
  TbLevel.BeforePost := DataSetBeforePost;
  TbLevel.BeforeDelete := DataSetBeforeDelete;
  Tables[5] := TbHour;
  TbHour.BeforePost := DataSetBeforePost;
  TbHour.BeforeDelete := DataSetBeforeDelete;
  Tables[6] := TbTimeTable;
  TbTimeTable.BeforePost := DataSetBeforePost;
  TbTimeTable.BeforeDelete := DataSetBeforeDelete;
  Tables[7] := TbCourse;
  TbCourse.BeforePost := DataSetBeforePost;
  TbCourse.BeforeDelete := DataSetBeforeDelete;
  Tables[8] := TbGroupId;
  TbGroupId.BeforePost := DataSetBeforePost;
  TbGroupId.BeforeDelete := DataSetBeforeDelete;
  Tables[9] := TbSubjectRestrictionType;
  TbSubjectRestrictionType.BeforePost := DataSetBeforePost;
  TbSubjectRestrictionType.BeforeDelete := DataSetBeforeDelete;
  Tables[10] := TbTimeSlot;
  TbTimeSlot.BeforePost := DataSetBeforePost;
  TbTimeSlot.BeforeDelete := DataSetBeforeDelete;
  Tables[11] := TbClass;
  TbClass.BeforePost := DataSetBeforePost;
  TbClass.BeforeDelete := DataSetBeforeDelete;
  Tables[12] := TbTeacher;
  TbTeacher.BeforePost := DataSetBeforePost;
  TbTeacher.BeforeDelete := DataSetBeforeDelete;
  Tables[13] := TbSubjectRestriction;
  TbSubjectRestriction.BeforePost := DataSetBeforePost;
  Tables[14] := TbDistribution;
  TbDistribution.BeforePost := DataSetBeforePost;
  TbDistribution.BeforeDelete := DataSetBeforeDelete;
  Tables[15] := TbTimeTableDetail;
  TbTimeTableDetail.BeforePost := DataSetBeforePost;
  Tables[16] := TbTeacherRestrictionType;
  TbTeacherRestrictionType.BeforePost := DataSetBeforePost;
  TbTeacherRestrictionType.BeforeDelete := DataSetBeforeDelete;
  Tables[17] := TbTeacherRestriction;
  TbTeacherRestriction.BeforePost := DataSetBeforePost;
  SetLength(FMasterRels[0], 1);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdRoomType';
    DetailFields := 'IdRoomType';
    Cascade := False;
  end;
  SetLength(FMasterRels[1], 1);
  with FMasterRels[1, 0] do
  begin
    DetailDataSet := TbCourse;
    MasterFields := 'IdSpecialization';
    DetailFields := 'IdSpecialization';
    Cascade := False;
  end;
  SetLength(FMasterRels[2], 1);
  with FMasterRels[2, 0] do
  begin
    DetailDataSet := TbTimeSlot;
    MasterFields := 'IdDay';
    DetailFields := 'IdDay';
    Cascade := False;
  end;
  SetLength(FMasterRels[3], 2);
  with FMasterRels[3, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
    Cascade := False;
  end;
  with FMasterRels[3, 1] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
    Cascade := False;
  end;
  SetLength(FMasterRels[4], 1);
  with FMasterRels[4, 0] do
  begin
    DetailDataSet := TbCourse;
    MasterFields := 'IdLevel';
    DetailFields := 'IdLevel';
    Cascade := False;
  end;
  SetLength(FMasterRels[5], 1);
  with FMasterRels[5, 0] do
  begin
    DetailDataSet := TbTimeSlot;
    MasterFields := 'IdHour';
    DetailFields := 'IdHour';
    Cascade := False;
  end;
  SetLength(FMasterRels[6], 1);
  with FMasterRels[6, 0] do
  begin
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdTimeTable';
    DetailFields := 'IdTimeTable';
    Cascade := True;
  end;
  SetLength(FMasterRels[7], 1);
  with FMasterRels[7, 0] do
  begin
    DetailDataSet := TbClass;
    MasterFields := 'IdLevel;IdSpecialization';
    DetailFields := 'IdLevel;IdSpecialization';
    Cascade := False;
  end;
  SetLength(FDetailRels[7], 2);
  with FDetailRels[7, 0] do
  begin
    MasterDataSet := TbSpecialization;
    MasterFields := 'IdSpecialization';
    DetailFields := 'IdSpecialization';
  end;
  with FDetailRels[7, 1] do
  begin
    MasterDataSet := TbLevel;
    MasterFields := 'IdLevel';
    DetailFields := 'IdLevel';
  end;
  SetLength(FMasterRels[8], 1);
  with FMasterRels[8, 0] do
  begin
    DetailDataSet := TbClass;
    MasterFields := 'IdGroupId';
    DetailFields := 'IdGroupId';
    Cascade := False;
  end;
  SetLength(FMasterRels[9], 1);
  with FMasterRels[9, 0] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdSubjectRestrictionType';
    DetailFields := 'IdSubjectRestrictionType';
    Cascade := False;
  end;
  SetLength(FMasterRels[10], 3);
  with FMasterRels[10, 0] do
  begin
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  with FMasterRels[10, 1] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  with FMasterRels[10, 2] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  SetLength(FDetailRels[10], 2);
  with FDetailRels[10, 0] do
  begin
    MasterDataSet := TbDay;
    MasterFields := 'IdDay';
    DetailFields := 'IdDay';
  end;
  with FDetailRels[10, 1] do
  begin
    MasterDataSet := TbHour;
    MasterFields := 'IdHour';
    DetailFields := 'IdHour';
  end;
  SetLength(FMasterRels[11], 1);
  with FMasterRels[11, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdLevel;IdSpecialization;IdGroupId';
    Cascade := False;
  end;
  SetLength(FDetailRels[11], 2);
  with FDetailRels[11, 0] do
  begin
    MasterDataSet := TbCourse;
    MasterFields := 'IdLevel;IdSpecialization';
    DetailFields := 'IdLevel;IdSpecialization';
  end;
  with FDetailRels[11, 1] do
  begin
    MasterDataSet := TbGroupId;
    MasterFields := 'IdGroupId';
    DetailFields := 'IdGroupId';
  end;
  SetLength(FMasterRels[12], 2);
  with FMasterRels[12, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
    Cascade := False;
  end;
  with FMasterRels[12, 1] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
    Cascade := False;
  end;
  SetLength(FDetailRels[13], 3);
  with FDetailRels[13, 0] do
  begin
    MasterDataSet := TbSubject;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
  end;
  with FDetailRels[13, 1] do
  begin
    MasterDataSet := TbSubjectRestrictionType;
    MasterFields := 'IdSubjectRestrictionType';
    DetailFields := 'IdSubjectRestrictionType';
  end;
  with FDetailRels[13, 2] do
  begin
    MasterDataSet := TbTimeSlot;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
  end;
  SetLength(FMasterRels[14], 1);
  with FMasterRels[14, 0] do
  begin
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    Cascade := False;
  end;
  SetLength(FDetailRels[14], 4);
  with FDetailRels[14, 0] do
  begin
    MasterDataSet := TbRoomType;
    MasterFields := 'IdRoomType';
    DetailFields := 'IdRoomType';
  end;
  with FDetailRels[14, 1] do
  begin
    MasterDataSet := TbSubject;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
  end;
  with FDetailRels[14, 2] do
  begin
    MasterDataSet := TbClass;
    MasterFields := 'IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdLevel;IdSpecialization;IdGroupId';
  end;
  with FDetailRels[14, 3] do
  begin
    MasterDataSet := TbTeacher;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
  end;
  SetLength(FDetailRels[15], 3);
  with FDetailRels[15, 0] do
  begin
    MasterDataSet := TbDistribution;
    MasterFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
  end;
  with FDetailRels[15, 1] do
  begin
    MasterDataSet := TbTimeTable;
    MasterFields := 'IdTimeTable';
    DetailFields := 'IdTimeTable';
  end;
  with FDetailRels[15, 2] do
  begin
    MasterDataSet := TbTimeSlot;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
  end;
  SetLength(FMasterRels[16], 1);
  with FMasterRels[16, 0] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdTeacherRestrictionType';
    DetailFields := 'IdTeacherRestrictionType';
    Cascade := False;
  end;
  SetLength(FDetailRels[17], 3);
  with FDetailRels[17, 0] do
  begin
    MasterDataSet := TbTimeSlot;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
  end;
  with FDetailRels[17, 1] do
  begin
    MasterDataSet := TbTeacher;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
  end;
  with FDetailRels[17, 2] do
  begin
    MasterDataSet := TbTeacherRestrictionType;
    MasterFields := 'IdTeacherRestrictionType';
    DetailFields := 'IdTeacherRestrictionType';
  end;
  with DataSetNameList do
  begin
    Add('TbRoomType=RoomType');
    Add('TbSpecialization=Specialization');
    Add('TbDay=Day');
    Add('TbSubject=Subject');
    Add('TbLevel=Level');
    Add('TbHour=Hour');
    Add('TbTimeTable=TimeTable');
    Add('TbCourse=Course');
    Add('TbGroupId=GroupId');
    Add('TbSubjectRestrictionType=SubjectRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbClass=Class');
    Add('TbTeacher=Teacher');
    Add('TbSubjectRestriction=SubjectRestriction');
    Add('TbDistribution=Distribution');
    Add('TbTimeTableDetail=TimeTableDetail');
    Add('TbTeacherRestrictionType=TeacherRestrictionType');
    Add('TbTeacherRestriction=TeacherRestriction');
  end;
  with FieldCaptionList do
  begin
    Add('TbRoomType.IdRoomType=Idigo');
    Add('TbRoomType.NaRoomType=Nombre');
    Add('TbRoomType.AbRoomType=Abeviatura');
    Add('TbSpecialization.IdSpecialization=Idigo');
    Add('TbSpecialization.NaSpecialization=Nombre');
    Add('TbSpecialization.AbSpecialization=Abeviatura');
    Add('TbDay.IdDay=Idigo');
    Add('TbDay.NaDay=Nombre');
    Add('TbSubject.IdSubject=Idigo');
    Add('TbSubject.NaSubject=Nombre');
    Add('TbLevel.IdLevel=Idigo');
    Add('TbLevel.NaLevel=Nombre');
    Add('TbLevel.AbLevel=Abeviatura');
    Add('TbHour.IdHour=Idigo');
    Add('TbHour.NaHour=Nombre');
    Add('TbTimeTable.IdTimeTable=Idigo');
    Add('TbTimeTable.TimeIni=Momento Inicial');
    Add('TbTimeTable.TimeEnd=Momento Final');
    Add('TbCourse.IdLevel=Level');
    Add('TbCourse.IdSpecialization=Especialización');
    Add('TbGroupId.IdGroupId=Idigo');
    Add('TbGroupId.NaGroupId=Nombre');
    Add('TbSubjectRestrictionType.IdSubjectRestrictionType=Idigo');
    Add('TbSubjectRestrictionType.NaSubjectRestrictionType=Nombre');
    Add('TbSubjectRestrictionType.ColSubjectRestrictionType=Color');
    Add('TbSubjectRestrictionType.ValSubjectRestrictionType=Valor');
    Add('TbTimeSlot.IdDay=Day');
    Add('TbTimeSlot.IdHour=Hour');
    Add('TbClass.IdLevel=Level');
    Add('TbClass.IdSpecialization=Specialization');
    Add('TbClass.IdGroupId=Class');
    Add('TbTeacher.IdTeacher=Idigo');
    Add('TbTeacher.CedTeacher=Cedula');
    Add('TbTeacher.ApeTeacher=Apellido');
    Add('TbTeacher.NaTeacher=Nombre');
    Add('TbSubjectRestriction.IdSubject=Subject');
    Add('TbSubjectRestriction.IdDay=Day');
    Add('TbSubjectRestriction.IdHour=Hour');
    Add('TbSubjectRestriction.IdSubjectRestrictionType=Tipo de Prohibicion');
    Add('TbDistribution.IdSubject=Subject');
    Add('TbDistribution.IdLevel=Level');
    Add('TbDistribution.IdSpecialization=Specialization');
    Add('TbDistribution.IdGroupId=Class');
    Add('TbDistribution.IdTeacher=Teacher');
    Add('TbDistribution.IdRoomType=Tipo de Aula');
    Add('TbTimeTableDetail.IdTimeTable=TimeTable');
    Add('TbTimeTableDetail.IdSubject=Subject');
    Add('TbTimeTableDetail.IdLevel=Level');
    Add('TbTimeTableDetail.IdSpecialization=Specialization');
    Add('TbTimeTableDetail.IdGroupId=Class');
    Add('TbTimeTableDetail.IdDay=Day');
    Add('TbTimeTableDetail.IdHour=Hour');
    Add('TbTeacherRestrictionType.IdTeacherRestrictionType=Idigo');
    Add('TbTeacherRestrictionType.NaTeacherRestrictionType=Nombre');
    Add('TbTeacherRestrictionType.ColTeacherRestrictionType=Color');
    Add('TbTeacherRestrictionType.ValTeacherRestrictionType=Valor');
    Add('TbTeacherRestriction.IdTeacher=Teacher');
    Add('TbTeacherRestriction.IdDay=Day');
    Add('TbTeacherRestriction.IdHour=Hour');
    Add('TbTeacherRestriction.IdTeacherRestrictionType=Tipo de prohibicion');
  end;
  with DataSetDescList do
  begin
    Add('TbRoomType=Tipos de aula');
    Add('TbSpecialization=Specializationes');
    Add('TbDay=Days laborables');
    Add('TbSubject=Subjects');
    Add('TbLevel=Leveles');
    Add('TbHour=Hours academicas');
    Add('TbTimeTable=TimeTables del colegio');
    Add('TbCourse=Courses');
    Add('TbGroupId=Identificadores de paralelo');
    Add('TbSubjectRestrictionType=Tipos de prohibicion de materia');
    Add('TbTimeSlot=TimeSlots laborables');
    Add('TbClass=Classs');
    Add('TbTeacher=Teacheres');
    Add('TbSubjectRestriction=Prohibiciones de materia');
    Add('TbDistribution=Distribution');
    Add('TbTimeTableDetail=Detalle de los horarios');
    Add('TbTeacherRestrictionType=Tipos de prohibicion de profesor');
    Add('TbTeacherRestriction=Prohibiciones de profesor');
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsourcebase.lrs}
{$ENDIF}
end.

