{ -*- mode: Delphi -*- }
unit dsourcebase;

(*
  14/02/2012 0:37

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
    TbGroup: TZTable;
    DSGroup: TDataSource;
    TbSpecialization: TZTable;
    DSSpecialization: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbCourse: TZTable;
    DSCourse: TDataSource;
    TbRoomType: TZTable;
    DSRoomType: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbClass: TZTable;
    DSClass: TDataSource;
    TbSubject: TZTable;
    DSSubject: TDataSource;
    TbTeacher: TZTable;
    DSTeacher: TDataSource;
    TbDistribution: TZTable;
    DSDistribution: TDataSource;
    TbJoinedClass: TZTable;
    DSJoinedClass: TDataSource;
    TbSubjectRestrictionType: TZTable;
    DSSubjectRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbAssistance: TZTable;
    DSAssistance: TDataSource;
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
  SetLength(FTables, 20);
  Tables[0] := TbLevel;
  Tables[1] := TbGroup;
  Tables[2] := TbSpecialization;
  Tables[3] := TbDay;
  Tables[4] := TbCourse;
  Tables[5] := TbRoomType;
  Tables[6] := TbHour;
  Tables[7] := TbClass;
  Tables[8] := TbSubject;
  Tables[9] := TbTeacher;
  Tables[10] := TbDistribution;
  Tables[11] := TbJoinedClass;
  Tables[12] := TbSubjectRestrictionType;
  Tables[13] := TbTimeSlot;
  Tables[14] := TbAssistance;
  Tables[15] := TbTeacherRestrictionType;
  Tables[16] := TbTeacherRestriction;
  Tables[17] := TbSubjectRestriction;
  Tables[18] := TbTimetable;
  Tables[19] := TbTimetableDetail;
  with DataSetNameList do
  begin
    Add('TbLevel=Level');
    Add('TbGroup=Group');
    Add('TbSpecialization=Specialization');
    Add('TbDay=Day');
    Add('TbCourse=Course');
    Add('TbRoomType=RoomType');
    Add('TbHour=Hour');
    Add('TbClass=Class');
    Add('TbSubject=Subject');
    Add('TbTeacher=Teacher');
    Add('TbDistribution=Distribution');
    Add('TbJoinedClass=JoinedClass');
    Add('TbSubjectRestrictionType=SubjectRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbAssistance=Assistance');
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
    Add('TbGroup.IdGroup=' + SFlGroup_IdGroup);
    Add('TbGroup.NaGroup=' + SFlGroup_NaGroup);
    Add('TbSpecialization.IdSpecialization=' + SFlSpecialization_IdSpecialization);
    Add('TbSpecialization.NaSpecialization=' + SFlSpecialization_NaSpecialization);
    Add('TbSpecialization.AbSpecialization=' + SFlSpecialization_AbSpecialization);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbCourse.IdLevel=' + SFlCourse_IdLevel);
    Add('TbCourse.IdSpecialization=' + SFlCourse_IdSpecialization);
    Add('TbRoomType.IdRoomType=' + SFlRoomType_IdRoomType);
    Add('TbRoomType.NaRoomType=' + SFlRoomType_NaRoomType);
    Add('TbRoomType.AbRoomType=' + SFlRoomType_AbRoomType);
    Add('TbRoomType.Number=' + SFlRoomType_Number);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbClass.IdLevel=' + SFlClass_IdLevel);
    Add('TbClass.IdSpecialization=' + SFlClass_IdSpecialization);
    Add('TbClass.IdGroup=' + SFlClass_IdGroup);
    Add('TbSubject.IdSubject=' + SFlSubject_IdSubject);
    Add('TbSubject.NaSubject=' + SFlSubject_NaSubject);
    Add('TbTeacher.IdTeacher=' + SFlTeacher_IdTeacher);
    Add('TbTeacher.TeacherNationalId=' + SFlTeacher_TeacherNationalId);
    Add('TbTeacher.LnTeacher=' + SFlTeacher_LnTeacher);
    Add('TbTeacher.NaTeacher=' + SFlTeacher_NaTeacher);
    Add('TbDistribution.IdSubject=' + SFlDistribution_IdSubject);
    Add('TbDistribution.IdLevel=' + SFlDistribution_IdLevel);
    Add('TbDistribution.IdSpecialization=' + SFlDistribution_IdSpecialization);
    Add('TbDistribution.IdGroup=' + SFlDistribution_IdGroup);
    Add('TbDistribution.IdTeacher=' + SFlDistribution_IdTeacher);
    Add('TbDistribution.IdRoomType=' + SFlDistribution_IdRoomType);
    Add('TbDistribution.RoomCount=' + SFlDistribution_RoomCount);
    Add('TbDistribution.Composition=' + SFlDistribution_Composition);
    Add('TbJoinedClass.IdSubject=' + SFlJoinedClass_IdSubject);
    Add('TbJoinedClass.IdLevel=' + SFlJoinedClass_IdLevel);
    Add('TbJoinedClass.IdSpecialization=' + SFlJoinedClass_IdSpecialization);
    Add('TbJoinedClass.IdGroup=' + SFlJoinedClass_IdGroup);
    Add('TbJoinedClass.IdLevel1=' + SFlJoinedClass_IdLevel1);
    Add('TbJoinedClass.IdSpecialization1=' + SFlJoinedClass_IdSpecialization1);
    Add('TbJoinedClass.IdGroup1=' + SFlJoinedClass_IdGroup1);
    Add('TbSubjectRestrictionType.IdSubjectRestrictionType=' + SFlSubjectRestrictionType_IdSubjectRestrictionType);
    Add('TbSubjectRestrictionType.NaSubjectRestrictionType=' + SFlSubjectRestrictionType_NaSubjectRestrictionType);
    Add('TbSubjectRestrictionType.ColSubjectRestrictionType=' + SFlSubjectRestrictionType_ColSubjectRestrictionType);
    Add('TbSubjectRestrictionType.ValSubjectRestrictionType=' + SFlSubjectRestrictionType_ValSubjectRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbAssistance.IdSubject=' + SFlAssistance_IdSubject);
    Add('TbAssistance.IdLevel=' + SFlAssistance_IdLevel);
    Add('TbAssistance.IdSpecialization=' + SFlAssistance_IdSpecialization);
    Add('TbAssistance.IdGroup=' + SFlAssistance_IdGroup);
    Add('TbAssistance.IdTeacher=' + SFlAssistance_IdTeacher);
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
    Add('TbTimetableDetail.IdTimetable=' + SFlTimetableDetail_IdTimetable);
    Add('TbTimetableDetail.IdSubject=' + SFlTimetableDetail_IdSubject);
    Add('TbTimetableDetail.IdLevel=' + SFlTimetableDetail_IdLevel);
    Add('TbTimetableDetail.IdSpecialization=' + SFlTimetableDetail_IdSpecialization);
    Add('TbTimetableDetail.IdGroup=' + SFlTimetableDetail_IdGroup);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
  end;
  with DataSetDescList do
  begin
    Add('TbLevel=' + STbLevel);
    Add('TbGroup=' + STbGroup);
    Add('TbSpecialization=' + STbSpecialization);
    Add('TbDay=' + STbDay);
    Add('TbCourse=' + STbCourse);
    Add('TbRoomType=' + STbRoomType);
    Add('TbHour=' + STbHour);
    Add('TbClass=' + STbClass);
    Add('TbSubject=' + STbSubject);
    Add('TbTeacher=' + STbTeacher);
    Add('TbDistribution=' + STbDistribution);
    Add('TbJoinedClass=' + STbJoinedClass);
    Add('TbSubjectRestrictionType=' + STbSubjectRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbAssistance=' + STbAssistance);
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

