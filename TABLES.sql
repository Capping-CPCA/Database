/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All CREATE TABLE statements required to set up the Parent Empowerment
 * Program Attendance/Participant Database.
 *
 * NOTE: the `DROP TABLE` or `DROP TYPE` statements must be executed in a specific
 * order to properly reinitialize the database.
 * NOTE: Stay away from using `DROP TABLE CASCADE` unless ABSOLUTELY necessary
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 0.2.1
 */


-- DROP STATEMENTS --
DROP TABLE IF EXISTS EmergencyContactDetail;
DROP TABLE IF EXISTS ParticipantsIntakeLanguages;
DROP TABLE IF EXISTS Family;
DROP TABLE IF EXISTS ContactAgencyAssociatedWithReferred;
DROP TABLE IF EXISTS IntakeInformation;
DROP TABLE IF EXISTS Surveys;
DROP TABLE IF EXISTS AgencyReferral;
DROP TABLE IF EXISTS SelfReferral;
DROP TABLE IF EXISTS FormPhoneNumbers;
DROP TABLE IF EXISTS Forms;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS ZipCodes;
DROP TABLE IF EXISTS FacilitatorLanguage;
DROP TABLE IF EXISTS ParticipantClassAttendance;
DROP TABLE IF EXISTS FacilitatorClassAttendance;
DROP TABLE IF EXISTS ClassOffering;
DROP TABLE IF EXISTS CurriculumClasses;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Curricula;
DROP TABLE IF EXISTS Languages;
DROP TABLE IF EXISTS ContactAgencyMembers;
DROP TABLE IF EXISTS EmergencyContacts;
DROP TABLE IF EXISTS Children;
DROP TABLE IF EXISTS FamilyMembers;
DROP TABLE IF EXISTS Sites;
DROP TABLE IF EXISTS OutOfHouse;
DROP TABLE IF EXISTS Participants;
DROP TABLE IF EXISTS Facilitators;
DROP TABLE IF EXISTS Superusers;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS People;

-- DROP ENUMS
DROP TYPE IF EXISTS RELATIONSHIP;
DROP TYPE IF EXISTS PROGRAMTYPE;
DROP TYPE IF EXISTS PHONETYPE;
DROP TYPE IF EXISTS PERMISSION;
DROP TYPE IF EXISTS STATES;
DROP TYPE IF EXISTS LEVELTYPE;
DROP TYPE IF EXISTS REFERRALTYPE;
DROP TYPE IF EXISTS FORM;
DROP TYPE IF EXISTS SEX;
DROP TYPE IF EXISTS RACE;
-- END OF DROP STATEMENTS --


-- ENUMERATED TYPES --
CREATE TYPE RACE AS ENUM('Caucasian', 'African American', 'Multi Racial', 'Latino', 'Pacific Islander', 'Native American', 'Other');
CREATE TYPE SEX AS ENUM ('Male', 'Female', 'Other');
CREATE TYPE REFERRALTYPE AS ENUM ('CPS', 'DC Sherriff', 'Family', 'Friend', 'Self', 'Lawyer', 'Local Police', 'New York State Police', 'Family Court', 'County Court', 'Other Court', 'Other Police', 'Other');
CREATE TYPE LEVELTYPE AS ENUM ('PRIMARY', 'SECONDARY');
CREATE TYPE STATES AS ENUM('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware',
'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',
'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania',
'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
'West Virginia', 'Wisconsin', 'Wyoming');
CREATE TYPE PERMISSION AS ENUM('New', 'Coordinator', 'Facilitator', 'Administrator');
CREATE TYPE PHONETYPE AS ENUM('Primary', 'Secondary', 'Day', 'Evening', 'Home', 'Cell');
CREATE TYPE PROGRAMTYPE AS ENUM('In-House', 'Jail', 'Rehab');
CREATE TYPE RELATIONSHIP AS ENUM ('Mother', 'Father', 'Daughter', 'Son', 'Sister', 'Brother', 'Aunt', 'Uncle', 'Niece', 'Nephew', 'Cousin', 'Grandmother', 'Grandfather', 'Granddaughter', 'Grandson', 'Stepsister', 'Stepbrother', 'Stepmother', 'Stepfather', 'Stepdaughter', 'Stepson', 'Sister-in-law', 'Brother-in-law', 'Mother-in-law', 'Daughter-in-law', 'Son-in-law', 'Friend', 'Other');
-- END OF ENUMERATED TYPES --


-- CREATE ENTITIES --
/**
 * People
 *  Abstractly defines the identifying characteristics of all members of the DB
 */
CREATE TABLE IF NOT EXISTS People (
  peopleID 								SERIAL				NOT NULL	UNIQUE,
  firstName 							TEXT 				NOT NULL,
  lastName 								TEXT 				NOT NULL,
  middleInit							VARCHAR(1),
  PRIMARY KEY (peopleID)
);

/**
 * Employees
 * SUPERTYPE: People
 *  Defines characteristics of an employee working on the CPCA for PEP
 */
CREATE TABLE IF NOT EXISTS Employees (
  employeeID 							INT,
  email 								TEXT,
  primaryPhone 							TEXT,
  permissionLevel 						PERMISSION,
  DF                                                                         INT                                        DEFAULT 0,
  PRIMARY KEY (employeeID),
  FOREIGN KEY (employeeID) REFERENCES People(peopleID)
);

/**
 * Facilitators
 * SUPERTYPE: Facilitators
 *  Defines characteristics of employees that are qualified to teach a class
 */
CREATE TABLE IF NOT EXISTS Facilitators (
  facilitatorID 						INT,
  DF                                                          INT                                        DEFAULT 0,
  PRIMARY KEY (facilitatorID),
  FOREIGN KEY (facilitatorID) REFERENCES Employees(employeeID)
);

/**
 * Participants
 * SUPERTYPE: People
 *  Defines characteristics of each participant currently enrolled in the PEP
 *  program
 */
CREATE TABLE IF NOT EXISTS Participants (
  participantID 						INT,
  dateOfBirth 							DATE,
  race									RACE,
  sex                   SEX,
  PRIMARY KEY (participantID),
  FOREIGN KEY (participantID) REFERENCES People(peopleID)
);

/**
 * OutOfHouse
 * SUPERTYPE: People
 *  Defines the characteristics of a participant that does not take "in-house"
 *  classes. Usually reserved for participants in jail or more "locked-down"
 *  rehabs
 */
CREATE TABLE IF NOT EXISTS OutOfHouse (
  outOfHouseID 							INT,
  description 							TEXT,
  PRIMARY KEY (outOfHouseID),
  FOREIGN KEY (outOfHouseID) REFERENCES Participants(participantID)
);

/**
 * FamilyMembers
 * SUPERTYPE: People
 *  Family members of participants enrolled in the PEP program. Typically linked
 *  through the Intake form.
 */
CREATE TABLE IF NOT EXISTS FamilyMembers (
  familyMemberID 						INT,
  relationship 							RELATIONSHIP,
  dateOfBirth 							DATE,
  race 									RACE,
  sex									SEX,
  PRIMARY KEY (familyMemberID),
  FOREIGN KEY (familyMemberID) REFERENCES People(peopleID)
);

/**
 * Children
 * SUPERTYPE: FamilyMembers
 *  Children that are "linked" to the participant, inheriting the family member
 *  attributes as well
 */
CREATE TABLE IF NOT EXISTS Children (
  childrenID 							INT,
  custody 								TEXT,
  location 								TEXT,
  PRIMARY KEY (childrenID),
  FOREIGN KEY (childrenID) REFERENCES FamilyMembers(familyMemberID)
);

/**
 * EmergencyContacts
 * SUPERTYPE: People
 *  Listed contacts for a specific participant for emergency situations
 */
CREATE TABLE IF NOT EXISTS EmergencyContacts (
  emergencyContactID					INT,
  relationship 							RELATIONSHIP,
  primaryPhone 							TEXT,
  PRIMARY KEY (emergencyContactID),
  FOREIGN KEY (emergencyContactID) REFERENCES People(peopleID)
);

/**
 * ContactAgencyMembers
 * SUPERTYPE: People
 *  Contacts that work for an agency who were listed in/filled out an agency
 *  referral
 */
CREATE TABLE IF NOT EXISTS ContactAgencyMembers (
  contactAgencyID 						INT,
  agency 								REFERRALTYPE,
  phone 								TEXT,
  email 								TEXT,
  PRIMARY KEY (contactAgencyID),
  FOREIGN KEY (contactAgencyID) REFERENCES People(peopleID)
);

/**
 * Lanugages
 *  Stores all languages (for keeping track of courses in certain languages as
 *  well as primary/secondary languages for participants/facilitators)
 */
CREATE TABLE IF NOT EXISTS Languages (
  lang 									TEXT				NOT NULL	UNIQUE,
  PRIMARY KEY (lang)
);

/**
 * Curricula
 *  Stores all the curriculums taught by the Parent Empowerment Program
 */
CREATE TABLE IF NOT EXISTS Curricula (
  curriculumID							SERIAL					NOT NULL	UNIQUE,
  curriculumName 						TEXT				NOT NULL,
  siteName     							PROGRAMTYPE			NOT NULL,
  missNumber							INT					DEFAULT 2,
  DF									INT					DEFAULT 0,
  PRIMARY KEY (curriculumID)
);

/**
 * Classes
 *  Defines characteristics of each class. Each class merely has a topic name
 *  according to the CPCA's curriculum topics
 */
CREATE TABLE IF NOT EXISTS Classes (
  ClassID								INT					NOT NULL	UNIQUE,
  topicName 							TEXT				NOT NULL,
  description 							TEXT,
  DF									INT					DEFAULT 0,
  PRIMARY KEY (ClassID)
);

/**
 * CurriculumClasses
 *  Breaks up the MTM between classes and curricula. One class can belong to
 *  many curricula and one curriculum can have many classes
 */
CREATE TABLE IF NOT EXISTS CurriculumClasses (
  ClassID 							INT NOT NULL,
  CurriculumID     					INT NOT NULL,
  PRIMARY KEY (ClassID, CurriculumID),
  FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
  FOREIGN KEY (CurriculumID) REFERENCES Curricula(CurriculumID)
);

CREATE TABLE IF NOT EXISTS Sites (
  siteName								TEXT				NOT NULL,
  siteType								PROGRAMTYPE,
  PRIMARY KEY (siteName)
);
  

/**
 * ClassOffering
 *  Specifies the offering of a certain class for a running curriculum
 */
CREATE TABLE IF NOT EXISTS ClassOffering (
  ClassID	 							INT                NOT NULL,
  CurriculumID	                        INT                NOT NULL,
  date 									TIMESTAMP			NOT NULL,
  siteName								TEXT				NOT NULL,
  lang 									TEXT				DEFAULT 'English',
  PRIMARY KEY (ClassID, CurriculumID, date, siteName),
  FOREIGN KEY (ClassID, CurriculumID) REFERENCES CurriculumClasses(ClassID, CurriculumID),
  FOREIGN KEY (lang) REFERENCES Languages(lang),
  FOREIGN KEY (siteName) REFERENCES Sites(siteName)
);

/**
 * FacilitatorClassAttendance
 *  Breaks up the MTM between the offering of a class, and the facilitator that
 *  ran the class. One facilitator can run several classes (throughout the week)
 *  and one class could THEORETICALLY have several facilitators
 */
CREATE TABLE IF NOT EXISTS FacilitatorClassAttendance (
  ClassID 								INT         NOT NULL,
  CurriculumID	                        INT         NOT NULL,
  date 									TIMESTAMP    NOT NULL,
  facilitatorID							INT          NOT NULL,
  siteName								TEXT		NOT NULL,
  PRIMARY KEY (ClassID, CurriculumID, date, facilitatorID, siteName),
  FOREIGN KEY (ClassID, CurriculumID, date, siteName) REFERENCES ClassOffering(ClassID, CurriculumID, date, siteName),
  FOREIGN KEY (facilitatorID) REFERENCES Facilitators(facilitatorID)
);

/**
 * ParticipantClassAttendance
 *  Breaks up the MTM between the offering of a class and the participant that
 *  is attending that class. There are many participants in a class, and each
 *  particpant can attend multiple classes
 */
CREATE TABLE IF NOT EXISTS ParticipantClassAttendance (
  ClassID	 							INT	         NOT NULL,
  CurriculumID	                        INT	         NOT NULL,
  date 									TIMESTAMP    NOT NULL,
  participantID 						INT          NOT NULL,
  comments							   TEXT,
  numChildren							INT,
  isNew                                 BOOLEAN      NOT NULL,
  zipCode                               INT,
  siteName								TEXT		NOT NULL,
  PRIMARY KEY (ClassID, CurriculumID, date, participantID, siteName),
  FOREIGN KEY (ClassID, CurriculumID, date, siteName) REFERENCES ClassOffering(ClassID, CurriculumID, date, siteName),
  FOREIGN KEY (participantID) REFERENCES Participants(participantID)
);

/**
 * FacilitatorLanguage
 *  Breaks up the MTM between Facilitators and Languages. Facilitators may
 *  speak multiple languages. In order to cater to the diverse participants, we
 *  must keep track of each language that the facilitator can teach in, to know
 *  which courses they can teach.
 */
CREATE TABLE IF NOT EXISTS FacilitatorLanguage (
  facilitatorID 						INT,
  lang 									TEXT,
  level 								LEVELTYPE			NOT NULL,
  PRIMARY KEY (facilitatorID, lang, level),
  FOREIGN KEY (facilitatorID) REFERENCES Facilitators(facilitatorID),
  FOREIGN KEY (lang) REFERENCES Languages(lang)
);

-- Forms and Related Tables	--

/**
 * ZipCodes
 *  Zip Code identifies city and state, thus it is best practice to have zip
 *  codes as a separate table
 */
CREATE TABLE IF NOT EXISTS ZipCodes (
  zipCode 								INT					UNIQUE,
  city 									TEXT 				NOT NULL,
  state 								STATES				NOT NULL,
  PRIMARY KEY (zipCode)
);

/**
 * Addresses
 *  Will keep track of any locations associated with forms. As of now only one
 *  address should be linked to all forms filled out for a specific participant
 */
CREATE TABLE IF NOT EXISTS Addresses (
  addressID 							SERIAL 				NOT NULL	UNIQUE,
  addressNumber 						INT,
  aptInfo								TEXT,
  street 								TEXT,
  zipCode 								INT,
  PRIMARY KEY (addressID),
  FOREIGN KEY (zipCode) REFERENCES ZipCodes(zipCode)
);

/**
 * Forms
 *  Identifies the set of forms that a participant fills out when enrolling for
 *  the PEP program. The fields in this table contain the overlapping fields for
 *  each form. Thus, the following columns should have the same information for
 *  all forms filled out for a participant.
 */
CREATE TABLE IF NOT EXISTS Forms (
  formID 								SERIAL				NOT NULL	UNIQUE,
  addressID 							INT,
  employeeSignedDate 					DATE				NOT NULL	DEFAULT NOW(),
  employeeID 							INT					NOT NULL,
  participantID                         INT                 NOT NULL,
  PRIMARY KEY (formID),
  FOREIGN KEY (addressID) REFERENCES Addresses(addressID),
  FOREIGN KEY (employeeID) REFERENCES Employees(EmployeeID),
  FOREIGN KEY (participantID) REFERENCES Participants(participantID)
);

/**
 * FormPhoneNumbers
 *  Phone numbers associated with the forms the participant fills out
 */
CREATE TABLE IF NOT EXISTS FormPhoneNumbers (
  formID								INT,
  phoneNumber							TEXT,
  phoneType								PHONETYPE			NOT NULL,
  PRIMARY KEY (formID, phoneNumber),
  FOREIGN KEY (formID) REFERENCES Forms(formID)
);

/**
 * SelfReferral
 * SUPERTYPE: Forms
 *  Specifies the form data that are for self referred individuals
 */
CREATE TABLE IF NOT EXISTS SelfReferral (
  selfReferralID 						INT,
  referralSource 						TEXT,
  hasInvolvementCPS 					BOOLEAN,
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

/**
 * AgencyReferral
 * SUPERTYPE: Forms
 *  Specifies the form data that regard participants referred by an agency
 */
CREATE TABLE IF NOT EXISTS AgencyReferral (
  agencyReferralID 						INT,
  reason 								TEXT,
  hasAgencyConsentForm 					BOOLEAN,
  additionalInfo 						TEXT,
  hasSpecialNeeds 						BOOLEAN,
  hasSubstanceAbuseHistory 				BOOLEAN,
  hasInvolvementCPS 					BOOLEAN,
  isPregnant 							BOOLEAN,
  hasIQDoc 								BOOLEAN,
  hasMentalHealth 						BOOLEAN,
  hasDomesticViolenceHistory 			BOOLEAN,
  childrenLiveWithIndividual 			BOOLEAN,
  dateFirstContact 						DATE,
  meansOfContact 						TEXT,
  dateOfInitialMeet 					TIMESTAMP,
  location 								TEXT,
  comments 								TEXT,
  PRIMARY KEY (agencyReferralID),
  FOREIGN KEY (agencyReferralID) REFERENCES Forms(formID)
);

/**
 * Surveys
 * SUPERTYPE: Forms
 *  Will define the characteristics of a survey form
 */
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
  ClassID                             	INT,
  date	                             TIMESTAMP,
  CurriculumID	                        INT,
  siteName		                         TEXT,
  PRIMARY KEY (surveyID),
  FOREIGN KEY (surveyID) REFERENCES Forms(formID),
  FOREIGN KEY (ClassID, CurriculumID, date, siteName) REFERENCES ClassOffering(ClassID, CurriculumID, date, siteName)
);

/**
 * IntakeInformation
 * SUPERTYPE: Forms
 *  Defines ALL fields that are listed in the CPCA PEP intake form
 */
CREATE TABLE IF NOT EXISTS IntakeInformation (
  intakeInformationID 					INT,
  occupation 							TEXT,
  religion 								TEXT,
  handicapsOrMedication 				TEXT,
  lastYearOfSchoolCompleted 			TEXT,
  hasSubstanceAbuseHistory 				BOOLEAN,
  substanceAbuseDescription 			TEXT,
  timeSeparatedFromChildren 			TEXT,
  timeSeparatedFromPartner 				TEXT,
  relationshipToOtherParent 			TEXT,
  hasParentingPartnershipHistory 		BOOLEAN,
  hasInvolvementCPS 						BOOLEAN,
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

/**
 * ContactAgencyAssociatedWithReferred
 *  Breaks up the MTM between an agency listed in an agency referral form and
 *  the actualy agency. One agency can refer many individuals, and an
 *  individual can be referred by many agencies
 */
CREATE TABLE IF NOT EXISTS ContactAgencyAssociatedWithReferred (
  contactAgencyID						INT,
  agencyReferralID						INT,
  isMainContact							BOOLEAN,
  PRIMARY KEY (contactAgencyID, agencyReferralID),
  FOREIGN KEY (contactAgencyID) REFERENCES ContactAgencyMembers(contactAgencyID),
  FOREIGN KEY (agencyReferralID) REFERENCES AgencyReferral(agencyReferralID)
);

/**
 * Family
 */
CREATE TABLE IF NOT EXISTS Family (
  familyMembersID						INT,
  formID								INT,
  PRIMARY KEY (familyMembersID, formID),
  FOREIGN KEY (familyMembersID) REFERENCES FamilyMembers(familyMemberID),
  FOREIGN KEY (formID) REFERENCES Forms(formID)
);

/**
 * ParticipantsIntakeLanguages
 *  Breaks up the MTM between a participant's intake form and the languages
 *  available. The reason this is linked to intake form is because this info is
 *  only obtained when they fill out an intake form. We want to be ablt to trace
 *  this information back to the intake form they filled out.
 */
CREATE TABLE IF NOT EXISTS ParticipantsIntakeLanguages (
  intakeInformationID					INT,
  lang									TEXT,
  PRIMARY KEY (intakeInformationID, lang),
  FOREIGN KEY (intakeInformationID) REFERENCES IntakeInformation(intakeInformationID),
  FOREIGN KEY (lang) REFERENCES Languages(lang)
);

/**
 * EmergencyContactDetail
 *  Breaks up the MTM between the intake information and the emergency contacts
 *  in the system. This information is linked to the intake form, because we
 *  want to trace this information back to the intake form they filled out.
 */
CREATE TABLE IF NOT EXISTS EmergencyContactDetail (
  emergencyContactID					INT,
  intakeInformationID					INT,
  PRIMARY KEY (emergencyContactID, intakeInformationID),
  FOREIGN KEY (emergencyContactID) REFERENCES EmergencyContacts(emergencyContactID),
  FOREIGN KEY (intakeInformationID) REFERENCES IntakeInformation(intakeInformationID)
);


/**
 * Superusers
 *  Users that have full access to the database
 */
CREATE TABLE IF NOT EXISTS Superusers (
  superUserID                           INT                 NOT NULL,
  username 								TEXT				NOT NULL	UNIQUE,
  hashedPassword 						TEXT 				NOT NULL,
  salt 								    TEXT 				NOT NULL,
  PRIMARY KEY (superUserId),
  FOREIGN KEY (superUserId) REFERENCES Employees(employeeID)
);
/**
 * Adding a Superuser
 *  Adding Algozzine as a default superuser. Salted the password with the salt provided.
 *  To get the password use SHA256. So, SHA256(password+hash). Theres no plus sign just the password directly
 *  followed by the hash.
 */

INSERT INTO People(firstName, lastName) VALUES ('Chris', 'Algozzine');

INSERT INTO Employees VALUES ((SELECT People.peopleID
                   FROM People
                           WHERE People.firstName = 'Chris' AND People.lastName = 'Algozzine'),
                           'Christopher.Algozzine@marist.edu',
                           '8455555555',
                           'Administrator',
                           0);
INSERT INTO Superusers VALUES ((SELECT People.peopleID
                   FROM People
                           WHERE People.firstName = 'Chris' AND People.lastName = 'Algozzine'),
                           'algozzine',
                           '0bac4e79bf8b3606d38f52e020787cf5247b37ceff4fac0d87ffa2c4c575ed06',
                           'UrVO9pq9BGxpXT-TDh9BNpw_NYfaGlRAzE7o_QereIP_u5ltXe');

-- END OF CREATE ENTITIES SECTION --

