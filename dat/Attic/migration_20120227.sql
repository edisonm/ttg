UPDATE Participant
SET IdActivity=
    (
      SELECT Activity.IdActivity
      FROM Activity
      WHERE Activity.IdTheme=Participant.IdTheme
      AND Activity.IdCategory=Participant.IdCategory
      AND Activity.IdParallel=Participant.IdParallel
    );

UPDATE TimetableDetail
SET IdActivity=
    (
      SELECT Activity.IdActivity
      FROM Activity
      WHERE Activity.IdTheme=TimetableDetail.IdTheme
      AND Activity.IdCategory=TimetableDetail.IdCategory
      AND Activity.IdParallel=TimetableDetail.IdParallel
    );
UPDATE TimetableResource
SET IdActivity=
    (
      SELECT Activity.IdActivity
      FROM Activity
      WHERE Activity.IdTheme=TimetableResource.IdTheme
      AND Activity.IdCategory=TimetableResource.IdCategory
      AND Activity.IdParallel=TimetableResource.IdParallel
    );
