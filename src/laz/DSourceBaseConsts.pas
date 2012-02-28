{ -*- mode: Delphi -*- }
unit DSourceBaseConsts;

(*
  28/02/2012 22:21

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
  STbResourceType = 'Resource types';
  STbHour = 'Academic Hours';
  STbResource = 'Resources';
  STbPeriod = 'Periods';
  STbActivity = 'Activities';
  STbRequirement = 'Participants';
  STbResourceRestrictionType = 'Types of Resource Restrictions';
  STbResourceRestriction = 'Resource Restrictions';
  STbFillRequirement = 'Participants';
  STbParticipant = 'Participants';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';
  STbTimetableResource = 'Resources of Timetables';

  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlTheme_Composition = 'Composition';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
  SFlResourceType_IdResourceType = 'IdResourceType';
  SFlResourceType_NaResourceType = 'Name';
  SFlResourceType_DefaultLimit = 'Default Limit';
  SFlResourceType_ValResourceType = 'Value';
  SFlHour_IdHour = 'Id';
  SFlHour_NaHour = 'Name';
  SFlHour_Interval = 'Interval';
  SFlResource_IdResourceType = 'Type';
  SFlResource_IdResource = 'Id';
  SFlResource_NaResource = 'Name';
  SFlResource_AbResource = 'Abbreviation';
  SFlResource_NumResource = 'Number';
  SFlPeriod_IdDay = 'Day';
  SFlPeriod_IdHour = 'Hour';
  SFlActivity_IdActivity = 'Id';
  SFlActivity_IdTheme = 'Theme';
  SFlActivity_NaActivity = 'Category';
  SFlRequirement_IdTheme = 'Theme';
  SFlRequirement_IdResourceType = 'Resource Type';
  SFlRequirement_Limit = 'Limit';
  SFlResourceRestrictionType_IdResourceRestrictionType = 'Id';
  SFlResourceRestrictionType_NaResourceRestrictionType = 'Name';
  SFlResourceRestrictionType_ColResourceRestrictionType = 'Color';
  SFlResourceRestrictionType_ValResourceRestrictionType = 'Value';
  SFlResourceRestriction_IdResource = 'Resource';
  SFlResourceRestriction_IdDay = 'Day';
  SFlResourceRestriction_IdHour = 'Hour';
  SFlResourceRestriction_IdResourceRestrictionType = 'Restriction Type';
  SFlFillRequirement_IdTheme = 'Theme';
  SFlFillRequirement_IdResourceType = 'Resource Type';
  SFlFillRequirement_IdResource = 'Resource';
  SFlFillRequirement_NumResource = 'Number';
  SFlParticipant_IdActivity = 'Category';
  SFlParticipant_IdResource = 'Resource';
  SFlParticipant_NumResource = 'Number';
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
  SFlTimetableResource_NumResource = 'Number';

implementation

end.

