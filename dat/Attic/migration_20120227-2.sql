DELETE FROM Resource WHERE IdResourceType="4";
DELETE FROM ResourceType WHERE IdResourceType="4";

INSERT INTO ResourceType(IdResourceType, NaResourceType, DefaultLimit, ValResourceType)
VALUES("4","Campo","1000", "0");
INSERT INTO Resource(IdResourceType,NaResource,AbResource,NumResource)
SELECT DISTINCT "4" AS IdResourceType, Theme.NaTheme AS NaResource,Theme.NaTheme AS AbResource, "1000" AS NumResource
FROM Theme INNER JOIN ThemeRestriction ON Theme.IdTheme=ThemeRestriction.IdTheme;

INSERT INTO RestrictionType(NaRestrictionType,ColRestrictionType,ValRestrictionType)
SELECT NaThemeRestrictionType AS NaRestrictionType,
       ColThemeRestrictionType AS NaRestrictionType,
       ValThemeRestrictionType AS ValRestrictionType
FROM ThemeRestrictionType;

INSERT INTO Restriction(IdResource,IdDay,IdHour,IdRestrictionType)
SELECT Resource.IdResource,ThemeRestriction.IdDay,ThemeRestriction.IdHour,RestrictionType.IdRestrictionType
FROM Resource INNER JOIN Theme ON Resource.NaResource=Theme.NaTheme
INNER JOIN ThemeRestriction ON Theme.IdTheme=ThemeRestriction.IdTheme
INNER JOIN ThemeRestrictionType ON ThemeRestriction.IdThemeRestrictionType=ThemeRestrictionType.IdThemeRestrictionType
INNER JOIN RestrictionType ON ThemeRestrictionType.NaThemeRestrictionType=RestrictionType.NaRestrictionType
WHERE Resource.IdResourceType="4";

INSERT INTO Participant(IdActivity,IdResource,NumResource)
SELECT Activity.IdActivity,Resource.IdResource,1 AS NumResource
FROM Activity
INNER JOIN Theme ON Activity.IdTheme=Theme.IdTheme
INNER JOIN Resource ON Resource.NaResource=Theme.NaTheme
WHERE Resource.IdResourceType=4;
