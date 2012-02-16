{ -*- mode: Delphi -*- }
unit dsourcebaseconsts;

(*
  14/02/2012 2:13

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
  STbSpecialization = 'Specializations';
  STbParallel = 'Parallels';
  STbDay = 'Working Days';
  STbCategory = 'Categories';
  STbHour = 'Academic Hours';
  STbRoomType = 'Types of Room';
  STbCluster = 'Clusters';
  STbTheme = 'Themes';
  STbTeacher = 'Teachers';
  STbDistribution = 'Distribution of Workload';
  STbJoinedCluster = 'Joined Clusters';
  STbThemeRestrictionType = 'Types of Theme Restrictions';
  STbTimeSlot = 'Time Slots';
  STbAssistance = 'Assistances';
  STbTeacherRestrictionType = 'Types of Teacher Restrictions';
  STbTeacherRestriction = 'Teacher Restrictions';
  STbThemeRestriction = 'Theme Restrictions';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';

  SFlLevel_IdLevel = 'Id';
  SFlLevel_NaLevel = 'Name';
  SFlLevel_AbLevel = 'Abbreviation';
  SFlSpecialization_IdSpecialization = 'Id';
  SFlSpecialization_NaSpecialization = 'Name';
  SFlSpecialization_AbSpecialization = 'Abbreviation';
  SFlParallel_IdParallel = 'Id';
  SFlParallel_NaParallel = 'Name';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlCategory_IdCategory = 'Category';
  SFlCategory_NaCategory = 'Name';
  SFlCategory_AbCategory = 'Abbreviation';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlRoomType_IdRoomType = 'Id';
  SFlRoomType_NaRoomType = 'Name';
  SFlRoomType_AbRoomType = 'Abbreviation';
  SFlRoomType_Number = 'Number';
  SFlCluster_IdCategory = 'Category';
  SFlCluster_IdParallel = 'Parallel';
  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlTeacher_IdTeacher = 'Id';
  SFlTeacher_TeacherNationalId = 'National ID';
  SFlTeacher_LnTeacher = 'Last Name';
  SFlTeacher_NaTeacher = 'Name';
  SFlDistribution_IdTheme = 'Theme';
  SFlDistribution_IdCategory = 'Category';
  SFlDistribution_IdParallel = 'Parallel';
  SFlDistribution_IdTeacher = 'Teacher';
  SFlDistribution_IdRoomType = 'Room Type';
  SFlDistribution_RoomCount = 'Room Count';
  SFlDistribution_Composition = 'Composition';
  SFlJoinedCluster_IdTheme = 'Theme';
  SFlJoinedCluster_IdCategory = 'Category';
  SFlJoinedCluster_IdParallel = 'Parallel';
  SFlJoinedCluster_IdCategory1 = 'Joined Category';
  SFlJoinedCluster_IdParallel1 = 'Joined Parallel';
  SFlThemeRestrictionType_IdThemeRestrictionType = 'Id';
  SFlThemeRestrictionType_NaThemeRestrictionType = 'Name';
  SFlThemeRestrictionType_ColThemeRestrictionType = 'Color';
  SFlThemeRestrictionType_ValThemeRestrictionType = 'Value';
  SFlTimeSlot_IdDay = 'Day';
  SFlTimeSlot_IdHour = 'Hour';
  SFlAssistance_IdTheme = 'Theme';
  SFlAssistance_IdCategory = 'Category';
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
  SFlThemeRestriction_IdTheme = 'Theme';
  SFlThemeRestriction_IdDay = 'Day';
  SFlThemeRestriction_IdHour = 'Hour';
  SFlThemeRestriction_IdThemeRestrictionType = 'Restriction Type';
  SFlTimetable_IdTimetable = 'Id';
  SFlTimetable_TimeIni = 'Initial Time';
  SFlTimetable_TimeEnd = 'End Time';
  SFlTimetable_Summary = 'Summary';
  SFlTimetableDetail_IdTimetable = 'Timetable';
  SFlTimetableDetail_IdTheme = 'Theme';
  SFlTimetableDetail_IdCategory = 'Category';
  SFlTimetableDetail_IdParallel = 'Parallel';
  SFlTimetableDetail_IdDay = 'Day';
  SFlTimetableDetail_IdHour = 'Hour';
  SFlTimetableDetail_Session = 'Session';

implementation

end.

