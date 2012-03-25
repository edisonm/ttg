{ -*- mode: Delphi -*- }
unit UTTGConsts;

{$I ttg.inc}

interface

uses
  Classes, SysUtils;

resourcestring
  SActivityWithoutResources = 'Activity %s does not have assigned resources';
  SApplyDownhill = 'Applying Downhill';
  SAttendant = 'Attendant';
  SAssign = 'Assign';
  SBaseTimetable = 'Base Timetable: %d';
  SBreakTimetableResource = 'Break TT. Resources';
  SBrokenSession = 'Broken Sessions';
  SChangesWillBeLostWarning = 'Changes will be lost, are you sure?';
  SClashActivity = 'Clash of Activities';
  SClashResource = 'Clash of Resources';
  SClashes = 'Clashes';
  SResourceOverflow = 'For [%s], the number of activities %d exceeds its capacity %d';
  SThemeOverflow = 'For [%s] and the Resources [%s], the limit %d has been exceeded in %d';
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
  SDeleteCell = 'Press <Del> to clean the cell';
  SDetail = 'Detail';
  SDoNotHaveResource = 'do not have teacher';
  SDoNotAppearsIn = 'do not appears in';
  SDownHillAlgorithm = 'Downhill Algorithm';
  SEditing = 'Editing';
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
  SInvalidComposition = 'Invalid Composition: [%s]';
  SInvalidData = 'Invalid input data';
  SIsEmpty = '%s is empty';
  SLoad = 'Load';
  SIterations = 'Number of iterations';
  SMutationProbability = 'Mutation Probability';
  SName = 'Name';
  SNo = 'No';
  SNoErrorReadyForCheckSummary = 'Ready to generate timetable. Show timetable check Summary?';
  SNonScatteredActivity = 'Non Scattered Activities';
  SNumHardRestrictions = 'Number of hard teacher restrictions...';
  SNumSoftRestrictions = 'Number of soft teacher restrictions...';
  SPendingChangesWillBeLostYouReallyWantToQuit = 'Pending changes will be lost. Do you really want to quit?';
  SPollinationProbability = 'Pollination Probability';
  SPopulationSize = 'Population size';
  SPressDelToClearCell = 'Press <Del> to clear cell';
  SProblems = 'Problems';
  SRandSeed = 'Random Generator Seed';
  SReady = 'Ready';
  SRelColsRows =  '%s|Columns: %s - Rows: %s ';
  SRelease = 'Release';
  SReparationProbability = 'Repair Probability';
  SSaveChanges = 'Do you want to save the changes?';
  SSaveDialogCSVFilter = 'Comma delimited CSV (*.csv)|*.csv';
  SSaveDialogFilter = 'Timetable (*.ttd)|*.ttd';
  SSearchBy = 'Search by %s';
  SSupervisor = 'Supervisor';
  SRestrictionsHead = 'Resource; Restrictions';
  SResourceWorkLoadHead = 'Resource; Work Load';
  SResourcesWorkLoadWithProblems = 'Resources'' work load with problems...';
  SResourcesWorkLoadWithoutProblems = 'Resources'' Work load without problems...';
  SRoom = 'Room';
  STheNextTimetablesAlreadyExists = 'The next Timetables already exists: %s';
  STimetableCodesToGenerate = 'Codes of Timetables to generate';
  SElapsedTime = 'Elapsed Time';
  STotalValue = 'Total Value';
  SValue = 'Value';
  SWeight = 'Weight';
  SWeights = 'Weights';
  SWorkInProgress = 'Work in progress [%d]';
  SWrongComposition = 'Wrong Composition';
  SYes = 'Yes';

implementation

end.
