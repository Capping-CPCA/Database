/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All VIEW entities created to facilitate front-end and server-side queries
 *
 * @author James Crowley, Carson Badame, John Randis, Jessie Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 0.2.1
 */

/**
 * ClassAttendanceDetails
 *  Returns all information related to a participant and their attendance for
 *  all classes offered
 *
 * @author John Randis & Marcos Barbieri
 */
CREATE VIEW ClassAttendanceDetails AS
    SELECT ParticipantInfo.pid,
       ParticipantInfo.participantFirstName,
       ParticipantInfo.participantMiddleInit,
       ParticipantInfo.participantLastName,
       ParticipantInfo.race,
       ParticipantInfo.sex,
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


/**
 * FacilitatorInfo
 *
 *  Returns all relevant information on facilitators. Since data for employees
 *  is scattered across three tables, this will make it easier for app developers
 *  to query for facilitator information.
 *
 * @author Carson Badame
 */
CREATE VIEW FacilitatorInfo AS
 SELECT facilitators.facilitatorid,
    people.firstname,
    people.lastname,
    people.middleinit,
    employees.email,
    employees.primaryphone,
    employees.permissionlevel,
    facilitatorlanguage.lang,
    facilitatorlanguage.level AS langlevel
   FROM people,
    facilitators,
    employees,
    facilitatorlanguage
  WHERE people.peopleid = employees.employeeid AND employees.employeeid = facilitators.facilitatorid AND facilitators.facilitatorid = facilitatorlanguage.facilitatorid
  ORDER BY facilitators.facilitatorid;


/**
 * FamilyInfo
 *  Returns data about the family related to the person ID
 *
 * @author Carson Badame
 */
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

/**
 * ParticipantStatus
 *  TEMP: Duplicated for testing
 * Returns basic info about a participant and the amount of classes they have attended, including then name of the most recent one.
 *
 * @author Carson Badame
 */
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

/**
 * CurriculumInfo
 *  Gathers curriculum information
 *
 * @author ?
 */
CREATE VIEW CurriculumInfo AS
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

/**
 * GetCurricula
 *
 * @author ?
 */
CREATE VIEW GetCurricula AS
    SELECT c.curriculumid, c.curriculumname
    FROM curricula c
    ORDER BY c.curriculumname ASC;

/**
 * GetClasses
 *
 * @author ?
 */
CREATE VIEW getClasses AS
    SELECT cc.curriculumid, cc.topicname
    FROM curriculumclasses cc
    ORDER BY cc.curriculumid;

/**
 * ParticipantInfo
 *  Joins together all information about a participant. We need to have a view
 *  because information is spread out across two tables People and Participant.
 * @author Marcos Barbieri
 */
CREATE VIEW ParticipantInfo AS
    SELECT Participants.participantID,
           People.firstName,
           People.middleInit,
           People.lastName,
           Participants.dateOfBirth,
           Participants.race,
           Participants.sex
    FROM Participants
    INNER JOIN People
    ON Participants.participantID=People.peopleID;
