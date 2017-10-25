------------------------------------
--         Useful Queries         --
------------------------------------

SELECT * FROM People;
SELECT * FROM Employees;
SELECT * FROM Facilitators;
SELECT * FROM Participants;
SELECT * FROM OutOfHome;
Select * FROM FamilyMembers;
SELECT * FROM Children;
Select * FROM EmergencyContacts;
SELECT * FROM ContactAgencyMembers;

-- Returns table with number of classes per curriculum
SELECT curriculumname, COUNT(DISTINCT topicName) 
FROM curriculuminfo
GROUP BY curriculumID, curriculumname;