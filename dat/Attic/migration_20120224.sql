INSERT INTO `ResourceType`(`IdResourceType`,`NaResourceType`,`DefaultLimit`,`ValResourceType`)
VALUES ("3","Group","1","301");
INSERT INTO `Resource`(`IdResourceType`,`NaResource`,`AbResource`,`NumResource`)
SELECT
  "3" AS `IdResourceType`,
  `NaCategory` || " " || `NaParallel` AS `NaResource`,
  `AbCategory` || " " || `NaParallel` AS `AbResource`,
  "1" AS `NumResource`
FROM
  `Cluster`
  INNER JOIN Category ON Cluster.IdCategory=Category.IdCategory
  INNER JOIN Parallel ON Cluster.IdParallel=Parallel.IdParallel;
INSERT INTO `Participant`(`IdTheme`,`IdCategory`,`IdParallel`,`IdResource`,`NumResource`)
SELECT `IdTheme`,`Activity`.`IdCategory`,`Activity`.`IdParallel`,`Resource`.`IdResource`, "1" AS `NumResource`
FROM `Activity`
  INNER JOIN Category ON Activity.IdCategory=Category.IdCategory
  INNER JOIN Parallel ON Activity.IdParallel=Parallel.IdParallel, `Resource`
WHERE
      Resource.IdResourceType=3
  AND Resource.NaResource=Category.NaCategory||" "||Parallel.NaParallel
