/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All VIEW entities created to facilitate front-end and server-side queries
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
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
DROP VIEW IF EXISTS ClassAttendanceDetails;
CREATE VIEW ClassAttendanceDetails AS
    SELECT Participants.participantID,
           People.firstName,
           People.middleInit,
           People.lastName,
           Participants.dateOfBirth,
           Participants.race,
           Participants.sex,
           ParticipantClassAttendance.topicName,
           ParticipantClassAttendance.curriculumName,
           ParticipantClassAttendance.date,
           ParticipantClassAttendance.comments,
           ParticipantClassAttendance.numChildren,
           ParticipantClassAttendance.isNew,
           ParticipantClassAttendance.zipCode,
           Curricula.siteName,
           FacilitatorClassAttendance.facilitatorID
       FROM Participants
       INNER JOIN People
       ON Participants.participantID = People.peopleID
       INNER JOIN ParticipantClassAttendance
       ON Participants.participantID = ParticipantClassAttendance.participantID
       INNER JOIN ClassOffering
       ON ClassOffering.topicName = ParticipantClassAttendance.topicName AND
          ClassOffering.date = ParticipantClassAttendance.date AND
          ClassOffering.curriculumName = ParticipantClassAttendance.curriculumName
       INNER JOIN Curricula
       ON Curricula.curriculumName = ClassOffering.curriculumName
       INNER JOIN FacilitatorClassAttendance
       ON FacilitatorClassAttendance.topicName = ClassOffering.topicName AND
          FacilitatorClassAttendance.date = ClassOffering.date AND
          FacilitatorClassAttendance.curriculumName = ClassOffering.curriculumName;

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
  WHERE people.peopleid = employees.employeeid AND
        employees.employeeid = facilitators.facilitatorid AND
        facilitators.facilitatorid = facilitatorlanguage.facilitatorid
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
  WHERE people.peopleid = familymembers.familymemberid AND
        familymembers.familymemberid = family.familymembersid
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
  WHERE people.peopleid = participants.participantid AND
        participants.participantid = participantclassattendance.participantid
  GROUP BY participants.participantid,
           people.firstname,
           people.lastname,
           people.middleinit,
           participants.dateofbirth,
           participants.race,
           participantclassattendance.topicname,
           participantclassattendance.date
  ORDER BY participants.participantid;

/**
 * CurriculumInfo
 *  Gathers curriculum information
 *
 * @author Jesse Opitz
 */
CREATE VIEW CurriculumInfo AS
  SELECT curricula.curriculumName,
    Curricula.siteName,
    Curricula.missNumber,
    Curriculumclasses.topicName,
    Classes.description
  FROM Curricula,
       Curriculumclasses,
       Classes
  WHERE Curricula.curriculumName = Curriculumclasses.curriculumName AND
        Curriculumclasses.topicname = Classes.topicname
  GROUP BY Curricula.curriculumName,
           Curriculumclasses.curriculumName,
           Curriculumclasses.topicName,
           Classes.topicName
  ORDER BY Curricula.curriculumName;

/**
 * GetCurricula
 *
 * @author John Randis
 */
CREATE VIEW GetCurricula AS
    SELECT c.curriculumname
    FROM curricula c
    ORDER BY c.curriculumname ASC;

/**
 * GetClasses
 *
 * @author John Randis
 */
CREATE VIEW getClasses AS
    SELECT cc.topicname
    FROM curriculumclasses cc
    ORDER BY cc.curriculumName;

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
    ON Participants.participantID=People.peopleID
    INNER JOIN Forms
    ON Participants.participantID=Forms.participantID;
