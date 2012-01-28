unit dsourcebase;

(*
  28/01/2012 1:41

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
    TbLevel: TZTable;
    DSLevel: TDataSource;
    TbGroupId: TZTable;
    DSGroupId: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbSpecialization: TZTable;
    DSSpecialization: TDataSource;
    TbCourse: TZTable;
    DSCourse: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbRoomType: TZTable;
    DSRoomType: TDataSource;
    TbClass: TZTable;
    DSClass: TDataSource;
    TbSubject: TZTable;
    DSSubject: TDataSource;
    TbTeacher: TZTable;
    DSTeacher: TDataSource;
    TbSubjectRestrictionType: TZTable;
    DSSubjectRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbDistribution: TZTable;
    DSDistribution: TDataSource;
    TbTeacherRestrictionType: TZTable;
    DSTeacherRestrictionType: TDataSource;
    TbTeacherRestriction: TZTable;
    DSTeacherRestriction: TDataSource;
    TbSubjectRestriction: TZTable;
    DSSubjectRestriction: TDataSource;
    TbTimeTable: TZTable;
    DSTimeTable: TDataSource;
    TbTimeTableDetail: TZTable;
    DSTimeTableDetail: TDataSource;

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
  Tables[0] := TbLevel;
  TbLevel.BeforePost := DataSetBeforePost;
  TbLevel.BeforeDelete := DataSetBeforeDelete;
  Tables[1] := TbGroupId;
  TbGroupId.BeforePost := DataSetBeforePost;
  TbGroupId.BeforeDelete := DataSetBeforeDelete;
  Tables[2] := TbDay;
  TbDay.BeforePost := DataSetBeforePost;
  TbDay.BeforeDelete := DataSetBeforeDelete;
  Tables[3] := TbSpecialization;
  TbSpecialization.BeforePost := DataSetBeforePost;
  TbSpecialization.BeforeDelete := DataSetBeforeDelete;
  Tables[4] := TbCourse;
  TbCourse.BeforePost := DataSetBeforePost;
  TbCourse.BeforeDelete := DataSetBeforeDelete;
  Tables[5] := TbHour;
  TbHour.BeforePost := DataSetBeforePost;
  TbHour.BeforeDelete := DataSetBeforeDelete;
  Tables[6] := TbRoomType;
  TbRoomType.BeforePost := DataSetBeforePost;
  TbRoomType.BeforeDelete := DataSetBeforeDelete;
  Tables[7] := TbClass;
  TbClass.BeforePost := DataSetBeforePost;
  TbClass.BeforeDelete := DataSetBeforeDelete;
  Tables[8] := TbSubject;
  TbSubject.BeforePost := DataSetBeforePost;
  TbSubject.BeforeDelete := DataSetBeforeDelete;
  Tables[9] := TbTeacher;
  TbTeacher.BeforePost := DataSetBeforePost;
  TbTeacher.BeforeDelete := DataSetBeforeDelete;
  Tables[10] := TbSubjectRestrictionType;
  TbSubjectRestrictionType.BeforePost := DataSetBeforePost;
  TbSubjectRestrictionType.BeforeDelete := DataSetBeforeDelete;
  Tables[11] := TbTimeSlot;
  TbTimeSlot.BeforePost := DataSetBeforePost;
  TbTimeSlot.BeforeDelete := DataSetBeforeDelete;
  Tables[12] := TbDistribution;
  TbDistribution.BeforePost := DataSetBeforePost;
  TbDistribution.BeforeDelete := DataSetBeforeDelete;
  Tables[13] := TbTeacherRestrictionType;
  TbTeacherRestrictionType.BeforePost := DataSetBeforePost;
  TbTeacherRestrictionType.BeforeDelete := DataSetBeforeDelete;
  Tables[14] := TbTeacherRestriction;
  TbTeacherRestriction.BeforePost := DataSetBeforePost;
  Tables[15] := TbSubjectRestriction;
  TbSubjectRestriction.BeforePost := DataSetBeforePost;
  Tables[16] := TbTimeTable;
  TbTimeTable.BeforePost := DataSetBeforePost;
  TbTimeTable.BeforeDelete := DataSetBeforeDelete;
  Tables[17] := TbTimeTableDetail;
  TbTimeTableDetail.BeforePost := DataSetBeforePost;
  SetLength(FMasterRels[0], 1);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbCourse;
    MasterFields := 'IdLevel';
    DetailFields := 'IdLevel';
    Cascade := False;
  end;
  SetLength(FMasterRels[1], 1);
  with FMasterRels[1, 0] do
  begin
    DetailDataSet := TbClass;
    MasterFields := 'IdGroupId';
    DetailFields := 'IdGroupId';
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
  SetLength(FMasterRels[3], 1);
  with FMasterRels[3, 0] do
  begin
    DetailDataSet := TbCourse;
    MasterFields := 'IdSpecialization';
    DetailFields := 'IdSpecialization';
    Cascade := False;
  end;
  SetLength(FMasterRels[4], 1);
  with FMasterRels[4, 0] do
  begin
    DetailDataSet := TbClass;
    MasterFields := 'IdLevel;IdSpecialization';
    DetailFields := 'IdLevel;IdSpecialization';
    Cascade := False;
  end;
  SetLength(FDetailRels[4], 2);
  with FDetailRels[4, 0] do
  begin
    MasterDataSet := TbLevel;
    MasterFields := 'IdLevel';
    DetailFields := 'IdLevel';
  end;
  with FDetailRels[4, 1] do
  begin
    MasterDataSet := TbSpecialization;
    MasterFields := 'IdSpecialization';
    DetailFields := 'IdSpecialization';
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
    DetailDataSet := TbDistribution;
    MasterFields := 'IdRoomType';
    DetailFields := 'IdRoomType';
    Cascade := False;
  end;
  SetLength(FMasterRels[7], 1);
  with FMasterRels[7, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdLevel;IdSpecialization;IdGroupId';
    Cascade := False;
  end;
  SetLength(FDetailRels[7], 2);
  with FDetailRels[7, 0] do
  begin
    MasterDataSet := TbCourse;
    MasterFields := 'IdLevel;IdSpecialization';
    DetailFields := 'IdLevel;IdSpecialization';
  end;
  with FDetailRels[7, 1] do
  begin
    MasterDataSet := TbGroupId;
    MasterFields := 'IdGroupId';
    DetailFields := 'IdGroupId';
  end;
  SetLength(FMasterRels[8], 2);
  with FMasterRels[8, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
    Cascade := False;
  end;
  with FMasterRels[8, 1] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
    Cascade := False;
  end;
  SetLength(FMasterRels[9], 2);
  with FMasterRels[9, 0] do
  begin
    DetailDataSet := TbDistribution;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
    Cascade := False;
  end;
  with FMasterRels[9, 1] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
    Cascade := False;
  end;
  SetLength(FMasterRels[10], 1);
  with FMasterRels[10, 0] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdSubjectRestrictionType';
    DetailFields := 'IdSubjectRestrictionType';
    Cascade := False;
  end;
  SetLength(FMasterRels[11], 3);
  with FMasterRels[11, 0] do
  begin
    DetailDataSet := TbSubjectRestriction;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  with FMasterRels[11, 1] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  with FMasterRels[11, 2] do
  begin
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
    Cascade := False;
  end;
  SetLength(FDetailRels[11], 2);
  with FDetailRels[11, 0] do
  begin
    MasterDataSet := TbDay;
    MasterFields := 'IdDay';
    DetailFields := 'IdDay';
  end;
  with FDetailRels[11, 1] do
  begin
    MasterDataSet := TbHour;
    MasterFields := 'IdHour';
    DetailFields := 'IdHour';
  end;
  SetLength(FMasterRels[12], 1);
  with FMasterRels[12, 0] do
  begin
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    Cascade := False;
  end;
  SetLength(FDetailRels[12], 4);
  with FDetailRels[12, 0] do
  begin
    MasterDataSet := TbClass;
    MasterFields := 'IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdLevel;IdSpecialization;IdGroupId';
  end;
  with FDetailRels[12, 1] do
  begin
    MasterDataSet := TbRoomType;
    MasterFields := 'IdRoomType';
    DetailFields := 'IdRoomType';
  end;
  with FDetailRels[12, 2] do
  begin
    MasterDataSet := TbSubject;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
  end;
  with FDetailRels[12, 3] do
  begin
    MasterDataSet := TbTeacher;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
  end;
  SetLength(FMasterRels[13], 1);
  with FMasterRels[13, 0] do
  begin
    DetailDataSet := TbTeacherRestriction;
    MasterFields := 'IdTeacherRestrictionType';
    DetailFields := 'IdTeacherRestrictionType';
    Cascade := False;
  end;
  SetLength(FDetailRels[14], 3);
  with FDetailRels[14, 0] do
  begin
    MasterDataSet := TbTeacherRestrictionType;
    MasterFields := 'IdTeacherRestrictionType';
    DetailFields := 'IdTeacherRestrictionType';
  end;
  with FDetailRels[14, 1] do
  begin
    MasterDataSet := TbTeacher;
    MasterFields := 'IdTeacher';
    DetailFields := 'IdTeacher';
  end;
  with FDetailRels[14, 2] do
  begin
    MasterDataSet := TbTimeSlot;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
  end;
  SetLength(FDetailRels[15], 3);
  with FDetailRels[15, 0] do
  begin
    MasterDataSet := TbSubjectRestrictionType;
    MasterFields := 'IdSubjectRestrictionType';
    DetailFields := 'IdSubjectRestrictionType';
  end;
  with FDetailRels[15, 1] do
  begin
    MasterDataSet := TbSubject;
    MasterFields := 'IdSubject';
    DetailFields := 'IdSubject';
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
    DetailDataSet := TbTimeTableDetail;
    MasterFields := 'IdTimeTable';
    DetailFields := 'IdTimeTable';
    Cascade := True;
  end;
  SetLength(FDetailRels[17], 3);
  with FDetailRels[17, 0] do
  begin
    MasterDataSet := TbDistribution;
    MasterFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
    DetailFields := 'IdSubject;IdLevel;IdSpecialization;IdGroupId';
  end;
  with FDetailRels[17, 1] do
  begin
    MasterDataSet := TbTimeSlot;
    MasterFields := 'IdDay;IdHour';
    DetailFields := 'IdDay;IdHour';
  end;
  with FDetailRels[17, 2] do
  begin
    MasterDataSet := TbTimeTable;
    MasterFields := 'IdTimeTable';
    DetailFields := 'IdTimeTable';
  end;
  with DataSetNameList do
  begin
    Add('TbLevel=Level');
    Add('TbGroupId=GroupId');
    Add('TbDay=Day');
    Add('TbSpecialization=Specialization');
    Add('TbCourse=Course');
    Add('TbHour=Hour');
    Add('TbRoomType=RoomType');
    Add('TbClass=Class');
    Add('TbSubject=Subject');
    Add('TbTeacher=Teacher');
    Add('TbSubjectRestrictionType=SubjectRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbDistribution=Distribution');
    Add('TbTeacherRestrictionType=TeacherRestrictionType');
    Add('TbTeacherRestriction=TeacherRestriction');
    Add('TbSubjectRestriction=SubjectRestriction');
    Add('TbTimeTable=TimeTable');
    Add('TbTimeTableDetail=TimeTableDetail');
  end;
  with FieldCaptionList do
  begin
    Add('TbLevel.IdLevel=Id');
    Add('TbLevel.NaLevel=Name');
    Add('TbLevel.AbLevel=Abbreviation');
    Add('TbGroupId.IdGroupId=Id');
    Add('TbGroupId.NaGroupId=Name');
    Add('TbDay.IdDay=Id');
    Add('TbDay.NaDay=Name');
    Add('TbSpecialization.IdSpecialization=Id');
    Add('TbSpecialization.NaSpecialization=Name');
    Add('TbSpecialization.AbSpecialization=Abbreviation');
    Add('TbCourse.IdLevel=Level');
    Add('TbCourse.IdSpecialization=Specialization');
    Add('TbHour.IdHour=Id');
    Add('TbHour.NaHour=Name');
    Add('TbRoomType.IdRoomType=Id');
    Add('TbRoomType.NaRoomType=Name');
    Add('TbRoomType.AbRoomType=Abbreviation');
    Add('TbRoomType.Number=Cantidad');
    Add('TbClass.IdLevel=Level');
    Add('TbClass.IdSpecialization=Specialization');
    Add('TbClass.IdGroupId=Group Id');
    Add('TbSubject.IdSubject=Id');
    Add('TbSubject.NaSubject=Name');
    Add('TbTeacher.IdTeacher=Id');
    Add('TbTeacher.TeacherNationalId=National ID');
    Add('TbTeacher.LnTeacher=Last Name');
    Add('TbTeacher.NaTeacher=Name');
    Add('TbSubjectRestrictionType.IdSubjectRestrictionType=Id');
    Add('TbSubjectRestrictionType.NaSubjectRestrictionType=Name');
    Add('TbSubjectRestrictionType.ColSubjectRestrictionType=Color');
    Add('TbSubjectRestrictionType.ValSubjectRestrictionType=Value');
    Add('TbTimeSlot.IdDay=Dia');
    Add('TbTimeSlot.IdHour=Hora');
    Add('TbDistribution.IdSubject=Subject');
    Add('TbDistribution.IdLevel=Level');
    Add('TbDistribution.IdSpecialization=Specialization');
    Add('TbDistribution.IdGroupId=Group Id');
    Add('TbDistribution.IdTeacher=Teacher');
    Add('TbDistribution.IdRoomType=Room Type');
    Add('TbTeacherRestrictionType.IdTeacherRestrictionType=Id');
    Add('TbTeacherRestrictionType.NaTeacherRestrictionType=Name');
    Add('TbTeacherRestrictionType.ColTeacherRestrictionType=Color');
    Add('TbTeacherRestrictionType.ValTeacherRestrictionType=Value');
    Add('TbTeacherRestriction.IdTeacher=Teacher');
    Add('TbTeacherRestriction.IdDay=Day');
    Add('TbTeacherRestriction.IdHour=Hour');
    Add('TbTeacherRestriction.IdTeacherRestrictionType=Restriction Type');
    Add('TbSubjectRestriction.IdSubject=Subject');
    Add('TbSubjectRestriction.IdDay=Day');
    Add('TbSubjectRestriction.IdHour=Hour');
    Add('TbSubjectRestriction.IdSubjectRestrictionType=Restriction Type');
    Add('TbTimeTable.IdTimeTable=Id');
    Add('TbTimeTable.TimeIni=Initial Time');
    Add('TbTimeTable.TimeEnd=End Time');
    Add('TbTimeTableDetail.IdTimeTable=TimeTable');
    Add('TbTimeTableDetail.IdSubject=Subject');
    Add('TbTimeTableDetail.IdLevel=Level');
    Add('TbTimeTableDetail.IdSpecialization=Specialization');
    Add('TbTimeTableDetail.IdGroupId=Group');
    Add('TbTimeTableDetail.IdDay=Day');
    Add('TbTimeTableDetail.IdHour=Hour');
  end;
  with DataSetDescList do
  begin
    Add('TbLevel=Levels');
    Add('TbGroupId=Group Identifiers');
    Add('TbDay=Working Days');
    Add('TbSpecialization=Specializations');
    Add('TbCourse=Courses');
    Add('TbHour=Academic Hours');
    Add('TbRoomType=Types of Room');
    Add('TbClass=Groups');
    Add('TbSubject=Subjects');
    Add('TbTeacher=Teachers');
    Add('TbSubjectRestrictionType=Types of Signature Restrictions');
    Add('TbTimeSlot=Time Slots');
    Add('TbDistribution=Distribution of Workload');
    Add('TbTeacherRestrictionType=Types of Teacher Restrictions');
    Add('TbTeacherRestriction=Teacher Restrictions');
    Add('TbSubjectRestriction=Subject Restrictions');
    Add('TbTimeTable=Timetables');
    Add('TbTimeTableDetail=Detail of Timetables');
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsourcebase.lrs}
{$ENDIF}
end.

