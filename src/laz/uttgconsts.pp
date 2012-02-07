{ -*- mode: Delphi -*- }
unit UTTGConsts;

{$I ttg.inc}

interface

uses
  Classes, SysUtils;

resourcestring

  SApplyDownHill = 'Applying Downhill: %23s';
  SAssign = 'Assign';
  SBaseTimetable = 'Base Timetable: %d';
  SBreakTimetableTeacher = 'Broken TT. Teachers';
  SBrokenSession = 'Broken Subjects';
  SChangesWillBeLostWarning = 'Changes will be lost, are you sure?';
  SClashRoomType = 'Clash of Classrooms';
  SClashSubject = 'Clash of Subjects';
  SClashTeacher = 'Clash of Teachers';
  SClassTimeSlotToSessionOverflow = 'Overflow of pattern for ClassTimeSlotToSession: Class %d-%d Duration %d';
  SClassWorkLoadHead = 'Class; Work Load';
  SClassWorkLoadWithProblems = 'Class work load with problems...';
  SClassWorkLoadWithoutProblems = 'Class work load without problems...';
  SCopyright = '1999-2012 by Edison Mera';
  SCount = 'Count';
  SCrossProbability = 'Cross Probability';
  SDay0 = 'Sunday';
  SDay1 = 'Monday';
  SDay2 = 'Tuesday';
  SDay3 = 'Wednesday';
  SDay4 = 'Thursday';
  SDay5 = 'Friday';
  SDay6 = 'Saturday';
  SDetail = 'Detail';
  SDownHillAlgorithm = 'Downhill Algorithm';
  SEvolutiveElitistAlgorithm = 'Evolutive Elitist Algorithm';
  SGenerateTimetables = 'Generate Timetables';
  SHour1 = 'First';
  SHour2 = 'Second';
  SHour3 = 'Third';
  SHour4 = 'Fourth';
  SHour5 = 'Fifth';
  SHour6 = 'Sixth';
  SHour7 = 'Seventh';
  SHour8 = 'Eighth';
  SHourF = 'Free';
  SImpossible = 'Impossible';
  SImprovedTimetableId = 'Improved Timetable Id';
  SImprovingTimetable = 'Improving Timetable [%d]';
  SImprovingTimetableIn =  'Improving Timetable [%d] in [%d]';
  SInadequate = 'Inadequate';
  SInvalidComposition = 'Invalid Composition: "%s"';
  SInvalidData = 'Invalid input data';
  SIsEmpty = '%s is empty';
  SLoad = 'Load';
  SMaxIteration = 'Max number of iterations';
  SMutationProbability = 'Mutation Probability';
  SNoErrorReadyForCheckSummary = 'Ready to generate timetable. Show timetable check Summary?';
  SNonScatteredSubject = 'Non Scattered Subjects';
  SNumHardTeacherRestrictions = 'Number of hard teacher restrictions...';
  SNumSoftTeacherRestrictions = 'Number of soft teacher restrictions...';
  SOutOfPositionEmptyHour = 'Out of position empty hours';
  SPendingChangesWillBeLostYouReallyWantToQuit = 'Pending changes will be lost. You really want to quit?';
  SPollinationProbability = 'Pollination Probability';
  SPopulationSize = 'Population size';
  SProblems = 'Problems';
  SRandSeed = 'Random Generator Seed';
  SReady = 'Ready';
  SRelColsRows =  '%s|Columns: %s - Rows: %s ';
  SRelease = 'Release';
  SReparationProbability = 'Repair Probability';
  SRoomTypesLoadHead = 'RoomType; Available Hours; Load';
  SRoomTypesWithProblems = 'Room types with problems...';
  SRoomTypesWithoutProblems = 'Room types without poblems...';
  SSaveChanges = 'Do you want to save the changes?';
  SSaveDialogCSVFilter = 'Comma delimited CSV (*.csv)|*.csv';
  SSaveDialogFilter =  'High School Timetable (*.ttd)|*.ttd';
  SSearchBy = 'Search by %s';
  STeacherRestrictionsHead = 'Teacher; Restrictions';
  STeacherWorkLoadHead = 'Teacher; Work Load';
  STeachersWorkLoadWithProblems = 'Teachers'' work load with problems...';
  STeachersWorkLoadWithoutProblems = 'Teachers'' Work load without problems...';
  STheNextTimetablesAlreadyExists = 'The next Timetables already exists: %s';
  STimetableCodesToGenerate = 'Codes of Timetables to generate';
  STotalValue = 'Total Value';
  SValue = 'Value';
  SWeight = 'Weight';
  SWeights = 'Weights';
  SWorkInProgress = 'Work in progress [%d]';
  SWrongComposition = 'Wrong Composition';

implementation

end.
