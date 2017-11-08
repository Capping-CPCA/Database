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
 * @author John Randis, Marcos Barbieri
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


/**
 * ZipCodeSafeInsert
 *
 * @author Marcos Barbieri
 *
 * TESTED
 */
CREATE OR REPLACE FUNCTION zipCodeSafeInsert(INT, TEXT, STATES) RETURNS VOID AS
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
 * @author Marcos Barbieri, John Randis
 *
 * @untested
 */
DROP FUNCTION IF EXISTS registerparticipantintake(
    INT,
    DATE,
    RACE,
    SEX,
    INT,
    TEXT,
    TEXT,
    INT,
    TEXT,
    STATES,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    BOOLEAN,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    BOOLEAN,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    BOOLEAN,
    BOOLEAN,
    BOOLEAN,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    BOOLEAN,
    text,
    BOOLEAN,
    BOOLEAN,
    TEXT,
    BOOLEAN,
    TEXT,
    DATE,
    DATE,
    DATE,
    INT
    );
CREATE OR REPLACE FUNCTION registerParticipantIntake(
    intakeParticipantID INT DEFAULT NULL::INT,
    intakeParticipantDOB DATE DEFAULT NULL::DATE,
    intakeParticipantRace RACE DEFAULT NULL::RACE,
    intakeParticipantSex SEX DEFAULT NULL::SEX,
    housenum INT DEFAULT NULL::INT,
    streetaddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zipcode INT DEFAULT 12601::INT,
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
    hasjailrecord BOOLEAN DEFAULT NULL::BOOLEAN,
    hasprisonrecord BOOLEAN DEFAULT NULL::BOOLEAN,
    offensejailprisonrec TEXT DEFAULT NULL::TEXT,
    currentlyonparole BOOLEAN DEFAULT NULL::BOOLEAN,
    onparoleforwhatoffense TEXT DEFAULT NULL::TEXT,
    ptpmainformsigneddate DATE DEFAULT NULL::DATE,
    ptpenrollmentsigneddate DATE DEFAULT NULL::DATE,
    ptpconstentreleaseformsigneddate DATE DEFAULT NULL::DATE,
    eID INT DEFAULT NULL::INT)
  RETURNS INT AS
$BODY$
    DECLARE
        pID                    INT;
        adrID                            INT;
        signedDate                       DATE;
        newFormID                           INT;
    BEGIN
        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = eID;
        -- if the employee is not found then raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
        END IF;
        
        --Check if person exists in the system 
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = intakeParticipantID;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', intakeParticipantID;
        END IF;

        -- Now check if that person exists as a participant the system
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = intakeParticipantID;
        -- if they are not found, then go ahead and create that person
        IF FOUND THEN
            pID := (SELECT Participants.participantID FROM Participants WHERE Participants.participantID = intakeParticipantID);
        ELSE
            INSERT INTO Participants VALUES (intakeParticipantID,
                                            intakeParticipantDOB,
                                            intakeParticipantRace,
                                            intakeParticipantSex) RETURNING participantID INTO pID;
        END IF;

       
          -- Handling anything relating to Address/Location information
          PERFORM zipCodeSafeInsert(registerParticipantIntake.zipCode, city, state);
          -- Insert the listed address
          INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
          VALUES (houseNum, streetAddress, apartmentInfo, registerParticipantIntake.zipCode)
          RETURNING addressID INTO adrID;

          -- Fill in the actual form information
          RAISE NOTICE 'address %', adrID;
          signedDate := (current_date);
          INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID) VALUES (adrID, signedDate, eID, pID) RETURNING formID INTO newFormID;
        

        -- Finally we can create the intake information
        INSERT INTO IntakeInformation VALUES (newFormID,
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
                                              hasJailRecord,
                                              hasPrisonRecord,
                                              offenseJailPrisonRec,
                                              currentlyOnParole,
                                              onParoleForWhatOffense,
                                              ptpMainFormSignedDate,
                                              ptpEnrollmentSignedDate,
                                              ptpConstentReleaseFormSignedDate
                                          );
          RETURN newformID;
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
                INSERT INTO People(firstName, lastName, middleInit) VALUES (fname, lname, mInit) RETURNING peopleID INTO eID;
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
                SELECT employeeInsert(fname, lname, mInit, em, pPhone, pLevel) INTO fID;
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
    agencyMemberID INT DEFAULT NULL::INT,
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
    
        --Check if person exists in the system 
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = agencyMemberID;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', agencyMemberID;
        END IF;
        
        --Check if the agency referral entity exists
        PERFORM agencyReferral.agencyReferralID
        FROM agencyReferral
        WHERE agencyReferral.agencyReferralID = arID;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find a referral form with the given form ID: %', agencyMemberID;
        END IF;
        
        -- Now check if that person exists as an agency member in the system
        PERFORM ContactAgencyMembers.contactAgencyID FROM ContactAgencyMembers WHERE ContactAgencyMembers.ContactAgencyID = agencyMemberID;
        IF FOUND THEN --Do not create a new agencyMember, but associate the existing one with the person being referred
        	INSERT INTO ContactAgencyAssociatedWithReferred(contactAgencyID, agencyReferralID, isMainContact) VALUES (agencyMemberID, arID, isMain);
            RAISE NOTICE 'Agency member already exists. Associated with referral form ID: %', arID ;
        ELSE
        	-- If they do not, run create the person as an agency member and associate them with the referred individual
            INSERT INTO ContactAgencyMembers(contactAgencyID, agency, phone, email) VALUES (agencyMemberID, agen, phn, em);
            INSERT INTO ContactAgencyAssociatedWithReferred(contactAgencyID, agencyReferralID, isMainContact) VALUES (agencyMemberID, arID, isMain);
        END IF;
        
    END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/**
 * @author John Randis, Carson Badame, Marcos Barbieri
 * @untested
 */
CREATE OR REPLACE FUNCTION addAgencyReferral(
  agencyReferralParticipantID INTEGER DEFAULT NULL::INTEGER,
  agencyReferralParticipantDateOfBirth DATE DEFAULT NULL::DATE,
  housenum INTEGER DEFAULT NULL::INTEGER,
  streetaddress TEXT DEFAULT NULL::TEXT,
  apartmentInfo TEXT DEFAULT NULL::TEXT,
  zipcode INTEGER DEFAULT 12601::INTEGER,
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
RETURNS INT AS
    $BODY$
        DECLARE
            newparticipantID   INT;
            agencyReferralID  INT;
            contactAgencyID   INT;
            adrID               INT;
            signedDate          DATE;
            newformID        INT;
            participantReturn TEXT;
        BEGIN
            -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
            PERFORM Employees.employeeID
            FROM Employees
            WHERE Employees.employeeID = eID;
            -- if the employee is not found then raise an exception
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
            END IF;
            
            PERFORM People.peopleID
            FROM People
            WHERE People.peopleID = agencyReferralParticipantID;
            IF NOT FOUND THEN 
			    RAISE EXCEPTION 'Was not able to find person with the following ID: %', agencyReferralParticipantID;
            END IF;
                
            -- Now check if the participant already exists in the system
            PERFORM Participants.participantID
            FROM Participants
            WHERE Participants.participantID = agencyReferralParticipantID;
            -- if they are not found, then go ahead and create that person
            IF FOUND THEN
                newparticipantID := (SELECT Participants.participantID FROM Participants WHERE Participants.participantID = agencyReferralParticipantID);
            ELSE
                INSERT INTO Participants VALUES (agencyReferralParticipantID,
                                                 agencyReferralParticipantDateOfBirth,
                                                 NULL,
                                                 NULL) RETURNING participantID INTO newparticipantID;
            END IF;

            -- Now we need to check if a Forms entity was made for the participant
            /*PERFORM Forms.formID
            FROM Forms
            WHERE Forms.participantID = agencyReferralParticipantID;
            -- if not found go ahead and create the form (perhaps we should put this
            -- in a function for modularity)
            IF FOUND THEN
                newFormID := (SELECT Forms.formID FROM Forms WHERE Forms.participantID = agencyReferralParticipantID);
            ELSE*/
                -- Handling anything relating to Address/Location information
                PERFORM zipCodeSafeInsert(addAgencyReferral.zipCode, city, state);
                -- Insert the listed address
                INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
                VALUES (houseNum, streetAddress, apartmentInfo, addAgencyReferral.zipCode)
                RETURNING addressID INTO adrID;

                -- Fill in the actual form information
                RAISE NOTICE 'address %', adrID;
                signedDate := (current_date);

                INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID) VALUES (adrID, signedDate, eID, agencyReferralParticipantID) RETURNING formID INTO newFormID;
            --END IF;

            -- Assign values to declared variables
            signedDate := (current_date);
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

 * @author Jesse Opitz and John Randis
 * @untested
 */
CREATE OR REPLACE FUNCTION createFamilyMember(
    familyID INT DEFAULT NULL::INT,
    rel RELATIONSHIP DEFAULT NULL::RELATIONSHIP,
    dob DATE DEFAULT NULL::DATE,
    race RACE DEFAULT NULL::RACE,
    gender SEX DEFAULT NULL::SEX,
    -- IF child is set to True
    -- -- Inserts child information
    child BOOLEAN DEFAULT NULL::boolean,
    cust TEXT DEFAULT NULL::text,
    loc TEXT DEFAULT NULL::text,
    fID INT DEFAULT NULL::int)
RETURNS VOID AS
$BODY$
    DECLARE
        pReturn INT;
    BEGIN        
        --Check to see if person exists
        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = familyID;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', familyID;
        END IF;
        
        --Check to see if associated form exists
        PERFORM Forms.formID
        FROM Forms
        WHERE Forms.formID = fID;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find a referral or intake form with the given form ID: %', familyID;
        END IF;
        
        --Create the family member
        INSERT INTO FamilyMembers(familyMemberID, relationship, dateOfBirth, race, sex) VALUES (familyID, rel, dob, race, gender);
        
        --Add to child table if they are the participant's child
        IF child = True THEN
          INSERT INTO Children(childrenID, custody, location) VALUES(familyID, cust, loc);
        END IF;
        
        --Associate them with the given form
        INSERT INTO Family(familyMembersID, formID) VALUES (familyID, fID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
 * Creates a participant in the correct order.
 *
 * @author Jesse Opitz
 * @untested
 */
 -- Stored Procedure for Creating Participants
DROP FUNCTION IF EXISTS createParticipants(TEXT, TEXT, VARCHAR, DATE, SEX, RACE);
CREATE OR REPLACE FUNCTION createParticipants(
    fname TEXT DEFAULT NULL::TEXT,
    lname TEXT DEFAULT NULL::TEXT,
    mInit VARCHAR DEFAULT NULL::VARCHAR,
    dob DATE DEFAULT NULL::DATE,
    gender SEX DEFAULT NULL::SEX,
    RACE RACE DEFAULT NULL::RACE)
RETURNS VOID AS
$BODY$
    DECLARE
        partID INT;
        myID	INT;
        pReturn TEXT;
    BEGIN
        SELECT peopleInsert(fname, lname, mInit) INTO partID;
        RAISE NOTICE 'people %', partID;
        INSERT INTO Participants(participantID, dateOfBirth, race, sex) VALUES (partID, dob, race, gender);
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
CREATE OR REPLACE FUNCTION attendanceInsert(
    attendanceParticipantID INT DEFAULT NULL::INT,
    attendantFirstName TEXT DEFAULT NULL::TEXT,
    attendantLastName TEXT DEFAULT NULL::TEXT,
    attendantMiddleInit VARCHAR DEFAULT NULL::VARCHAR,
    attendantAge INT DEFAULT NULL::INT,
    attendanceParticipantRace RACE DEFAULT NULL::RACE,
    attendanceParticipantSex SEX DEFAULT NULL:: SEX,
    attendanceFacilitatorID INT DEFAULT NULL::INT,
    attendanceTopic TEXT DEFAULT NULL::TEXT,
    attendanceDate TIMESTAMP DEFAULT NULL::TIMESTAMP,
    attendanceCurriculum TEXT DEFAULT NULL::TEXT,
    attendanceComments TEXT DEFAULT NULL::TEXT,
    attendanceNumChildren INT DEFAULT NULL::INT,
    isAttendanceNew BOOLEAN DEFAULT NULL::BOOLEAN,
    attendanceParticipantZipCode INT DEFAULT NULL::INT,
    inHouseFlag BOOLEAN DEFAULT FALSE::BOOLEAN
)
RETURNS VOID AS
$BODY$
    BEGIN
        -- first we need to check that the curriculum is created.
        -- we do not allow the creation of a curriculum through attendance
        -- curriculums should be created before the class runs
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
        PERFORM ClassOffering.topicName
        FROM ClassOffering
        WHERE ClassOffering.topicName=attendanceTopic AND
            ClassOffering.date=attendanceDate AND
            ClassOffering.siteName=attendanceSiteName;
        -- if it isn't found lets create it
        IF NOT FOUND THEN
            -- we will call our stored procedure for this.
            -- this way we can shorten this one and make more checks within the
            -- CreateClassOffering one
            PERFORM CreateClassOffering(
                offeringTopicName := attendanceTopic::TEXT,
                offeringTopicDescription := ''::TEXT,
                offeringTopicDate := attendanceDate::TIMESTAMP,
                attendanceCurriculum := attendanceCurriculum::TEXT,
                offeringLanguage := 'English'::TEXT,
                offeringCurriculumId := NULL::INT);
        END IF;

        -- Now we need to make sure that we didn't already register the
        -- facilitator's attendance
        PERFORM *
        FROM FacilitatorClassAttendance
        WHERE FacilitatorClassAttendance.topicName = attendanceTopic AND
              FacilitatorClassAttendance.date = attendanceDate AND
              FacilitatorClassAttendance.curriculumName = attendanceCurriculum AND
              FacilitatorClassAttendance.facilitatorID = attendanceFacilitatorID;
        -- if we don't find it then we need to register that facilitator's attendance
        IF NOT FOUND THEN
            INSERT INTO FacilitatorClassAttendance
            VALUES (attendanceTopic,
                    attendanceDate,
                    attendanceCurriculum,
                    attendanceFacilitatorID);
        END IF;

        -- now we need to check if the participant exists
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = attendanceParticipantID;
        -- if we don't find the participant lets go ahead and create it
        IF FOUND THEN
            -- this is tricky because we only want to create-if-not-found when we are
            -- dealing with out of house participants. In-house participant should be
            -- created through the creation of a referral/intake
            IF inHouseFlag IS FALSE THEN
                INSERT INTO Participants VALUES (attendanceParticipantID,
                                                 make_date((date_part('year', current_date)-attendantAge)::INT, 1, 1)::DATE,
                                                 attendanceParticipantRace,
                                                 attendanceParticipantSex);
            END IF;
        END IF;

        -- Still need to verify that sitename and topic exist
        RAISE NOTICE 'Inserting record for participant %', attendanceParticipantID;
        INSERT INTO ParticipantClassAttendance VALUES (attendanceTopic,
                                                       attendanceDate,
                                                       attendanceCurriculum,
                                                       attendanceParticipantID,
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
    LANGUAGE plpgsql VOLATILE;


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
 * @author Carson Badame
 * @tested
 */
CREATE OR REPLACE FUNCTION addSelfReferral(
    referralParticipantID INT DEFAULT NULL::INT,
    referralDOB DATE DEFAULT NULL::DATE,
    houseNum INT DEFAULT NULL::INT,
    streetAddress TEXT DEFAULT NULL::TEXT,
    apartmentInfo TEXT DEFAULT NULL::TEXT,
    zip INT DEFAULT NULL::INT,
    cityName TEXT DEFAULT NULL::TEXT,
    stateName STATES DEFAULT NULL::STATES,
    phoneNum TEXT DEFAULT NULL::TEXT,
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
RETURNS VOID AS
$BODY$
    DECLARE
        fID                 INT;
        adrID               INT;
        srID                INT;
        signedDate          DATE;
    BEGIN
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
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', agencyReferralParticipantID;
        END IF;

        -- now we need to check if a Forms entity was made for the participant
        PERFORM Forms.formID
        FROM Forms
        WHERE Forms.participantID = referralParticipantID;
        -- if not found go ahead and create the form (perhaps we should put this
        -- in a function for modularity)
        IF FOUND THEN
            fID := (SELECT Forms.formID FROM Forms WHERE Forms.participantID = referralParticipantID);
        ELSE
            -- Handling anything relating to Address/Location information
            PERFORM zipCodeSafeInsert(zip, cityName, stateName);
            -- Insert the listed address
            INSERT INTO Addresses(addressNumber, street, aptInfo, zipCode)
            VALUES (houseNum, streetAddress, apartmentInfo, zip)
            RETURNING addressID INTO adrID;

            -- Fill in the actual form information
            RAISE NOTICE 'address %', adrID;
            signedDate := (current_date);
            INSERT INTO Forms(addressID, employeeSignedDate, employeeID, participantID) VALUES (adrID, signedDate, eID, referralParticipantID) RETURNING formID INTO fID;
            RAISE NOTICE 'formID %',fID;
            INSERT INTO FormPhoneNumbers(formID, phoneNumber, phoneType) VALUES (fID, phoneNum, 'Primary');

        END IF;

        INSERT INTO SelfReferral VALUES (  fID,
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
        INSERT INTO EmergencyContacts(emergencyContactID, relationship, primaryphone) VALUES (pID, rel, phon);
        INSERT INTO  EmergencyContactDetail(emergencyContactID, intakeInformationID) VALUES (pID, intInfoID);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;


/**
* CreateCurriculum
*   Links topic to a new curriculum
* @returns VOID
* @author Jesse Opitz
* @untested
*/
DROP FUNCTION IF EXISTS createCurriculum();
CREATE OR REPLACE FUNCTION createCurriculum(
    tnID INT DEFAULT NULL::INT,
    currName TEXT DEFAULT NULL::TEXT,
    currType PROGRAMTYPE DEFAULT NULL::PROGRAMTYPE,
    missNum INT DEFAULT NULL::INT)
RETURNS INT AS
$BODY$
    DECLARE
        cID INT;
    BEGIN
        INSERT INTO Curricula(curriculumName, curriculumType, missNumber) VALUES (currName, currType, missNum) RETURNING curriculumID INTO cID;
        RETURN cID;
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
DROP FUNCTION IF EXISTS createOutOfHouseParticipant(INT, TEXT, INT);
CREATE OR REPLACE FUNCTION createOutOfHouseParticipant(
    outOfHouseParticipantId INT DEFAULT NULL::INT,
    participantAge INT DEFAULT NULL::INT,
    participantRace RACE DEFAULT NULL::RACE,
    participantSex SEX DEFAULT NULL::SEX,
    participantDescription TEXT DEFAULT NULL::TEXT,
    eID INT DEFAULT NULL::INT)
RETURNS INT AS
$BODY$
    DECLARE
        dateOfBirth DATE;
        pID INT;
        fID INT;
        dob DATE;
    BEGIN
        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        PERFORM Employees.employeeID
        FROM Employees
        WHERE Employees.employeeID = eID;
        -- if the employee is not found then raise an exception
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Was not able to find employee with the following ID: %', eID;
        END IF;

        PERFORM People.peopleID
        FROM People
        WHERE People.peopleID = outOfHouseParticipantId;
        IF NOT FOUND THEN 
            RAISE EXCEPTION 'Was not able to find person with the following ID: %', outOfHouseParticipantId;
        END IF;

        -- now check if the participant already exists in the system
        PERFORM Participants.participantID
        FROM Participants
        WHERE Participants.participantID = outOfHouseParticipantId;
        IF FOUND THEN
            RAISE EXCEPTION 'Participant already exists. %', outOfHouseParticipantId;
        END IF;

        -- now check if the participant already exists in the system
        PERFORM OutOfHouse.outOfHouseID
        FROM OutOfHouse
        WHERE OutOfHouse.outOfHouseID = outOfHouseParticipantId;
        IF FOUND THEN
            RAISE EXCEPTION 'Out-of-House Participant with ID: % already exists', outOfHouseParticipantId;
        END IF;

        
	--SELECT calculateDOB (participantAge) INTO dob;
	INSERT INTO Participants VALUES (outofHouseParticipantId, NULL, participantRace, participantSex);
        INSERT INTO OutOfHouse VALUES (outOfHouseParticipantId, participantDescription);
        SELECT registerParticipantIntake( intakeParticipantID := outOfHouseParticipantId::INT, eID := 1::INT) INTO fID;
        RETURN fID;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;
    

/**
* CreateClass
*   Creates a class linking to a curriculum through the createCurriculum
*   stored procedure.
* @returns VOID
* @author Jesse Opitz, Marcos Barbieri
* @untested
*/
DROP FUNCTION IF EXISTS createClass();
CREATE OR REPLACE FUNCTION createClass(
    className TEXT DEFAULT NULL::TEXT,
    classDescription TEXT DEFAULT NULL::TEXT,
    classCurriculumName TEXT DEFAULT NULL::TEXT)
RETURNS VOID AS
$BODY$
    BEGIN
        -- first we need to check that the curriculum is created
        PERFORM *
        FROM Curricula
        WHERE Curricula.curriculumName = classCurriculumName;
        -- if we don't find it should we create it ? I don't think so
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Curriculum: % was not found', classCurriculumName
                USING HINT = 'Please create a curriculum with the given name';
        END IF;

        -- now we need to check that the class isn't already created
        PERFORM *
        FROM Classes
        WHERE Classes.topicName = className AND
              Classes.description = classDescription;
        IF FOUND THEN
            RAISE EXCEPTION 'A class with the same name and description already exists';
        END IF;

        INSERT INTO Classes VALUES (className, classDescription, 0);
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE;
