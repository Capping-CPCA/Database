-- View to retrieve attendance details for every class/participant
CREATE VIEW ClassAttendanceDetails AS
    SELECT ParticipantAttendanceDetails.participantFirstName,
       ParticipantAttendanceDetails.participantMiddleInit,
       ParticipantAttendanceDetails.participantLastName,
       ParticipantAttendanceDetails.date,
       ParticipantAttendanceDetails.topicName,
       ParticipantAttendanceDetails.siteName,
       Sites.programType,
       TeacherAttendanceDetails.facilitatorFirstName,
       TeacherAttendanceDetails.facilitatorMiddleInit,
       TeacherAttendanceDetails.facilitatorLastName
    FROM (SELECT People.firstName AS participantFirstName, People.middleInit AS participantMiddleInit, People.lastName AS participantLastName, ParticipantClassAttendance.topicName, ParticipantClassAttendance.date, ParticipantClassAttendance.siteName
      FROM People
      INNER JOIN ParticipantClassAttendance
      ON People.peopleID = ParticipantClassAttendance.participantID) AS ParticipantAttendanceDetails
    INNER JOIN (SELECT People.firstName AS facilitatorFirstName, People.middleInit AS facilitatorMiddleInit, People.lastName AS facilitatorLastName, FacilitatorClassAttendance.topicName, FacilitatorClassAttendance.date, FacilitatorClassAttendance.siteName
        FROM People
            INNER JOIN FacilitatorClassAttendance
            ON People.peopleID = FacilitatorClassAttendance.facilitatorID) AS TeacherAttendanceDetails
    ON ParticipantAttendanceDetails.topicName = TeacherAttendanceDetails.topicName
    AND ParticipantAttendanceDetails.date = TeacherAttendanceDetails.date
    AND ParticipantAttendanceDetails.siteName = TeacherAttendanceDetails.siteName
    INNER JOIN Sites
    ON ParticipantAttendanceDetails.siteName = Sites.siteName;
