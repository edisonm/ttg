/* -*- mode: SQL; -*-

  14/02/2012 1:23

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*/
CREATE TABLE IF NOT EXISTS `Level`(
    `IdLevel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Level Id */,
    `NaLevel` varchar(15) NOT NULL UNIQUE /* Level Name */,
    `AbLevel` varchar(5) UNIQUE /* Level Abbreviation */
); /* Levels */
CREATE TABLE IF NOT EXISTS `Group`(
    `IdGroup` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Group Id */,
    `NaGroup` varchar(5) NOT NULL UNIQUE /* Name of Group */
); /* Group Identifiers */
CREATE TABLE IF NOT EXISTS `Specialization`(
    `IdSpecialization` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Specialization Id */,
    `NaSpecialization` varchar(20) NOT NULL UNIQUE /* Specialization Name */,
    `AbSpecialization` varchar(10) NOT NULL UNIQUE /* Specialization Abbreviation */
); /* Specializations */
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Day Id */,
    `NaDay` varchar(10) NOT NULL UNIQUE /* Name of Day */
); /* Working Days */
CREATE TABLE IF NOT EXISTS `Course`(
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdLevel`,`IdSpecialization`),
  CONSTRAINT `LevelCourse` FOREIGN KEY (`IdLevel`)
    REFERENCES `Level`(`IdLevel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `SpecializationCourse` FOREIGN KEY (`IdSpecialization`)
    REFERENCES `Specialization`(`IdSpecialization`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Courses */
CREATE TABLE IF NOT EXISTS `RoomType`(
    `IdRoomType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Room Type Id */,
    `NaRoomType` varchar(25) NOT NULL UNIQUE /* Room Type Name */,
    `AbRoomType` varchar(10) NOT NULL UNIQUE /* Room Type Abbreviation */,
    `Number` integer NOT NULL /* Number of Rooms */
); /* Types of Room */
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Hour Id */,
    `NaHour` varchar(10) NOT NULL UNIQUE /* Hour Name */,
    `Interval` varchar(21) NOT NULL UNIQUE /* Hour Interval */
); /* Academic Hours */
CREATE TABLE IF NOT EXISTS `Class`(
    `IdLevel` integer NOT NULL /* Level */,
    `IdSpecialization` integer NOT NULL /* Specialization */,
    `IdGroup` integer NOT NULL /* Group */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdLevel`,`IdSpecialization`,`IdGroup`),
  CONSTRAINT `CourseClass` FOREIGN KEY (`IdLevel`,`IdSpecialization`)
    REFERENCES `Course`(`IdLevel`,`IdSpecialization`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `GroupClass` FOREIGN KEY (`IdGroup`)
    REFERENCES `Group`(`IdGroup`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Groups */
CREATE TABLE IF NOT EXISTS `Subject`(
    `IdSubject` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Subject Id */,
    `NaSubject` varchar(20) NOT NULL UNIQUE /* Subject Name */
); /* Subjects */
CREATE TABLE IF NOT EXISTS `Teacher`(
    `IdTeacher` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Teacher Id */,
    `TeacherNationalId` varchar(11) NOT NULL /* Teacher National Id */,
    `LnTeacher` varchar(15) NOT NULL /* Teacher Last Name */,
    `NaTeacher` varchar(15) NOT NULL /* Teacher Name */,
  CONSTRAINT `ixLnNaTeacher` UNIQUE(`LnTeacher`,`NaTeacher`),
  CONSTRAINT `ixNaLnTeacher` UNIQUE(`NaTeacher`,`LnTeacher`)
); /* Teachers */
CREATE TABLE IF NOT EXISTS `Distribution`(
    `IdSubject` integer NOT NULL /* Subject Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdGroup` integer NOT NULL /* Group Id */,
    `IdTeacher` integer NOT NULL /* Teacher Id */,
    `IdRoomType` integer NOT NULL /* Room Type Id */,
    `RoomCount` integer /* Number of classrooms needed */,
    `Composition` varchar(40) NOT NULL /* Composition of the Slots for the Subject */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`),
  CONSTRAINT `ClassDistribution` FOREIGN KEY (`IdLevel`,`IdSpecialization`,`IdGroup`)
    REFERENCES `Class`(`IdLevel`,`IdSpecialization`,`IdGroup`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `RoomTypeDistribution` FOREIGN KEY (`IdRoomType`)
    REFERENCES `RoomType`(`IdRoomType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `SubjectDistribution` FOREIGN KEY (`IdSubject`)
    REFERENCES `Subject`(`IdSubject`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TeacherDistribution` FOREIGN KEY (`IdTeacher`)
    REFERENCES `Teacher`(`IdTeacher`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Distribution of Workload */
CREATE TABLE IF NOT EXISTS `JoinedClass`(
    `IdSubject` integer NOT NULL /* Subject Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdGroup` integer NOT NULL /* Group Id */,
    `IdLevel1` integer NOT NULL /* Level Id of Joined Class */,
    `IdSpecialization1` integer NOT NULL /* Specialization Id of Joined Class */,
    `IdGroup1` integer NOT NULL /* Group Id of Joined Class */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`,`IdLevel1`,`IdSpecialization1`,`IdGroup1`),
  CONSTRAINT `ClassJoinedClass` FOREIGN KEY (`IdLevel1`,`IdSpecialization1`,`IdGroup1`)
    REFERENCES `Class`(`IdLevel`,`IdSpecialization`,`IdGroup`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `DistributionJoinedClass` FOREIGN KEY (`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`)
    REFERENCES `Distribution`(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Joined Classes */
CREATE TABLE IF NOT EXISTS `SubjectRestrictionType`(
    `IdSubjectRestrictionType` integer NOT NULL PRIMARY KEY /* Subject Restriction Type Id */,
    `NaSubjectRestrictionType` varchar(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColSubjectRestrictionType` integer NOT NULL /* Restriction Type Color */,
    `ValSubjectRestrictionType` integer NOT NULL /* Restriction Type Value */
); /* Types of Subject Restrictions */
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
    `IdSubject` integer NOT NULL /* Subject Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdGroup` integer NOT NULL /* Group Id */,
    `IdTeacher` integer NOT NULL /* Teacher Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`,`IdTeacher`),
  CONSTRAINT `DistributionAssistance` FOREIGN KEY (`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`)
    REFERENCES `Distribution`(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`) ON UPDATE CASCADE ON DELETE CASCADE,
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
CREATE TABLE IF NOT EXISTS `SubjectRestriction`(
    `IdSubject` integer NOT NULL /* Subject Id */,
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
    `IdSubjectRestrictionType` integer NOT NULL /* Subject Restriction Type Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdSubject`,`IdDay`,`IdHour`),
  CONSTRAINT `SubjectRestrictionTypeSubjectRestriction` FOREIGN KEY (`IdSubjectRestrictionType`)
    REFERENCES `SubjectRestrictionType`(`IdSubjectRestrictionType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `SubjectSubjectRestriction` FOREIGN KEY (`IdSubject`)
    REFERENCES `Subject`(`IdSubject`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotSubjectRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Subject Restrictions */
CREATE TABLE IF NOT EXISTS `Timetable`(
    `IdTimetable` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Timetable Id */,
    `TimeIni` datetime NOT NULL /* Initial Time */,
    `TimeEnd` datetime NOT NULL /* End Time */,
    `Summary` text /* Summary of Timetable Generation */
); /* Timetables */
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` integer NOT NULL /* Timetable Id */,
    `IdSubject` integer NOT NULL /* Subject Id */,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */,
    `IdGroup` integer NOT NULL /* Group Id */,
    `IdDay` integer NOT NULL /* Day Id */,
    `IdHour` integer NOT NULL /* Hour Id */,
    `Session` integer NOT NULL /* Internal Number */,
  CONSTRAINT `ixRestrictionSubject` UNIQUE(`IdTimetable`,`IdLevel`,`IdSpecialization`,`IdGroup`,`IdDay`,`IdHour`),
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`,`IdDay`,`IdHour`),
  CONSTRAINT `DistributionTimetableDetail` FOREIGN KEY (`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`)
    REFERENCES `Distribution`(`IdSubject`,`IdLevel`,`IdSpecialization`,`IdGroup`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotTimetableDetail` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableDetail` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Detail of Timetables */
