/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All VIEW entities created to facilitate front-end and server-side queries
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 2.0
 */

 -- All Drop Statements For Procedures
DROP FUNCTION IF EXISTS PeopleInsert(TEXT, TEXT, VARCHAR(1));
DROP FUNCTION IF EXISTS zipCodeSafeInsert(VARCHAR(5), TEXT, STATES);
DROP FUNCTION IF EXISTS registerparticipantintake(INT, DATE, RACE, SEX, INT, TEXT, TEXT, VARCHAR(5), TEXT, STATES, TEXT, TEXT, TEXT, TEXT, BOOLEAN,
    TEXT, TEXT, TEXT, TEXT, BOOLEAN, BOOLEAN, TEXT, BOOLEAN,TEXT, TEXT, TEXT, TEXT, BOOLEAN, TEXT, BOOLEAN, TEXT, BOOLEAN, BOOLEAN, TEXT, BOOLEAN,
    BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, TEXT, BOOLEAN, BOOLEAN, TEXT, BOOLEAN, TEXT, BOOLEAN, TEXT, DATE, DATE, DATE, INT);
DROP FUNCTION IF EXISTS employeeInsert(INT, TEXT, TEXT, PERMISSION);
DROP FUNCTION IF EXISTS facilitatorInsert(INT, TEXT, TEXT, PERMISSION);
DROP FUNCTION IF EXISTS agencyMemberInsert(INT, REFERRALTYPE, TEXT, TEXT, BOOLEAN, INT);
DROP FUNCTION IF EXISTS addAgencyReferral(INT, DATE, RACE, SEX, INT, TEXT, TEXT, VARCHAR(5), TEXT, STATES, TEXT,
  BOOLEAN, TEXT, DATE, TEXT, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN, DATE, TEXT, TIMESTAMP, TEXT, TEXT, INT);
DROP FUNCTION IF EXISTS createFamilyMember(TEXT, TEXT, VARCHAR(1), RELATIONSHIP, DATE, RACE, SEX, BOOLEAN, TEXT, TEXT, INT);
DROP FUNCTION IF EXISTS attendanceInsert(INT, INT, RACE, SEX, TEXT, INT, INT, TIMESTAMP, INT, TEXT, INT, BOOLEAN, VARCHAR(5), TEXT);
--DROP FUNCTION IF EXISTS CreateClassOffering(TEXT, TEXT, TIMESTAMP, TEXT, TEXT, INT);
DROP FUNCTION IF EXISTS calculateDOB(INT);
DROP FUNCTION IF EXISTS addSelfReferral(INT, DATE, RACE, SEX, INT, TEXT, TEXT, VARCHAR(5), TEXT, STATES, TEXT, BOOLEAN, BOOLEAN, TEXT, DATE, DATE, DATE, TEXT, DATE, TEXT, INT);
DROP FUNCTION IF EXISTS createEmergencyContact(TEXT, TEXT, VARCHAR(1), INT, RELATIONSHIP, TEXT);
DROP FUNCTION IF EXISTS createOutOfHouseParticipant(INT, INT, RACE, SEX, TEXT, INT);
DROP FUNCTION IF EXISTS surveyInsert(INT, INT, INT, INT, INT, INT, INT, TEXT, TEXT, INT, INT, TIMESTAMP, TEXT);


/**
 * PeopleInsert
 *
 * @author John Randis, Marcos Barbieri
 * @tested
 */
CREATE OR REPLACE FUNCTION PeopleInsert(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::TEXT,
    mInit VARCHAR(1) DEFAULT NULL::VARCHAR(1))
RETURNS INT AS
$BODY$
    DECLARE
        myId INT;
    BEGIN
        INSERT INTO People(firstName, lastName, middleInit)
        VALUES (fname, lname, mInit)
        RETURNING peopleID INTO myId;

        RETURN myId;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * ZipCodeSafeInsert
 *
 * @author Marcos Barbieri
 * @untested
 */
CREATE OR REPLACE FUNCTION zipCodeSafeInsert(VARCHAR(5), TEXT, STATES) RETURNS VOID AS
$func$
    DECLARE
        zip     VARCHAR(5)    := $1;
        city    TEXT   := $2;
        state   STATES   := $3;
    BEGIN
        IF NOT EXISTS (SELECT ZipCodes.zipCode FROM ZipCodes WHERE ZipCodes.zipCode = zip) THEN
            INSERT INTO ZipCodes VALUES (zip, city, CAST(state AS STATES));
        END IF;
    END;
$func$ LANGUAGE plpgsql;


/**
 * RegisterParticipantIntake
 *
 * @author Marcos Barbieri, John Randis
 * @untested
 */
CREATE OR REPLACE FUNCTION registerParticipantIntake(
    intakeParticipantID INT DEFAULT NULL::INT,
    intakeParticipantDOB DATE DEFAULT NULL::DATE,
    intakeParticipantRace RACE DEFAULT NULL::RACE,
    intakeParticipantSex SEX DEFAULT NULL::SEX,
    housenum INT DEFAULT NULL::INT,
    streetaddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zipcode VARCHAR(5) DEFAULT '12601'::VARCHAR(5),
    city TEXT DEFAULT NULL::TEXT,
    state STATES DEFAULT NULL::STATES,
    occupation TEXT DEFAULT NULL::TEXT,
    religion TEXT DEFAULT NULL::TEXT,
    handicapsormedication TEXT DEFAULT NULL::TEXT,
    lastyearschool TEXT DEFAULT NULL::TEXT,
    hasdrugabusehist BOOLEAN DEFAULT NULL::BOOLEAN,
    substanceabusedescr TEXT DEFAULT NULL::TEXT,
    timeseparatedfromchildren TEXT DEFAULT NULL::TEXT,
    timeseparatedfrompartner TEXT DEFAULT NULL::TEXT,
    relationshiptootherparent TEXT DEFAULT NULL::TEXT,
    hasparentingpartnershiphistory BOOLEAN DEFAULT NULL::BOOLEAN,
    hasInvolvementCPS BOOLEAN DEFAULT NULL::BOOLEAN,
    hasprevinvolvmentcps text DEFAULT NULL::TEXT,
    ismandatedtotakeclass BOOLEAN DEFAULT NULL::BOOLEAN,
    whomandatedclass TEXT DEFAULT NULL::TEXT,
    reasonforattendence TEXT DEFAULT NULL::TEXT,
    safeparticipate TEXT DEFAULT NULL::TEXT,
    preventparticipate TEXT DEFAULT NULL::TEXT,
    hasattendedotherparenting BOOLEAN DEFAULT NULL::BOOLEAN,
    kindofparentingclasstaken TEXT DEFAULT NULL::TEXT,
    victimchildabuse BOOLEAN DEFAULT NULL::BOOLEAN,
    formofchildhoodabuse TEXT DEFAULT NULL::TEXT,
    hashadtherapy BOOLEAN DEFAULT NULL::BOOLEAN,
    stillissuesfromchildabuse BOOLEAN DEFAULT NULL::BOOLEAN,
    mostimportantliketolearn TEXT DEFAULT NULL::TEXT,
    hasdomesticviolencehistory BOOLEAN DEFAULT NULL::BOOLEAN,
    hasdiscusseddomesticviolence BOOLEAN DEFAULT NULL::BOOLEAN,
    hashistorychildabuseoriginfam BOOLEAN DEFAULT NULL::BOOLEAN,
    hashistoryviolencenuclearfamily BOOLEAN DEFAULT NULL::BOOLEAN,
    ordersofprotectioninvolved BOOLEAN DEFAULT NULL::BOOLEAN,
    reasonforordersofprotection TEXT DEFAULT NULL::TEXT,
    hasbeenarrested BOOLEAN DEFAULT NULL::BOOLEAN,
    hasbeenconvicted BOOLEAN DEFAULT NULL::BOOLEAN,
    reasonforarrestorconviction TEXT DEFAULT NULL::text,
    hasJailPrisonRecord BOOLEAN DEFAULT NULL::BOOLEAN,
    offensejailprisonrec TEXT DEFAULT NULL::TEXT,
    currentlyonparole BOOLEAN DEFAULT NULL::BOOLEAN,
    onparoleforwhatoffense TEXT DEFAULT NULL::TEXT,
    lang TEXT DEFAULT NULL::TEXT,
    ptpmainformsigneddate DATE DEFAULT NULL::DATE,
    ptpenrollmentsigneddate DATE DEFAULT NULL::DATE,
    familyMembersTakingClass BOOLEAN DEFAULT NULL::BOOLEAN,
    familyMemberNamesTakingClass TEXT DEFAULT NULL::TEXT,
    ptpconstentreleaseformsigneddate DATE DEFAULT NULL::DATE,
    eID INT DEFAULT NULL::INT)
  RETURNS INT AS
$BODY$
    DECLARE
        signedDate             DATE;
        pID                    INT;
        adrID                  INT;
        newFormID              INT;
    BEGIN
        signedDate := (SELECT current_date);

        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = eID;
        -- if the employee is not found then raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
        END IF;

        -- check if entry in People table exists
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = intakeParticipantID;
        -- abort if not found
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No person found with ID: %', intakeParticipantID;
        END IF;

        -- Now check if that person exists as a participant the system
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = intakeParticipantID;
        -- if they are not found, then go ahead and create that person
        IF FOUND THEN
            pID := (SELECT Participants.participantID FROM Participants WHERE Participants.participantID = intakeParticipantID);
            UPDATE Participants
            SET Participants.race = intakeParticipantRace,
                Participants.sex = intakeParticipantSex
            WHERE Participants.participantID = pID;
        ELSE
            INSERT INTO Participants
            VALUES (intakeParticipantID,
                    intakeParticipantDOB,
                    intakeParticipantRace,
                    intakeParticipantSex)
            RETURNING participantID INTO pID;
        END IF;

        -- Handling anything relating to Address/Location information
        PERFORM zipCodeSafeInsert(registerParticipantIntake.zipCode, city, state);
        -- Insert the listed address
        INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
        VALUES (houseNum, streetAddress, apartmentInfo, registerParticipantIntake.zipCode)
        RETURNING addressID INTO adrID;

        -- Fill in the actual form information
        RAISE NOTICE 'address %', adrID;
        INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID)
        VALUES (adrID, signedDate, eID, pID)
        RETURNING formID INTO newFormID;

        -- Finally we can create the intake information
        INSERT INTO IntakeInformation(intakeInformationID,
            occupation,
            religion,
            handicapsOrMedication,
            lastYearOfSchoolCompleted,
            hasSubstanceAbuseHistory,
            substanceAbuseDescription,
            timeSeparatedFromChildren,
            timeSeparatedFromPartner,
            relationshipToOtherParent,
            hasParentingPartnershipHistory,
            hasInvolvementCPS,
            previouslyInvolvedWithCPS,
            isMandatedToTakeClass,
            mandatedByWhom,
            reasonForAttendence,
            safeParticipate,
            preventativeBehaviors,
            attendedOtherParentingClasses,
            previousClassInfo,
            wasVictim,
            formOfChildhoodAbuse,
            hasHadTherapy,
            feelStillHasIssuesFromChildAbuse,
            mostImportantLikeToLearn,
            hasDomesticViolenceHistory,
            hasDiscussedDomesticViolence,
            hasHistoryOfViolenceInOriginFamily,
            hasHistoryOfViolenceInNuclearFamily,
            ordersOfProtectionInvolved,
            reasonForOrdersOfProtection,
            hasBeenArrested,
            hasBeenConvicted,
            reasonForArrestOrConviction,
            hasJailOrPrisonRecord,
            offenseForJailOrPrison,
            currentlyOnParole,
            onParoleForWhatOffense,
            language,
            otherFamilyTakingClass,
            familyMembersTakingClass,
            ptpFormSignedDate,
            ptpEnrollmentSignedDate,
            ptpConstentReleaseFormSignedDate)
        VALUES (newFormID,
            occupation,
            religion,
            handicapsOrMedication,
            lastYearSchool,
            hasDrugAbuseHist,
            substanceAbuseDescr,
            timeSeparatedFromChildren,
            timeSeparatedFromPartner,
            relationshipToOtherParent,
            hasParentingPartnershipHistory,
            hasInvolvementCPS,
            hasPrevInvolvmentCPS,
            isMandatedToTakeClass,
            whoMandatedClass,
            reasonForAttendence,
            safeParticipate,
            preventParticipate,
            hasAttendedOtherParenting,
            kindOfParentingClassTaken,
            victimChildAbuse,
            formOfChildhoodAbuse,
            hasHadTherapy,
            stillIssuesFromChildAbuse,
            mostImportantLikeToLearn,
            hasDomesticViolenceHistory,
            hasDiscussedDomesticViolence,
            hasHistoryChildAbuseOriginFam,
            hasHistoryViolenceNuclearFamily,
            ordersOfProtectionInvolved,
            reasonForOrdersOfProtection,
            hasBeenArrested,
            hasBeenConvicted,
            reasonForArrestOrConviction,
            hasJailPrisonRecord,
            offenseJailPrisonRec,
            currentlyOnParole,
            onParoleForWhatOffense,
            lang,
            familyMembersTakingClass,
            familyMemberNamesTakingClass,
            ptpMainFormSignedDate,
            ptpEnrollmentSignedDate,
            ptpConstentReleaseFormSignedDate);
          RETURN newformID;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

/**
 * Employee
 * Inserts a new person to the Employees table and links them with an id in the People table.
 * @author Carson Badame
 * @untested
 */
CREATE OR REPLACE FUNCTION employeeInsert(
    personID INT DEFAULT NULL::INT,
    em TEXT DEFAULT NULL::TEXT,
    pPhone TEXT DEFAULT NULL::TEXT,
    pLevel PERMISSION DEFAULT 'Coordinator'::PERMISSION)
RETURNS VOID AS
$BODY$
    DECLARE
        eID INT;
    BEGIN
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = personID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find person with ID: %', personID;
        END IF;

        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = personID;
        IF FOUND THEN
            RAISE EXCEPTION 'Employee with ID: % already exists', personID;
        ELSE
            INSERT INTO Employees
            VALUES (personID, em, pPhone, pLevel, false);
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Facilitator
 * Inserts a new person to the Facilitators table and links them with an id in the Employees and People tables.
 *
 * @author Carson Badame
 * @untested
 */
CREATE OR REPLACE FUNCTION facilitatorInsert(
    personID INT DEFAULT NULL::INT,
    em TEXT DEFAULT NULL::TEXT,
    pPhone TEXT DEFAULT NULL::TEXT,
    pLevel PERMISSION DEFAULT 'Coordinator'::PERMISSION)
RETURNS VOID AS
$BODY$
    BEGIN
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = personID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Could not find person with ID: %', personID;
        END IF;

        -- Check to see if the facilitator already exists
        PERFORM Facilitators.facilitatorID
        FROM Facilitators
        WHERE Facilitators.facilitatorID = personID;
        -- If they do, do need insert anything
        IF FOUND THEN
            RAISE EXCEPTION 'Facilitator already exists.';
        ELSE
            -- If they do not, check to see if they exists as an employee
            PERFORM Employees.employeeID
            FROM Employees
            WHERE Employees.employeeID = personID;
            -- If they do not, then add the employee
            IF NOT FOUND THEN
                PERFORM employeeInsert(personID, em, pPhone, pLevel);
            END IF;

            -- finally add the facilitator
            INSERT INTO Facilitators(facilitatorID) VALUES (personID);
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Agency Member
 * Inserts a new person to the ContactAgencyMembers table and links them with an id in the People table.
 *
 * @author John Randis, Carson Badame
 * @untested
 */
CREATE OR REPLACE FUNCTION agencyMemberInsert(
    agencyMemberID INT DEFAULT NULL::INT,
    agen REFERRALTYPE DEFAULT NULL::referraltype,
    phn TEXT DEFAULT NULL::text,
    em TEXT DEFAULT NULL::text,
    isMain BOOLEAN DEFAULT NULL::boolean,
    arID INT DEFAULT NULL::int)
RETURNS VOID AS
$BODY$
    DECLARE
        caID INT;
        pReturn TEXT;
    BEGIN
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = agencyMemberID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Could not find person with ID: %', agencyMemberID;
        END IF;

        --Check if the agency referral entity exists
        PERFORM agencyReferral.agencyReferralID
        FROM agencyReferral
        WHERE agencyReferral.agencyReferralID = arID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find a referral form with the given form ID: %', arID;
        END IF;

        -- Now check if that person exists as an agency member in the system
        PERFORM ContactAgencyMembers.contactAgencyID
        FROM ContactAgencyMembers
        WHERE ContactAgencyMembers.ContactAgencyID = agencyMemberID;
        -- if not found create the agency
        IF NOT FOUND THEN
            INSERT INTO ContactAgencyMembers(contactAgencyID, agency, phone, email) VALUES (agencyMemberID, agen, phn, em);
            RAISE NOTICE 'Agency member already exists. Associated with referral form ID: %', arID;
        END IF;

        -- finally insert the associated agency
        INSERT INTO ContactAgencyAssociatedWithReferred(contactAgencyID, agencyReferralID, isMainContact)
        VALUES (agencyMemberID, arID, isMain);
    END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/**
 * Add Agency Referral
 *
 *
 * @author John Randis, Carson Badame, Marcos Barbieri
 * @untested
 */
CREATE OR REPLACE FUNCTION addAgencyReferral(
  agencyReferralParticipantID INTEGER DEFAULT NULL::INTEGER,
  agencyReferralParticipantDateOfBirth DATE DEFAULT NULL::DATE,
  agencyReferralParticipantRace RACE DEFAULT NULL::RACE,
  agencyReferralParticipantSex SEX DEFAULT NULL::SEX,
  housenum INTEGER DEFAULT NULL::INTEGER,
  streetaddress TEXT DEFAULT NULL::TEXT,
  apartmentInfo TEXT DEFAULT NULL::TEXT,
  zipcode VARCHAR(5) DEFAULT '12601'::VARCHAR(5),
  city TEXT DEFAULT NULL::TEXT,
  state STATES DEFAULT NULL::STATES,
  referralReason TEXT DEFAULT NULL::TEXT,
  hasAgencyConsentForm BOOLEAN DEFAULT FALSE::BOOLEAN,
  referringAgency TEXT DEFAULT NULL::TEXT,
  referringAgencyDate DATE DEFAULT NULL::DATE,
  additionalInfo TEXT DEFAULT NULL::TEXT,
  hasSpecialNeeds BOOLEAN DEFAULT NULL::BOOLEAN,
  hasSubstanceAbuseHistory BOOLEAN DEFAULT NULL::BOOLEAN,
  hasInvolvementCPS BOOLEAN DEFAULT NULL::BOOLEAN,
  isPregnant BOOLEAN DEFAULT NULL::BOOLEAN,
  hasIQDoc BOOLEAN DEFAULT NULL::BOOLEAN,
  mentalHealthIssue BOOLEAN DEFAULT NULL::BOOLEAN,
  hasDomesticViolenceHistory BOOLEAN DEFAULT NULL::BOOLEAN,
  childrenLiveWithIndividual BOOLEAN DEFAULT NULL::BOOLEAN,
  dateFirstContact DATE DEFAULT NULL::DATE,
  meansOfContact TEXT DEFAULT NULL::TEXT,
  dateOfInitialMeeting TIMESTAMP DEFAULT NULL::TIMESTAMP,
  location TEXT DEFAULT NULL::TEXT,
  comments TEXT DEFAULT NULL::TEXT,
  eID INT DEFAULT NULL::INT)
RETURNS INT AS
    $BODY$
        DECLARE
            signedDate        DATE;
            agencyReferralID  INT;
            contactAgencyID   INT;
            adrID             INT;
            newformID         INT;
        BEGIN
            signedDate := (SELECT current_date);

            -- need to make sure that the person is in the database
            PERFORM People.peopleID
            FROM People
            WHERE People.peopleID = agencyReferralParticipantID;
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Was not able to find person with the following ID: %', agencyReferralParticipantID;
            END IF;

            -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
            PERFORM Employees.employeeID
            FROM Employees
            WHERE Employees.employeeID = eID;
            -- if the employee is not found then raise an exception
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
            END IF;

            -- Now check if the participant already exists in the system
            PERFORM Participants.participantID
            FROM Participants
            WHERE Participants.participantID = agencyReferralParticipantID;
            -- if they are not found, then go ahead and create that person
            IF NOT FOUND THEN
                INSERT INTO Participants
                VALUES (agencyReferralParticipantID,
                        agencyReferralParticipantDateOfBirth,
                        agencyReferralParticipantRace,
                        agencyReferralParticipantSex);
            END IF;

            -- Handling anything relating to Address/Location information
            PERFORM zipCodeSafeInsert(addAgencyReferral.zipCode, city, state);
            -- Insert the listed address
            INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
            VALUES (houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode)
            RETURNING addressID INTO adrID;

            -- Fill in the actual form information
            RAISE NOTICE 'address %', adrID;

            INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID)
            VALUES (adrID, signedDate, eID, agencyReferralParticipantID)
            RETURNING formID INTO newFormID;

            -- Insert the information into the table
            INSERT INTO AgencyReferral VALUES (newformID,
                                               referralReason,
                                               hasAgencyConsentForm,
                                               additionalInfo,
                                               hasSpecialNeeds,
                                               hasSubstanceAbuseHistory,
                                               hasInvolvementCPS,
                                               isPregnant,
                                               hasIQDoc,
                                               mentalHealthIssue,
                                               hasDomesticViolenceHistory,
                                               childrenLiveWithIndividual,
                                               dateFirstContact,
                                               meansOfContact,
                                               dateOfInitialMeeting,
                                               location,
                                               comments);
            -- Finally return the participant ID with the form ID for developer
            -- convenience
            RETURN newFormID;
          END;
      $BODY$
LANGUAGE plpgsql VOLATILE;


/**
 * Creates a family member in the database.

 * @author Jesse Opitz, John Randis
 * @untested
 */
CREATE OR REPLACE FUNCTION createFamilyMember(
    familyMemberFName TEXT DEFAULT NULL::TEXT,
    familyMemberLName TEXT DEFAULT NULL::TEXT,
    familyMemberMiddleInit VARCHAR(1) DEFAULT NULL::VARCHAR(1),
    rel RELATIONSHIP DEFAULT NULL::RELATIONSHIP,
    dob DATE DEFAULT NULL::DATE,
    race RACE DEFAULT NULL::RACE,
    sex SEX DEFAULT NULL::SEX,
    child BOOLEAN DEFAULT NULL::boolean,
    cust TEXT DEFAULT NULL::text,
    loc TEXT DEFAULT NULL::text,
    fID INT DEFAULT NULL::int)
RETURNS VOID AS
$BODY$
    DECLARE
        newFamilyMemberID INT;
    BEGIN
        newFamilyMemberID := (SELECT PeopleInsert(fname := familyMemberFName::text,
            lname := familyMemberLName::TEXT,
            mInit := familyMemberMiddleInit::VARCHAR(1)));

        -- check to see if associated form exists
        PERFORM Forms.formID
        FROM Forms
        WHERE Forms.formID = fID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find a referral or intake form with the given form ID: %', fID;
        END IF;

        -- create the family member
        INSERT INTO FamilyMembers(familyMemberID, relationship, dateOfBirth, race, sex)
        VALUES (newFamilyMemberID, rel, dob, race, sex);

        -- add to child table if they are the participant's child
        IF child = True THEN
            INSERT INTO Children(childrenID, custody, location)
            VALUES (newFamilyMemberID, cust, loc);
        END IF;

        -- Associate them with the given form
        INSERT INTO Family(familyMembersID, formID)
        VALUES (newFamilyMemberID, fID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * ParticipantAttendanceInsert
 *  Used for inserting the attendance record for a participant for a specific
 *  class offering
 * @returns VOID
 * @author Marcos Barbieri
 * @untested
 */
CREATE OR REPLACE FUNCTION public.attendanceinsert(
    attendanceparticipantid integer DEFAULT NULL::integer,
    attendantage integer DEFAULT NULL::integer,
    attendanceparticipantrace race DEFAULT NULL::race,
    attendanceparticipantsex sex DEFAULT NULL::sex,
    attendancesite text DEFAULT NULL::text,
    attendancefacilitatorid integer DEFAULT NULL::integer,
    attendanceclassid integer DEFAULT NULL::integer,
    attendancedate timestamp without time zone DEFAULT NULL::timestamp without time zone,
    attendancecurriculumid integer DEFAULT NULL::integer,
    attendancecomments text DEFAULT NULL::text,
    attendancenumchildren integer DEFAULT NULL::integer,
    isattendancenew boolean DEFAULT NULL::boolean,
    attendanceparticipantzipcode character varying DEFAULT '12601'::character varying(5),
    classofferinglang text DEFAULT 'English'::text)
  RETURNS void AS
$BODY$
    BEGIN
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = attendanceParticipantID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find person with ID: %', attendanceParticipantID;
        END IF;

        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = attendanceParticipantID;
        IF NOT FOUND THEN
            INSERT INTO Participants (participantID, dateOfBirth, race, sex)
            VALUES (attendanceParticipantID, make_date((date_part('year', current_date)-attendantAge)::INT, 1, 1)::DATE,
                    attendanceParticipantRace, attendanceParticipantSex);
        ELSE
            -- we should probably update the information if we find that its NULL

            PERFORM Participants.dateOfbirth
            FROM Participants
            WHERE Participants.participantID = attendanceParticipantID AND
                  Participants.dateOfBirth != NULL;
            IF FOUND THEN
                UPDATE Participants
                SET dateOfBirth = make_date((date_part('year', current_date)-attendantAge))::INT
                WHERE Participants.participantID = attendanceParticipantID AND
                      Participants.dateOfBirth IS NULL;
            END IF;

            PERFORM Participants.race
            FROM Participants
            WHERE Participants.participantID = attendanceParticipantID AND
                  Participants.race != NULL;
            IF FOUND THEN
                UPDATE Participants
                SET race = attendanceParticipantRace
                WHERE Participants.participantID = attendanceParticipantID AND
                      Participants.race IS NULL;
            END IF;

            PERFORM Participants.sex
            FROM Participants
            WHERE Participants.participantID = attendanceParticipantID AND
                  Participants.sex != NULL;
            IF FOUND THEN
                UPDATE Participants
                SET sex = attendanceParticipantSex
                WHERE Participants.participantID = attendanceParticipantID AND
                      Participants.sex IS NULL;
            END IF;
        END IF;

        -- check if a site is found
        PERFORM Sites.siteName
        FROM Sites
        WHERE Sites.siteName = attendanceSite;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Site % provided does not exist', attendanceSite;
        END IF;

        -- first we need to check that the curriculum is created.
        -- we do not allow the creation of a curriculum through attendance
        -- curriculums should be created before the class runs
        PERFORM Curricula.curriculumID
        FROM Curricula
        WHERE Curricula.curriculumID = attendanceCurriculumID;
        -- if we don't find it, raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Curriculum: % not found', attendanceCurriculumID;
        END IF;

        -- now we need to check that the course exists in the system
        PERFORM Classes.classID
        FROM Classes
        WHERE Classes.classID = attendanceClassID;
        -- if we don't find the class, raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Class: % not found', attendanceClassID;
        END IF;

        PERFORM *
        FROM CurriculumClasses
        WHERE CurriculumClasses.curriculumID = attendanceCurriculumID AND
            CurriculumClasses.classID = attendanceClassID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find Class ID % linked to Curriculum ID %',
                attendanceClassID, attendanceCurriculumID;
        END IF;

        -- now check that the facilitator being registered exists
        PERFORM Facilitators.facilitatorID
        FROM Facilitators
        WHERE Facilitators.facilitatorID = attendanceFacilitatorID;
        -- If we don't find it we need to raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Facilitator with facilitatorID: % does not exist',
                attendanceFacilitatorID;
        END IF;

        -- Now we need to check if the Class offering that we are registering exists
        PERFORM ClassOffering.classID
        FROM ClassOffering
        WHERE ClassOffering.classID = attendanceClassID AND
            ClassOffering.date = attendanceDate AND
            ClassOffering.curriculumID = attendanceCurriculumID AND
            ClassOffering.siteName = attendanceSite;
        -- if it isn't found lets create it
        IF NOT FOUND THEN
            -- we will call our stored procedure for this.
            -- this way we can shorten this one and make more checks within the
            -- CreateClassOffering one
            INSERT INTO ClassOffering
            VALUES (attendanceClassID,
                attendanceCurriculumID,
                attendanceDate,
                attendanceSite,
                classOfferingLang);
        END IF;

        -- Now we need to make sure that we didn't already register the
        -- facilitator's attendance
        PERFORM *
        FROM FacilitatorClassAttendance
        WHERE FacilitatorClassAttendance.date = attendanceDate AND
              FacilitatorClassAttendance.siteName = attendanceSite AND
              FacilitatorClassAttendance.facilitatorID = attendanceFacilitatorID;
        -- if we don't find it then we need to register that facilitator's attendance
        IF NOT FOUND THEN
            INSERT INTO FacilitatorClassAttendance
            VALUES (attendanceDate,
                    attendanceFacilitatorID,
                    attendanceSite);
        END IF;

        -- now we need to check if the participant exists
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = attendanceParticipantID;
        -- if we don't find the participant lets go ahead and create it
        IF NOT FOUND THEN
            -- this is tricky because we only want to create-if-not-found when we are
            -- dealing with out of house participants. In-house participant should be
            -- created through the creation of a referral/intake
            INSERT INTO Participants VALUES (attendanceParticipantID,
                                             make_date((date_part('year', current_date)-attendantAge)::INT, 1, 1)::DATE,
                                             attendanceParticipantRace,
                                             attendanceParticipantSex);
        END IF;

        -- Still need to verify that sitename and topic exist
        RAISE NOTICE 'Inserting record for participant %', attendanceParticipantID;
        INSERT INTO ParticipantClassAttendance VALUES (attendanceDate,
            attendanceParticipantID,
            attendanceComments,
            attendanceNumChildren,
            isAttendanceNew,
            attendanceParticipantZipCode,
            attendanceSite);
    END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

/**
 * CreateClassOffering
 * Creates the class (if necessary) and the class offering for a specific course
 * @donotuse REDUNDANT
 */
/*CREATE OR REPLACE FUNCTION CreateClassOffering(
    offeringTopicName TEXT DEFAULT NULL::TEXT,
    offeringTopicDescription TEXT DEFAULT NULL::TEXT,
    offeringTopicDate TIMESTAMP DEFAULT NULL::TIMESTAMP,
    offeringCurriculum TEXT DEFAULT NULL::TEXT,
    offeringLanguage TEXT DEFAULT NULL::TEXT,
    offeringCurriculumId INT DEFAULT NULL::INT)
RETURNS VOID AS
$BODY$
BEGIN
    -- first we need to check that the curriculum is created.
    PERFORM Curricula.curriculumName
    FROM Curricula
    WHERE Curricula.curriculumName = attendanceCurriculum;
    -- if we don't find it, raise an exception
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Curriculum: % not found', attendanceCurriculum;
    END IF;

    -- now we need to check that the course exists in the system
    PERFORM Classes.topicName
    FROM Classes
    WHERE Classes.topicName = attendanceTopic;
    -- if we don't find the class, raise an exception
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Class: % not found', attendanceTopic;
    END IF;

    -- insert the necessary data into the ClassOffering table
    INSERT INTO ClassOffering VALUES (offeringTopicName, offeringTopicDate, offeringCurriculum, offeringLanguage, offeringCurriculumId);
END
$BODY$
    LANGUAGE plpgsql VOLATILE; */


/**
 * CalculateDOB
 *  Takes the age and subtracets it from the current year to get an age estimate.
 *  The reason we do this is because the PEP program only asks for age on certain
 *  forms, and not DOB. However, age should never be stored, only DOB, so we must
 *  calculate this manually.
 *
 * @author Marcos Barbieri
 *
 * TESTED
 */
 CREATE OR REPLACE FUNCTION calculateDOB(age INT DEFAULT NULL::INT)
 RETURNS INT AS
 $BODY$
    DECLARE
        currentYear INT := date_part('year', CURRENT_DATE);
        dob INT;
    BEGIN
        dob := currentYear - age;
        RETURN dob;
    END
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Inserts a new referral form to the addSelfReferral table and links them with an id in the Forms, Participants, and People tables.
 *
 * @author Carson Badame, John Randis
 * @untested
 */
CREATE OR REPLACE FUNCTION addSelfReferral(
    referralParticipantID INT DEFAULT NULL::INT,
    referralDOB DATE DEFAULT NULL::DATE,
    referralRace RACE DEFAULT NULL::RACE,
    referralSex SEX DEFAULT NULL::SEX,
    houseNum INT DEFAULT NULL::INT,
    streetAddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zip VARCHAR(5) DEFAULT '12601'::VARCHAR(5),
    cityName TEXT DEFAULT NULL::TEXT,
    stateName STATES DEFAULT NULL::STATES,
    refSource TEXT DEFAULT NULL::TEXT,
    hasInvolvement BOOLEAN DEFAULT NULL::BOOLEAN,
    hasAttended BOOLEAN DEFAULT NULL::BOOLEAN,
    reasonAttending TEXT DEFAULT NULL::TEXT,
    firstCall DATE DEFAULT NULL::DATE,
    returnCallDate DATE DEFAULT NULL::DATE,
    startDate DATE DEFAULT NULL::DATE,
    classAssigned TEXT DEFAULT NULL::TEXT,
    letterMailedDate DATE DEFAULT NULL::DATE,
    extraNotes TEXT DEFAULT NULL::TEXT,
    eID INT DEFAULT NULL::INT)
RETURNS INT AS
$BODY$
    DECLARE
        fID                 INT;
        adrID               INT;
        srID                INT;
        signedDate          DATE;
    BEGIN
        signedDate := (current_date);

        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = referralParticipantID;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find person with ID: %', referralParticipantID;
        END IF;

        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = eID;
        -- if the employee is not found then raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
        END IF;

        -- now check if the participant already exists in the system
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = referralParticipantID;
        -- if they are not found, then go ahead and create that person
        IF NOT FOUND THEN
            INSERT INTO Participants
            VALUES (referralParticipantID,
                    referralDOB,
                    referralRace,
                    referralSex);
        END IF;

        -- Handling anything relating to Address/Location information
        PERFORM zipCodeSafeInsert(zip, cityName, stateName);
        -- Insert the listed address
        INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
        VALUES (houseNum, streetAddress, apartmentInfo, zip)
        RETURNING addressID INTO adrID;
        -- Fill in the actual form information
        RAISE NOTICE 'address %', adrID;

        INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID)
        VALUES (adrID, signedDate, eID, referralParticipantID)
        RETURNING formID INTO fID;
        RAISE NOTICE 'formID %',fID;

        INSERT INTO SelfReferral VALUES (fID,
                                         refSource,
                                         hasInvolvement,
                                         hasAttended,
                                         reasonAttending,
                                         firstCall,
                                         returnCallDate,
                                         startDate,
                                         classAssigned,
                                         letterMailedDate,
                                         extraNotes);

        RETURN fID;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
* CreateEmergencyContact
*   Used to create an emergency contact by other stored procedures
* @returns VOID
* @author Jesse Opitz
* @untested
*/
CREATE OR REPLACE FUNCTION createEmergencyContact(
    emerContactFName TEXT DEFAULT NULL::TEXT,
    emerContactLName TEXT DEFAULT NULL::TEXT,
    emerContactMiddleInit VARCHAR(1) DEFAULT NULL::VARCHAR(1),
    intInfoID INT DEFAULT NULL::int,
    rel RELATIONSHIP DEFAULT NULL::relationship,
    phon TEXT DEFAULT NULL::text
)
RETURNS VOID AS
$BODY$
    DECLARE
        pID INT;
    BEGIN
        INSERT INTO People(firstName, lastName, middleInit)
        VALUES (emerContactFName,
            emerContactLName,
            emerContactMiddleInit)
        RETURNING peopleID INTO pID;

        -- we don't want checks just insert every time because we said so
        INSERT INTO EmergencyContacts(emergencyContactID, relationship, primaryphone)
        VALUES (pID, rel, phon);

        INSERT INTO  EmergencyContactDetail(emergencyContactID, intakeInformationID)
        VALUES (pID, intInfoID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * createOutOfHouseParticipant
 *  Creates a new Out of House Participant making sure all information is stored
 *  soundly.
 *
 * @returns INT
 * @author Marcos Barbieri, John Randis
 * @untested
 */
CREATE OR REPLACE FUNCTION createOutOfHouseParticipant(
    outOfHouseParticipantId INT DEFAULT NULL::INT,
    participantAge INT DEFAULT NULL::INT,
    participantRace RACE DEFAULT NULL::RACE,
    participantSex SEX DEFAULT NULL::SEX,
    participantDescription TEXT DEFAULT NULL::TEXT,
    eID INT DEFAULT NULL::INT)
RETURNS VOID AS
$BODY$
    BEGIN
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = outOfHouseParticipantId;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', outOfHouseParticipantId;
        END IF;

        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = eID;
        -- if the employee is not found then raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
        END IF;

        -- now check if the participant already exists in the system
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = outOfHouseParticipantId;
        IF NOT FOUND THEN
            INSERT INTO Participants
            VALUES (outofHouseParticipantId,
                make_date((date_part('year', current_date)-participantAge)::INT, 1, 1)::DATE,
                participantRace,
                participantSex);
        ELSE
            -- now check if the participant already exists in the system
            PERFORM OutOfHouse.outOfHouseID
            FROM OutOfHouse
            WHERE OutOfHouse.outOfHouseID = outOfHouseParticipantId;
            IF FOUND THEN
                RAISE EXCEPTION 'Out-of-House Participant with ID: % already exists', outOfHouseParticipantId;
            END IF;
        END IF;

        INSERT INTO OutOfHouse
        VALUES (outOfHouseParticipantId, participantDescription);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Survey Insert
 *
 * @return VOID
 * @author Marcos Barbieri and Carson Badame
 * @untested
 */
 CREATE OR REPLACE FUNCTION surveyInsert(
    surveyParticipantName TEXT DEFAULT NULL::TEXT,
    surveyMaterialPresentedScore INT DEFAULT NULL::INT,
    surveyPresTopicDiscussedScore INT DEFAULT NULL::INT,
    surveyPresOtherParentsScore INT DEFAULT NULL::INT,
    surveyPresChildPerspectiveScore INT DEFAULT NULL::INT,
    surveyPracticeInfoScore INT DEFAULT NULL::INT,
    surveyRecommendScore INT DEFAULT NULL::INT,
    surveySuggestedFutureTopics TEXT DEFAULT NULL::TEXT,
    surveyComments TEXT DEFAULT NULL::TEXT,
    surveyStartTime TIMESTAMP DEFAULT NULL::TIMESTAMP,
    surveySiteName TEXT DEFAULT NULL::TEXT,
    firstWeek BOOLEAN DEFAULT NULL::BOOLEAN,
    topicName TEXT DEFAULT NULL::TEXT,
    gender SEX DEFAULT NULL::SEX,
    race RACE DEFAULT NULL::RACE,
    ageGroup TEXT DEFAULT NULL::TEXT
 )
 RETURNS VOID AS
 $BODY$
    DECLARE
        surveyClassID INT;
    BEGIN
        -- check if a site is found
        PERFORM Sites.siteName
        FROM Sites
        WHERE Sites.siteName = surveySiteName;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Site % provided does not exist', surveySiteName;
        END IF;

        -- now we need to check that the course exists in the system
        PERFORM Classes.classID
        FROM Classes
        WHERE Classes.topicName = surveyInsert.topicName;
        -- if we don't find the class, raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Class: % not found', surveyInsert.topicName;
        ELSE
            surveyClassID := (SELECT Classes.classID FROM Classes WHERE Classes.topicName = surveyInsert.topicName);
        END IF;

        -- Now we need to check if the Class offering that we are registering exists
        PERFORM ClassOffering.classID
        FROM ClassOffering
        WHERE ClassOffering.classID = surveyClassID AND
            ClassOffering.date = surveyStartTime AND
            ClassOffering.siteName = surveySiteName;
        -- if it isn't raise an exception
        IF NOT FOUND THEN
            INSERT INTO ClassOffering (date, siteName) VALUES(surveyStartTime, surveySiteName);
        END IF;

        -- Still need to verify that sitename and topic exist
        RAISE NOTICE 'Inserting record for participant %', surveyParticipantName;
        INSERT INTO Surveys (participantName, materialPresentedScore, presTopicDiscussedScore, presOtherParentsScore, presChildPerspectiveScore, practiceInfoScore, recommendScore,
                             suggestedFutureTopics, comments, startTime, siteName, firstWeek, topicName, gender, race, ageGroup)
        VALUES (surveyParticipantName,
            surveyMaterialPresentedScore,
            surveyPresTopicDiscussedScore,
            surveyPresOtherParentsScore,
            surveyPresChildPerspectiveScore,
            surveyPracticeInfoScore,
            surveyRecommendScore,
            surveySuggestedFutureTopics,
            surveyComments,
            surveyStartTime,
            surveySiteName,
            firstWeek,
            surveyInsert.topicName,
            gender,
            race,
            ageGroup);
    END
 $BODY$
    LANGUAGE plpgsql VOLATILE;


/**
* Address Update
*
* @return VOID
* @author Carson Badame
*
*/
CREATE OR REPLACE FUNCTION addressUpdate(
  pID INT DEFAULT NULL::INT,
  newAddressNumber INT DEFAULT NULL::INT,
  newAptInfo TEXT DEFAULT NULL::TEXT,
  newStreet TEXT DEFAULT NULL::TEXT,
  newZipcode VARCHAR(5) DEFAULT NULL::VARCHAR(5),
  newCity TEXT DEFAULT NULL::TEXT,
  newState STATES DEFAULT NULL::STATES
)
RETURNS VOID AS
$BODY$
    DECLARE
        zipKey VARCHAR(5);
        addrID INT;
    BEGIN
        -- Grabs the addressID associated with the participant
        addrID := (SELECT Addresses.addressID 
                      FROM People, Participants, Forms, Addresses 
                      WHERE People.peopleID = pID
                      AND People.peopleID = Participants.participantID 
                      AND Participants.participantID = Forms.participantID 
                      AND Forms.addressID = Addresses.addressID);
        -- Checks to see if inserted zipcode already exists
        PERFORM Zipcodes.zipcode 
                FROM Zipcodes 
                WHERE Zipcodes.zipcode = newZipcode 
                AND Zipcodes.city = newCity 
                AND Zipcodes.state = newState;
        -- If it does, then update the address info and set the zipcode fk to the found zipcode
        IF FOUND THEN
            zipKey := (SELECT Zipcodes.zipcode 
                       FROM Zipcodes 
                       WHERE Zipcodes.zipcode = newZipcode 
                       AND Zipcodes.city = newCity 
                       AND Zipcodes.state = newState);
            UPDATE Addresses
            SET addressNumber = newAddressNumber,
                aptInfo = newAptInfo,
                street = newStreet,
                zipcode = zipKey
            WHERE addressID = addrID;
        -- If it does not, then insert the new zipcode info, then update the address info and set the zipcode fk to the new zipcode
        ELSE
            PERFORM zipCodeSafeInsert(newZipcode, newCity, newState);
            zipKey := (SELECT Zipcodes.zipcode 
                       FROM Zipcodes 
                       WHERE Zipcodes.zipcode = newZipcode 
                       AND Zipcodes.city = newCity 
                       AND Zipcodes.state = newState);
            UPDATE Addresses 
            SET addressNumber = newAddressNumber,
                aptInfo = newAptInfo,
                street = newStreet,
                zipcode = zipKey
            WHERE addressID = addrID;
        END IF;
    END
$BODY$
    LANGUAGE plpgsql VOLATILE;
