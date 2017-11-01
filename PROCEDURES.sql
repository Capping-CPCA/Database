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
 * PeopleInsert
 *
<<<<<<< HEAD
 * @author Jesse Opitz, Marcos Barbieri
 */
 CREATE OR REPLACE FUNCTION PeopleInsert(fname TEXT DEFAULT NULL::text,
         lname TEXT DEFAULT NULL::text,
         mInit VARCHAR DEFAULT NULL::varchar)
         RETURNS INT AS
 $BODY$
     DECLARE
         myId INT;
     BEGIN
         INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit) RETURNING peopleID INTO myId;
         RETURN myId;
     END;
 $BODY$
     LANGUAGE plpgsql VOLATILE;
=======
 * @author John Randis
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION peopleInsert(fname TEXT DEFAULT NULL::text,
        lname TEXT DEFAULT NULL::text,
        mInit VARCHAR DEFAULT NULL::varchar)
        RETURNS VOID AS
$BODY$
    BEGIN
        INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;
>>>>>>> e0c6d16ee6beba9a8d41dde2b3c27addcc31dc5d


/**
 * ZipCodeSafeInsert
 *
 * @author Marcos Barbieri
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION zipCodeSafeInsert(INT, TEXT, StATES) RETURNS VOID AS
$func$
    DECLARE
        zip     INT    := $1;
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
 * @author Marcos Barbieri
 *
 * TESTED
 */
 -- CREATING A STORED PROCEDURE FOR UI FORMS
 -- Function: public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text)
 -- DROP FUNCTION public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text);
CREATE OR REPLACE FUNCTION registerParticipantIntake(
    fname text DEFAULT NULL::text,
    lname text DEFAULT NULL::text,
    dob date DEFAULT NULL::date,
    race text DEFAULT NULL::text,
    housenum integer DEFAULT NULL::integer,
    streetaddress text DEFAULT NULL::text,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zipcode integer DEFAULT NULL::integer,
    city text DEFAULT NULL::text,
    state text DEFAULT NULL::text,
    occupation text DEFAULT NULL::text,
    religion text DEFAULT NULL::text,
    ethnicity text DEFAULT NULL::text,
    handicapsormedication text DEFAULT NULL::text,
    lastyearschool text DEFAULT NULL::text,
    hasdrugabusehist boolean DEFAULT NULL::boolean,
    substanceabusedescr text DEFAULT NULL::text,
    timeseparatedfromchildren text DEFAULT NULL::text,
    timeseparatedfrompartner text DEFAULT NULL::text,
    relationshiptootherparent text DEFAULT NULL::text,
    hasparentingpartnershiphistory boolean DEFAULT NULL::boolean,
    hasInvolvementCPS boolean DEFAULT NULL::boolean,
    hasprevinvolvmentcps text DEFAULT NULL::text,
    ismandatedtotakeclass boolean DEFAULT NULL::boolean,
    whomandatedclass text DEFAULT NULL::text,
    reasonforattendence text DEFAULT NULL::text,
    safeparticipate text DEFAULT NULL::text,
    preventparticipate text DEFAULT NULL::text,
    hasattendedotherparenting boolean DEFAULT NULL::boolean,
    kindofparentingclasstaken text DEFAULT NULL::text,
    victimchildabuse boolean DEFAULT NULL::boolean,
    formofchildhoodabuse text DEFAULT NULL::text,
    hashadtherapy boolean DEFAULT NULL::boolean,
    stillissuesfromchildabuse boolean DEFAULT NULL::boolean,
    mostimportantliketolearn text DEFAULT NULL::text,
    hasdomesticviolencehistory boolean DEFAULT NULL::boolean,
    hasdiscusseddomesticviolence boolean DEFAULT NULL::boolean,
    hashistorychildabuseoriginfam boolean DEFAULT NULL::boolean,
    hashistoryviolencenuclearfamily boolean DEFAULT NULL::boolean,
    ordersofprotectioninvolved boolean DEFAULT NULL::boolean,
    reasonforordersofprotection text DEFAULT NULL::text,
    hasbeenarrested boolean DEFAULT NULL::boolean,
    hasbeenconvicted boolean DEFAULT NULL::boolean,
    reasonforarrestorconviction text DEFAULT NULL::text,
    hasjailrecord boolean DEFAULT NULL::boolean,
    hasprisonrecord boolean DEFAULT NULL::boolean,
    offensejailprisonrec text DEFAULT NULL::text,
    currentlyonparole boolean DEFAULT NULL::boolean,
    onparoleforwhatoffense text DEFAULT NULL::text,
    ptpmainformsigneddate date DEFAULT NULL::date,
    ptpenrollmentsigneddate date DEFAULT NULL::date,
    ptpconstentreleaseformsigneddate date DEFAULT NULL::date,
    employeeemail text DEFAULT NULL::text)
  RETURNS void AS
$BODY$
    DECLARE
        eID                       INT;
        participantID                    INT;
        adrID                            INT;
        signedDate                       DATE;
        formID                           INT;
    BEGIN
        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID FROM Employees WHERE Employees.email = employeeEmail;
        IF FOUND THEN
            eID := (SELECT Employees.employeeID FROM Employees WHERE Employees.email = employeeEmail);
            RAISE NOTICE 'employee %', eID;
            -- Now check if the participant already exists in the system
            PERFORM Participants.participantID FROM Participants
                      WHERE Participants.participantID = (SELECT People.peopleID
                                                          FROM People
                                                          WHERE People.firstName = fName AND People.lastName = lName);
            IF FOUND THEN
                participantID := (SELECT Participants.participantID FROM Participants
                                  WHERE Participants.participantID = (SELECT People.peopleID
                                                                      FROM People
                                                                      WHERE People.firstName = fName AND People.lastName = lName));
                RAISE NOTICE 'participant %', participantID;

                -- Handling anything relating to Address/Location information
                PERFORM zipCodeSafeInsert(registerParticipantIntake.zipCode, city, state);
                RAISE NOTICE 'zipCode %', (SELECT ZipCodes.zipCode FROM ZipCodes WHERE ZipCodes.city = registerParticipantIntake.city AND
                                                                                       ZipCodes.state = registerParticipantIntake.state::STATES);
                RAISE NOTICE 'Address info % % % %', houseNum, streetAddress, apartmentInfo, registerParticipantIntake.zipCode;
                INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode) VALUES (houseNum, streetAddress, apartmentInfo, registerParticipantIntake.zipCode);
                adrID := (SELECT Addresses.addressID FROM Addresses WHERE Addresses.addressNumber = registerParticipantIntake.houseNum AND
                                                                              Addresses.street = registerParticipantIntake.streetAddress AND
                                                                              --Addresses.aptInfo = registerParticipantIntake.apartmentInfo AND
                                                                              Addresses.zipCode = registerParticipantIntake.zipCode);

                -- Fill in the actual form information
                RAISE NOTICE 'address %', adrID;
                signedDate := (current_date);
                INSERT INTO Forms(addressID, employeeSignedDate, employeeID) VALUES (adrID, signedDate, eID);
                formID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                Forms.employeeSignedDate = signedDate AND
                                                                Forms.employeeID = eID);
                RAISE NOTICE 'formID %', formID;
                INSERT INTO IntakeInformation VALUES (formID,
                                                      occupation,
                                                      religion,
                                                      ethnicity,
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
                                                      hasJailRecord,
                                                      hasPrisonRecord,
                                                      offenseJailPrisonRec,
                                                      currentlyOnParole,
                                                      onParoleForWhatOffense,
                                                      ptpMainFormSignedDate,
                                                      ptpEnrollmentSignedDate,
                                                      ptpConstentReleaseFormSignedDate
                                                  );
                INSERT INTO ParticipantsFormDetails VALUES (participantID, formID);
            ELSE
                RAISE EXCEPTION 'Was not able to find participant';
            END IF;
        ELSE
            RAISE EXCEPTION 'Was not able to find employee';
        END IF;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

/**
 * Employee
 * @author Carson Badame
 *
 * Inserts a new person to the Employees table and links them with an id in the People table.
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION employeeInsert(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    em TEXT DEFAULT NULL::text,
    pPhone TEXT DEFAULT NULL::text,
    pLevel PERMISSION DEFAULT 'Coordinator'::PERMISSION)
RETURNS VOID AS
$BODY$
    DECLARE
        eID INT;
    BEGIN
        PERFORM Employees.employeeID FROM People, Employees WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = Employees.employeeID;
        IF FOUND THEN
            RAISE NOTICE 'Employee already exists.';
        ELSE
            -- Checks to see if new employee already exists in People table
            PERFORM People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit;
            -- If they do, insert link them to peopleID and insert into Employees table
            IF FOUND THEN
                eID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit= mInit);
                RAISE NOTICE 'people %', eID;
                INSERT INTO Employees(employeeID, email, primaryPhone, permissionLevel) VALUES (eID, em, pPhone, pLevel);
            -- Else create new person in People table and then insert them into Employees table
            ELSE
                INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit);
                eID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
                RAISE NOTICE 'people %', eID;
                INSERT INTO Employees(employeeID, email, primaryPhone, permissionLevel) VALUES (eID, em, pPhone, pLevel);
            END IF;
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Facilitator
 * @author Carson Badame
 *
 * Inserts a new person to the Facilitators table and links them with an id in the Employees and People tables.
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION facilitatorInsert(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    em TEXT DEFAULT NULL::text,
    pPhone TEXT DEFAULT NULL::text,
    pLevel PERMISSION DEFAULT 'Coordinator'::PERMISSION)
RETURNS VOID AS
$BODY$
    DECLARE
        fID INT;
        eReturn TEXT;
    BEGIN
    -- Check to see if the facilitator already exists
        PERFORM Facilitators.facilitatorID FROM People, Employees, Facilitators WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = Employees.employeeID AND Employees.employeeID = Facilitators.facilitatorID;
        -- If they do, do need insert anything
        IF FOUND THEN
            RAISE NOTICE 'Facilitator already exists.';
        ELSE
            -- If they do not, check to see if they exists as an employee
            PERFORM Employees.employeeID FROM Employees, People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = Employees.employeeID;
            -- If they do, then add the facilitator and link them to the employee
            IF FOUND THEN
                fID := (SELECT Employees.employeeID FROM Employees, People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = Employees.employeeID);
                RAISE NOTICE 'employee %', fID;
                INSERT INTO Facilitators(facilitatorID) VALUES (fID);
            -- If they do not, run the employeeInsert function and then add the facilitator
            ELSE
                SELECT employeeInsert(fname, lname, mInit, em, pPhone, pLevel) INTO eReturn;
                fID := (SELECT Employees.employeeID FROM Employees, People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = Employees.employeeID);
                RAISE NOTICE 'employee %', fID;
                INSERT INTO Facilitators(facilitatorID) VALUES (fID);
            END IF;
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Agency Member
 * @author John Randis and Carson Badame
 *
 * Inserts a new person to the ContactAgencyMembers table and links them with an id in the People table.
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION agencyMemberInsert(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    agen REFERRALTYPE DEFAULT NULL::referraltype,
    phn INT DEFAULT NULL::int,
    em TEXT DEFAULT NULL::text,
    isMain BOOLEAN DEFAULT NULL::boolean,
    arID INT DEFAULT NULL::int)
RETURNS VOID AS
$BODY$
    DECLARE
        caID INT;
        pReturn TEXT;
    BEGIN
    -- Check to see if the agency member already exists
        PERFORM ContactAgencyMembers.contactAgencyID FROM ContactAgencyMembers, People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit AND People.peopleID = ContactAgencyMembers.contactAgencyID;
        -- If they do, do not insert anything
        IF FOUND THEN
            RAISE NOTICE 'Agency member already exists.';
        ELSE
            -- If they do not, check to see if they exists as an a person
            PERFORM People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit;
            -- If they do, then add the agency member and link them to the employee
            IF FOUND THEN
                caID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
                RAISE NOTICE 'AgencyMember %', caID;
                INSERT INTO ContactAgencyMembers(contactAgencyID, agency, phone, email) VALUES (caID, agen, phn, em);
                INSERT INTO ContactAgencyAssociatedWithReferred(contactAgencyID, agencyReferralID, isMainContact) VALUES (caID, arID, isMain);
            -- If they do not, run create the person and then add them as an agency member
            ELSE
                INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit);
                caID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
                RAISE NOTICE 'AgencyMember %', caID;
                INSERT INTO ContactAgencyMembers(contactAgencyID, agency, phone, email) VALUES (caID, agen, phn, em);
                INSERT INTO ContactAgencyAssociatedWithReferred(contactAgencyID, agencyReferralID, isMainContact) VALUES (caID, arID, isMain);
            END IF;
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * @author John Randis and Carson Badame
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION addAgencyReferral(
  fName TEXT DEFAULT NULL::TEXT,
  lName TEXT DEFAULT NULL::TEXT,
  mInit VARCHAR DEFAULT NULL::VARCHAR,
  dob DATE DEFAULT NULL::DATE,
  race RACE DEFAULT NULL::RACE,
  gender SEX DEFAULT NULL::SEX,
  housenum INTEGER DEFAULT NULL::INTEGER,
  streetaddress TEXT DEFAULT NULL::TEXT,
  apartmentInfo TEXT DEFAULT NULL::TEXT,
  zipcode INTEGER DEFAULT NULL::INTEGER,
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
  dateOfInitialMeeting TIMESTAMP DEFAULT NULL::DATE,
  location TEXT DEFAULT NULL::TEXT,
  comments TEXT DEFAULT NULL::TEXT,
  eID INT DEFAULT NULL::INT)
  RETURNS int AS
      $BODY$
          DECLARE
              participantID		INT;
              agencyReferralID	INT;
              contactAgencyID		INT;
              adrID               INT;
              signedDate          DATE;
              formID				INT;
              participantReturn TEXT;
          BEGIN
              PERFORM Participants.participantID FROM Participants
                                    WHERE Participants.participantID = (SELECT People.peopleID
                                                                        FROM People
                                                                        WHERE People.firstName = fName AND People.lastName = lName);
              IF FOUND THEN
                participantID := (SELECT Participants.participantID FROM Participants
                                      WHERE Participants.participantID = (SELECT People.peopleID
                                                                          FROM People
                                                                          WHERE People.firstName = fName AND People.lastName = lName));
                RAISE NOTICE 'participant %', participantID;

                 -- Handling anything relating to Address/Location information
                PERFORM zipCodeSafeInsert(addAgencyReferral.zipCode, city, state);
                RAISE NOTICE 'zipCode %', addAgencyReferral.zipCode;
                RAISE NOTICE 'Address info % % % %', houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode;
                INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode) VALUES (houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode);
                adrID := (SELECT Addresses.addressID FROM Addresses WHERE Addresses.addressNumber = addAgencyReferral.houseNum AND
                                                                              Addresses.street = addAgencyReferral.streetAddress AND
                                                                              Addresses.zipCode = addAgencyReferral.zipCode);

                -- Fill in the actual form information
                RAISE NOTICE '+ %', adrID;
                RAISE NOTICE 'EID %', eID;
                signedDate := (current_date);
                INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID) VALUES (adrID, signedDate, eID, participantID);
                formID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                Forms.employeeSignedDate = signedDate AND Forms.employeeID = eID);

                RAISE NOTICE 'formID %', formID;
                INSERT INTO AgencyReferral VALUES (formID,
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
                RETURN (formID);
              ELSE
                PERFORM createParticipants(fname, lname, mInit, dob, rac, gender);
                PERFORM addAgencyReferral(fname, lname, mInit, dob, rac, gender, housenum, streetaddress, apartmentInfo, zipcode, city, state, referralReason,
                  hasAgencyConsentForm, referringAgency, referringAgencyDate, additionalInfo, hasSpecialNeeds, hasSubstanceAbuseHistory, hasInvolvementCPS, isPregnant, hasIQDoc,
                  mentalHealthIssue, hasDomesticViolenceHistory, childrenLiveWithIndividual, dateFirstContact, meansOfContact, dateOfInitialMeeting, location, comments, eID);
                formID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                Forms.employeeSignedDate = signedDate AND Forms.employeeID = eID);
                RETURN (formID);
              END IF;
          END;
      $BODY$
LANGUAGE plpgsql VOLATILE;




/**
 * @author Jesse Opitz
 *
 * Creates a family member in the database.
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION createFamilyMember(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    rel RELATIONSHIP DEFAULT NULL::relationship,
    dob DATE DEFAULT NULL::date,
    rac RACE DEFAULT NULL::race,
    gender SEX DEFAULT NULL::sex,
    -- IF child is set to True
    -- -- Inserts child information
    child BOOLEAN DEFAULT NULL::boolean,
    cust TEXT DEFAULT NULL::text,
    loc TEXT DEFAULT NULL::text,
    fID INT DEFAULT NULL::int)
RETURNS VOID AS
$BODY$
    DECLARE
        fmID INT;
        pReturn TEXT;
    BEGIN
        SELECT peopleInsert(fname, lname, mInit) INTO pReturn;
        fmID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
        RAISE NOTICE 'FamilyMember %', fmID;
        INSERT INTO FamilyMembers(familyMemberID, relationship, dateOfBirth, race, sex) VALUES (fmID, rel, dob, rac, gender);
        IF child = True THEN
          INSERT INTO Children(childrenID, custody, location) VALUES(fmID, cust, loc);
        END IF;
        INSERT INTO Family(familyMembersID, formID) VALUES (fmID, fID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;

/**
 * Participants
 * @author Jesse Opitz
 * ****STILL NEEDS TESTING****
 * Creates a participant in the correct order.
 *
 * TESTED
 */
 -- Stored Procedure for Creating Participants
DROP FUNCTION IF EXISTS createParticipants(TEXT, TEXT, VARCHAR, DATE, RACE, SEX);
CREATE OR REPLACE FUNCTION createParticipants(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    dob DATE DEFAULT NULL::date,
    rac RACE DEFAULT NULL::race,
    gender SEX DEFAULT NULL::sex)
RETURNS VOID AS
$BODY$
    DECLARE
        partID INT;
        pReturn TEXT;
    BEGIN
        SELECT peopleInsert(fname, lname, mInit) INTO partID;
        RAISE NOTICE 'people %', partID;
        INSERT INTO Participants(participantID, dateOfBirth, race, sex) VALUES (partID, dob, rac, gender);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;

/**
 * ParticipantAttendanceInsert
 *  Used for inserting the attendance record for a participant for a specific
 *  class offering
 * @returns VOID
 * @author Marcos Barbieri
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION participantAttendanceInsert(
    attendanceParticipantFName TEXT DEFAULT NULL::TEXT,
    attendanceParticipantMiddleInit TEXT DEFAULT NULL::TEXT,
    attendanceParticipantLName TEXT DEFAULT NULL::TEXT,
    attendanceParticipantSex SEX DEFAULT NULL::SEX,
    attendanceParticipantRace RACE DEFAULT NULL::RACE,
    attendanceParticipantAge INT DEFAULT NULL::INT,
    attendanceTopic TEXT DEFAULT NULL::TEXT,
    attendanceDate TIMESTAMP DEFAULT NULL::TIMESTAMP,
    attendanceSiteName TEXT DEFAULT NULL::TEXT,
    attendanceComments TEXT DEFAULT NULL::TEXT,
    attendanceNumChildren INT DEFAULT NULL::INT,
    isAttendanceNew BOOLEAN DEFAULT NULL::BOOLEAN,
    attendanceParticipantZipCode INT DEFAULT NULL::INT,
    inHouseFlag BOOLEAN DEFAULT FALSE::BOOLEAN
)
RETURNS VOID AS
$BODY$
    DECLARE
        ptpId INT;
    BEGIN
        -- Check if the class offering exists
        PERFORM ClassOffering.topicName
        FROM ClassOffering
        WHERE ClassOffering.topicName=attendanceTopic AND
            ClassOffering.date=attendanceDate AND
            ClassOffering.siteName=attendanceSiteName;
        IF NOT FOUND THEN
            RAISE NOTICE 'Creating class offering with topic name %', attendanceTopic;
            PERFORM CreateClassOffering(
                offeringTopicName := attendanceTopic::TEXT,
                offeringTopicDescription := ''::TEXT,
                offeringTopicDate := attendanceDate::TIMESTAMP,
                offeringSiteName := attendanceSiteName::TEXT,
                offeringLanguage := 'English'::TEXT,
                offeringCurriculumId := NULL::INT);
        END IF;

        -- Check if the participant exists
        PERFORM MatchedPeopleCount.count
        FROM (SELECT COUNT(ParticipantInfo.ParticipantID)
              FROM ParticipantInfo
              WHERE ParticipantInfo.firstName=attendanceParticipantFName AND
                    ParticipantInfo.middleInit=attendanceParticipantMiddleInit AND
                    ParticipantInfo.lastName=attendanceParticipantLName AND
                    ParticipantInfo.sex=attendanceParticipantSex AND
                    ParticipantInfo.race=attendanceParticipantRace AND
                    date_part('year', ParticipantInfo.dateOfBirth)=CalculateDOB(attendanceParticipantAge)) AS MatchedPeopleCount;
        IF NOT FOUND THEN
            IF (inHouseFlag IS FALSE) THEN
                PERFORM createParticipants(fname := attendanceParticipantFName::TEXT,
                    lname := attendanceParticipantLName::text,
                    mInit := attendanceParticipantMiddleInit::VARCHAR,
                    dob := make_date((date_part('year', current_date)-attendanceParticipantAge)::INT, 1, 1)::DATE,
                    rac := attendanceParticipantRace::RACE,
                    gender := attendanceParticipantSex::SEX);
            END IF;
        END IF;

        -- Finally insert the attendance information
        SELECT ParticipantInfo.ParticipantID
        INTO ptpId
        FROM ParticipantInfo
        WHERE ParticipantInfo.firstName=attendanceParticipantFName AND
              ParticipantInfo.lastName=attendanceParticipantLName AND
              ParticipantInfo.sex=attendanceParticipantSex AND
              ParticipantInfo.race=attendanceParticipantRace AND
              date_part('year', ParticipantInfo.dateOfBirth)=CalculateDOB(attendanceParticipantAge);
        -- Still need to verify that sitename and topic exist
        RAISE NOTICE 'Inserting record for participant %', ptpId;
        INSERT INTO ParticipantClassAttendance VALUES (attendanceTopic,
                                                       attendanceDate,
                                                       attendanceSiteName,
                                                       ptpId,
                                                       attendanceComments,
                                                       attendanceNumChildren,
                                                       isAttendanceNew,
                                                       attendanceParticipantZipCode);
    END
$BODY$
    LANGUAGE plpgsql VOLATILE;

/**
 * CreateClassOffering
 * Creates the class (if necessary) and the class offering for a specific course
 */
CREATE OR REPLACE FUNCTION CreateClassOffering(
    offeringTopicName TEXT DEFAULT NULL::TEXT,
    offeringTopicDescription TEXT DEFAULT NULL::TEXT,
    offeringTopicDate TIMESTAMP DEFAULT NULL::TIMESTAMP,
    offeringSiteName TEXT DEFAULT NULL::TEXT,
    offeringLanguage TEXT DEFAULT NULL::TEXT,
    offeringCurriculumId INT DEFAULT NULL::INT)
RETURNS VOID AS
$BODY$
BEGIN
    PERFORM Classes.topicName
    FROM Classes
    WHERE Classes.topicName=offeringTopicName;
    IF FOUND THEN
        PERFORM ClassOffering.topicName
        FROM ClassOffering
        WHERE ClassOffering.topicName=offeringTopicName AND
              ClassOffering.date=offeringTopicDate AND
              ClassOffering.siteName=offeringSiteName;
        IF FOUND THEN
            RAISE EXCEPTION 'Class Offering already exists --> %', offeringTopicName
                 USING HINT = 'Please check topicName, date and siteName';
        ELSE
            INSERT INTO ClassOffering VALUES (offeringTopicName, offeringTopicDate, offeringSiteName, offeringLanguage, offeringCurriculumId);
        END IF;
    ELSE
        INSERT INTO Classes VALUES (offeringTopicName, offeringTopicDescription);
        PERFORM CreateClassOffering(
            offeringTopicName := offeringTopicName::TEXT,
            offeringTopicDescription := offeringTopicDescription::TEXT,
            offeringTopicDate := offeringTopicDate::TIMESTAMP,
            offeringSiteName := offeringSiteName::TEXT,
            offeringLanguage := offeringLanguage::TEXT,
            offeringCurriculumId := offeringCurriculumId::INT);
    END IF;
END
$BODY$
    LANGUAGE plpgsql VOLATILE;

/**
 * CalculateDOB
 *  Takes the age and subtracts it from the current year to get an age estimate.
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
 * Self Referral
 * @author Carson Badame
 *
 * Inserts a new referral form to the addSelfReferral table and links them with an id in the Forms, Participants, and People tables.
 */
CREATE OR REPLACE FUNCTION addSelfReferral(
    fName TEXT DEFAULT NULL::TEXT,
    lName TEXT DEFAULT NULL::TEXT,
    mInit VARCHAR DEFAULT NULL::VARCHAR,
    dob DATE DEFAULT NULL::DATE,
    raceVal RACE DEFAULT NULL::RACE,
    sexVal SEX DEFAULT NULL::SEX,
    houseNum INTEGER DEFAULT NULL::INTEGER,
    streetAddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zip INTEGER DEFAULT NULL::INTEGER,
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
    RETURNS void AS
        $BODY$
            DECLARE
                pID                 INT;
                fID                 INT;
                adrID               INT;
                srID                INT;
                signedDate          DATE;
            BEGIN

                -- Check if the person already exists in the db
                PERFORM People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit;
                IF FOUND THEN
                    pID := (SELECT People.peopleID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
                    PERFORM * FROM Participants WHERE Participants.participantID = pID;

                    IF FOUND THEN
                        RAISE NOTICE 'participant %', pID;

                         -- Handling anything relating to Address/Location information
                        PERFORM zipcode FROM ZipCodes WHERE ZipCodes.city = cityName AND ZipCodes.state = stateName::STATES;
                        IF FOUND THEN
                          RAISE NOTICE 'Zipcode already exists.';
                        ELSE
                          INSERT INTO ZipCodes(zipcode, city, state) VALUES (zip, cityName, stateName);
                          RAISE NOTICE 'zipCode %', (SELECT zipcode FROM ZipCodes WHERE ZipCodes.city = cityName AND ZipCodes.state = stateName::STATES);
                        END IF;
                        RAISE NOTICE 'Address info % % % %', houseNum, streetAddress, apartmentInfo, zip;
                        INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode) VALUES (houseNum, streetAddress, apartmentInfo, zip);
                        adrID := (SELECT Addresses.addressID FROM Addresses WHERE Addresses.addressNumber = houseNum AND
                                                                                      Addresses.street = streetAddress AND
                                                                                      Addresses.zipCode = zip);

                        -- Fill in the actual form information
                        RAISE NOTICE '+ %', adrID;
                        signedDate := (current_date);
                        INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID) VALUES (adrID, signedDate, eID, pID);
                        fID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                        Forms.employeeSignedDate = signedDate AND Forms.employeeID = eID);

                        RAISE NOTICE 'formID %', fID;
                        INSERT INTO SelfReferral VALUES (selfReferralID,
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

                    ELSE
                        INSERT INTO Participants(participantID, dateOfBirth, race, sex) VALUES (pID, dob, raceVal, sexVal);
                        PERFORM addSelfReferral(fName, lName, mInit, dob, raceVal, sexVal, houseNum, streetAddress, apartmentInfo, zip, cityName, stateName, refSource, hasInvolvement,
                            hasAttended, reasonAttending, firstCall, returnCallDate, startDate, classAssigned, letterMailedDate, extraNotes);
                    END IF;
                ELSE
                    INSERT INTO People(firstName, lastName, middleInit) VALUES (fName, lName, mInit);
                    PERFORM addSelfReferral(fName, lName, mInit, dob, raceVal, sexVal, houseNum, streetAddress, apartmentInfo, zip, cityName, stateName, refSource, hasInvolvement,
                            hasAttended, reasonAttending, firstCall, returnCallDate, startDate, classAssigned, letterMailedDate, extraNotes);
                END IF;
            END;
        $BODY$
  LANGUAGE plpgsql VOLATILE;

/**
* CreateEmergencyContact
*   Used to create an emergency contact by other stored procedures
* @returns VOID
* @author Jesse Opitz
*/
DROP FUNCTION IF EXISTS createEmeregencyContact();
CREATE OR REPLACE FUNCTION createEmergencyContact(
    pID INT DEFAULT NULL::int,
    intInfoID INT DEFAULT NULL::int,
    rel RELATIONSHIP DEFAULT NULL::relationship,
    phon TEXT DEFAULT NULL::text
)
RETURNS VOID AS
$BODY$
    DECLARE
    BEGIN
        INSERT INTO EmergencyContacts(emergencyContactID, relationship, phone) VALUES (pID, rel, phon);
        INSERT INTO  EmergencyContactDetail(emergencyContactID, intakeInformationID) VALUES (pID, intInfoID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;

/**
* CreateCurriculum
*   Links topic to a new curriculum
* @returns VOID
* @author Jesse Opitz
* ***Will be tested with class creation***
*/
DROP FUNCTION IF EXISTS createCurriculum();
CREATE OR REPLACE FUNCTION createCurriculum(
    tnID INT DEFAULT NULL::int,
    currName TEXT DEFAULT NULL::text,
    currType PROGRAMTYPE DEFAULT NULL::programtype,
    missNum INT DEFAULT NULL::int
)
RETURNS INT AS
$BODY$
    DECLARE
    cID INT;
    BEGIN
        INSERT INTO Curricula(curriculumName, curriculumType, missNumber) VALUES (currName, currType, missNum);
        SELECT Curricula.curriculumID FROM Curricula WHERE Curriclua.curriculumName = currName AND Curricula.curriculumType = currType AND Curricula.missNumber = missNum INTO cID;
        RETURN cID;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


    /**
     * createOutOfHouseParticipant
     *  Creates a new Out of House Participant making sure all information is stored
     *  soundly.
     *
     * @author Marcos Barbieri
     */
     DROP FUNCTION IF EXISTS createOutOfHouseParticipant(TEXT, TEXT, TEXT, INT, RACE, TEXT);
     CREATE OR REPLACE FUNCTION createOutOfHouseParticipant(
        participantFirstName TEXT DEFAULT NULL::TEXT,
        participantMiddleInit TEXT DEFAULT NULL::TEXT,
        participantLastName TEXT DEFAULT NULL::TEXT,
        participantAge INT DEFAULT NULL::INT,
        participantRace RACE DEFAULT NULL::RACE,
        participantSex SEX DEFAULT NULL::SEX,
        participantDescription TEXT DEFAULT NULL::TEXT)
    RETURNS INT AS
    $BODY$
        DECLARE
            dateOfBirth DATE;
            ptpID INT;
        BEGIN
            PERFORM OutOfHouse.outOfHouseID
            FROM People
            INNER JOIN Participants
            ON People.peopleID=Participants.participantID
            INNER JOIN OutOfHouse
            ON People.peopleID=OutOfHouse.outOfHouseID
            WHERE People.firstName=participantFirstName AND
                  People.middleInit=participantMiddleInit AND
                  People.lastName=participantLastName AND
                  date_part('year', Participants.dateOfBirth)=(date_part('year', CURRENT_DATE)-participantAge) AND
                  Participants.race=participantRace AND
                  Participants.sex=participantSex;
            IF FOUND THEN
                RAISE EXCEPTION 'Participant is already in the system. Cannot duplicate.';
            ELSE
                dateOfBirth := format('%s-%s-%s', (date_part('year', CURRENT_DATE)-participantAge)::TEXT, '01', '01')::DATE;
                INSERT INTO People(firstName, middleInit, lastName) VALUES (participantFirstName, participantMiddleInit, participantLastName);
                ptpID := LASTVAL();
                INSERT INTO Participants VALUES (ptpID, dateOfBirth, participantRace, participantSex);
                INSERT INTO OutOfHouse VALUES (ptpID, participantDescription);
                RETURN ptpID;
            END IF;
        END;
    $BODY$
        LANGUAGE plpgsql VOLATILE;

/**
* CreateClass
*   Creates a class linking to a curriculum through the createCurriculum
*   stored procedure.
* @returns VOID
* @author Jesse Opitz
* *** Needs testing ***
*/

DROP FUNCTION IF EXISTS createClass();

CREATE OR REPLACE FUNCTION createClass(
    currName TEXT DEFAULT NULL::text,
    currType PROGRAMTYPE DEFAULT NULL::programtype,
    missNum INT DEFAULT NULL::int,
    topName TEXT DEFAULT NULL::text,
    classDesc TEXT DEFAULT NULL::text,
    dat TIMESTAMP DEFAULT NULL::timestamp,
    nameOfSite SITES DEFAULT NULL::sites,
    language TEXT DEFAULT NULL::text,
    currID INT DEFAULT NULL::int
)
RETURNS VOID AS
$BODY$
    BEGIN
      INSERT INTO Class(topicName, description) VALUES (topName, classDesc);
      RAISE NOTICE 'class %', topName;

      INSERT INTO ClassOffering(topicName, date, siteName, lang, curriculumID) VALUES (topName, dat, nameOfSite, language, currID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;
