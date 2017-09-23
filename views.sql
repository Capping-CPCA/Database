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

	
-- Facilitator Info --
 SELECT facilitators.facilitatorid,
    people.firstname,
    people.lastname,
    people.middleinit,
    employees.email,
    employees.primaryphone,
    employees.permissionlevel,
    facilitators.program,
    facilitatorlangugage.lang,
    facilitatorlangugage.level AS langlevel
   FROM people,
    facilitators,
    employees,
    facilitatorlangugage
  WHERE people.peopleid = employees.employeeid AND employees.employeeid = facilitators.facilitatorid AND facilitators.facilitatorid = facilitatorlangugage.facilitatorid
  ORDER BY facilitators.facilitatorid;
  
 -- Family Info	--
 
CREATE OR REPLACE VIEW public."FamilyInfo" AS 
 SELECT family.formid AS familyid,
    people.peopleid,
    people.firstname,
    people.lastname,
    people.middleinit,
    familymembers.relationship,
    familymembers.dateofbirth,
    familymembers.race,
    familymembers.sex
   FROM people,
    familymembers,
    family
  WHERE people.peopleid = familymembers.familymemberid AND familymembers.familymemberid = family.familymembersid
  ORDER BY family.formid;

-- Participant Status
CREATE OR REPLACE VIEW public."ParticipantStatus" AS 
 SELECT participants.participantid,
    people.firstname,
    people.lastname,
    people.middleinit,
    participants.dateofbirth,
    participants.race,
    participantclassattendance.topicname AS mostrecentclass,
    participantclassattendance.date,
    max(atttotal.totalclasses) AS totalclasses
   FROM people,
    participants,
    participantclassattendance,
    ( SELECT participantclassattendance_1.participantid,
            row_number() OVER (ORDER BY participantclassattendance_1.participantid) AS totalclasses
           FROM participantclassattendance participantclassattendance_1) atttotal
  WHERE people.peopleid = participants.participantid AND participants.participantid = participantclassattendance.participantid
  GROUP BY participants.participantid, people.firstname, people.lastname, people.middleinit, participants.dateofbirth, participants.race, participantclassattendance.topicname, participantclassattendance.date
  ORDER BY participants.participantid;
