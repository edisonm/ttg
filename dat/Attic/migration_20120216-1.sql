/* STAGE 1 */
CREATE TABLE IF NOT EXISTS `Category_`(
    `IdCategory` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `IdLevel` integer NOT NULL /* Level Id */,
    `IdSpecialization` integer NOT NULL /* Specialization Id */
); /* Categories */

INSERT INTO `Category_`(`IdLevel`, `IdSpecialization`)
SELECT `IdLevel`, `IdSpecialization`
FROM `Category`;

UPDATE `Category`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`Category`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`Category`.`IdSpecialization`
  );

UPDATE `Cluster`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`Cluster`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`Cluster`.`IdSpecialization`
  );

UPDATE `Activity`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`Activity`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`Activity`.`IdSpecialization`
  );

UPDATE `JoinedCluster`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`JoinedCluster`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`JoinedCluster`.`IdSpecialization`
  ),
  `IdCategory1` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`JoinedCluster`.`IdLevel1`
      AND `Category_`.`IdSpecialization`=`JoinedCluster`.`IdSpecialization1`
  );

UPDATE `Participant`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`Participant`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`Participant`.`IdSpecialization`
  );

UPDATE `TimetableDetail`
SET `IdCategory` =
  (
    SELECT `Category_`.`IdCategory`
    FROM `Category_`
    WHERE `Category_`.`IdLevel`=`TimetableDetail`.`IdLevel`
      AND `Category_`.`IdSpecialization`=`TimetableDetail`.`IdSpecialization`
  );
