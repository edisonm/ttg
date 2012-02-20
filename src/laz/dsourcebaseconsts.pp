{ -*- mode: Delphi -*- }
unit dsourcebaseconsts;

(*
  20/02/2012 16:11

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

  STbCategory = 'Categories';
  STbParallel = 'Parallels';
  STbCluster = 'Clusters';
  STbDay = 'Working Days';
  STbHour = 'Academic Hours';
  STbTheme = 'Themes';
  STbActivity = 'Activities';
  STbPeriod = 'Periods';
  STbResourceType = 'Resource types';
  STbResource = 'Resources';
  STbResourceRestrictionType = 'Types of Resource Restrictions';
  STbResourceRestriction = 'Resource Restrictions';
  STbRequirement = 'Requirements';
  STbJoinedCluster = 'Joined Clusters';
  STbThemeRestrictionType = 'Types of Theme Restrictions';
  STbThemeRestriction = 'Theme Restrictions';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';
  STbTimetableResource = 'Resources of Timetables';

  SFlCategory_IdCategory = 'Id';
  SFlCategory_NaCategory = 'Name';
  SFlCategory_AbCategory = 'Abbreviation';
  SFlParallel_IdParallel = 'Id';
  SFlParallel_NaParallel = 'Name';
  SFlCluster_IdCategory = 'Category';
  SFlCluster_IdParallel = 'Parallel';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlActivity_IdTheme = 'Theme';
  SFlActivity_IdCategory = 'Category';
  SFlActivity_IdParallel = 'Parallel';
  SFlActivity_Composition = 'Composition';
  SFlPeriod_IdDay = 'Day';
  SFlPeriod_IdHour = 'Hour';
  SFlResourceType_IdResourceType = 'IdResourceType';
  SFlResourceType_NaResourceType = 'Name';
  SFlResourceType_DefaultLimit = 'Default Limit';
  SFlResourceType_ValResourceType = 'Value';
  SFlResource_IdResource = 'Id';
  SFlResource_IdResourceType = 'Type';
  SFlResource_NaResource = 'Name';
  SFlResource_AbResource = 'Abbreviation';
  SFlResource_NumResource = 'Number';
  SFlResourceRestrictionType_IdResourceRestrictionType = 'Id';
  SFlResourceRestrictionType_NaResourceRestrictionType = 'Name';
  SFlResourceRestrictionType_ColResourceRestrictionType = 'Color';
  SFlResourceRestrictionType_ValResourceRestrictionType = 'Value';
  SFlResourceRestriction_IdResource = 'Resource';
  SFlResourceRestriction_IdDay = 'Day';
  SFlResourceRestriction_IdHour = 'Hour';
  SFlResourceRestriction_IdResourceRestrictionType = 'Restriction Type';
  SFlRequirement_IdTheme = 'Theme';
  SFlRequirement_IdCategory = 'Category';
  SFlRequirement_IdParallel = 'Parallel';
  SFlRequirement_IdResource = 'Resource';
  SFlRequirement_NumRequirement = 'Number';
  SFlJoinedCluster_IdTheme = 'Theme';
  SFlJoinedCluster_IdCategory = 'Category';
  SFlJoinedCluster_IdParallel = 'Parallel';
  SFlJoinedCluster_IdCategory1 = 'Joined Category';
  SFlJoinedCluster_IdParallel1 = 'Joined Parallel';
  SFlThemeRestrictionType_IdThemeRestrictionType = 'Id';
  SFlThemeRestrictionType_NaThemeRestrictionType = 'Name';
  SFlThemeRestrictionType_ColThemeRestrictionType = 'Color';
  SFlThemeRestrictionType_ValThemeRestrictionType = 'Value';
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
  SFlTimetableResource_IdTimetable = 'Timetable';
  SFlTimetableResource_IdTheme = 'Theme';
  SFlTimetableResource_IdCategory = 'Category';
  SFlTimetableResource_IdParallel = 'Parallel';
  SFlTimetableResource_IdResource = 'Resource';

implementation

end.

