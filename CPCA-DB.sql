DROP TABLE IF EXISTS "Referral";
DROP TABLE IF EXISTS "FacilitatorLanguage";
DROP TABLE IF EXISTS "Family";
DROP TABLE IF EXISTS "FamilyMembers";
DROP TABLE IF EXISTS "ContactAgencyAssociatedWithReffered";
DROP TABLE IF EXISTS "ContactAgencyMembers";
DROP TABLE IF EXISTS "EmergencyContactDetail";
DROP TABLE IF EXISTS "EmergencyContacts";
DROP TABLE IF EXISTS "ReferredLanguages";
DROP TABLE IF EXISTS "Referred";
DROP TABLE IF EXISTS "Referring";
DROP TABLE IF EXISTS "FacilitatorClassAttendance";
DROP TABLE IF EXISTS "ParticipantClassAttendance";
DROP TABLE IF EXISTS "CurriculumClasses";
DROP TABLE IF EXISTS "Curricula";
DROP TABLE IF EXISTS "ClassOffering";
DROP TABLE IF EXISTS "Languages";
DROP TABLE IF EXISTS "Class";
DROP TABLE IF EXISTS "Addresses";
DROP TABLE IF EXISTS "ParticipantRehabSite";
DROP TABLE IF EXISTS "Rehab";
DROP TABLE IF EXISTS "Sites";
DROP TABLE IF EXISTS "ZipCode";
DROP TABLE IF EXISTS "FamilyMembers";
DROP TABLE IF EXISTS "Facilitators";
DROP TABLE IF EXISTS "Employees";
DROP TABLE IF EXISTS "Participants";
DROP TABLE IF EXISTS "People";

DROP TYPE IF EXISTS RACE;
DROP TYPE IF EXISTS SEX;
DROP TYPE IF EXISTS FORM;
DROP TYPE IF EXISTS REFERRALTYPE;
DROP TYPE IF EXISTS CURRICULUMTYPE;
DROP TYPE IF EXISTS SITES;
DROP TYPE IF EXISTS LEVELTYPE;


CREATE TYPE RACE AS ENUM('Asian', 'Black', 'Latino', 'Native American', 'Pacific Islander', 'White');
CREATE TYPE SEX AS ENUM ('Male', 'Female');
CREATE TYPE FORM AS ENUM ('Intake', 'Referral');
CREATE TYPE REFERRALTYPE AS ENUM ('Self', 'Court', 'Agency', 'Friend', 'Family');
CREATE TYPE CURRICULUMTYPE AS ENUM ('FULL', 'MINI');
CREATE TYPE LEVELTYPE AS ENUM ('PRIMARY', 'SECONDARY');

--
CREATE TABLE IF NOT EXISTS "People" (
  "peopleID" INT,
  "firstName" TEXT NOT NULL,
  "lastName" TEXT NOT NULL,
  PRIMARY KEY ("peopleID")
);

--
CREATE TABLE IF NOT EXISTS "Participants" (
  "participantID" INT references "People" ("peopleID"),
  "dateOfBirth" DATE NOT NULL,
  "race" RACE NOT NULL,
  PRIMARY KEY ("participantID")
);

--
CREATE TABLE IF NOT EXISTS "Employees" (
  "employeeID" INT references "People" ("peopleID"),
  "email" TEXT,
  "primaryPhone" TEXT,
  "permissionLevel" TEXT,
  PRIMARY KEY ("employeeID")
);

--
CREATE TABLE IF NOT EXISTS "Facilitators" (
  "facilitatorID" INT REFERENCES "People" ("peopleID"),
  "program" TEXT,
  PRIMARY KEY ("facilitatorID")
);

--
CREATE TABLE IF NOT EXISTS "ZipCode" (
  "zipCode" INT,
  "city" TEXT,
  "state" TEXT,
  PRIMARY KEY ("zipCode")
);

--
CREATE TABLE IF NOT EXISTS "Sites" (
  "siteName" TEXT,
  PRIMARY KEY ("siteName")
);

--
CREATE TABLE IF NOT EXISTS "Rehab" (
  "rehabID" INT,
  "description" TEXT,
  PRIMARY KEY ("rehabID"),
  FOREIGN KEY ("rehabID") REFERENCES "Participants" ("participantID") 
);

--
CREATE TABLE IF NOT EXISTS "ParticipantRehabSite" (
  "rehabID" INT,
  "siteName" TEXT,
  PRIMARY KEY ("rehabID", "siteName"),
  FOREIGN KEY ("rehabID") REFERENCES "Rehab" ("rehabID"),
  FOREIGN KEY ("siteName") REFERENCES "Sites" ("siteName")
);

--
CREATE TABLE IF NOT EXISTS "Addresses" (
  "addressID" INT,
  "addressNumber" INT,
  "street" TEXT,
  "zipCode" INT references "ZipCode" ("zipCode"),
  PRIMARY KEY ("addressID")
);

--
CREATE TABLE IF NOT EXISTS "Class" (
  "topicName" TEXT,
  "description" TEXT,
  PRIMARY KEY ("topicName")
);

--
CREATE TABLE IF NOT EXISTS "Languages" (
  "lang" TEXT,
  PRIMARY KEY ("lang")
);

--
CREATE TABLE IF NOT EXISTS "ClassOffering" (
  "topicName" TEXT,
  "date" TIMESTAMP,
  "siteName" TEXT,
  "lang" TEXT,
  PRIMARY KEY ("topicName", "date", "siteName"),
  FOREIGN KEY ("topicName") REFERENCES "Class" ("topicName"),
  FOREIGN KEY ("siteName") REFERENCES "Sites" ("siteName"),
  FOREIGN KEY ("lang") REFERENCES "Languages" ("lang")
);

--
CREATE TABLE IF NOT EXISTS "Curricula" (
  "curriculumID" INT,
  "name" TEXT,
  "type" CURRICULUMTYPE,
  PRIMARY KEY ("curriculumID")
);

--
CREATE TABLE IF NOT EXISTS "CurriculumClasses" (
  "topicName" TEXT,
  "curriculumID" INT,
  PRIMARY KEY ("topicName", "curriculumID"),
  FOREIGN KEY ("topicName") REFERENCES "Class" ("topicName"),
  FOREIGN KEY ("curriculumID") REFERENCES "Curricula" ("curriculumID")
);

--
CREATE TABLE IF NOT EXISTS "ParticipantClassAttendance" (
  "topicName" TEXT,
  "date" TIMESTAMP,
  "siteName" TEXT,
  "participantID" INT,
  PRIMARY KEY("topicName", "date", "siteName", "participantID"),
  FOREIGN KEY("topicName", "date", "siteName") REFERENCES "ClassOffering"("topicName", "date", "siteName"),
  FOREIGN KEY("participantID") REFERENCES "Participants"("participantID")
);

--
CREATE TABLE IF NOT EXISTS "FacilitatorClassAttendance" (
  "topicName" TEXT,
  "date" TIMESTAMP,
  "siteName" TEXT,
  "facilitatorID" INT,
  PRIMARY KEY("topicName", "date", "siteName", "facilitatorID"),
  FOREIGN KEY("topicName", "date", "siteName") REFERENCES "ClassOffering"("topicName", "date", "siteName"),
  FOREIGN KEY("facilitatorID") REFERENCES "Facilitators"("facilitatorID")
);

--
CREATE TABLE IF NOT EXISTS "Referring" (
  "referringID" INT,
  "type" REFERRALTYPE,
  "email" TEXT,
  "phone" TEXT,
  PRIMARY KEY ("referringID"), 
  FOREIGN KEY ("referringID") REFERENCES "People" ("peopleID")
);

--
CREATE TABLE IF NOT EXISTS "Referred" (
  "referredID" INT,
  "addressID" INT,
  "primaryPhone" TEXT,
  "canLeavePrimaryPhoneMessage" BOOLEAN,
  "secondaryPhone" TEXT,
  "canLeaveSecondaryPhoneMessage" BOOLEAN,
  "specificNeeds" TEXT,
  "hasSpecialEducationHistory" BOOLEAN,
  "hasSubstanceAbuseHistory" BOOLEAN,
  "substanceAbuseDescription" TEXT,
  "isInvolvedWithPreventiveServices" BOOLEAN,
  "isPregnant" BOOLEAN,
  "hasMentalHealthIssues" BOOLEAN,
  "hasDomesticViolenceHistory" BOOLEAN,
  "childResidesWithIndividual" BOOLEAN,
  "hasIQDocumentation" BOOLEAN,
  "numPeopleInHousehold" INT,
  "occupation" TEXT,
  "religion" TEXT,
  "ethnicity" TEXT,
  "handicapsOrMedication" TEXT,
  "lastYearOfSchoolCompleted" TEXT,
  "timeSeparatedFromChildren" TEXT,
  "timeSeparatedFromPartner" TEXT,
  "relationshipToOtherParent" TEXT,
  "currentlyInvolvedWithCPS" TEXT,
  "previouslyInvolvedWithCPS" TEXT,
  "isMandatedToTakeClass" BOOLEAN,
  "reasonForAttendence" TEXT,
  "safeParticipate" TEXT,
  "preventativeBehaviors" TEXT,
  "attendedOtherParentingClasses" TEXT,
  "previousClassInfo" TEXT,
  "wasVictim" BOOLEAN,
  "formOfChildhoodAbuse" TEXT,
  "hasHadTherapy" BOOLEAN,
  "feelStillHasIssuesFromChildAbuse" TEXT,
  "mostImportantLikeToLearn" TEXT,
  "hadInvolvementWithDomesticViolence" TEXT,
  "hasDiscussedDomesticViolence" TEXT,
  "hasHistoryOfViolenceInOriginFamily" BOOLEAN,
  "hasHistoryOfViolenceInNuclearFamily" BOOLEAN,
  "ordersOfProtectionInvolved" BOOLEAN,
  "reasonForOrdersOfProtection" TEXT,
  "hasBeenArrested" BOOLEAN,
  "hasBeenConvicted" BOOLEAN,
  "reasonForArrest/Conviction" TEXT,
  "hasJailRecord" BOOLEAN,
  "hasPrisonRecord" BOOLEAN,
  "offenseForJailOrPrison" TEXT,
  "currentlyOnParole" TEXT,
  "onParoleForWhatOffense" TEXT,
  "hasOtherFamilyMembersTakingClass" BOOLEAN,
  "namesOfFamilyMembersTakingClass" TEXT,
  "clientSignature" TEXT,
  "clientSignatuerDate" DATE,
  "staffWitness" INT,
  "staffWitnessSignatureDate" DATE,
  PRIMARY KEY ("referredID"),
  FOREIGN KEY ("referredID") REFERENCES "People" ("peopleID"),
  FOREIGN KEY ("addressID") REFERENCES "Addresses" ("addressID"),
  FOREIGN KEY ("staffWitness") REFERENCES "Employees" ("employeeID")
);

--
CREATE TABLE IF NOT EXISTS "ReferredLanguages" (
  "referredID" INT,
  "lang" TEXT,
  PRIMARY KEY("referredID", "lang"),
  FOREIGN KEY("referredID") REFERENCES "Referred"("referredID"),
  FOREIGN KEY("lang") REFERENCES "Languages"("lang")
);

--
CREATE TABLE IF NOT EXISTS "EmergencyContacts" (
  "emergencyContactID" INT,
  "relationship" TEXT,
  "phone" TEXT,
  PRIMARY KEY("emergencyContactID"),
  FOREIGN KEY("emergencyContactID") REFERENCES "People"("peopleID")
);

--
CREATE TABLE IF NOT EXISTS "EmergencyContactDetail" (
  "emergencyContactID" INT,
  "referredID" INT,
  PRIMARY KEY("emergencyContactID", "referredID"),
  FOREIGN KEY("emergencyContactID") REFERENCES "EmergencyContacts"("emergencyContactID"),
  FOREIGN KEY("referredID") REFERENCES "Referred"("referredID")
);

--
CREATE TABLE IF NOT EXISTS "ContactAgencyMembers" (
  "contactAgencyID" INT,
  "agency" TEXT,
  "phone" INT,
  PRIMARY KEY ("contactAgencyID"),
  FOREIGN KEY ("contactAgencyID") REFERENCES "People" ("peopleID")
);

--
CREATE TABLE IF NOT EXISTS "ContactAgencyAssociatedWithReffered" (
  "contactAgencyID" INT,
  "referredID" INT,
  PRIMARY KEY("contactAgencyID", "referredID"),
  FOREIGN KEY("contactAgencyID") REFERENCES "ContactAgencyMembers"("contactAgencyID"),
  FOREIGN KEY("referredID") REFERENCES "Referred"("referredID")
);

--
CREATE TABLE IF NOT EXISTS "FamilyMembers" (
  "memberID" INT,
  "relation" TEXT,
  "age" DATE,
  "race" RACE,
  "sex" SEX,
  "form" FORM,
  PRIMARY KEY ("memberID"),
  FOREIGN KEY ("memberID") REFERENCES "People" ("peopleID")
);

--
CREATE TABLE IF NOT EXISTS "Family" (
  "memberID" INT,
  "referredID" INT,
  "formType" FORM,
  PRIMARY KEY("memberID", "referredID"),
  FOREIGN KEY("memberID") REFERENCES "FamilyMembers"("memberID"),
  FOREIGN KEY("referredID") REFERENCES "Referred"("referredID")
);

--
CREATE TABLE IF NOT EXISTS "FacilitatorLanguage" (
  "facilitatorID" INT,
  "lang" TEXT,
  "level" LEVELTYPE,
  PRIMARY KEY ("facilitatorID", "lang"),
  FOREIGN KEY ("facilitatorID") REFERENCES "Facilitators" ("facilitatorID"),
  FOREIGN KEY ("lang") REFERENCES "Languages" ("lang")
);

--
CREATE TABLE IF NOT EXISTS "Referral" (
  "referringID" INT,
  "referredID" INT,
  "reason" TEXT,
  "dateReferred" DATE,
  "meansOfContact" TEXT,
  "dateOfInitialMeet" DATE,
  "employeeID" INT,
  "siteName" TEXT,
  "comments" TEXT,
  PRIMARY KEY ("referringID", "referredID"),
  FOREIGN KEY ("referringID") REFERENCES "Referring" ("referringID"),
  FOREIGN KEY ("referredID") REFERENCES "Referred" ("referredID"),
  FOREIGN KEY ("employeeID") REFERENCES "Employees" ("employeeID")
);
