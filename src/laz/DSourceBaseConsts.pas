{ -*- mode: Delphi -*- }
unit DSourceBaseConsts;

(*
  08/03/2012 17:19

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
  STbResourceType = 'Resource types';
  STbDay = 'Working Days';
  STbHour = 'Academic Hours';
  STbResource = 'Resources';
  STbPeriod = 'Periods';
  STbActivity = 'Activities';
  STbAvailability = 'Availability of Resources to Cover Requirements in the Theme';
  STbResourceTypeLimit = 'Limits for usage of Resource Types in Themes';
  STbRestrictionType = 'Types of Restrictions';
  STbRestriction = 'Restrictions';
  STbParticipant = 'Participants';
  STbTimetable = 'Timetables';
  STbTimetableDetail = 'Detail of Timetables';
  STbTimetableResource = 'Resources of Timetables';

  SFlTheme_IdTheme = 'Id';
  SFlTheme_NaTheme = 'Name';
  SFlTheme_Composition = 'Composition';
  SFlResourceType_IdResourceType = 'IdResourceType';
  SFlResourceType_NaResourceType = 'Name';
  SFlResourceType_NumResourceLimit = 'Resource Limit';
  SFlResourceType_ValResourceType = 'Value';
  SFlResourceType_MaxWorkLoad = 'MaxWorkLoad';
  SFlDay_IdDay = 'Id';
  SFlDay_NaDay = 'Name';
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
  SFlActivity_NaActivity = 'Name';
  SFlAvailability_IdTheme = 'Theme';
  SFlAvailability_IdResource = 'Resource';
  SFlAvailability_NumResource = 'Number';
  SFlResourceTypeLimit_IdTheme = 'Theme';
  SFlResourceTypeLimit_IdResourceType = 'Resource Type';
  SFlResourceTypeLimit_NumResourceLimit = 'Limit';
  SFlRestrictionType_IdRestrictionType = 'Id';
  SFlRestrictionType_NaRestrictionType = 'Name';
  SFlRestrictionType_ColRestrictionType = 'Color';
  SFlRestrictionType_ValRestrictionType = 'Value';
  SFlRestriction_IdResource = 'Resource';
  SFlRestriction_IdDay = 'Day';
  SFlRestriction_IdHour = 'Hour';
  SFlRestriction_IdRestrictionType = 'Restriction Type';
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

