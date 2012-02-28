{ -*- mode: Delphi -*- }
unit DSourceBaseConsts;

(*
  28/02/2012 16:43

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
  STbDay = 'Working Days';
  STbHour = 'Academic Hours';
  STbPeriod = 'Periods';
  STbResourceType = 'Resource types';
  STbResource = 'Resources';
  STbResourceRestrictionType = 'Types of Resource Restrictions';
  STbResourceRestriction = 'Resource Restrictions';
  STbActivity = 'Activities';
  STbRequirement = 'Requirements';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';
  STbTimetableResource = 'Resources of Timetables';

  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlTheme_Composition = 'Composition';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
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
  SFlActivity_IdActivity = 'Id';
  SFlActivity_IdTheme = 'Theme';
  SFlActivity_NaActivity = 'Category';
  SFlActivity_Composition = 'Composition';
  SFlRequirement_IdActivity = 'Category';
  SFlRequirement_IdResource = 'Resource';
  SFlRequirement_NumRequirement = 'Number';
  SFlTimetable_IdTimetable = 'Id';
  SFlTimetable_TimeIni = 'Initial Time';
  SFlTimetable_TimeEnd = 'End Time';
  SFlTimetable_Summary = 'Summary';
  SFlTimetableDetail_IdTimetable = 'Timetable';
  SFlTimetableDetail_IdActivity = 'Activity';
  SFlTimetableDetail_IdDay = 'Day';
  SFlTimetableDetail_IdHour = 'Hour';
  SFlTimetableDetail_Session = 'Session';
  SFlTimetableResource_IdTimetable = 'Timetable';
  SFlTimetableResource_IdActivity = 'Activity';
  SFlTimetableResource_IdResource = 'Resource';

implementation

end.

