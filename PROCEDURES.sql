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
 * PeopleInsert
 *
 * @author ?
 */
CREATE OR REPLACE FUNCTION PeopleInsert(fname TEXT DEFAULT NULL::text,
        lname TEXT DEFAULT NULL::text,
        mInit VARCHAR DEFAULT NULL::varchar)
        RETURNS VOID AS
$BODY$
    BEGIN
        INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * ZipCodeSafeInsert
 *
 * @author Marcos Barbieri
 */
CREATE OR REPLACE FUNCTION ZipCodeSafeInsert(INT, TEXT, TEXT) RETURNS VOID AS
$func$
    DECLARE
        zip     INT    := $1;
        city    TEXT   := $2;
        state   TEXT   := $3;
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
 */
 -- CREATING A STORED PROCEDURE FOR UI FORMS
 -- Function: public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text)
 -- DROP FUNCTION public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text);
CREATE OR REPLACE FUNCTION RegisterParticipantIntake(
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
    secondaryphone text DEFAULT NULL::text,
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
                                                      secondaryPhone,
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
                SELECT peopleInsert(fname, lname, mInit);
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
                SELECT employeeInsert(fname, lname, mInit, em, pPhone, pLevel);
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
                SELECT peopleInsert(firstName, lastName, middleInit);
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
 * @author John Randis
 */
CREATE OR REPLACE FUNCTION addAgencyReferral(
    fName TEXT DEFAULT NULL::TEXT,
    lName TEXT DEFAULT NULL::TEXT,
    dob DATE DEFAULT NULL::DATE,
    housenum INTEGER DEFAULT NULL::INTEGER,
    streetaddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zipcode INTEGER DEFAULT NULL::INTEGER,
    city TEXT DEFAULT NULL::TEXT,
    state TEXT DEFAULT NULL::TEXT,
    secondaryphone TEXT DEFAULT NULL::TEXT,
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
    employeeEmail TEXT DEFAULT NULL::TEXT)
    RETURNS void AS
        $BODY$
            DECLARE
                eID					INT;
                participantID		INT;
                agencyReferralID	INT;
                contactAgencyID		INT;
                adrID               INT;
                signedDate          DATE;
                formID				INT;
            BEGIN
            -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
                PERFORM verifyEmployee(employeeEmail);

                IF FOUND THEN
                    participantID := (SELECT Participants.participantID FROM Participants
                                      WHERE Participants.participantID = (SELECT People.peopleID
                                                                          FROM People
                                                                          WHERE People.firstName = fName AND People.lastName = lName));
                RAISE NOTICE 'participant %', participantID;

                 -- Handling anything relating to Address/Location information
                PERFORM zipCodeSafeInsert(addAgencyReferral.zipCode, city, state);
                RAISE NOTICE 'zipCode %', (SELECT ZipCodes.zipCode FROM ZipCodes WHERE ZipCodes.city = addAgencyReferral.city AND
                                                                                       ZipCodes.state = addAgencyReferral.state::STATES);
                RAISE NOTICE 'Address info % % % %', houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode;
                INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode) VALUES (houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode);
                adrID := (SELECT Addresses.addressID FROM Addresses WHERE Addresses.addressNumber = addAgencyReferral.houseNum AND
                                                                              Addresses.street = addAgencyReferral.streetAddress AND
                                                                              Addresses.zipCode = addAgencyReferral.zipCode);

                -- Fill in the actual form information
                RAISE NOTICE '+ %', adrID;
                signedDate := (current_date);
                INSERT INTO Forms(addressID, employeeSignedDate, employeeID) VALUES (adrID, signedDate, eID);
                formID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                Forms.employeeSignedDate = signedDate AND Forms.employeeID = eID);

                RAISE NOTICE 'formID %', formID;
                INSERT INTO AgencyReferral VALUES (formID,
                                                   secondaryPhone,
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
               ELSE
                RAISE EXCEPTION 'Was not able to find participant';
            END IF;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
COST 100;


/**
 * Family Member
 * @author Jesse Opitz
 *
 * Creates a family member in the database.
 */
CREATE OR REPLACE FUNCTION createFamilyMember(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    rel RELATIONSHIP DEFAULT NULL::relationship,
    dob DATE DEFAULT NULL::date,
    rac RACE DEFAULT NULL::race,
    gender SEX DEFAULT NULL::sex,
    formIdent INT DEFAULT NULL::int,
    -- IF child is set to True
    -- -- Inserts child information
    child BOOLEAN DEFAULT NULL::boolean,
    cust TEXT DEFAULT NULL::text,
    loc TEXT DEFAULT NULL::text)
RETURNS VOID AS
$BODY$
    DECLARE
        fmID INT;
    BEGIN
        SELECT peopleInsert(fname, lname, mInit);
        fmID := (SELECT People.personID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
        RAISE NOTICE 'people %', fmID;
        INSERT INTO FamilyMembers(familyMemberID, relationship, dateOfBirth, race, sex) VALUES (fmID, rel, dob, rac, gender);
        INSERT INTO Family(familyMemberID, formID) VALUES(fmID, formIdent);
        IF child = True THEN
        INSERT INTO Children(childrenID, custody, location) VALUES(fmID, cust, loc);
        END IF;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;

DROP FUNCTION IF EXISTS createParticipants(TEXT, TEXT, VARCHAR, RELATIONSHIP, DATE, RACE, SEX, INT, BOOLEAN, TEXT, TEXT);

/**
 * Participants
 * @author Jesse Opitz
 * ****STILL NEEDS TESTING****
 * Creates a participant in the correct order.
 */
CREATE OR REPLACE FUNCTION createParticipants(
    fname TEXT DEFAULT NULL::text,
    lname TEXT DEFAULT NULL::text,
    mInit VARCHAR DEFAULT NULL::varchar,
    dob DATE DEFAULT NULL::date,
    rac RACE DEFAULT NULL::race,
    gender SEX DEFAULT NULL::sex,
    formIdent INT DEFAULT NULL::int
    )
RETURNS VOID AS
$BODY$
    DECLARE
        partID INT;
    BEGIN
        SELECT peopleInsert(fname, lname, mInit);
        partID := (SELECT People.personID FROM People WHERE People.firstName = fname AND People.lastName = lname AND People.middleInit = mInit);
        RAISE NOTICE 'people %', partID;
        INSERT INTO Participants(participantID, dateOfBirth, race, sex) VALUES (partID, dob, rac, gender);
        INSERT INTO ParticipantFormDetails(participantID, formID) VALUES(partID, formIdent);
    END;
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
    stateName TEXT DEFAULT NULL::TEXT,
    refSource TEXT DEFAULT NULL::TEXT,
    hasInvolvement BOOLEAN DEFAULT NULL::BOOLEAN,
    hasAttended BOOLEAN DEFAULT NULL::BOOLEAN,
    reasonAttending TEXT DEFAULT NULL::TEXT,
    firstCall DATE DEFAULT NULL::DATE,
    returnCallDate DATE DEFAULT NULL::DATE,
    startDate DATE DEFAULT NULL::DATE,
    classAssigned TEXT DEFAULT NULL::TEXT,
    letterMailedDate DATE DEFAULT NULL::DATE,
    extraNotes TEXT DEFAULT NULL::TEXT)
    RETURNS void AS
        $BODY$
            DECLARE
                pID                 INT;
                fID                 INT;
                adrID               INT;
                srID                INT;
                eID                 INT;
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
                        PERFORM zipCodeSafeInsert(zip, cityName, stateName);
                        RAISE NOTICE 'zipCode %', (SELECT zip FROM ZipCodes WHERE ZipCodes.city = cityName AND
                                                                                               ZipCodes.state = stateName::STATES);
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
                        SELECT addSelfReferral(fName, lName, mInit, dob, raceVal, sexVal, houseNum, streetAddress, apartmentInfo, zip, cityName, stateName, refSource, hasInvolvement, 
                            hasAttended, reasonAttending, firstCall, returnCallDate, startDate, classAssigned, letterMailedDate, extraNotes);
                    END IF;
                ELSE
                    INSERT INTO People(firstName, lastName, middleInit) VALUES (fName, lName, mInit);
                    SELECT addSelfReferral(fName, lName, mInit, dob, raceVal, sexVal, houseNum, streetAddress, apartmentInfo, zip, cityName, stateName, refSource, hasInvolvement, 
                            hasAttended, reasonAttending, firstCall, returnCallDate, startDate, classAssigned, letterMailedDate, extraNotes);
                END IF;
            END;
        $BODY$
  LANGUAGE plpgsql VOLATILE
