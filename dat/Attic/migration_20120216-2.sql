UPDATE `Category`
SET `AbCategory`=
    (
      SELECT `AbLevel` || " " || `AbSpecialization`
      FROM `Level`, `Specialization`
      WHERE `Level`.`IdLevel`=`Category`.`IdLevel`
      	AND `Specialization`.`IdSpecialization`=`Category`.`IdSpecialization`
    ),
`NaCategory`=
    (
      SELECT `NaLevel` || " " || `NaSpecialization`
      FROM `Level`, `Specialization`
      WHERE `Level`.`IdLevel`=`Category`.`IdLevel`
      	AND `Specialization`.`IdSpecialization`=`Category`.`IdSpecialization`
    );
