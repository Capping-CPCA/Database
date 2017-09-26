--		People		--
INSERT INTO People(firstName, lastName, middleInit) VALUES ('James', 'Crowley', 'D');
INSERT INTO People(firstName, lastName) VALUES ('Marcos', 'Barbieri');
INSERT INTO People(firstName, lastName) VALUES ('Carson', 'Badame');
INSERT INTO People(firstName, lastName, middleInit) VALUES ('Jesse', 'Opitz', 'P');
INSERT INTO People(firstName, lastName, middleInit) VALUES ('Rachel', 'Ulicni', 'M');
INSERT INTO People(firstName, lastName) VALUES ('John', 'Randis');
INSERT INTO People(firstName, lastName) VALUES ('Christopher', 'Algozzine');
INSERT INTO People(firstName, lastName) VALUES ('Dan', 'Grogan');
INSERT INTO People(firstName, lastName) VALUES ('Michlle', 'Opitz');
INSERT INTO People(firstName, lastName) VALUES ('Michlle', 'Crawley');

--		Employees		--
INSERT INTO Employees(employeeID, email, primaryPhone, permissionLevel) VALUES (5, 'Rachel@thecpca.com', '845-867-5309', 'Facilitator');
INSERT INTO Employees(employeeID, email, primaryPhone, permissionLevel) VALUES (3, 'Carson@thecpca.com', '845-234-4567', 'User');
INSERT INTO Employees(employeeID, email, permissionLevel) VALUES (6, 'John@thecpca.com', 'Superuser');
INSERT INTO Employees(employeeID, email, permissionLevel) VALUES (7, 'Christopher@thecpca.com', 'Facilitator');
INSERT INTO Employees(employeeID, email, permissionLevel) VALUES (8, 'Dan@thecpca.com', 'Administrator');

--		Facilitators		--
INSERT INTO Facilitators(facilitatorID, program) VALUES (5, 'PEP');
INSERT INTO Facilitators(facilitatorID, program) VALUES (7, 'TPP');

--		Participants		--
INSERT INTO Participants(participantID, dateOfBirth, race) VALUES (2, '1996-04-03', 'Pacific Islander');
INSERT INTO Participants(participantID, dateOfBirth, race) VALUES (4, '1878-01-01', 'White');

--		OutOfHouse			--
INSERT INTO OutOfHouse(outOfHouseID, description) VALUES (4, 'Jailed for beating wife and kids');

--		FamilyMembers		--
INSERT INTO FamilyMembers(familyMemberID, relationship, dateOfBirth, race, sex) VALUES (9, 'Daughter', '2001-07-23', 'Black', 'Female');

--		Children			--
INSERT INTO Children(childrenID, custody, location) VALUES (9, 'NO', 'Mothers');

--		EmergencyContacts		--
INSERT INTO EmergencyContacts(emergencyContactID, relationship, primaryPhone) VALUES (9, 'Daughter', '518-347-0303');

--		ContactAgencyMembers		--
INSERT INTO ContactAgencyMembers(contactAgencyID, agency, phone) VALUES (10, 'Court', '845-100-2324');

--		Languages		--
INSERT INTO Languages(lang) VALUES ('English');
INSERT INTO Languages(lang) VALUES ('Spanish');

--		Sites		--
INSERT INTO Sites(siteName, programType) VALUES ('Fox Run', 'Rehab');
INSERT INTO Sites(siteName, programType) VALUES ('Dutchess County Jail', 'Jail');
INSERT INTO Sites(siteName, programType) VALUES ('Poughkeepsie Site', 'In-House');

--		Curricula		--
INSERT INTO Curricula(curriculumName, curriculumType, missNumber) VALUES ('DC Womens Jail', 'Jail', 2);
INSERT INTO Curricula(curriculumName, curriculumType) VALUES ('In-House Poughkeepsie', 'In-House');
INSERT INTO Curricula(curriculumName, curriculumType) VALUES ('In-House Men', 'In-House');
INSERT INTO Curricula(curriculumName, curriculumType) VALUES ('Fox Run', 'Rehab');


--		Class		--
INSERT INTO Classes(topicName, description) VALUES ('How to be a good parent', 'A class that does what it says');
INSERT INTO Classes(topicName) VALUES ('How to be Cool');
INSERT INTO Classes(topicName, description) VALUES ('Parenting 101', 'Intro Class');

INSERT INTO Classes(topicName) VALUES ('Nurtuing/Culture/Spirituality');
INSERT INTO Classes(topicName) VALUES ('Developing Empathy/Getting Needs Met');
INSERT INTO Classes(topicName) VALUES ('Recognizing & Undering Feelings');
INSERT INTO Classes(topicName) VALUES ('Problem Solving & Decision Making');
INSERT INTO Classes(topicName) VALUES ('Communication/Listening/Criticism/Confrontation/Fair Fighting');
INSERT INTO Classes(topicName) VALUES ('Understanding & Expressing Anger');
INSERT INTO Classes(topicName) VALUES ('Talking about Effects of Drugs/Alcohol/Smoking on Family');
INSERT INTO Classes(topicName) VALUES ('Recap classes 1-8');
INSERT INTO Classes(topicName) VALUES ('Relationships/Personal Space');
INSERT INTO Classes(topicName) VALUES ('Children''s Brain Development');
INSERT INTO Classes(topicName) VALUES ('Male/Female Brain/Quiz');
INSERT INTO Classes(topicName) VALUES ('Ages & Stages: Appropriate Expectations');
INSERT INTO Classes(topicName) VALUES ('Ages & Stages: Infants to Toddler');
INSERT INTO Classes(topicName) VALUES ('Ages & Stages: Preschool to Adolescence');
INSERT INTO Classes(topicName) VALUES ('Establishing Nurturing Parenting Routines');
INSERT INTO Classes(topicName) VALUES ('Child Proofing Home/Safety Checklist/Safety Reminders');
INSERT INTO Classes(topicName) VALUES ('Recap classes 10-17');
INSERT INTO Classes(topicName) VALUES ('Feeding Young Children Nutritious Foods');
INSERT INTO Classes(topicName) VALUES ('Keeping Children Safe/Child Abuse & Neglect');
INSERT INTO Classes(topicName) VALUES ('Improving Self-Worth/Children''s Self Worth');
INSERT INTO Classes(topicName) VALUES ('Developing Personal Power Adults/Children');
INSERT INTO Classes(topicName) VALUES ('Helping Children Manage Behavior');
INSERT INTO Classes(topicName) VALUES ('Attachment/Sepration & Loss');
INSERT INTO Classes(topicName) VALUES ('Understanding Discipline/Developing Family Morals/Values/Rights');
INSERT INTO Classes(topicName) VALUES ('Using Rewards & Punishment to Guide/Teach Children/Praise');
INSERT INTO Classes(topicName) VALUES ('Alternatives to Physical Punishment');
INSERT INTO Classes(topicName) VALUES ('Guest Speaker');

INSERT INTO Classes(topicName) VALUES ('Understanding & handling Stress');
INSERT INTO Classes(topicName) VALUES ('Keeping Children Keeping/Child Abuse & Neglect');


--		CurriculumClasses		--
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be a good parent', 1);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be a good parent', 2);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be Cool', 1);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Parenting 101', 1);

INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Nurtuing/Culture/Spirituality', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Developing Empathy/Getting Needs Met', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Recognizing & Undering Feelings', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Problem Solving & Decision Making', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Communication/Listening/Criticism/Confrontation/Fair Fighting', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Understanding & Expressing Anger', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Talking about Effects of Drugs/Alcohol/Smoking on Family', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Recap classes 1-8', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Relationships/Personal Space', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Children''s Brain Development', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Male/Female Brain/Quiz', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Ages & Stages: Appropriate Expectations', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Ages & Stages: Infants to Toddler', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Ages & Stages: Preschool to Adolescence', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Establishing Nurturing Parenting Routines', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Child Proofing Home/Safety Checklist/Safety Reminders', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Recap classes 10-17', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Feeding Young Children Nutritious Foods', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Keeping Children Safe/Child Abuse & Neglect', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Improving Self-Worth/Children''s Self Worth', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Developing Personal Power Adults/Children', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Helping Children Manage Behavior', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Attachment/Sepration & Loss', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Understanding Discipline/Developing Family Morals/Values/Rights', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Using Rewards & Punishment to Guide/Teach Children/Praise', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Alternatives to Physical Punishment', 7);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Guest Speaker', 7);


INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Developing Empathy/Getting Needs Met', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Recognizing & Undering Feelings', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Communication/Listening/Criticism/Confrontation/Fair Fighting', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Understanding & handling Stress', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Understanding & Expressing Anger', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Relationships/Personal Space', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Establishing Nurturing Parenting Routines', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Keeping Children Keeping/Child Abuse & Neglect', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Improving Self-Worth/Children''s Self Worth', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Developing Personal Power Adults/Children', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Helping Children Manage Behavior', 5);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Understanding Discipline/Developing Family Morals/Values/Rights', 5);




--		ClassOffering		--
INSERT INTO ClassOffering(topicName, date, siteName, lang, curriculumID) VALUES ('How to be a good parent', '2017-09-23 05:22:21.649491', 'Dutchess County Jail', 'English', 1);
INSERT INTO ClassOffering(topicName, date, siteName, lang, curriculumID) VALUES ('How to be Cool', '2017-09-23 05:22:21.649491', 'Dutchess County Jail', 'English', 1);
INSERT INTO ClassOffering(topicName, date, siteName, lang, curriculumID) VALUES ('Parenting 101', '2017-09-23 05:22:21.649491', 'Dutchess County Jail', 'English', 1);

--		FacilitatorClassAttendance		--
INSERT INTO FacilitatorClassAttendance(topicName, date, siteName, facilitatorID) VALUES ('How to be a good parent', '2017-09-23 05:22:21.649491', 'Dutchess County Jail', 5);

--		ParticipantClassAttendance		--
INSERT INTO ParticipantClassAttendance(topicName, date, siteName, participantID) VALUES ('How to be a good parent', '2017-09-23 05:22:21.649491', 'Dutchess County Jail', 4);

--		FacilitatorLangugage		--
INSERT INTO FacilitatorLanguage(facilitatorID, lang, level) VALUES (5, 'English', 'PRIMARY');

--		ParticipantOutOfHouseSite		--
INSERT INTO ParticipantOutOfHouseSite(outOfHouseID, siteName) VALUES (4, 'Dutchess County Jail');