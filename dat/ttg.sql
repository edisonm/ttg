/* -*- mode: SQL; -*-

  28/02/2012 3:15

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update

*/

CREATE TABLE IF NOT EXISTS `Theme`(
    `IdTheme` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Theme Id */,
    `NaTheme` VARCHAR(20) NOT NULL UNIQUE /* Theme Name */
); /* Themes */
CREATE TABLE IF NOT EXISTS `Theme_`(
    `IdTheme_` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Theme Id */,
    `IdTheme` INTEGER,
    `IdCategory` INTEGER,
    `NaTheme` VARCHAR(30) NOT NULL UNIQUE /* Theme Name */
); /* Themes */
CREATE TABLE IF NOT EXISTS `Category`(
    `IdCategory` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Id */,
    `NaCategory` VARCHAR(25) NOT NULL UNIQUE /* Name */,
    `AbCategory` VARCHAR(10) NOT NULL UNIQUE /* Abbreviation */
); /* Categories */
CREATE TABLE IF NOT EXISTS `Parallel`(
    `IdParallel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Parallel Id */,
    `NaParallel` VARCHAR(5) NOT NULL UNIQUE /* Parallel Name */
); /* Parallels */
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Day Id */,
    `NaDay` VARCHAR(10) NOT NULL UNIQUE /* Name of Day */
); /* Working Days */
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Hour Id */,
    `NaHour` VARCHAR(10) NOT NULL UNIQUE /* Hour Name */,
    `Interval` VARCHAR(21) NOT NULL UNIQUE /* Hour Interval */
); /* Academic Hours */
CREATE TABLE IF NOT EXISTS `Cluster`(
    `IdCategory` INTEGER NOT NULL /* Category */,
    `IdParallel` INTEGER NOT NULL /* Parallel */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdCategory`,`IdParallel`),
  CONSTRAINT `CategoryCluster` FOREIGN KEY (`IdCategory`)
    REFERENCES `Category`(`IdCategory`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ParallelCluster` FOREIGN KEY (`IdParallel`)
    REFERENCES `Parallel`(`IdParallel`) ON UPDATE CASCADE ON DELETE RESTRICT
); /* Clusters */
CREATE TABLE IF NOT EXISTS `Period`(
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdDay`,`IdHour`),
  CONSTRAINT `DayPeriod` FOREIGN KEY (`IdDay`)
    REFERENCES `Day`(`IdDay`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `HourPeriod` FOREIGN KEY (`IdHour`)
    REFERENCES `Hour`(`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Periods */
CREATE TABLE IF NOT EXISTS `ResourceType`(
    `IdResourceType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Resource Type Id */,
    `NaResourceType` VARCHAR(15) NOT NULL UNIQUE /* Name */,
    `DefaultLimit` INTEGER NOT NULL /* Default Limit */,
    `ValResourceType` INTEGER NOT NULL /* Value of Clashes */
); /* Resource types */
CREATE TABLE IF NOT EXISTS `Resource`(
    `IdResource` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Resource Id */,
    `IdResourceType` INTEGER NOT NULL /* Resource Type Id */,
    `NaResource` VARCHAR(25) NOT NULL UNIQUE /* Resource Name */,
    `AbResource` VARCHAR(15) NOT NULL UNIQUE /* Resource Abbreviation */,
    `NumResource` INTEGER NOT NULL /* Number of resources */,
  CONSTRAINT `ResourceTypeResource` FOREIGN KEY (`IdResourceType`)
    REFERENCES `ResourceType`(`IdResourceType`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Resources */
CREATE TABLE IF NOT EXISTS `ResourceRestrictionType`(
    `IdResourceRestrictionType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Resource Restriction Type Id */,
    `NaResourceRestrictionType` VARCHAR(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColResourceRestrictionType` INTEGER NOT NULL /* Restriction Type Color */,
    `ValResourceRestrictionType` INTEGER NOT NULL /* Restriction Type Value */
); /* Types of Resource Restrictions */
CREATE TABLE IF NOT EXISTS `ResourceRestriction`(
    `IdResource` INTEGER NOT NULL /* Resource Id */,
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
    `IdResourceRestrictionType` INTEGER NOT NULL /* Resource Restriction Type Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdResource`,`IdDay`,`IdHour`),
  CONSTRAINT `PeriodResourceRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `Period`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ResourceResourceRestriction` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `ResourceRestrictionTypeResourceRestriction` FOREIGN KEY (`IdResourceRestrictionType`)
    REFERENCES `ResourceRestrictionType`(`IdResourceRestrictionType`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Resource Restrictions */
CREATE TABLE IF NOT EXISTS `Activity`(
    `IdActivity` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Activity Id */,
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdTheme_` INTEGER /*  NOT NULL Theme Id */,
    `IdCategory` INTEGER NOT NULL /* Category */,
    `IdParallel` INTEGER NOT NULL /* Parallel */,
    `Composition` VARCHAR(40) NOT NULL /* Configuration of periods */,
  CONSTRAINT `ThemeActivity` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE CASCADE ON DELETE RESTRICT
); /* Activities */
CREATE TABLE IF NOT EXISTS `Requirement`(
    `IdActivity` INTEGER NOT NULL /* Category Id */,
    `IdResource` INTEGER NOT NULL /* Resource Id */,
    `NumRequirement` INTEGER NOT NULL /* Number of Resources */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdActivity`,`IdResource`),
  CONSTRAINT `ActivityRequirement` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `ResourceRequirement` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE RESTRICT
); /* Requirements */
CREATE TABLE IF NOT EXISTS `Timetable`(
    `IdTimetable` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Timetable Id */,
    `TimeIni` DATETIME NOT NULL /* Initial Time */,
    `TimeEnd` DATETIME NOT NULL /* End Time */,
    `Summary` TEXT /* Summary of Timetable Generation */
); /* Timetables */
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` INTEGER NOT NULL /* Timetable Id */,
    `IdActivity` INTEGER NOT NULL /* Activity Id */,
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
    `Session` INTEGER NOT NULL /* Internal Number */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdActivity`,`IdDay`,`IdHour`),
  CONSTRAINT `ActivityTimetableDetail` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `PeriodTimetableDetail` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `Period`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableDetail` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Detail of Timetables */
CREATE TABLE IF NOT EXISTS `TimetableResource`(
    `IdTimetable` INTEGER NOT NULL /* Timetable Id */,
    `IdActivity` INTEGER NOT NULL /* Activity Id */,
    `IdResource` INTEGER NOT NULL /* Resource Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdActivity`,`IdResource`),
  CONSTRAINT `ActivityTimetableResource` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `ResourceTimetableResource` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableResource` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Resources of Timetables */
