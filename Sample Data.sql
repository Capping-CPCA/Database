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

--		Class		--
INSERT INTO Classes(topicName, description) VALUES ('How to be a good parent', 'A class that does what it says');
INSERT INTO Classes(topicName) VALUES ('How to be Cool');
INSERT INTO Classes(topicName, description) VALUES ('Parenting 101', 'Intro Class');

--		CurriculumClasses		--
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be a good parent', 1);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be a good parent', 2);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('How to be Cool', 1);
INSERT INTO CurriculumClasses(topicName, curriculumID) VALUES ('Parenting 101', 1);

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