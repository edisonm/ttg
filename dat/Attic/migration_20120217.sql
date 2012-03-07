DELETE FROM TimetableResource;
DELETE FROM ResourceRestriction;
DELETE FROM ResourceRestrictionType;
DELETE FROM Participant;
DELETE FROM Resource;
DELETE FROM ResourceType;
DELETE FROM Activity;

INSERT INTO Activity(IdTheme,IdCategory,Composition)
SELECT DISTINCT IdTheme,IdCategory,Composition
FROM Activity;
INSERT INTO ResourceType(IdResourceType,NaResourceType,DefaultLimit) VALUES ("1","Profesor","1");
INSERT INTO ResourceType(IdResourceType,NaResourceType,DefaultLimit) VALUES ("2","Aula","0");

INSERT INTO Resource(IdResource,IdResourceType,NaResource,AbResource,NumResource)
SELECT IdResource AS IdResource,
       "1" AS IdResourceType,
       NumResource||" "||NaResource AS NaResource,
       AbResource AS AbResource,
       "1" AS NumResource
FROM Resource;

INSERT INTO Resource(IdResourceType,NaResource,AbResource,NumResource)
SELECT 2 AS IdResourceType,NaRoomType AS NaResource,AbRoomType AS AbResource,`Number` AS NumResource
FROM RoomType;

INSERT INTO Participant(IdResource,IdTheme,IdCategory,IdParallel,IsFixed,NumResource)
SELECT DISTINCT IdResource AS IdResource,IdTheme,IdCategory,IdParallel,1 as IsFixed,1 as NumResource
FROM Activity;
INSERT INTO Participant(IdResource,IdTheme,IdCategory,IdParallel,IsFixed,NumResource)
SELECT IdResource,IdTheme,IdCategory,IdParallel,1 as IsFixed,Activity.RoomCount AS NumResource
FROM Activity INNER JOIN RoomType ON Activity.IdRoomType=RoomType.IdRoomType
INNER JOIN Resource
   ON Resource.NaResource=RoomType.NaRoomType
  AND Resource.AbResource=RoomType.AbRoomType
WHERE Resource.IdResourceType=2;

INSERT INTO Participant(IdResource,IdTheme,IdCategory,IdParallel,IsFixed,NumResource)
SELECT IdResource AS IdResource,IdTheme,IdCategory,IdParallel,1 as IsFixed,1 as NumResource
FROM Participant;

INSERT INTO ResourceRestrictionType(IdResourceRestrictionType,IdResourceType,NaResourceRestrictionType,
       ColResourceRestrictionType,ValResourceRestrictionType)
SELECT IdResourceRestrictionType AS IdResourceRestrictionType,
       1 AS IdResourceType,
       NaResourceRestrictionType AS NaResourceRestrictionType,
       ColResourceRestrictionType AS ColResourceRestrictionType,
       ValResourceRestrictionType AS ValResourceRestrictionType
FROM ResourceRestrictionType;
INSERT INTO ResourceRestriction(IdResource,IdDay,IdHour,IdResourceRestrictionType)
SELECT IdResource as IdResource,IdDay,IdHour,"1" as IdResourceRestrictionType
FROM ResourceRestriction;
INSERT INTO TimetableResource(IdTimetable,IdResource,IdTheme,IdCategory,IdParallel)
SELECT IdTimetable,IdResource,IdTheme,IdCategory,IdParallel
FROM Timetable,Participant;
