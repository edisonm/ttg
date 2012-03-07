INSERT INTO FillRequirement(IdTheme,IdResource,NumResource)
SELECT Activity.IdTheme,Participant.IdResource,SUM(Participant.NumResource) AS NumResource
FROM Activity INNER JOIN Participant ON Activity.IdActivity=Participant.IdActivity
GROUP BY Activity.IdTheme,Participant.IdResource;

DELETE FROM Participant;

/*
SELECT FillRequirement.*,Theme.NaTheme,Resource.NaResource
FROM FillRequirement INNER JOIN Theme ON FillRequirement.IdTheme=Theme.IdTheme
INNER JOIN Resource ON FillRequirement.IdResource=Resource.IdResource
WHERE Resource.IdResourceType<>3
AND FillRequirement.NumResource<(
  SELECT COUNT(*)
  FROM Activity
  WHERE Activity.IdTheme=FillRequirement.IdTheme
  GROUP BY Activity.IdTheme
  HAVING COUNT(*)>1
);
*/
