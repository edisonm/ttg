/* -*- mode: SQL; -*-

  08/02/2012 22:34

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*/
CREATE TABLE IF NOT EXISTS `Level`(
    `IdLevel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaLevel` varchar(15) NOT NULL UNIQUE,
    `AbLevel` varchar(5) UNIQUE
);
CREATE TABLE IF NOT EXISTS `GroupId`(
    `IdGroupId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaGroupId` varchar(5) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaDay` varchar(10) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `Specialization`(
    `IdSpecialization` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaSpecialization` varchar(20) NOT NULL UNIQUE,
    `AbSpecialization` varchar(10) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `Course`(
    `IdLevel` integer NOT NULL,
    `IdSpecialization` integer NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdLevel,IdSpecialization),
  CONSTRAINT LevelCourse FOREIGN KEY (IdLevel)
    REFERENCES Level(IdLevel) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT SpecializationCourse FOREIGN KEY (IdSpecialization)
    REFERENCES Specialization(IdSpecialization) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaHour` varchar(10) NOT NULL UNIQUE,
    `Interval` varchar(21) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `RoomType`(
    `IdRoomType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaRoomType` varchar(25) NOT NULL UNIQUE,
    `AbRoomType` varchar(10) NOT NULL UNIQUE,
    `Number` integer NOT NULL
);
CREATE TABLE IF NOT EXISTS `Class`(
    `IdLevel` integer NOT NULL,
    `IdSpecialization` integer NOT NULL,
    `IdGroupId` integer NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdLevel,IdSpecialization,IdGroupId),
  CONSTRAINT CourseClass FOREIGN KEY (IdLevel,IdSpecialization)
    REFERENCES Course(IdLevel,IdSpecialization) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT GroupIdClass FOREIGN KEY (IdGroupId)
    REFERENCES GroupId(IdGroupId) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `Subject`(
    `IdSubject` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaSubject` varchar(20) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `Teacher`(
    `IdTeacher` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `TeacherNationalId` varchar(11) NOT NULL,
    `LnTeacher` varchar(15) NOT NULL,
    `NaTeacher` varchar(15) NOT NULL,
  CONSTRAINT ixLnNaTeacher UNIQUE(LnTeacher,NaTeacher),
  CONSTRAINT ixNaLnTeacher UNIQUE(NaTeacher,LnTeacher)
);
CREATE TABLE IF NOT EXISTS `SubjectRestrictionType`(
    `IdSubjectRestrictionType` integer NOT NULL PRIMARY KEY,
    `NaSubjectRestrictionType` varchar(10) NOT NULL UNIQUE,
    `ColSubjectRestrictionType` integer NOT NULL,
    `ValSubjectRestrictionType` integer NOT NULL
);
CREATE TABLE IF NOT EXISTS `TimeSlot`(
    `IdDay` integer NOT NULL,
    `IdHour` integer NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdDay,IdHour),
  CONSTRAINT DayTimeSlot FOREIGN KEY (IdDay)
    REFERENCES Day(IdDay) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT HourTimeSlot FOREIGN KEY (IdHour)
    REFERENCES Hour(IdHour) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `Distribution`(
    `IdSubject` integer NOT NULL,
    `IdLevel` integer NOT NULL,
    `IdSpecialization` integer NOT NULL,
    `IdGroupId` integer NOT NULL,
    `IdTeacher` integer NOT NULL,
    `IdRoomType` integer NOT NULL,
    `Composition` varchar(40) NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdSubject,IdLevel,IdSpecialization,IdGroupId),
  CONSTRAINT ClassDistribution FOREIGN KEY (IdLevel,IdSpecialization,IdGroupId)
    REFERENCES Class(IdLevel,IdSpecialization,IdGroupId) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT RoomTypeDistribution FOREIGN KEY (IdRoomType)
    REFERENCES RoomType(IdRoomType) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT SubjectDistribution FOREIGN KEY (IdSubject)
    REFERENCES Subject(IdSubject) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TeacherDistribution FOREIGN KEY (IdTeacher)
    REFERENCES Teacher(IdTeacher) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `TeacherRestrictionType`(
    `IdTeacherRestrictionType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `NaTeacherRestrictionType` varchar(10) NOT NULL UNIQUE,
    `ColTeacherRestrictionType` integer NOT NULL,
    `ValTeacherRestrictionType` integer NOT NULL
);
CREATE TABLE IF NOT EXISTS `TeacherRestriction`(
    `IdTeacher` integer NOT NULL,
    `IdDay` integer NOT NULL,
    `IdHour` integer NOT NULL,
    `IdTeacherRestrictionType` integer NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdTeacher,IdDay,IdHour),
  CONSTRAINT TeacherRestrictionTypeTeacherRestriction FOREIGN KEY (IdTeacherRestrictionType)
    REFERENCES TeacherRestrictionType(IdTeacherRestrictionType) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TeacherTeacherRestriction FOREIGN KEY (IdTeacher)
    REFERENCES Teacher(IdTeacher) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TimeSlotTeacherRestriction FOREIGN KEY (IdDay,IdHour)
    REFERENCES TimeSlot(IdDay,IdHour) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `SubjectRestriction`(
    `IdSubject` integer NOT NULL,
    `IdDay` integer NOT NULL,
    `IdHour` integer NOT NULL,
    `IdSubjectRestrictionType` integer NOT NULL,
  CONSTRAINT PrimaryKey PRIMARY KEY(IdSubject,IdDay,IdHour),
  CONSTRAINT SubjectRestrictionTypeSubjectRestriction FOREIGN KEY (IdSubjectRestrictionType)
    REFERENCES SubjectRestrictionType(IdSubjectRestrictionType) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT SubjectSubjectRestriction FOREIGN KEY (IdSubject)
    REFERENCES Subject(IdSubject) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TimeSlotSubjectRestriction FOREIGN KEY (IdDay,IdHour)
    REFERENCES TimeSlot(IdDay,IdHour) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS `Timetable`(
    `IdTimetable` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `TimeIni` datetime NOT NULL,
    `TimeEnd` datetime NOT NULL,
    `Summary` text
);
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` integer NOT NULL,
    `IdSubject` integer NOT NULL,
    `IdLevel` integer NOT NULL,
    `IdSpecialization` integer NOT NULL,
    `IdGroupId` integer NOT NULL,
    `IdDay` integer NOT NULL,
    `IdHour` integer NOT NULL,
    `Session` integer NOT NULL,
  CONSTRAINT ixRestrictionSubject UNIQUE(IdTimetable,IdLevel,IdSpecialization,IdGroupId,IdDay,IdHour),
  CONSTRAINT PrimaryKey PRIMARY KEY(IdTimetable,IdSubject,IdLevel,IdSpecialization,IdGroupId,IdDay,IdHour),
  CONSTRAINT DistributionTimetableDetail FOREIGN KEY (IdSubject,IdLevel,IdSpecialization,IdGroupId)
    REFERENCES Distribution(IdSubject,IdLevel,IdSpecialization,IdGroupId) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TimeSlotTimetableDetail FOREIGN KEY (IdDay,IdHour)
    REFERENCES TimeSlot(IdDay,IdHour) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT TimetableTimetableDetail FOREIGN KEY (IdTimetable)
    REFERENCES Timetable(IdTimetable) ON UPDATE CASCADE ON DELETE CASCADE
);
