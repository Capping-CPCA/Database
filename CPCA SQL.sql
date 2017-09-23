------------------------------------
--         Drop Statements        --
------------------------------------
DROP TABLE IF EXISTS EmergencyContactDetail;
DROP TABLE IF EXISTS ParticipantsIntakeLanguages;
DROP TABLE IF EXISTS Family;
DROP TABLE IF EXISTS ContactAgencyAssociatedWithReferred;
DROP TABLE IF EXISTS IntakeInformation;
DROP TABLE IF EXISTS Surveys;
DROP TABLE IF EXISTS AgencyReferral;
DROP TABLE IF EXISTS SelfReferral;
DROP TABLE IF EXISTS ParticipantsFormDetails;
DROP TABLE IF EXISTS FormPhoneNumbers;
DROP TABLE IF EXISTS Forms;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS ZipCode;
DROP TABLE IF EXISTS ParticipantOutOfHouseSite;
DROP TABLE IF EXISTS FacilitatorLangugage;
DROP TABLE IF EXISTS ParticipantClassAttendance;
DROP TABLE IF EXISTS FacilitatorClassAttendance;
DROP TABLE IF EXISTS ClassOffering;
DROP TABLE IF EXISTS CurriculumClasses;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Curricula;
DROP TABLE IF EXISTS Sites;
DROP TABLE IF EXISTS Languages;
DROP TABLE IF EXISTS ContactAgencyMembers;
DROP TABLE IF EXISTS EmergencyContacts;
DROP TABLE IF EXISTS Children;
DROP TABLE IF EXISTS FamilyMembers;
DROP TABLE IF EXISTS OutOfHouse;
DROP TABLE IF EXISTS Participants;
DROP TABLE IF EXISTS Facilitators;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS People;

DROP TYPE IF EXISTS RELATIONSHIP;
DROP TYPE IF EXISTS PARENTINGPROGRAM;
DROP TYPE IF EXISTS PROGRAMTYPE;
DROP TYPE IF EXISTS PHONETYPE;
DROP TYPE IF EXISTS PERMISSION;
DROP TYPE IF EXISTS STATES;
DROP TYPE IF EXISTS LEVELTYPE;
DROP TYPE IF EXISTS CURRICULUMTYPE;
DROP TYPE IF EXISTS REFERRALTYPE;
DROP TYPE IF EXISTS FORM;
DROP TYPE IF EXISTS SEX;
DROP TYPE IF EXISTS RACE;


------------------------------------
--         CREATE Statements      --
------------------------------------
CREATE TYPE RACE AS ENUM('Asian', 'Black', 'Latino', 'Native American', 'Pacific Islander', 'White');
CREATE TYPE SEX AS ENUM ('Male', 'Female');
CREATE TYPE FORM AS ENUM ('Intake', 'Referral');
CREATE TYPE REFERRALTYPE AS ENUM ('Self', 'Court', 'Agency', 'Friend', 'Family');
CREATE TYPE CURRICULUMTYPE AS ENUM ('FULL', 'MINI');
CREATE TYPE LEVELTYPE AS ENUM ('PRIMARY', 'SECONDARY');
CREATE TYPE STATES AS ENUM('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware',
'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',
'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 
'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 
'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 
'West Virginia', 'Wisconsin', 'Wyoming');
CREATE TYPE PERMISSION AS ENUM('User', 'Facilitator', 'Administator', 'Superuser');
CREATE TYPE PHONETYPE AS ENUM('Primary', 'Secondary', 'Day', 'Evening', 'Home', 'Cell');
CREATE TYPE PROGRAMTYPE AS ENUM('In-House', 'Jail', 'Rehab');
CREATE TYPE PARENTINGPROGRAM AS ENUM('TPP', 'SNPP', 'PEP');
CREATE TYPE RELATIONSHIP AS ENUM ('Mother', 'Father', 'Daughter', 'Son', 'Sister', 'Brother', 'Aunt', 'Uncle', 'Niece', 'Nephew', 'Cousin', 'Grandmother', 'Grandfather', 'Granddaughter', 'Grandson', 'Stepsister', 'Stepbrother', 'Stepmother', 'Stepfather', 'Stepdaughter', 'Stepson', 'Sister-in-law', 'Brother-in-law', 'Mother-in-law', 'Daughter-in-law', 'Son-in-law', 'Friend', 'Other');

--		People and Subtypes		--
CREATE TABLE IF NOT EXISTS People (
  peopleID 								SERIAL			NOT NULL	UNIQUE,
  firstName 							TEXT 			NOT NULL,
  lastName 								TEXT 			NOT NULL,
  PRIMARY KEY (peopleID)
);

CREATE TABLE IF NOT EXISTS Employees (
  employeeID 							INT,
  email 								TEXT			NOT NULL,
  primaryPhone 							TEXT,
  permisionLevel 						PERMISSION		NOT NULL,
  PRIMARY KEY (employeeID),
  FOREIGN KEY (employeeID) REFERENCES People(peopleID)
);

CREATE TABLE IF NOT EXISTS Facilitators (
  facilitatorID 						INT,
  program 								PARENTINGPROGRAM,
  PRIMARY KEY (facilitatorID),
  FOREIGN KEY (facilitatorID) REFERENCES Employees(employeeID)
);

CREATE TABLE IF NOT EXISTS Participants (
  participantID 						INT,
  dateOfBirth 							DATE			NOT NULL,
  race									RACE			NOT NULL,
  PRIMARY KEY (participantID),
  FOREIGN KEY (participantID) REFERENCES People(peopleID)
);

CREATE TABLE IF NOT EXISTS OutOfHouse (
  outOfHouseID 							INT,
  description 							TEXT,
  PRIMARY KEY (outOfHouseID),
  FOREIGN KEY (outOfHouseID) REFERENCES Participants(participantID)
);

CREATE TABLE IF NOT EXISTS FamilyMembers (
  familyMemberID 						INT,
  relationship 							RELATIONSHIP	NOT NULL,
  dateOfBirth 							DATE			NOT NULL,
  race 									RACE,
  sex									SEX,
  PRIMARY KEY (familyMemberID),
  FOREIGN KEY (familyMemberID) REFERENCES People(peopleID)
);

CREATE TABLE IF NOT EXISTS Children (
  childrenID 							INT,
  custody 								TEXT			NOT NULL,
  location 								TEXT			NOT NULL,
  PRIMARY KEY (childrenID),
  FOREIGN KEY (childrenID) REFERENCES FamilyMembers(familyMemberID)
);

CREATE TABLE IF NOT EXISTS EmergencyContacts (
  emergencyContactID					INT,
  relationship 							RELATIONSHIP	NOT NULL,
  primaryPhone 							TEXT			NOT NULL,
  PRIMARY KEY (emergencyContactID),
  FOREIGN KEY (emergencyContactID) REFERENCES People(peopleID)
);

CREATE TABLE IF NOT EXISTS ContactAgencyMembers (
  contactAgencyID 						INT,
  agency 								REFERRALTYPE	NOT NULL,
  phone 								TEXT			NOT NULL,
  email 								TEXT			NOT NULL,
  PRIMARY KEY (contactAgencyID),
  FOREIGN KEY (contactAgencyID) REFERENCES People(peopleID)
);


--		Curricula and Class		--
CREATE TABLE IF NOT EXISTS Languages (
  lang 									TEXT			NOT NULL	UNIQUE,
  PRIMARY KEY (lang)
);

CREATE TABLE IF NOT EXISTS Sites (
  siteName 								TEXT			NOT NULL	UNIQUE,
  programType 							PROGRAMTYPE		NOT NULL,
  PRIMARY KEY (siteName)
);

CREATE TABLE IF NOT EXISTS Curricula (
  curriculumID							SERIAL			NOT NULL	UNIQUE,
  curriculumName 						TEXT			NOT NULL,
  curriculmType							PROGRAMTYPE		NOT NULL,
  missNumber							INT				DEFAULT 2,
  PRIMARY KEY (curriculumID)
);

CREATE TABLE IF NOT EXISTS Classes (
  topicName 							TEXT			NOT NULL	UNIQUE,
  description 							TEXT,
  PRIMARY KEY (topicName)
);

CREATE TABLE IF NOT EXISTS CurriculumClasses (
  topicName 							TEXT,
  curriculumID							INT,
  PRIMARY KEY (topicName, curriculumID),
  FOREIGN KEY (topicName) REFERENCES Classes(topicName),
  FOREIGN KEY (curriculumID) REFERENCES Curricula(curriculumID)
);

CREATE TABLE IF NOT EXISTS ClassOffering (
  topicName 							TEXT,
  date 									TIMESTAMP		NOT NULL,
  siteName 								TEXT,
  lang 									TEXT			DEFAULT 'English',
  curriculumID							INT,
  PRIMARY KEY (topicName, date, siteName),
  FOREIGN KEY (topicName) REFERENCES Classes(topicName),
  FOREIGN KEY (siteName) REFERENCES Sites(siteName),
  FOREIGN KEY (lang) REFERENCES Languages(lang),
  FOREIGN KEY (curriculumID) REFERENCES Curricula(curriculumID)
);

CREATE TABLE IF NOT EXISTS FacilitatorClassAttendance (
  topicName 							TEXT,
  date 									TIMESTAMP,
  siteName 								TEXT,
  facilitatorID							INT,
  PRIMARY KEY (topicName, date, siteName, facilitatorID),
  FOREIGN KEY (topicName, date, siteName) REFERENCES ClassOffering(topicName, date, siteName),
  FOREIGN KEY (facilitatorID) REFERENCES Facilitators(facilitatorID)
);

CREATE TABLE IF NOT EXISTS ParticipantClassAttendance (
  topicName 							TEXT,
  date 									TIMESTAMP,
  siteName 								TEXT,
  participantID 						INT,
  PRIMARY KEY (topicName, date, siteName, participantID),
  FOREIGN KEY (topicName, date, siteName) REFERENCES ClassOffering(topicName, date, siteName),
  FOREIGN KEY (participantID) REFERENCES Participants(participantID)
);

CREATE TABLE IF NOT EXISTS FacilitatorLangugage (
  facilitatorID 						INT,
  lang 									TEXT,
  level 								LEVELTYPE			NOT NULL,
  PRIMARY KEY (facilitatorID, lang, level),
  FOREIGN KEY (facilitatorID) REFERENCES Facilitators(facilitatorID),
  FOREIGN KEY (lang) REFERENCES Languages(lang)
);

CREATE TABLE IF NOT EXISTS ParticipantOutOfHouseSite (
  outOfHouseID INT,
  siteName TEXT,
  PRIMARY KEY (outOfHouseID, siteName),
  FOREIGN KEY (outOfHouseID) REFERENCES OutOfHouse(outOfHouseID),
  FOREIGN KEY (siteName) REFERENCES Sites(siteName)
);

--		Forms and Related Tables		--
CREATE TABLE IF NOT EXISTS ZipCode (
  zipCode 								INT					UNIQUE,
  city 									TEXT 				NOT NULL,
  state 								STATES				NOT NULL,
  PRIMARY KEY (zipCode)
);

CREATE TABLE IF NOT EXISTS Addresses (
  addressID 							SERIAL 				NOT NULL	UNIQUE,
  addressNumber 						INT,
  aptInfo								TEXT,
  street 								TEXT				NOT NULL,
  zipCode 								INT					NOT NULL,
  PRIMARY KEY (addressID),
  FOREIGN KEY (zipCode) REFERENCES ZipCode(zipCode)
);

CREATE TABLE IF NOT EXISTS Forms (
  formID 								SERIAL				NOT NULL	UNIQUE,
  addressID 							INT,
  empolyeeSignedDate 					DATE				NOT NULL	DEFAULT NOW(),
  employeeID 							INT,
  PRIMARY KEY (formID),
  FOREIGN KEY (addressID) REFERENCES Addresses(addressID),
  FOREIGN KEY (employeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE IF NOT EXISTS FormPhoneNumbers (
  formID INT,
  phoneNumber TEXT,
  phoneType PHONETYPE,
  PRIMARY KEY (formID, phoneNumber),
  FOREIGN KEY (formID) REFERENCES Forms(formID)
);

CREATE TABLE IF NOT EXISTS ParticipantsFormDetails (
  participantID 						INT,
  formID 								INT,
  PRIMARY KEY (participantID, formID),
  FOREIGN KEY (participantID) REFERENCES Participants(participantID),
  FOREIGN KEY (formID) REFERENCES Forms(formID)
);

CREATE TABLE IF NOT EXISTS SelfReferral (
  selfReferralID 						INT,
  referralSource 						TEXT,
  hasInvolvmentCPS 						BOOLEAN,
  hasAttendedPEP 						BOOLEAN,
  reasonAttendingPEP 					TEXT,
  dateFirstCall 						DATE,
  returnClientCallDate 					DATE,
  tentativeStartDate 					DATE,
  classAssignedTo 						TEXT,
  introLetterMailedDate 				DATE,
  Notes 								TEXT,
  PRIMARY KEY (selfReferralID),
  FOREIGN KEY (selfReferralID) REFERENCES Forms(formID)
);

CREATE TABLE IF NOT EXISTS AgencyReferral (
  agencyReferralID 						INT,
  secondaryPhone 						TEXT,
  reason 								TEXT,
  hasAgencyConstentForm 				BOOLEAN,
  addtionalInfo 						TEXT,
  program 								PARENTINGPROGRAM,
  hasSpecialNeeds 						BOOLEAN,
  hasSubstanceAbuseHistory 				BOOLEAN,
  hasInvolvmentCPS 						BOOLEAN,
  isPregnant 							BOOLEAN,
  hasIQDoc 								BOOLEAN,
  hasMentalHeath 						BOOLEAN,
  hasDomesticViolenceHistory 			BOOLEAN,
  childrenLiveWithIndivdual 			BOOLEAN,
  dateFirstContact 						DATE,
  meansOfContact 						TEXT,
  dateOfInitialMeet 					TIMESTAMP,
  location 								TEXT,
  comments 								TEXT,
  PRIMARY KEY (agencyReferralID),
  FOREIGN KEY (agencyReferralID) REFERENCES Forms(formID)
);

CREATE TABLE IF NOT EXISTS Surveys (
  surveyID 								INT,
  materialPresentedScore 				INT,
  presTopicDiscussedScore 				INT,
  presOtherParentsScore 				INT,
  presChildPerspectiveScore 			INT,
  practiceInfoScore 					INT,
  recommendScore 						INT,
  suggestedFutureTopics 				TEXT,
  comments 								TEXT,
  PRIMARY KEY (surveyID),
  FOREIGN KEY (surveyID) REFERENCES Forms(formID)
);


CREATE TABLE IF NOT EXISTS IntakeInformation (
  intakeInformationID 					INT,
  secondaryPhone 						TEXT,
  occupation 							TEXT,
  religion 								TEXT,
  ethnicity 							TEXT,
  handicapsOrMedication 				TEXT,
  lastYearOfSchoolCompleted 			TEXT,
  hasSubstanceAbuseHistory 				BOOLEAN,
  substanceAbuseDescription 			TEXT,
  timeSeparatedFromChildren 			TEXT,
  timeSeparatedFromPartner 				TEXT,
  relationshipToOtherParent 			TEXT,
  hasParentingPartnershipHistory 		BOOLEAN,
  hasInvolvmentCPS 						BOOLEAN,
  previouslyInvolvedWithCPS 			TEXT,
  isMandatedToTakeClass 				BOOLEAN,
  mandatedByWhom 						TEXT,
  reasonForAttendence					TEXT,
  safeParticipate 						TEXT,
  preventativeBehaviors 				TEXT,
  attendedOtherParentingClasses			BOOLEAN,
  previousClassInfo 					TEXT,
  wasVictim 							BOOLEAN,
  formOfChildhoodAbuse 					TEXT,
  hasHadTherapy 						BOOLEAN,
  feelStillHasIssuesFromChildAbuse 		TEXT,
  mostImportantLikeToLearn 				TEXT,
  hasDomesticViolenceHistory 			BOOLEAN,
  hasDiscussedDomesticViolence 			TEXT,
  hasHistoryOfViolenceInOriginFamily 	BOOLEAN,
  hasHistoryOfViolenceInNuclearFamily 	BOOLEAN,
  ordersOfProtectionInvolved 			BOOLEAN,
  reasonForOrdersOfProtection 			TEXT,
  hasBeenArrested 						BOOLEAN,
  hasBeenConvicted 						BOOLEAN,
  reasonForArrestOrConviction 			TEXT,
  hasJailRecord 						BOOLEAN,
  hasPrisonRecord 						BOOLEAN,
  offenseForJailOrPrison 				TEXT,
  currentlyOnParole 					BOOLEAN,
  onParoleForWhatOffense 				TEXT,
  prpFormSignedDate 					DATE,
  ptpEnrollmentSignedDate 				DATE,
  ptpConstentReleaseFormSignedDate 		DATE,
  PRIMARY KEY (intakeInformationID),
  FOREIGN KEY (intakeInformationID) REFERENCES Forms(formID)
);

CREATE TABLE IF NOT EXISTS ContactAgencyAssociatedWithReferred (
  contactAgencyID 	INT,
  agencyReferralID 	INT,
  isMainContact 	BOOLEAN,
  PRIMARY KEY (contactAgencyID, agencyReferralID),
  FOREIGN KEY (contactAgencyID) REFERENCES ContactAgencyMembers(contactAgencyID),
  FOREIGN KEY (agencyReferralID) REFERENCES AgencyReferral(agencyReferralID)
);

CREATE TABLE IF NOT EXISTS Family (
  familyMembersID INT,
  formID INT,
  PRIMARY KEY (familyMembersID, formID),
  FOREIGN KEY (familyMembersID) REFERENCES FamilyMembers(familyMemberID),
  FOREIGN KEY (formID) REFERENCES Forms(formID)
);
  

CREATE TABLE IF NOT EXISTS ParticipantsIntakeLanguages (
  intakeInformationID 	INT,
  lang 					TEXT,
  PRIMARY KEY (intakeInformationID, lang),
  FOREIGN KEY (intakeInformationID) REFERENCES IntakeInformation(intakeInformationID),
  FOREIGN KEY (lang) REFERENCES Languages(lang)
);


CREATE TABLE IF NOT EXISTS EmergencyContactDetail (
  emergencyContactID INT,
  intakeInformationID INT,
  PRIMARY KEY (emergencyContactID, intakeInformationID),
  FOREIGN KEY (emergencyContactID) REFERENCES EmergencyContacts(emergencyContactID),
  FOREIGN KEY (intakeInformationID) REFERENCES IntakeInformation(intakeInformationID)
);

