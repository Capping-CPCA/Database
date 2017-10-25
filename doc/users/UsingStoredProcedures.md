Using Stored Procedures
=====================================

Stored Procedures use keyword arguments, for example if you have the stored procedure `foo` with the parameter `bar`, in PostgreSQL to call procedure `foo` you must do the following

<p style="text-align:center;"><code>foo(bar = 2)</code></p>

where `bar = 2` refers to the parameter that we are passing, which we are setting to the value of `2`. **NOTE** this is the general idea of using Postgres functions in this database. More specifically, for this database, if a user/developer was to call the stored procedure `RegisterParticipantIntake` it would look something like the following

<pre style="text-align:center;">
SELECT registerParticipantIntake(
fName := 'Marcos'::TEXT,
lName := 'Barbieri'::TEXT,
dob := '1996-04-03'::DATE,
race:= 'Pacific Islander'::TEXT,
houseNum := 3::INT,
streetAddress := 'Elm St'::TEXT,
zipCode := 12601::INT,
city := 'Poughkeepsie'::TEXT,
state := 'New York'::TEXT,
secondaryPhone := '(914)-514-0781'::TEXT,
occupation := 'DB Admin'::TEXT,
religion := 'Catholic'::TEXT,
ethnicity :='Eurohawaiian'::TEXT,
lastYearSchool := 'High School Diploma'::TEXT,
hasDrugAbuseHist := FALSE::BOOLEAN,
timeSeparatedFromChildren := '2 years'::TEXT,
timeSeparatedFromPartner := '2 years'::TEXT,
relationshipToOtherParent := 'Father'::TEXT,
hasParentingPartnershipHistory := FALSE::BOOLEAN,
hasInvolvmentCPS := FALSE::BOOLEAN,
hasPrevInvolvmentCPS := 'NO'::TEXT,
isMandatedToTakeClass := FALSE::BOOLEAN,
reasonForAttendence := 'nothing better to do'::TEXT,
safeParticipate := 'cookies'::TEXT,    -- Qualities of Class that Make Individuals Safe Participate
preventParticipate := 'no cookies'::TEXT,    -- Behaviors that Prevent Participation
hasAttendedOtherParenting := FALSE::BOOLEAN,
victimChildAbuse := FALSE::BOOLEAN,
hasHadTherapy := FALSE::BOOLEAN,
mostImportantLikeToLearn := 'multiplication'::TEXT,    -- Most Important Thing to Laern from Class
hasDomesticViolenceHistory := FALSE::BOOLEAN,
hasHistoryChildAbuseOriginFam := FALSE::BOOLEAN, -- Has History of Abuse in Family of Origin
hasHistoryViolenceNuclearFamily := FALSE::BOOLEAN, -- Has History of Abuse in Nuclear Family
ordersOfProtectionInvolved := FALSE::BOOLEAN,
hasBeenArrested := FALSE::BOOLEAN, -- Has Been Arrested
hasBeenConvicted := FALSE::BOOLEAN,
hasJailRecord := FALSE::BOOLEAN, -- Has Jail Record
hasPrisonRecord := FALSE::BOOLEAN,
currentlyOnParole := FALSE::BOOLEAN,
ptpMainFormSignedDate := '2000-04-05'::DATE,    -- Participant Main Form Signed Date
ptpEnrollmentSignedDate := '2000-04-05'::DATE,    -- Participant Enrollment Form Signed Date
ptpConstentReleaseFormSignedDate := '2000-04-05'::DATE,    -- Participant Consent Release Form Signed Date
employeeEmail := 'Rachel@thecpca.com'::TEXT     -- Employee that entered the information/signed
);
</pre>
