-- View to retrieve attendance details for every class/participant
CREATE VIEW ClassAttendanceDetails AS
    SELECT ParticipantInfo.pid,
       ParticipantInfo.participantFirstName,
       ParticipantInfo.participantMiddleInit,
       ParticipantInfo.participantLastName,
       ParticipantInfo.race,
       ParticpantInfo.sex,
       ParticipantInfo.dateOfBirth,
       ParticipantInfo.comments,
       ParticipantInfo.classDate,
       ParticipantInfo.classTopic,
       ParticipantInfo.siteName,
       Sites.programType
    FROM (SELECT People.peopleId AS pid,
         People.firstName AS participantFirstName,
                 People.middleInit AS participantMiddleInit,
                 People.lastName AS participantLastName,
                 (SELECT race FROM Participants WHERE Participants.participantId = People.peopleId) AS race,
                 (SELECT dateOfBirth FROM Participants WHERE Participants.participantId = People.peopleId) AS dateOfBirth,
                 (SELECT sex FROM Participants WHERE Participants.participantId = People.peopleId) AS sex,
                 ParticipantClassAttendance.topicName AS classTopic,
                 ParticipantClassAttendance.date AS classDate,
                 ParticipantClassAttendance.siteName,
                 ParticipantClassAttendance.comments
          FROM People
          INNER JOIN ParticipantClassAttendance
          ON People.peopleID = ParticipantClassAttendance.participantID) AS ParticipantInfo
    INNER JOIN Sites
    ON ParticipantInfo.siteName = Sites.siteName;


-- Facilitator Info --
CREATE VIEW FacilitatorInfo AS
 SELECT facilitators.facilitatorid,
    people.firstname,
    people.lastname,
    people.middleinit,
    employees.email,
    employees.primaryphone,
    employees.permissionlevel,
    facilitators.program,
    facilitatorlanguage.lang,
    facilitatorlanguage.level AS langlevel
   FROM people,
    facilitators,
    employees,
    facilitatorlanguage
  WHERE people.peopleid = employees.employeeid AND employees.employeeid = facilitators.facilitatorid AND facilitators.facilitatorid = facilitatorlanguage.facilitatorid
  ORDER BY facilitators.facilitatorid;

 -- Family Info	--

CREATE VIEW FamilyInfo AS
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
CREATE VIEW ParticipantStatus AS
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

-- Curriculum Info
CREATE VIEW curriculumInfo AS
  SELECT curricula.curriculumID,
    curricula.curriculumName,
    curricula.curriculumType,
    curricula.missNumber,
    curriculumclasses.topicName,
    classes.description
  FROM curricula,
    curriculumclasses,
    classes
  WHERE curricula.curriculumID = curriculumclasses.curriculumID AND curriculumclasses.topicname = classes.topicname
  GROUP BY curricula.curriculumID, curriculumclasses.curriculumID, curriculumclasses.topicName, classes.topicName
  ORDER BY curricula.curriculumID;

CREATE VIEW getCurricula AS
	SELECT c.curriculumid, c.curriculumname 
	FROM curricula c 
	ORDER BY c.curriculumname ASC;
	
CREATE VIEW getClasses AS 
	SELECT cc.curriculumid, cc.topicname 
	FROM curriculumclasses cc 
	ORDER BY cc.curriculumid;

