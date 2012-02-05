{ -*- mode: Delphi -*- }
unit dsourcebaseconsts;

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
  Classes, SysUtils;

resourcestring

  STbLevel = 'Levels';
  STbGroupId = 'Group Identifiers';
  STbDay = 'Working Days';
  STbSpecialization = 'Specializations';
  STbCourse = 'Courses';
  STbHour = 'Academic Hours';
  STbRoomType = 'Types of Room';
  STbClass = 'Groups';
  STbSubject = 'Subjects';
  STbTeacher = 'Teachers';
  STbSubjectRestrictionType = 'Types of Subject Restrictions';
  STbTimeSlot = 'Time Slots';
  STbDistribution = 'Distribution of Workload';
  STbTeacherRestrictionType = 'Types of Teacher Restrictions';
  STbTeacherRestriction = 'Teacher Restrictions';
  STbSubjectRestriction = 'Subject Restrictions';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';

  SFlLevel_IdLevel = 'Id';
  SFlLevel_NaLevel = 'Name';
  SFlLevel_AbLevel = 'Abbreviation';
  SFlGroupId_IdGroupId = 'Id';
  SFlGroupId_NaGroupId = 'Name';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlSpecialization_IdSpecialization = 'Id';
  SFlSpecialization_NaSpecialization = 'Name';
  SFlSpecialization_AbSpecialization = 'Abbreviation';
  SFlCourse_IdLevel = 'Level';
  SFlCourse_IdSpecialization = 'Specialization';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlRoomType_IdRoomType = 'Id';
  SFlRoomType_NaRoomType = 'Name';
  SFlRoomType_AbRoomType = 'Abbreviation';
  SFlRoomType_Number = 'Number';
  SFlClass_IdLevel = 'Level';
  SFlClass_IdSpecialization = 'Specialization';
  SFlClass_IdGroupId = 'Group Id';
  SFlSubject_IdSubject = 'Id';
  SFlSubject_NaSubject = 'Name';
  SFlTeacher_IdTeacher = 'Id';
  SFlTeacher_TeacherNationalId = 'National ID';
  SFlTeacher_LnTeacher = 'Last Name';
  SFlTeacher_NaTeacher = 'Name';
  SFlSubjectRestrictionType_IdSubjectRestrictionType = 'Id';
  SFlSubjectRestrictionType_NaSubjectRestrictionType = 'Name';
  SFlSubjectRestrictionType_ColSubjectRestrictionType = 'Color';
  SFlSubjectRestrictionType_ValSubjectRestrictionType = 'Value';
  SFlTimeSlot_IdDay = 'Day';
  SFlTimeSlot_IdHour = 'Hour';
  SFlDistribution_IdSubject = 'Subject';
  SFlDistribution_IdLevel = 'Level';
  SFlDistribution_IdSpecialization = 'Specialization';
  SFlDistribution_IdGroupId = 'Group Id';
  SFlDistribution_IdTeacher = 'Teacher';
  SFlDistribution_IdRoomType = 'Room Type';
  SFlDistribution_Composition = 'Composition';
  SFlTeacherRestrictionType_IdTeacherRestrictionType = 'Id';
  SFlTeacherRestrictionType_NaTeacherRestrictionType = 'Name';
  SFlTeacherRestrictionType_ColTeacherRestrictionType = 'Color';
  SFlTeacherRestrictionType_ValTeacherRestrictionType = 'Value';
  SFlTeacherRestriction_IdTeacher = 'Teacher';
  SFlTeacherRestriction_IdDay = 'Day';
  SFlTeacherRestriction_IdHour = 'Hour';
  SFlTeacherRestriction_IdTeacherRestrictionType = 'Restriction Type';
  SFlSubjectRestriction_IdSubject = 'Subject';
  SFlSubjectRestriction_IdDay = 'Day';
  SFlSubjectRestriction_IdHour = 'Hour';
  SFlSubjectRestriction_IdSubjectRestrictionType = 'Restriction Type';
  SFlTimetable_IdTimetable = 'Id';
  SFlTimetable_TimeIni = 'Initial Time';
  SFlTimetable_TimeEnd = 'End Time';
  SFlTimetable_Summary = 'Summary';
  SFlTimetableDetail_IdTimeTable = 'Timetable';
  SFlTimetableDetail_IdSubject = 'Subject';
  SFlTimetableDetail_IdLevel = 'Level';
  SFlTimetableDetail_IdSpecialization = 'Specialization';
  SFlTimetableDetail_IdGroupId = 'Group';
  SFlTimetableDetail_IdDay = 'Day';
  SFlTimetableDetail_IdHour = 'Hour';
  SFlTimetableDetail_Session = 'Session';

implementation

end.

