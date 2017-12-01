/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All VIEW entities created to facilitate front-end and server-side queries
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 2.0
 */

-- All View Drop Statements
DROP VIEW IF EXISTS ClassAttendanceDetails;
DROP VIEW IF EXISTS FacilitatorInfo;
DROP VIEW IF EXISTS FamilyInfo;
DROP VIEW IF EXISTS CurriculumInfo;
DROP VIEW IF EXISTS ParticipantModal;
DROP VIEW IF EXISTS ContactAgencyMemberModal;
DROP VIEW IF EXISTS ParticipantInfo;
DROP VIEW IF EXISTS SelfReferralInfo;
DROP VIEW IF EXISTS AgencyReferralInfo;
DROP VIEW IF EXISTS IntakePacketInfo;

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
        ON ClassOffering.date = ParticipantClassAttendance.date AND
           ClassOffering.siteName = ParticipantClassAttendance.siteName
        LEFT JOIN Curricula
        ON Curricula.curriculumID = ClassOffering.curriculumID
        LEFT JOIN FacilitatorClassAttendance
        ON FacilitatorClassAttendance.date = ClassOffering.date AND
           FacilitatorClassAttendance.siteName = ClassOffering.siteName
        LEFT JOIN Classes
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
 * ParticipantModal
 *  Allows away for users to choose which participant they are inserting info too.
 *  Thus we create table with people, participants, addresses, and phones numbers to make the choice eaiser.
 * @author Jimmy Crowley
 */
CREATE VIEW ParticipantModal AS
    SELECT  people.*,
            participants.dateOfBirth,
            participants.race,
            participants.sex,
            formphonenumbers.phoneNumber,
            formphonenumbers.phoneType,
            addresses.addressNumber,
            addresses.aptInfo,
            addresses.street,
            zipcodes.*
    from participants
    INNER JOIN people on participants.participantid = people.peopleid
    LEFT JOIN forms on participants.participantid= forms.participantid
    LEFT JOIN formphonenumbers ON forms.formid = formphonenumbers.formid
    LEFT JOIN Addresses ON forms.addressID = Addresses.addressID
    LEFT JOIN ZipCodes ON Addresses.zipcode = ZipCodes.zipcode
    ORDER BY participants.participantid;

/**
 * ContactAgencyMemberModal
 *  Allows away for users to choose which contact agency member they are inserting info too.
 *  Thus we create table with people and contact agency member to make the choice eaiser.
 * @author Jimmy Crowley
 */
CREATE VIEW ContactAgencyMemberModal AS
    SELECT  People.*,
            ContactAgencyMembers.agency,
            ContactAgencyMembers.phone,
            ContactAgencyMembers.email
    from ContactAgencyMembers
    INNER JOIN people on ContactAgencyMembers.contactAgencyID = people.peopleid
    ORDER BY ContactAgencyMembers.contactAgencyID;

/** SelfReferralInfo
 *  Returns all information in a persons self referral form
 *  except for family family member information. That can be 
 *  retrieved from the FamilyInfo view.
 *
 * @author Jesse Opitz
 */

CREATE VIEW SelfReferralInfo AS
    SELECT Participants.participantID,
      Participants.dateOfBirth AS PDoB,
      Participants.race AS PRace,
      Participants.sex AS PSex,
      People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
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
      Participants
      INNER JOIN People
      ON Participants.participantID = People.peopleID
      INNER JOIN Forms
      ON Forms.participantID = Participants.participantID
      INNER JOIN SelfReferral
      ON Forms.formID = SelfReferral.selfReferralID;

/**
 * AgencyReferralInfo
 *  Returns all information in a persons agency referral form
 *  except for family family member information. That can be 
 *  retrieved from the FamilyInfo view.
 * 
 * @author Jesse Opitz
 */

CREATE VIEW AgencyReferralInfo AS
    SELECT Participants.participantID,
      Participants.dateOfBirth AS PDoB,
      Participants.race AS PRace,
      Participants.sex AS PSex,
      People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
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
      INNER JOIN Forms
      ON Forms.participantID = Participants.participantID
      INNER JOIN AgencyReferral
      ON Forms.formID = AgencyReferral.agencyReferralID;

/**
 * IntakePacketInfo
 *  Returns all information in a persons intake packet form
 *  except for family member information. That can be 
 *  retrieved from the FamilyInfo view.
 *
 * @author Jesse Opitz
 */

CREATE VIEW IntakePacketInfo AS
    SELECT Participants.participantID,
      Participants.dateOfBirth AS PDoB,
      Participants.race AS PRace,
      Participants.sex AS PSex,
      People.peopleID,
      People.firstName,
      People.lastName,
      People.middleInit,
      Forms.formID,
      Forms.addressID,
      Forms.employeeSignedDate,
      Forms.employeeID,
      IntakeInformation.intakeInformationID,
      IntakeInformation.occupation,
      IntakeInformation.religion,
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
      IntakeInformation.offenseForJailOrPrison,
      IntakeInformation.currentlyOnParole,
      IntakeInformation.onParoleForWhatOffense,
      IntakeInformation.language,
      IntakeInformation.otherFamilyTakingClass,
      IntakeInformation.familyMembersTakingClass,
      IntakeInformation.ptpFormSignedDate,
      IntakeInformation.ptpEnrollmentSignedDate,
      IntakeInformation.ptpConstentReleaseFormSignedDate
    FROM
      Participants
      INNER JOIN People
      ON Participants.participantID = People.peopleID
      INNER JOIN Forms
      ON Forms.participantID = Participants.participantID
      INNER JOIN IntakeInformation
      ON Forms.formID = IntakeInformation.intakeInformationID;

/**
 * relatedContactAgency
 *  Links contact agency member information to an
 *  agency referral.
 *
 * @author Jesse Opitz
 */
CREATE VIEW relatedContactAgency AS
SELECT AgencyReferral.agencyReferralID,
      ContactAgencyAssociatedWithReferred.isMainContact,
      ContactAgencyMembers.contactAgencyID,
      ContactAgencyMembers.agency,
      ContactAgencyMembers.phone,
      ContactAgencyMembers.email
FROM AgencyReferral
      INNER JOIN ContactAgencyAssociatedWithReferred
      ON ContactAgencyAssociatedWithReferred.agencyReferralID = AgencyReferral.agencyReferralID
      INNER JOIN ContactAgencyMembers
      ON ContactAgencyMembers.contactAgencyID = ContactAgencyAssociatedWithReferred.contactAgencyID;

/** 
 * participantEmergencyContactInfo
 *  Links emergency contact information to an
 *  intake packet.
 *
 * @author Jesse Opitz
 */
CREATE VIEW participantEmergencyContactInfo AS
SELECT IntakeInformation.intakeInformationID,
      EmergencyContactDetail.EmergencyContactID,
      EmergencyContacts.relationship,
      EmergencyContacts.primaryPhone
FROM IntakeInformation
      INNER JOIN EmergencyContactDetail
      ON EmergencyContactDetail.intakeInformationID = IntakeInformation.intakeInformationID
      INNER JOIN EmergencyContacts
      ON EmergencyContactDetail.EmergencyContactID = EmergencyContacts.EmergencyContactID;

/**
 * participantContactInfo
 *  Returns a participants address and phone numbers.
 * 
 * @author Jesse Opitz
 */

CREATE VIEW participantContactInfo AS
SELECT Participants.participantID,
      People.peopleID,
      Forms.formID,
      Addresses.addressID,
      Addresses.addressNumber,
      Addresses.street,
      Addresses.aptinfo,
      ZipCodes.city,
      ZipCodes.state,
      ZipCodes.zipCode,
      FormPhoneNumbers.phoneNumber,
      FormPhoneNumbers.phoneType
FROM Participants
      INNER JOIN People
      ON Participants.participantID = People.peopleID
      INNER JOIN Forms
      ON Forms.participantID = Participants.participantID
      INNER JOIN Addresses
      ON Forms.addressID = Addresses.addressID
      INNER JOIN ZipCodes
      ON Addresses.zipCode = ZipCodes.zipCode
      INNER JOIN FormPhoneNumbers
      ON Forms.formID = FormPhoneNumbers.formID;

