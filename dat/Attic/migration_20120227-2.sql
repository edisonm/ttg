DELETE FROM Resource WHERE IdResourceType="4";
DELETE FROM ResourceType WHERE IdResourceType="4";

INSERT INTO ResourceType(IdResourceType, NaResourceType, DefaultLimit, ValResourceType)
VALUES("4","Campo","1000", "0");
INSERT INTO Resource(IdResourceType,NaResource,AbResource,NumResource)
SELECT DISTINCT "4" AS IdResourceType, Theme.NaTheme AS NaResource,Theme.NaTheme AS AbResource, "1000" AS NumResource
FROM Theme INNER JOIN ThemeRestriction ON Theme.IdTheme=ThemeRestriction.IdTheme;

INSERT INTO ResourceRestrictionType(NaResourceRestrictionType,ColResourceRestrictionType,ValResourceRestrictionType)
SELECT NaThemeRestrictionType AS NaResourceRestrictionType,
       ColThemeRestrictionType AS NaResourceRestrictionType,
       ValThemeRestrictionType AS ValResourceRestrictionType
FROM ThemeRestrictionType;

INSERT INTO ResourceRestriction(IdResource,IdDay,IdHour,IdResourceRestrictionType)
SELECT Resource.IdResource,ThemeRestriction.IdDay,ThemeRestriction.IdHour,ResourceRestrictionType.IdResourceRestrictionType
FROM Resource INNER JOIN Theme ON Resource.NaResource=Theme.NaTheme
INNER JOIN ThemeRestriction ON Theme.IdTheme=ThemeRestriction.IdTheme
INNER JOIN ThemeRestrictionType ON ThemeRestriction.IdThemeRestrictionType=ThemeRestrictionType.IdThemeRestrictionType
INNER JOIN ResourceRestrictionType ON ThemeRestrictionType.NaThemeRestrictionType=ResourceRestrictionType.NaResourceRestrictionType
WHERE Resource.IdResourceType="4";

INSERT INTO Participant(IdActivity,IdResource,NumResource)
SELECT Activity.IdActivity,Resource.IdResource,1 AS NumResource
FROM Activity
INNER JOIN Theme ON Activity.IdTheme=Theme.IdTheme
INNER JOIN Resource ON Resource.NaResource=Theme.NaTheme
WHERE Resource.IdResourceType=4;
