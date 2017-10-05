DROP FUNCTION IF EXISTS zipCodeSafeInsert(INT, TEXT, TEXT);
--DROP FUNCTION IF EXISTS registerParticipantIntake();

-- UTILITY FUNCTION FOR SAFELY INSERTING A ZIP CODE
CREATE OR REPLACE FUNCTION zipCodeSafeInsert(INT, TEXT, TEXT) RETURNS VOID AS
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

-- CREATING A STORED PROCEDURE FOR UI FORMS
-- Function: public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text)

-- DROP FUNCTION public.registerparticipantintake(text, text, date, text, integer, text, integer, integer, text, text, text, text, text, text, text, text, boolean, text, text, text, text, boolean, boolean, text, boolean, text, text, text, text, boolean, text, boolean, text, boolean, boolean, text, boolean, boolean, boolean, boolean, boolean, text, boolean, boolean, text, boolean, boolean, text, boolean, text, date, date, date, text);

CREATE OR REPLACE FUNCTION registerparticipantintake(
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
    hasinvolvmentcps boolean DEFAULT NULL::boolean,
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
                                                      hasInvolvmentCPS,
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


--Stored Procedure for Creating Employees

CREATE OR REPLACE FUNCTION employeeInsert(
	fname TEXT DEFAULT NULL::text,
	lname TEXT DEFAULT NULL::text,
	mInit VARCHAR DEFAULT NULL::varchar,
	em TEXT DEFAULT NULL::text, 
	pPhone TEXT DEFAULT NULL::text, 
	pLevel PERMISSION DEFAULT NULL::PERMISSION) 
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
