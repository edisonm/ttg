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
  SGenerateTimeTables = 'Generar Horarios';
  STimeTableCodesToGenerate = 'Codigos de los Horarios a generar';
  SInvalidData = 'El dato ingresado no es valido';
  STheNextTimeTablesAlreadyExists = 'Los siguientes horarios ya existian: %s';
  SNoErrorReadyForCheckSummary =
    'No se encontraron errores, esta listo para generar horario.'#13#10
    + 'Desea mostrar el resumen del chequeo del horario?';
  SPendingChangesWillBeLostYouReallyWantToQuit =
    'Los cambios realizados hasta el momento se perderan.'#13#10 +
    'Esta seguro que desea cerrar el programa?';
  SReady = 'Listo';
  SSaveDialogFilter =  'TimeTable para colegio (*.ttd)|*.ttd';
  SChangesWillBeLostWarning = 'Los cambios realizados se perderan, Esta seguro?';
  SRelColsRows =  '%s|Columnas: %s - Filas: %s ';
  SIsEmpty = '%s esta vacio';
  SSaveChanges = 'Desea guardar los cambios efectuados?';
  SCopyright = '1999-2012 by Edison Mera';
  SDownHillAlgorithm = 'Algoritmo de Descenso';
  SEvolutiveElitistAlgorithm = 'Algoritmo Evolutivo Elitista';
  SRandSeed = 'Semilla Numeros aleatorios';
  SPopulationSize = 'Numero de individuos';
  SMaxIteration = 'Maximo de generaciones';
  SCrossProb = 'Probabilidad de cruce';
  SMutationProb = 'Probabilidad de Mutacion';
  SRepairProb = 'Probabilidad de Reparacion';
  SPollinationProb = 'Probabilidad de polinizacion';
  SWorkInProgress = 'Elaboracion en progreso [%d]';
  SImprovingTimeTable = 'Mejorando TimeTable [%d]';
  SApplyDownHill = 'Aplicar Descenso: %23s';
  SImprovingTimeTableIn =  'Mejorando TimeTable [%d] en [%d]';
  SBaseTimeTable = 'TimeTable base: %d';
  SSearchBy = 'Buscar por %s';
  SClassTimeSlotToSessionOverflow = 'Se desbordo Molde de ClassTimeSlotToSession: ' +
    'Class %d-%d Duracion %d';
  SWeights = 'Pesos';
  SClashTeacher = 'Cruce de profesores';
  SClashSubject = 'Cruce de materias';
  SClashRoomType = 'Cruce de aulas';
  SBrokenTeacher = 'Fracc. h. profesores';
  SOutOfPositionEmptyHour = 'Horas Huecas desubicadas:';
  SBrokenSession = 'Materias cortadas';
  SNonScatteredSubject = 'Materias juntas';
implementation

end.

