{ -*- mode: Delphi -*- }
unit dsourcebase;

(*
  05/02/2012 1:06

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
  dsourcebaseconsts,
  DBase, ZConnection, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    DbZConnection: TZConnection;
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
    TbTimetable: TZTable;
    DSTimetable: TDataSource;
    TbTimetableDetail: TZTable;
    DSTimetableDetail: TDataSource;

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
  Tables[16] := TbTimetable;
  TbTimetable.BeforePost := DataSetBeforePost;
  TbTimetable.BeforeDelete := DataSetBeforeDelete;
  Tables[17] := TbTimetableDetail;
  TbTimetableDetail.BeforePost := DataSetBeforePost;
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
    DetailDataSet := TbTimetableDetail;
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
    DetailDataSet := TbTimetableDetail;
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
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTimeTable';
    DetailFields := 'IdTimetable';
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
    MasterDataSet := TbTimetable;
    MasterFields := 'IdTimetable';
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
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
  end;
  with FieldCaptionList do
  begin
    Add('TbLevel.IdLevel=' + SFlLevel_IdLevel);
    Add('TbLevel.NaLevel=' + SFlLevel_NaLevel);
    Add('TbLevel.AbLevel=' + SFlLevel_AbLevel);
    Add('TbGroupId.IdGroupId=' + SFlGroupId_IdGroupId);
    Add('TbGroupId.NaGroupId=' + SFlGroupId_NaGroupId);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbSpecialization.IdSpecialization=' + SFlSpecialization_IdSpecialization);
    Add('TbSpecialization.NaSpecialization=' + SFlSpecialization_NaSpecialization);
    Add('TbSpecialization.AbSpecialization=' + SFlSpecialization_AbSpecialization);
    Add('TbCourse.IdLevel=' + SFlCourse_IdLevel);
    Add('TbCourse.IdSpecialization=' + SFlCourse_IdSpecialization);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbRoomType.IdRoomType=' + SFlRoomType_IdRoomType);
    Add('TbRoomType.NaRoomType=' + SFlRoomType_NaRoomType);
    Add('TbRoomType.AbRoomType=' + SFlRoomType_AbRoomType);
    Add('TbRoomType.Number=' + SFlRoomType_Number);
    Add('TbClass.IdLevel=' + SFlClass_IdLevel);
    Add('TbClass.IdSpecialization=' + SFlClass_IdSpecialization);
    Add('TbClass.IdGroupId=' + SFlClass_IdGroupId);
    Add('TbSubject.IdSubject=' + SFlSubject_IdSubject);
    Add('TbSubject.NaSubject=' + SFlSubject_NaSubject);
    Add('TbTeacher.IdTeacher=' + SFlTeacher_IdTeacher);
    Add('TbTeacher.TeacherNationalId=' + SFlTeacher_TeacherNationalId);
    Add('TbTeacher.LnTeacher=' + SFlTeacher_LnTeacher);
    Add('TbTeacher.NaTeacher=' + SFlTeacher_NaTeacher);
    Add('TbSubjectRestrictionType.IdSubjectRestrictionType=' + SFlSubjectRestrictionType_IdSubjectRestrictionType);
    Add('TbSubjectRestrictionType.NaSubjectRestrictionType=' + SFlSubjectRestrictionType_NaSubjectRestrictionType);
    Add('TbSubjectRestrictionType.ColSubjectRestrictionType=' + SFlSubjectRestrictionType_ColSubjectRestrictionType);
    Add('TbSubjectRestrictionType.ValSubjectRestrictionType=' + SFlSubjectRestrictionType_ValSubjectRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbDistribution.IdSubject=' + SFlDistribution_IdSubject);
    Add('TbDistribution.IdLevel=' + SFlDistribution_IdLevel);
    Add('TbDistribution.IdSpecialization=' + SFlDistribution_IdSpecialization);
    Add('TbDistribution.IdGroupId=' + SFlDistribution_IdGroupId);
    Add('TbDistribution.IdTeacher=' + SFlDistribution_IdTeacher);
    Add('TbDistribution.IdRoomType=' + SFlDistribution_IdRoomType);
    Add('TbDistribution.Composition=' + SFlDistribution_Composition);
    Add('TbTeacherRestrictionType.IdTeacherRestrictionType=' + SFlTeacherRestrictionType_IdTeacherRestrictionType);
    Add('TbTeacherRestrictionType.NaTeacherRestrictionType=' + SFlTeacherRestrictionType_NaTeacherRestrictionType);
    Add('TbTeacherRestrictionType.ColTeacherRestrictionType=' + SFlTeacherRestrictionType_ColTeacherRestrictionType);
    Add('TbTeacherRestrictionType.ValTeacherRestrictionType=' + SFlTeacherRestrictionType_ValTeacherRestrictionType);
    Add('TbTeacherRestriction.IdTeacher=' + SFlTeacherRestriction_IdTeacher);
    Add('TbTeacherRestriction.IdDay=' + SFlTeacherRestriction_IdDay);
    Add('TbTeacherRestriction.IdHour=' + SFlTeacherRestriction_IdHour);
    Add('TbTeacherRestriction.IdTeacherRestrictionType=' + SFlTeacherRestriction_IdTeacherRestrictionType);
    Add('TbSubjectRestriction.IdSubject=' + SFlSubjectRestriction_IdSubject);
    Add('TbSubjectRestriction.IdDay=' + SFlSubjectRestriction_IdDay);
    Add('TbSubjectRestriction.IdHour=' + SFlSubjectRestriction_IdHour);
    Add('TbSubjectRestriction.IdSubjectRestrictionType=' + SFlSubjectRestriction_IdSubjectRestrictionType);
    Add('TbTimetable.IdTimetable=' + SFlTimetable_IdTimetable);
    Add('TbTimetable.TimeIni=' + SFlTimetable_TimeIni);
    Add('TbTimetable.TimeEnd=' + SFlTimetable_TimeEnd);
    Add('TbTimetable.Summary=' + SFlTimetable_Summary);
    Add('TbTimetableDetail.IdTimeTable=' + SFlTimetableDetail_IdTimeTable);
    Add('TbTimetableDetail.IdSubject=' + SFlTimetableDetail_IdSubject);
    Add('TbTimetableDetail.IdLevel=' + SFlTimetableDetail_IdLevel);
    Add('TbTimetableDetail.IdSpecialization=' + SFlTimetableDetail_IdSpecialization);
    Add('TbTimetableDetail.IdGroupId=' + SFlTimetableDetail_IdGroupId);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
  end;
  with DataSetDescList do
  begin
    Add('TbLevel=' + STbLevel);
    Add('TbGroupId=' + STbGroupId);
    Add('TbDay=' + STbDay);
    Add('TbSpecialization=' + STbSpecialization);
    Add('TbCourse=' + STbCourse);
    Add('TbHour=' + STbHour);
    Add('TbRoomType=' + STbRoomType);
    Add('TbClass=' + STbClass);
    Add('TbSubject=' + STbSubject);
    Add('TbTeacher=' + STbTeacher);
    Add('TbSubjectRestrictionType=' + STbSubjectRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbDistribution=' + STbDistribution);
    Add('TbTeacherRestrictionType=' + STbTeacherRestrictionType);
    Add('TbTeacherRestriction=' + STbTeacherRestriction);
    Add('TbSubjectRestriction=' + STbSubjectRestriction);
    Add('TbTimetable=' + STbTimetable);
    Add('TbTimetableDetail=' + STbTimetableDetail);
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsourcebase.lrs}
{$ENDIF}
end.

