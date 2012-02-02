{ -*- mode: Delphi -*- }
unit UTTGConsts;

{$I ttg.inc}

interface

uses
  Classes, SysUtils;

resourcestring

  SNumSoftTeacherRestrictions = 'Number of soft teacher restrictions...';
  SNumHardTeacherRestrictions = 'Number of hard teacher restrictions...';
  STeacherRestrictionsHead = 'Teacher; Restrictions';
  STeachersWorkLoadWithoutProblems = 'Teachers'' Work load without problems...';
  STeachersWorkLoadWithProblems = 'Teachers'' work load with problems...';
  STeacherWorkLoadHead = 'Teacher; Work Load';
  SRoomTypesWithoutProblems = 'Room types without poblems...';
  SRoomTypesWithProblems = 'Room types with problems...';
  SRoomTypesLoadHead = 'RoomType; Available Hours; Load';
  SClassWorkLoadWithoutProblems = 'Class work load without problems...';
  SClassWorkLoadWithProblems = 'Class work load with problems...';
  SClassWorkLoadHead = 'Class; Work Load';
  SProblems = 'Problems';
  SGenerateTimeTables = 'Generate Timetables';
  STimeTableCodesToGenerate = 'Codes of Timetables to generate';
  SInvalidData = 'Invalid input data';
  STheNextTimeTablesAlreadyExists = 'The next Timetables already exists: %s';
  SNoErrorReadyForCheckSummary =
    'Ready to generate timetable. Show timetable check Summary?';
  SPendingChangesWillBeLostYouReallyWantToQuit =
    'Pending changes will be lost. You really want to quit?';
  SReady = 'Ready';
  SSaveDialogFilter =  'High School Timetable (*.ttd)|*.ttd';
  SChangesWillBeLostWarning = 'Changes will be lost, are you sure?';
  SRelColsRows =  '%s|Columns: %s - Rows: %s ';
  SIsEmpty = '%s is empty';
  SSaveChanges = 'Do you want to save the changes?';
  SCopyright = '1999-2012 by Edison Mera';
  SDownHillAlgorithm = 'Downhill Algorithm';
  SEvolutiveElitistAlgorithm = 'Evolutive Elitist Algorithm';
  SRandSeed = 'Random Generator Seed';
  SPopulationSize = 'Population size';
  SMaxIteration = 'Max number of iterations';
  SCrossProb = 'Cross Probability';
  SMutationProb = 'Mutation Probability';
  SRepairProb = 'Repair Probability';
  SPollinationProb = 'Pollination Probability';
  SWorkInProgress = 'Work in progress [%d]';
  SImprovingTimeTable = 'Improving Timetable [%d]';
  SApplyDownHill = 'Applying Downhill: %23s';
  SImprovingTimeTableIn =  'Improving Timetable [%d] in [%d]';
  SBaseTimeTable = 'Base Timetable: %d';
  SSearchBy = 'Search by %s';
  SClassTimeSlotToSessionOverflow =
    'Overflow of pattern for ClassTimeSlotToSession: Class %d-%d Duration %d';
  SWeights = 'Weights';
  SClashTeacher = 'Clash of Teachers';
  SClashSubject = 'Clash of Subjects';
  SClashRoomType = 'Clash of Classrooms';
  SBreakTimeTableTeacher = 'Broken TT. Teachers';
  SOutOfPositionEmptyHour = 'Out of position empty hours';
  SBrokenSession = 'Broken Subjects';
  SNonScatteredSubject = 'Non Scattered Subjects';
  STotalValue = 'Total Value';
  SWrongComposition = 'Wrong Composition';
  SDetail = 'Detail';
  SCount = 'Count';
  SWeight = 'Weight';
  SValue = 'Value';

implementation

end.

