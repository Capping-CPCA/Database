/**
 * PEP Capping 2017 Algozzine's Class
 *
 * All INSERT statements needed to test the DB
 *
 * @author James Crowley, Carson Badame, John Randis, Jesse Opitz,
           Rachel Ulicni & Marcos Barbieri
 * @version 2.0
 */

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
                           FALSE);
INSERT INTO Superusers VALUES ((SELECT People.peopleID
                   FROM People
                           WHERE People.firstName = 'Chris' AND People.lastName = 'Algozzine'),
                           'algozzine',
                           '0bac4e79bf8b3606d38f52e020787cf5247b37ceff4fac0d87ffa2c4c575ed06',
                           'UrVO9pq9BGxpXT-TDh9BNpw_NYfaGlRAzE7o_QereIP_u5ltXe');

/**
 * Adding a Classes
 *  Default classes will be added once ran.
 */
INSERT INTO classes (classid, topicname, description, df) VALUES (1, 'Nurturing/Culture/Spirituality', 'Pages 7-10 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (2, 'Developing Empathy/Getting Needs Met', 'Pages 61-65 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (3, 'Recognizing & Understanding Feelings', 'Page 68 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (4, 'Problem Solving & Decision Making', 'Page 73 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (5, 'Communication/ Listening/ Criticism/ Confrontation/ Fair Fighting', 'Pages 70-72 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (6, 'Understanding & Handling Stress', 'Page 78 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (7, 'Understanding & Expressing Anger', 'Page 81 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (8, 'Talking about Effects of Drugs/Alcohol/Smoking on Family', 'Pages 11-17 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (9, 'Recap classes 1-9', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (10, 'Relationships/Personal Space', 'Pages 18-27 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (11, 'Children''s Brain Development', 'Pages 28-30 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (12, 'Male/Female Brain/Quiz', 'Pages 31-32 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (13, 'Emotional Honesty & Guilt/Shame', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (14, 'Ages & Stages: Appropriate Expectations', 'Pages 33-35 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (15, 'Ages & Stages: Infants to Toddler', 'Pages 36-42 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (16, 'Ages & Stages: Preschool to Adolescence', 'Pages 43-46 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (17, 'Establishing Nurturing Parenting Routines', 'Pages 125-135 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (18, 'Child Proofing Home/Safety Checklist/Safety Reminders', 'Pages 102-106 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (19, 'Recap classes 10-17', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (20, 'Feeding Young Children Nutritious Foods', 'Pages 47-49 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (21, 'Keeping Children Safe/Child Abuse & Neglect', 'Pages 54-59 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (22, 'Improving Self-Worth/Children''s Self Worth', 'Pages 85-89 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (23, 'Developing Personal Power Adults/Children', 'Pages 90-91 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (24, 'Helping Children Manage Behavior', 'Pages 92-94 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (25, 'Attachment/Separation & Loss', 'Pages 152-153 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (26, 'Understanding Discipline/Developing Family Morals/Values/Rules', 'Pages 95-101 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (27, 'Using Rewards & Punishment to Guide/Teach Children/Praise', 'Pages 107-114 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (28, 'Alternatives to Physical Punishment', 'Pages 117-124 in handbook', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (29, 'Guest Speaker', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (30, 'Communication', 'This is the shortened version for rehab locations', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (31, 'Self Esteem/Self Worth', 'for rehab curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (32, 'Anger Management', 'for rehab curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (33, 'Discipline/Rewards/Punishment/Praise', 'for rehab curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (34, 'Self Esteem/Self Care - Hygiene', 'Importance of bathing & body lice, scabbies, STDs', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (35, 'Anger Management / Stress & Frustration', 'for jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (36, 'Conflict Resolution/Fair Fighting', 'for jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (37, 'Communications - Active Listening', 'Everybody Loves Raymond video with Activity Sheet', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (38, 'Communications I & III', 'Listening (shapes activity) and Barriers to effective communication', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (39, 'Communications II - Learning Modalities', 'How to help your children learn and retain information learned', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (40, 'Child Development I', 'Eric Erickson stages of life. CDC stages of child development.', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (41, 'Child Development II', 'Brain development/Group activity - needs of children', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (42, 'Discipline -', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (43, 'Discipline - Appropriate Expectations', 'used in jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (44, 'Discipline - Family Values, Rules, Morals', 'used in jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (45, 'Discipline I & II', 'used in jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (46, '"Dads on Time-Out" - talking to children about incarceration', 'used in jail curricula', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (47, 'Co-Dependency/Parent Drug Use effects on Children', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (48, 'Family Meetings/Game Class', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (49, 'Importance of Dads -', '', false);
INSERT INTO classes (classid, topicname, description, df) VALUES (50, 'Importance of Dads - Courageous', 'Christmas week & Summer Vacation week', false);

-- Catch the sequence up to the number of manually inserted Classes
SELECT setval('classes_classid_seq', 50);

/**
 * Adding a Curricula
 *  Default curricula will be added once ran.
 */
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (1, 'Jail Ladies New', 2, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (2, 'Jail Men', 1, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (3, 'Cornerstone', 0, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (4, 'Nurturing Skills for Families - Women', 2, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (5, 'Nurturing Skills for Families - Men', 2, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (6, 'ITAP', 1, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (7, 'Full Curriculum', 2, false);
INSERT INTO curricula (curriculumid, curriculumname, missnumber, df) VALUES (8, 'Jail Women', 3, false);

-- Catch the sequence up to the number of manually inserted Curricula
SELECT setval('curricula_curriculumid_seq', 8); 


/**
 * Adding a curriculumclasses
 *  Default relationships curriculms and classes will be added once ran.
 */
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (13, 1);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (14, 1);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (31, 3);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (32, 3);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (33, 3);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (30, 3);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (1, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (2, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (3, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (4, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (5, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (6, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (7, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (8, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (9, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (10, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (11, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (12, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (14, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (15, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (16, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (17, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (18, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (19, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (20, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (21, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (22, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (23, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (24, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (25, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (26, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (27, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (28, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (29, 5);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (13, 2);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (34, 2);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (34, 1);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (1, 6);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (46, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (14, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (15, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (23, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (43, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (44, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (42, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (45, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (1, 7);
INSERT INTO curriculumclasses (classid, curriculumid) VALUES (6, 7);

/**
 * Adding a Sites
 *  Default sites will be added once ran.
 */


/**
 * Adding a Empolyees
 *  Default empolyees will be added once ran.
 */


 /**
 * Adding a Lanugages
 *  Default Lanugages will be added once ran.
 */
INSERT INTO languages (lang) VALUES ('English');
INSERT INTO languages (lang) VALUES ('Spanish');
-- END OF INSERT ENTITIES SECTION --
