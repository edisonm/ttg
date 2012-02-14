{ -*- mode: Delphi -*- }
unit dsourcebaseconsts;

(*
  14/02/2012 1:23

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
  STbParallel = 'Parallel Identifiers';
  STbSpecialization = 'Specializations';
  STbDay = 'Working Days';
  STbCourse = 'Courses';
  STbRoomType = 'Types of Room';
  STbHour = 'Academic Hours';
  STbClass = 'Parallels';
  STbSubject = 'Subjects';
  STbTeacher = 'Teachers';
  STbDistribution = 'Distribution of Workload';
  STbJoinedClass = 'Joined Classes';
  STbSubjectRestrictionType = 'Types of Subject Restrictions';
  STbTimeSlot = 'Time Slots';
  STbAssistance = 'Assistances';
  STbTeacherRestrictionType = 'Types of Teacher Restrictions';
  STbTeacherRestriction = 'Teacher Restrictions';
  STbSubjectRestriction = 'Subject Restrictions';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';

  SFlLevel_IdLevel = 'Id';
  SFlLevel_NaLevel = 'Name';
  SFlLevel_AbLevel = 'Abbreviation';
  SFlParallel_IdParallel = 'Id';
  SFlParallel_NaParallel = 'Name';
  SFlSpecialization_IdSpecialization = 'Id';
  SFlSpecialization_NaSpecialization = 'Name';
  SFlSpecialization_AbSpecialization = 'Abbreviation';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlCourse_IdLevel = 'Level';
  SFlCourse_IdSpecialization = 'Specialization';
  SFlRoomType_IdRoomType = 'Id';
  SFlRoomType_NaRoomType = 'Name';
  SFlRoomType_AbRoomType = 'Abbreviation';
  SFlRoomType_Number = 'Number';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlClass_IdLevel = 'Level';
  SFlClass_IdSpecialization = 'Specialization';
  SFlClass_IdParallel = 'Parallel';
  SFlSubject_IdSubject = 'Id';
  SFlSubject_NaSubject = 'Name';
  SFlTeacher_IdTeacher = 'Id';
  SFlTeacher_TeacherNationalId = 'National ID';
  SFlTeacher_LnTeacher = 'Last Name';
  SFlTeacher_NaTeacher = 'Name';
  SFlDistribution_IdSubject = 'Subject';
  SFlDistribution_IdLevel = 'Level';
  SFlDistribution_IdSpecialization = 'Specialization';
  SFlDistribution_IdParallel = 'Parallel';
  SFlDistribution_IdTeacher = 'Teacher';
  SFlDistribution_IdRoomType = 'Room Type';
  SFlDistribution_RoomCount = 'Room Count';
  SFlDistribution_Composition = 'Composition';
  SFlJoinedClass_IdSubject = 'Subject';
  SFlJoinedClass_IdLevel = 'Level';
  SFlJoinedClass_IdSpecialization = 'Specialization';
  SFlJoinedClass_IdParallel = 'Parallel';
  SFlJoinedClass_IdLevel1 = 'Level';
  SFlJoinedClass_IdSpecialization1 = 'Specialization';
  SFlJoinedClass_IdParallel1 = 'Parallel';
  SFlSubjectRestrictionType_IdSubjectRestrictionType = 'Id';
  SFlSubjectRestrictionType_NaSubjectRestrictionType = 'Name';
  SFlSubjectRestrictionType_ColSubjectRestrictionType = 'Color';
  SFlSubjectRestrictionType_ValSubjectRestrictionType = 'Value';
  SFlTimeSlot_IdDay = 'Day';
  SFlTimeSlot_IdHour = 'Hour';
  SFlAssistance_IdSubject = 'Subject';
  SFlAssistance_IdLevel = 'Level';
  SFlAssistance_IdSpecialization = 'Specialization';
  SFlAssistance_IdParallel = 'Parallel';
  SFlAssistance_IdTeacher = 'Assistant';
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
  SFlTimetableDetail_IdTimetable = 'Timetable';
  SFlTimetableDetail_IdSubject = 'Subject';
  SFlTimetableDetail_IdLevel = 'Level';
  SFlTimetableDetail_IdSpecialization = 'Specialization';
  SFlTimetableDetail_IdParallel = 'Parallel';
  SFlTimetableDetail_IdDay = 'Day';
  SFlTimetableDetail_IdHour = 'Hour';
  SFlTimetableDetail_Session = 'Session';

implementation

end.

