/* -*- mode: SQL; -*-

  14/02/2012 2:13

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*/
CREATE TABLE IF NOT EXISTS `Level`(
    `IdLevel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Level Id */,
    `NaLevel` varchar(15) NOT NULL UNIQUE /* Level Name */,
    `AbLevel` varchar(5) UNIQUE /* Level Abbreviation */
); /* Levels */
CREATE TABLE IF NOT EXISTS `Specialization`(
    `IdSpecialization` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Specialization Id */,
    `NaSpecialization` varchar(20) NOT NULL UNIQUE /* Specialization Name */,
    `AbSpecialization` varchar(10) NOT NULL UNIQUE /* Specialization Abbreviation */
); /* Specializations */
CREATE TABLE IF NOT EXISTS `Parallel`(
    `IdParallel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Parallel Id */,
    `NaParallel` varchar(5) NOT NULL UNIQUE /* Parallel Name */
); /* Parallels */
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Day Id */,
    `NaDay` varchar(10) NOT NULL UNIQUE /* Name of Day */
); /* Working Days */
CREATE TABLE IF NOT EXISTS `Category`(
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdLevel`,`IdSpecialization`),
  CONSTRAINT `LevelCategory` FOREIGN KEY (`IdLevel`)
    REFERENCES `Level`(`IdLevel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `SpecializationCategory` FOREIGN KEY (`IdSpecialization`)
    REFERENCES `Specialization`(`IdSpecialization`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Categories */
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Hour Id */,
    `NaHour` varchar(10) NOT NULL UNIQUE /* Hour Name */,
    `Interval` varchar(21) NOT NULL UNIQUE /* Hour Interval */
); /* Academic Hours */
CREATE TABLE IF NOT EXISTS `RoomType`(
    `IdRoomType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Room Type Id */,
    `NaRoomType` varchar(25) NOT NULL UNIQUE /* Room Type Name */,
    `AbRoomType` varchar(10) NOT NULL UNIQUE /* Room Type Abbreviation */,
    `Number` integer NOT NULL /* Number of Rooms */
); /* Types of Room */
CREATE TABLE IF NOT EXISTS `Class`(
    `IdLevel` integer NOT NULL /* Level */,
    `IdSpecialization` integer NOT NULL /* Specialization */,
    `IdParallel` integer NOT NULL /* Parallel */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdLevel`,`IdSpecialization`,`IdParallel`),
  CONSTRAINT `CategoryClass` FOREIGN KEY (`IdLevel`,`IdSpecialization`)
    REFERENCES `Category`(`IdLevel`,`IdSpecialization`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ParallelClass` FOREIGN KEY (`IdParallel`)
    REFERENCES `Parallel`(`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Classes */
CREATE TABLE IF NOT EXISTS `Theme`(
    `IdTheme` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Theme Id */,
    `NaTheme` varchar(20) NOT NULL UNIQUE /* Theme Name */
); /* Themes */
CREATE TABLE IF NOT EXISTS `Teacher`(
    `IdTeacher` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Teacher Id */,
    `TeacherNationalId` varchar(11) NOT NULL /* Teacher National Id */,
    `LnTeacher` varchar(15) NOT NULL /* Teacher Last Name */,
    `NaTeacher` varchar(15) NOT NULL /* Teacher Name */,
  CONSTRAINT `ixLnNaTeacher` UNIQUE(`LnTeacher`,`NaTeacher`),
  CONSTRAINT `ixNaLnTeacher` UNIQUE(`NaTeacher`,`LnTeacher`)
); /* Teachers */
CREATE TABLE IF NOT EXISTS `Distribution`(
    `IdTheme` integer NOT NULL /* Theme Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdParallel` integer NOT NULL /* Parallel Id */,
    `IdTeacher` integer NOT NULL /* Teacher Id */,
    `IdRoomType` integer NOT NULL /* Room Type Id */,
    `RoomCount` integer /* Number of classrooms needed */,
    `Composition` varchar(40) NOT NULL /* Composition of the Slots for the Theme */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`),
  CONSTRAINT `ClassDistribution` FOREIGN KEY (`IdLevel`,`IdSpecialization`,`IdParallel`)
    REFERENCES `Class`(`IdLevel`,`IdSpecialization`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `RoomTypeDistribution` FOREIGN KEY (`IdRoomType`)
    REFERENCES `RoomType`(`IdRoomType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ThemeDistribution` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TeacherDistribution` FOREIGN KEY (`IdTeacher`)
    REFERENCES `Teacher`(`IdTeacher`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Distribution of Workload */
CREATE TABLE IF NOT EXISTS `JoinedClass`(
    `IdTheme` integer NOT NULL /* Theme Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdParallel` integer NOT NULL /* Parallel Id */,
    `IdLevel1` integer NOT NULL /* Level Id of Joined Class */,
    `IdSpecialization1` integer NOT NULL /* Specialization Id of Joined Class */,
    `IdParallel1` integer NOT NULL /* Parallel Id of Joined Class */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`,`IdLevel1`,`IdSpecialization1`,`IdParallel1`),
  CONSTRAINT `ClassJoinedClass` FOREIGN KEY (`IdLevel1`,`IdSpecialization1`,`IdParallel1`)
    REFERENCES `Class`(`IdLevel`,`IdSpecialization`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `DistributionJoinedClass` FOREIGN KEY (`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Joined Classes */
CREATE TABLE IF NOT EXISTS `ThemeRestrictionType`(
    `IdThemeRestrictionType` integer NOT NULL PRIMARY KEY /* Theme Restriction Type Id */,
    `NaThemeRestrictionType` varchar(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColThemeRestrictionType` integer NOT NULL /* Restriction Type Color */,
    `ValThemeRestrictionType` integer NOT NULL /* Restriction Type Value */
); /* Types of Theme Restrictions */
CREATE TABLE IF NOT EXISTS `TimeSlot`(
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdDay`,`IdHour`),
  CONSTRAINT `DayTimeSlot` FOREIGN KEY (`IdDay`)
    REFERENCES `Day`(`IdDay`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `HourTimeSlot` FOREIGN KEY (`IdHour`)
    REFERENCES `Hour`(`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Time Slots */
CREATE TABLE IF NOT EXISTS `Assistance`(
    `IdTheme` integer NOT NULL /* Theme Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdParallel` integer NOT NULL /* Parallel Id */,
    `IdTeacher` integer NOT NULL /* Teacher Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`,`IdTeacher`),
  CONSTRAINT `DistributionAssistance` FOREIGN KEY (`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `TeacherAssistance` FOREIGN KEY (`IdTeacher`)
    REFERENCES `Teacher`(`IdTeacher`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Assistances */
CREATE TABLE IF NOT EXISTS `TeacherRestrictionType`(
    `IdTeacherRestrictionType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Teacher Restriction Type Id */,
    `NaTeacherRestrictionType` varchar(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColTeacherRestrictionType` integer NOT NULL /* Restriction Type Color */,
    `ValTeacherRestrictionType` integer NOT NULL /* Restriction Type Value */
); /* Types of Teacher Restrictions */
CREATE TABLE IF NOT EXISTS `TeacherRestriction`(
    `IdTeacher` integer NOT NULL /* Teacher Id */,
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
    `IdTeacherRestrictionType` integer NOT NULL /* Teacher Restriction Type Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTeacher`,`IdDay`,`IdHour`),
  CONSTRAINT `TeacherRestrictionTypeTeacherRestriction` FOREIGN KEY (`IdTeacherRestrictionType`)
    REFERENCES `TeacherRestrictionType`(`IdTeacherRestrictionType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TeacherTeacherRestriction` FOREIGN KEY (`IdTeacher`)
    REFERENCES `Teacher`(`IdTeacher`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotTeacherRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Teacher Restrictions */
CREATE TABLE IF NOT EXISTS `ThemeRestriction`(
    `IdTheme` integer NOT NULL /* Theme Id */,
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
    `IdThemeRestrictionType` integer NOT NULL /* Theme Restriction Type Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdDay`,`IdHour`),
  CONSTRAINT `ThemeRestrictionTypeThemeRestriction` FOREIGN KEY (`IdThemeRestrictionType`)
    REFERENCES `ThemeRestrictionType`(`IdThemeRestrictionType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ThemeThemeRestriction` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotThemeRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Theme Restrictions */
CREATE TABLE IF NOT EXISTS `Timetable`(
    `IdTimetable` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Timetable Id */,
    `TimeIni` datetime NOT NULL /* Initial Time */,
    `TimeEnd` datetime NOT NULL /* End Time */,
    `Summary` text /* Summary of Timetable Generation */
); /* Timetables */
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` integer NOT NULL /* Timetable Id */,
    `IdTheme` integer NOT NULL /* Theme Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdParallel` integer NOT NULL /* Parallel Id */,
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
    `Session` integer NOT NULL /* Internal Number */,
  CONSTRAINT `ixRestrictionTheme` UNIQUE(`IdTimetable`,`IdLevel`,`IdSpecialization`,`IdParallel`,`IdDay`,`IdHour`),
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`,`IdDay`,`IdHour`),
  CONSTRAINT `DistributionTimetableDetail` FOREIGN KEY (`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdLevel`,`IdSpecialization`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotTimetableDetail` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableDetail` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Detail of Timetables */
