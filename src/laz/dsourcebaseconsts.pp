{ -*- mode: Delphi -*- }
unit dsourcebaseconsts;

(*
  19/02/2012 18:09

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

  STbTheme = 'Themes';
  STbCategory = 'Categories';
  STbParallel = 'Parallels';
  STbDay = 'Working Days';
  STbHour = 'Academic Hours';
  STbCluster = 'Clusters';
  STbJoinedCluster = 'Joined Clusters';
  STbResourceType = 'Resource types';
  STbResource = 'Resources';
  STbResourceRestrictionType = 'Types of Resource Restrictions';
  STbTimeSlot = 'Time Slots';
  STbActivity = 'Activities';
  STbRequirement = 'Requirements';
  STbThemeRestrictionType = 'Types of Theme Restrictions';
  STbThemeRestriction = 'Theme Restrictions';
  STbResourceRestriction = 'Resource Restrictions';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';
  STbTimetableResource = 'Resources of Timetables';

  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlCategory_IdCategory = 'Id';
  SFlCategory_NaCategory = 'Name';
  SFlCategory_AbCategory = 'Abbreviation';
  SFlParallel_IdParallel = 'Id';
  SFlParallel_NaParallel = 'Name';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlCluster_IdCategory = 'Category';
  SFlCluster_IdParallel = 'Parallel';
  SFlJoinedCluster_IdTheme = 'Theme';
  SFlJoinedCluster_IdCategory = 'Category';
  SFlJoinedCluster_IdParallel = 'Parallel';
  SFlJoinedCluster_IdCategory1 = 'Joined Category';
  SFlJoinedCluster_IdParallel1 = 'Joined Parallel';
  SFlResourceType_IdResourceType = 'IdResourceType';
  SFlResourceType_NaResourceType = 'Name';
  SFlResourceType_DefaultLimit = 'Default Limit';
  SFlResource_IdResource = 'Id';
  SFlResource_IdResourceType = 'Type';
  SFlResource_NaResource = 'Name';
  SFlResource_AbResource = 'Abbreviation';
  SFlResource_NumResource = 'Number';
  SFlResourceRestrictionType_IdResourceRestrictionType = 'Id';
  SFlResourceRestrictionType_IdResourceType = 'Resource Type';
  SFlResourceRestrictionType_NaResourceRestrictionType = 'Name';
  SFlResourceRestrictionType_ColResourceRestrictionType = 'Color';
  SFlResourceRestrictionType_ValResourceRestrictionType = 'Value';
  SFlTimeSlot_IdDay = 'Day';
  SFlTimeSlot_IdHour = 'Hour';
  SFlActivity_IdTheme = 'Theme';
  SFlActivity_IdCategory = 'Category';
  SFlActivity_IdParallel = 'Parallel';
  SFlActivity_Composition = 'Composition';
  SFlRequirement_IdTheme = 'Theme';
  SFlRequirement_IdCategory = 'Category';
  SFlRequirement_IdParallel = 'Parallel';
  SFlRequirement_IdResource = 'Resource';
  SFlRequirement_NumRequirement = 'Number';
  SFlThemeRestrictionType_IdThemeRestrictionType = 'Id';
  SFlThemeRestrictionType_NaThemeRestrictionType = 'Name';
  SFlThemeRestrictionType_ColThemeRestrictionType = 'Color';
  SFlThemeRestrictionType_ValThemeRestrictionType = 'Value';
  SFlThemeRestriction_IdTheme = 'Theme';
  SFlThemeRestriction_IdDay = 'Day';
  SFlThemeRestriction_IdHour = 'Hour';
  SFlThemeRestriction_IdThemeRestrictionType = 'Restriction Type';
  SFlResourceRestriction_IdResource = 'Resource';
  SFlResourceRestriction_IdDay = 'Day';
  SFlResourceRestriction_IdHour = 'Hour';
  SFlResourceRestriction_IdResourceRestrictionType = 'Restriction Type';
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
  SFlTimetableResource_IdTimetable = 'Timetable';
  SFlTimetableResource_IdTheme = 'Theme';
  SFlTimetableResource_IdCategory = 'Category';
  SFlTimetableResource_IdParallel = 'Parallel';
  SFlTimetableResource_IdResource = 'Resource';

implementation

end.

