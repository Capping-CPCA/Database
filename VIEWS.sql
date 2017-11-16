/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All VIEW entities created to facilitate front-end and server-side queries
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 0.2.1
 */

-- All View Drop Statements
DROP VIEW IF EXISTS ClassAttendanceDetails;
DROP VIEW IF EXISTS FacilitatorInfo;
DROP VIEW IF EXISTS FamilyInfo;
DROP VIEW IF EXISTS CurriculumInfo;
DROP VIEW IF EXISTS ParticipantInfo;
DROP VIEW IF EXISTS SelfReferralInfo;
DROP VIEW IF EXISTS AgencyReferralInfo;

/**
 * ClassAttendanceDetails
 *  Returns all information related to a participant and their attendance for
 *  all classes offered
 *
 * @author John Randis & Marcos Barbieri
 */
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
 * CurriculumInfo
 *  Gathers curriculum information
 *
 * @author Jesse Opitz
 */
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

/**
 * SelfReferralInfo
 *  Returns all information in a persons self referral form
 *
 * @author Jesse Opitz
 */

CREATE VIEW SelfReferralInfo AS
    SELECT People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      --Family.familyMembersID,
      --Family.formID,
      FamilyMembers.familyMemberID,
      FamilyMembers.relationship,
      FamilyMembers.dateOfBirth,
      FamilyMembers.race,
      FamilyMembers.sex,
      Children.childrenID,
      Children.custody,
      Children.location,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
      Forms.participantID,
      SelfReferral.selfReferralID,
      SelfReferral.referralSource,
      SelfReferral.hasInvolvementCPS,
      SelfReferral.hasAttendedPEP,
      SelfReferral.reasonAttendingPEP,
      SelfReferral.dateFirstCall,
      SelfReferral.returnClientCallDate,
      SelfReferral.tentativeStartDate,
      SelfReferral.classAssignedTo,
      SelfReferral.introLetterMailedDate,
      SelfReferral.notes
    FROM 
      People 
      INNER JOIN FamilyMembers
      ON People.peopleID = FamilyMembers.familyMemberID
      INNER JOIN Children
      ON Children.childrenID = FamilyMembers.familyMemberID
      INNER JOIN Family
      ON Family.familyMembersID = FamilyMembers.familyMemberID
      INNER JOIN Forms
      ON Forms.formID = Family.formID
      INNER JOIN SelfReferral
      ON Forms.formID = SelfReferral.selfReferralID;

/**
 * AgencyReferralInfo
 *  Returns all information in a persons agency referral form
 *
 * @author Jesse Opitz
 */
DROP VIEW IF EXISTS AgencyReferralInfo;

CREATE VIEW AgencyReferralInfo AS
    SELECT Participants.participantID,
      Participants.dateOfBirth AS PDoB,
      Participants.race AS PRace,
      Participants.sex AS PSex,
      People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      --Family.familyMembersID,
      --Family.formID,
      FamilyMembers.familyMemberID,
      FamilyMembers.relationship,
      FamilyMembers.dateOfBirth AS FMDoB,
      FamilyMembers.race AS FMRace,
      FamilyMembers.sex AS FMSex,
      Children.childrenID,
      Children.custody,
      Children.location AS childLocation,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
      --Forms.participantID,
      AgencyReferral.agencyReferralID,
      AgencyReferral.reason,
      AgencyReferral.hasAgencyConsentForm,
      AgencyReferral.additionalInfo,
      AgencyReferral.hasSpecialNeeds,
      AgencyReferral.hasSubstanceAbuseHistory,
      AgencyReferral.hasInvolvementCPS,
      AgencyReferral.isPregnant,
      AgencyReferral.hasIQDoc,
      AgencyReferral.hasMentalHealth,
      AgencyReferral.hasDomesticViolenceHistory,
      AgencyReferral.childrenLiveWithIndividual,
      AgencyReferral.dateFirstContact,
      AgencyReferral.meansOfContact,
      AgencyReferral.dateOfInitialMeet,
      AgencyReferral.location AS ARLocation,
      AgencyReferral.comments
    FROM 
      Participants
      INNER JOIN People 
      ON Participants.participantID = People.peopleID
      INNER JOIN FamilyMembers
      ON People.peopleID = FamilyMembers.familyMemberID
      INNER JOIN Children
      ON Children.childrenID = FamilyMembers.familyMemberID
      INNER JOIN Family
      ON Family.familyMembersID = FamilyMembers.familyMemberID
      INNER JOIN Forms
      ON Forms.formID = Family.formID
      INNER JOIN AgencyReferral
      ON Forms.formID = AgencyReferral.agencyReferralID;

/**
 * IntakePacketInfo
 *  Returns all information in a persons agency referral form
 *
 * @author Jesse Opitz
 */
DROP VIEW IF EXISTS IntakePacketInfo;

CREATE VIEW IntakePacketInfo AS
    SELECT Participants.participantID,
      Participants.dateOfBirth AS PDoB,
      Participants.race AS PRace,
      Participants.sex AS PSex,
      People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      --Family.familyMembersID,
      --Family.formID,
      FamilyMembers.familyMemberID,
      FamilyMembers.relationship,
      FamilyMembers.dateOfBirth AS FMDoB,
      FamilyMembers.race AS FMRace,
      FamilyMembers.sex AS FMSex,
      Children.childrenID,
      Children.custody,
      Children.location AS childLocation,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
      --Forms.participantID,
      IntakeInformation.intakeInformationID,
      IntakeInformation.occupation,
      IntakeInformation.religion,
      --IntakeInformation.ethnicity,
      IntakeInformation.handicapsOrMedication,
      IntakeInformation.lastYearOfSchoolCompleted,
      IntakeInformation.hasSubstanceAbuseHistory,
      IntakeInformation.substanceAbuseDescription,
      IntakeInformation.timeSeparatedFromChildren,
      intakeinformation.timeseparatedfrompartner,
      IntakeInformation.relationshipToOtherParent,
      IntakeInformation.hasParentingPartnershipHistory,
      IntakeInformation.hasInvolvementCPS,
      IntakeInformation.previouslyInvolvedWithCPS,
      IntakeInformation.isMandatedToTakeClass,
      IntakeInformation.mandatedByWhom,
      IntakeInformation.reasonForAttendence,
      IntakeInformation.safeParticipate,
      IntakeInformation.preventativeBehaviors,
      IntakeInformation.attendedOtherParentingClasses,
      IntakeInformation.previousClassInfo,
      IntakeInformation.wasVictim,
      IntakeInformation.formOfChildhoodAbuse,
      IntakeInformation.hasHadTherapy,
      IntakeInformation.feelStillHasIssuesFromChildAbuse,
      IntakeInformation.mostImportantLikeToLearn,
      IntakeInformation.hasDomesticViolenceHistory,
      IntakeInformation.hasHistoryOfViolenceInOriginFamily,
      IntakeInformation.hasHistoryOfViolenceInNuclearFamily,
      IntakeInformation.ordersOfProtectionInvolved,
      IntakeInformation.reasonForOrdersOfProtection,
      IntakeInformation.hasBeenArrested,
      IntakeInformation.hasBeenConvicted,
      intakeinformation.reasonforarrestorconviction,
      IntakeInformation.hasJailOrPrisonRecord,
      --IntakeInformation.hasPrisonRecord,
      IntakeInformation.offenseForJailOrPrison,
      IntakeInformation.currentlyOnParole,
      IntakeInformation.onParoleForWhatOffense,
      IntakeInformation.language,
      IntakeInformation.otherFamilyTakingClass,
      IntakeInformation.familyMembersTakingClass,
      IntakeInformation.prpFormSignedDate,
      IntakeInformation.ptpEnrollmentSignedDate,
      IntakeInformation.ptpConstentReleaseFormSignedDate
    FROM 
      Participants
      INNER JOIN People 
      ON Participants.participantID = People.peopleID
      INNER JOIN FamilyMembers
      ON People.peopleID = FamilyMembers.familyMemberID
      INNER JOIN Children
      ON Children.childrenID = FamilyMembers.familyMemberID
      INNER JOIN Family
      ON Family.familyMembersID = FamilyMembers.familyMemberID
      INNER JOIN Forms
      ON Forms.formID = Family.formID
      INNER JOIN IntakeInformation
      ON Forms.formID = IntakeInformation.intakeInformationID;