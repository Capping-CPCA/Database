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
            Classes.classID,
            Classes.topicName,
            Curricula.curriculumID,
            Curricula.curriculumName,
            ParticipantClassAttendance.date,
            ParticipantClassAttendance.siteName,
            ParticipantClassAttendance.comments,
            ParticipantClassAttendance.numChildren,
            ParticipantClassAttendance.isNew,
            ParticipantClassAttendance.zipCode,
            FacilitatorClassAttendance.facilitatorID
        FROM Participants
        INNER JOIN People
        ON Participants.participantID = People.peopleID
        INNER JOIN ParticipantClassAttendance
        ON Participants.participantID = ParticipantClassAttendance.participantID
        INNER JOIN ClassOffering
        ON ClassOffering.classID = ParticipantClassAttendance.classID AND
           ClassOffering.date = ParticipantClassAttendance.date AND
           ClassOffering.curriculumID = ParticipantClassAttendance.curriculumID AND
           ClassOffering.siteName = ParticipantClassAttendance.siteName
        INNER JOIN Curricula
        ON Curricula.curriculumID = ClassOffering.curriculumID
        INNER JOIN FacilitatorClassAttendance
        ON FacilitatorClassAttendance.classID = ClassOffering.classID AND
           FacilitatorClassAttendance.date = ClassOffering.date AND
           FacilitatorClassAttendance.curriculumID = ClassOffering.curriculumID AND
           FacilitatorClassAttendance.siteName = ClassOffering.siteName
        INNER JOIN Classes
        ON Classes.classID = ClassOffering.classID;

/**
 * FacilitatorInfo
 *
 *  Returns all relevant information on facilitators. Since data for employees
 *  is scattered across three tables, this will make it easier for app developers
 *  to query for facilitator information.
 *
 * @author Carson Badame
 */
DROP VIEW IF EXISTS FacilitatorInfo;
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
DROP VIEW IF EXISTS FamilyInfo;
CREATE VIEW FamilyInfo AS
    SELECT Family.formid,
        Participants.participantID,
        People.firstName,
        People.lastName,
        People.middleInit,
        FamilyMembers.familyMemberID,
        FamilyMembers.relationship,
        FamilyMembers.dateofbirth,
        FamilyMembers.race,
        FamilyMembers.sex
    FROM Participants
    INNER JOIN People
    ON People.peopleID = Participants.participantID
    INNER JOIN Forms
    ON Forms.participantID = Participants.participantID
    INNER JOIN Family
    ON Family.formID = Forms.formID
    INNER JOIN FamilyMembers
    ON FamilyMembers.familyMemberID = Family.familyMembersID;

/**
 * ParticipantStatus
 *  TEMP: Duplicated for testing
 * Returns basic info about a participant and the amount of classes they have attended, including then name of the most recent one.
 *
 * @author Carson Badame
 * @donotuse TEMP
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
 DROP VIEW IF EXISTS CurriculumInfo;
CREATE VIEW CurriculumInfo AS
    SELECT Curricula.curriculumID,
         Curricula.curriculumName,
        Curricula.missNumber,
        Curricula.DF AS CurriculumDeleteFlag,
        Classes.classID,
        Classes.topicName,
        Classes.description,
        Classes.DF AS ClassDeleteFlag
    FROM Curricula
    INNER JOIN CurriculumClasses
    ON Curricula.curriculumID = CurriculumClasses.curriculumID
    INNER JOIN Classes
    ON Classes.classID = CurriculumClasses.classID
    ORDER BY Curricula.curriculumName;

/**
 * ParticipantInfo
 *  Joins together all information about a participant. We need to have a view
 *  because information is spread out across two tables People and Participant.
 * @author Marcos Barbieri
 */
DROP VIEW IF EXISTS ParticipantInfo;
CREATE VIEW ParticipantInfo AS
    SELECT Participants.participantID,
        People.firstName,
        People.middleInit,
        People.lastName,
        Participants.dateOfBirth,
        Participants.race,
        Participants.sex,
        Forms.formID
    FROM Participants
    INNER JOIN People
    ON Participants.participantID=People.peopleID
    INNER JOIN Forms
    ON Participants.participantID=Forms.participantID;
