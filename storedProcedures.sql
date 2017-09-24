DROP FUNCTION IF EXISTS zipCodeSafeInsert(INT, TEXT, TEXT);
--DROP FUNCTION IF EXISTS registerParticipantIntake();

-- UTILITY FUNCTION FOR SAFELY INSERTING A ZIP CODE
CREATE OR REPLACE FUNCTION zipCodeSafeInsert(INT, TEXT, TEXT) RETURNS VOID AS
$$
    DECLARE
        zip     INT    := $1;
        city    TEXT   := $2;
        state   TEXT   := $3;
    BEGIN
        IF NOT EXISTS (SELECT ZipCodes.zipCode FROM ZipCodes WHERE ZipCodes.zipCode = zip) THEN
            INSERT INTO ZipCodes VALUES (zip, city, CAST(state AS STATES));
        END IF;
    END;
$$ LANGUAGE plpgsql;

-- CREATING A STORED PROCEDURE FOR UI FORMS
CREATE OR REPLACE FUNCTION registerParticipantIntake(TEXT,    -- First Name
                                                     TEXT,    -- Last Name
                                                     DATE,    -- DOB
                                                     TEXT,    -- Race
                                                     INT,     -- House Number
                                                     TEXT,    -- Street Name
                                                     INT,     -- Apartment Number (if they have one)
                                                     INT,     -- Zip Code
                                                     TEXT,    -- City
                                                     TEXT,    -- State
                                                     TEXT,    -- Occupation
                                                     TEXT,    -- Religion
                                                     TEXT,    -- Ethnicity
                                                     TEXT,    -- andicapped or Requires Medication
                                                     TEXT,    -- Last Year of School Completed/Highest Degree Earned
                                                     BOOLEAN, -- Has Drug Abuse History
                                                     TEXT,    -- Substance Abuse History Description
                                                     TEXT,    -- Time Separated from Children
                                                     TEXT,    -- Time Separated from Partner
                                                     TEXT,    -- Relationship to Other Parent
                                                     BOOLEAN, -- Has Parenting Partner History
                                                     BOOLEAN, -- Has Current Involvment with CPS
                                                     TEXT,    -- Has Previous Involvement with CPS
                                                     BOOLEAN, -- Is Mandated to Take Class
                                                     TEXT,    -- If so Who Mandated Them?
                                                     TEXT,    -- Reason for Attendance
                                                     TEXT,    -- Qualities of Class that Make Individuals Safe Participate
                                                     TEXT,    -- Behaviors that Prevent Participation
                                                     BOOLEAN, -- Has Attended Other Parenting Classes
                                                     TEXT,    -- If so What Kinds of Parenting Classes
                                                     BOOLEAN, -- Was Victim of Child Abuse
                                                     TEXT,    -- If so What Form
                                                     BOOLEAN, -- Has Had Therapy
                                                     TEXT,    -- Does the Participant feel like they still have issues from child abuse
                                                     TEXT,    -- Most Important Thing to Laern from Class
                                                     BOOLEAN, -- Has Domestic Violence History
                                                     TEXT,    -- Has Discussed Domestic Violence History
                                                     BOOLEAN, -- Has History of Abuse in Family of Origin
                                                     BOOLEAN, -- Has History of Abuse in Nuclear Family
                                                     BOOLEAN, -- Orders of Protection Involved
                                                     TEXT,    -- Reason for Order of Protection
                                                     BOOLEAN, -- Has Been Arrested
                                                     BOOLEAN, -- Has Been Convicted
                                                     TEXT,    -- Reason for Arrest/Convicted
                                                     BOOLEAN, -- Has Jail Record
                                                     BOOLEAN, -- Has Prison Record
                                                     TEXT,    -- Offense if Jail/Prison Record
                                                     BOOLEAN, -- Currently on Parole
                                                     TEXT,    -- On Parole for What Offense
                                                     DATE,    -- Participant Main Form Signed Date
                                                     DATE,    -- Participant Enrollment Form Signed Date
                                                     DATE,    -- Participant Consent Release Form Signed Date
                                                     INT      -- Employee that entered the information/signed
                                                 ) RETURNS void AS
 $$
    DECLARE
        firstName                        TEXT                  := $1;
        lastName                         TEXT                  := $2;
        dob                              DATE                  := $3;
        race                             TEXT                  := $4;
        houseNum                         INT                   := $5;
        streetAddress                    TEXT                  := $6;
        apartmentNum                     INT                   := $7;
        zipCode                          INT                   := $8;
        city                             TEXT                  := $9;
        state                            TEXT                  := $10;
        occupation                       TEXT                  := $11;
        religion                         TEXT                  := $12;
        ethnicity                        TEXT                  := $13;
        handicapsOrMedication            TEXT                  := $14;
        lastYearSchool                   TEXT                  := $15;
        hasDrugAbuseHist                 BOOLEAN               := $16;
        substanceAbuseDescr              TEXT                  := $17;
        timeSeparatedFromChildren        TEXT                  := $18;
        timeSeparatedFromPartner         TEXT                  := $19;
        relationshipToOtherParent        TEXT                  := $20;
        hasParentingPartnershipHistory   BOOLEAN               := $21;
        hasInvolvmentCPS                 BOOLEAN               := $22;
        hasPrevInvolvmentCPS             BOOLEAN               := $23;
        isMandatedToTakeClass            BOOLEAN               := $24;
        whoMandatedClass                 TEXT                  := $25;
        reasonForAttendence              TEXT                  := $26;
        safeParticipate                  TEXT                  := $27;
        preventParticipate               TEXT                  := $28;
        hasAttendedOtherParenting        BOOLEAN               := $29;
        kindOfParentingClassTaken        TEXT                  := $30;
        victimChildAbuse                 BOOLEAN               := $31;
        formOfChildhoodAbuse             TEXT                  := $32;
        hasHadTherapy                    BOOLEAN               := $33;
        stillIssuesFromChildAbuse        BOOLEAN               := $34;
        mostImportantLikeToLearn         TEXT                  := $35;
        hasDomesticViolenceHistory       BOOLEAN               := $36;
        hasDiscussedDomesticViolence     BOOLEAN               := $37;
        hasHistoryChildAbuseOriginFam    BOOLEAN               := $38;
        hasHistoryViolenceNuclearFamily  BOOLEAN               := $39;
        ordersOfProtectionInvolved       BOOLEAN               := $40;
        reasonForOrdersOfProtection      TEXT                  := $41;
        hasBeenArrested                  BOOLEAN               := $42;
        hasBeenConvicted                 BOOLEAN               := $43;
        reasonForArrestOrConviction      TEXT                  := $44;
        currentlyOnParole                BOOLEAN               := $45;
        onParoleForWhatOffense           TEXT                  := $46;
        ptpMainFormSignedDate            DATE                  := $47;
        ptpEnrollmentSignedDate          DATE                  := $48;
        ptpConstentReleaseFormSignedDate DATE                  := $49;
        employeeSigned                   INT                   := $50;

        participantID                    INT;
        adrID                            INT;
        signedDate                       DATE;
        formID                           INT;
    BEGIN
        -- First make sure that the employee is in the database. We don't want to authorize dirty inserts
        IF EXISTS (SELECT Employees.employeeID FROM Employees WHERE Employees.email = employeeEmail) THEN
            -- Now check if the participant already exists in the system
            IF EXISTS (SELECT Participants.participantID FROM Participants
                       WHERE Participants.participantID = (SELECT People.peopleID
                                                           FROM People
                                                           WHERE People.firstName = firstName AND People.lastName = lastName)) THEN
                participantID := (SELECT Participants.participantID FROM Participants
                                  WHERE Participants.participantID = (SELECT People.peopleID
                                                                      FROM People
                                                                      WHERE People.firstName = firstName AND People.lastName = lastName));

                -- Handling anything relating to Address/Location information
                SELECT zipCodeSafeInsert(zipCode, city, state);
                INSERT INTO Addresses(addressNumber, street, apt, zipCode) VALUES (houseNum, streetAddress, apartmentNum, zipCode);
                adrID := (SELECT Addresses.addressNumber FROM Addresses WHERE Addresses.addressNumber = houseNum AND
                                                                              Addresses.street = streetAddress AND
                                                                              Addresses.apt = apartmentNum AND
                                                                              Addresses.zipCode = zipCode);

                -- Fill in the actual form information
                signedDate := (current_date);
                INSERT INTO Forms(addressID, employeeSignedDate, employeeID) VALUES (adrID, signedDate, employeeSigned);
                formID := (SELECT Forms.formID FROM Forms WHERE Forms.addressID = adrID AND
                                                                Forms.employeeSignedDate = signedDate AND
                                                                Forms.employeeID = employeeSigned);
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
                                                      currentlyOnParole,
                                                      onParoleForWhatOffense,
                                                      ptpMainFormSignedDate,
                                                      ptpEnrollmentSignedDate,
                                                      ptpConstentReleaseFormSignedDate
                                                  );
            END IF;
        END IF;
    END;
$$ LANGUAGE plpgsql;
