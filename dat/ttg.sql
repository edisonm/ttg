/* -*- mode: SQL; -*-

  14/02/2012 2:13

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*/
CREATE TABLE IF NOT EXISTS `Parallel`(
    `IdParallel` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Parallel Id */,
    `NaParallel` VARCHAR(5) NOT NULL UNIQUE /* Parallel Name */
); /* Parallels */
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Day Id */,
    `NaDay` VARCHAR(10) NOT NULL UNIQUE /* Name of Day */
); /* Working Days */
CREATE TABLE IF NOT EXISTS `Category`(
    `IdCategory` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Category Id */,
    `NaCategory` VARCHAR(25) NOT NULL UNIQUE /* Category Name */,
    `AbCategory` VARCHAR(10) NOT NULL UNIQUE /* Category Abbreviation */
); /* Categories */
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Hour Id */,
    `NaHour` VARCHAR(10) NOT NULL UNIQUE /* Hour Name */,
    `Interval` VARCHAR(21) NOT NULL UNIQUE /* Hour Interval */
); /* Academic Hours */
CREATE TABLE IF NOT EXISTS `RoomType`(
    `IdRoomType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Room Type Id */,
    `NaRoomType` VARCHAR(25) NOT NULL UNIQUE /* Room Type Name */,
    `AbRoomType` VARCHAR(10) NOT NULL UNIQUE /* Room Type Abbreviation */,
    `Number` INTEGER NOT NULL /* Number of Rooms */
); /* Types of Room */
CREATE TABLE IF NOT EXISTS `Cluster`(
    `IdCategory` INTEGER NOT NULL /* Category */,
    `IdParallel` INTEGER NOT NULL /* Parallel */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdCategory`,`IdParallel`),
  CONSTRAINT `CategoryCluster` FOREIGN KEY (`IdCategory`)
    REFERENCES `Category`(`IdCategory`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ParallelCluster` FOREIGN KEY (`IdParallel`)
    REFERENCES `Parallel`(`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Clusters */
CREATE TABLE IF NOT EXISTS `Theme`(
    `IdTheme` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Theme Id */,
    `NaTheme` VARCHAR(20) NOT NULL UNIQUE /* Theme Name */
); /* Themes */
CREATE TABLE IF NOT EXISTS `ResourceType`(
    `IdResourceType` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Resource Type Id */,
    `NaResourceType` VARCHAR(15) NOT NULL UNIQUE /* Name */,
    `DefaultLimit` INTEGER NOT NULL /* Default Limit */
);
CREATE TABLE IF NOT EXISTS `Resource`(
    `IdResource` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT /* Resource Id */,
    `IdResourceType` INTEGER /* NOT NULL Resource Type Id */,
    `NaResource` VARCHAR(25) NOT NULL /* UNIQUE Resource Name */,
    `AbResource` VARCHAR(11) NOT NULL /* UNIQUE Abbreviation */,
    `NumResource` INTEGER NOT NULL /* Number of resources */
); /* Resources */
CREATE TABLE IF NOT EXISTS `Distribution`(
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdCategory` INTEGER NOT NULL /* Category Id */,
    `IdParallel` INTEGER NOT NULL /* Parallel Id */,
    `IdResource` INTEGER NOT NULL /* Resource Id */,
    `IdRoomType` INTEGER NOT NULL /* Room Type Id */,
    `RoomCount` INTEGER /* Number of classrooms needed */,
    `Composition` VARCHAR(40) NOT NULL /* Composition of the Slots for the Theme */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdCategory`,`IdParallel`),
  CONSTRAINT `ClusterDistribution` FOREIGN KEY (`IdCategory`,`IdParallel`)
    REFERENCES `Cluster`(`IdCategory`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `RoomTypeDistribution` FOREIGN KEY (`IdRoomType`)
    REFERENCES `RoomType`(`IdRoomType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ThemeDistribution` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ResourceDistribution` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Distribution of Workload */
CREATE TABLE IF NOT EXISTS `JoinedCluster`(
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdCategory` INTEGER NOT NULL /* Category Id */,
    `IdParallel` INTEGER NOT NULL /* Parallel Id */,
    `IdCategory1` INTEGER NOT NULL /* Category Id of Joined Cluster */,
    `IdParallel1` INTEGER NOT NULL /* Parallel Id of Joined Cluster */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdCategory`,`IdParallel`,`IdCategory1`,`IdParallel1`),
  CONSTRAINT `ClusterJoinedCluster` FOREIGN KEY (`IdCategory1`,`IdParallel1`)
    REFERENCES `Cluster`(`IdCategory`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `DistributionJoinedCluster` FOREIGN KEY (`IdTheme`,`IdCategory`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdCategory`,`IdParallel`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Joined Clusters */
CREATE TABLE IF NOT EXISTS `ThemeRestrictionType`(
    `IdThemeRestrictionType` INTEGER NOT NULL PRIMARY KEY /* Theme Restriction Type Id */,
    `NaThemeRestrictionType` VARCHAR(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColThemeRestrictionType` INTEGER NOT NULL /* Restriction Type Color */,
    `ValThemeRestrictionType` INTEGER NOT NULL /* Restriction Type Value */
); /* Types of Theme Restrictions */
CREATE TABLE IF NOT EXISTS `TimeSlot`(
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdDay`,`IdHour`),
  CONSTRAINT `DayTimeSlot` FOREIGN KEY (`IdDay`)
    REFERENCES `Day`(`IdDay`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `HourTimeSlot` FOREIGN KEY (`IdHour`)
    REFERENCES `Hour`(`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Time Slots */
CREATE TABLE IF NOT EXISTS `Assistance`(
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdCategory` INTEGER NOT NULL /* Category Id */,
    `IdParallel` INTEGER NOT NULL /* Parallel Id */,
    `IdResource` INTEGER NOT NULL /* Resource Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdCategory`,`IdParallel`,`IdResource`),
  CONSTRAINT `DistributionAssistance` FOREIGN KEY (`IdTheme`,`IdCategory`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdCategory`,`IdParallel`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `ResourceAssistance` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Assistances */
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
  CONSTRAINT `ResourceRestrictionTypeResourceRestriction` FOREIGN KEY (`IdResourceRestrictionType`)
    REFERENCES `ResourceRestrictionType`(`IdResourceRestrictionType`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ResourceResourceRestriction` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotResourceRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Resource Restrictions */
CREATE TABLE IF NOT EXISTS `ThemeRestriction`(
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
    `IdThemeRestrictionType` INTEGER NOT NULL /* Theme Restriction Type Id */,
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
    `TimeIni` DATETIME NOT NULL /* Initial Time */,
    `TimeEnd` DATETIME NOT NULL /* End Time */,
    `Summary` text /* Summary of Timetable Generation */
); /* Timetables */
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` INTEGER NOT NULL /* Timetable Id */,
    `IdTheme` INTEGER NOT NULL /* Theme Id */,
    `IdCategory` INTEGER NOT NULL /* Category Id */,
    `IdParallel` INTEGER NOT NULL /* Parallel Id */,
    `IdDay` INTEGER NOT NULL /* Day Id */,
    `IdHour` INTEGER NOT NULL /* Hour Id */,
    `Session` INTEGER NOT NULL /* Internal Number */,
  CONSTRAINT `ixRestrictionTheme` UNIQUE(`IdTimetable`,`IdCategory`,`IdParallel`,`IdDay`,`IdHour`),
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdTheme`,`IdCategory`,`IdParallel`,`IdDay`,`IdHour`),
  CONSTRAINT `DistributionTimetableDetail` FOREIGN KEY (`IdTheme`,`IdCategory`,`IdParallel`)
    REFERENCES `Distribution`(`IdTheme`,`IdCategory`,`IdParallel`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimeSlotTimetableDetail` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `TimeSlot`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableDetail` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Detail of Timetables */
