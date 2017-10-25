Using Stored Procedures
=====================================

Stored Procedures use keyword arguments, for example if you have the stored procedure `foo` with the parameter `bar`, in PostgreSQL to call procedure `foo` you must do the following

<p style="text-align:center;"><code>foo(bar = 2)</code></p>

where `bar = 2` refers to the parameter that we are passing, which we are setting to the value of `2`. **NOTE** this is the general idea of using Postgres functions in this database. More specifically, for this database, if a user/developer was to call the stored procedure `RegisterParticipantIntake` it would look something like the following

<pre style="text-align:center;">
SELECT registerParticipantIntake(
fName := '<PARTICIPANT_FIRST_NAME>'::TEXT,
lName := '<PARTICIPANT_LAST_NAME>'::TEXT,
dob := '<PARTICIPANT_DOB>'::DATE,
race:= '<PARTICIPANT_RACE>'::TEXT,
houseNum := <PARTICIPANT_HOUSE_NUM>::INT,
streetAddress := '<PARTICIPANT_STREET_ADDRESS>'::TEXT,
zipCode := <PARTICIPANT_ZIP_CODE>::INT,
city := '<PARTICIPANT_CITY>'::TEXT,
state := '<PARTICIPANT_STATE>'::TEXT,
secondaryPhone := '<PARTICIPANT_SECONDARY_PHONE>'::TEXT,
occupation := '<PARTICIPANT_OCCUPATION>'::TEXT,
religion := '<PARTICIPANT_RELIGION>'::TEXT,
ethnicity :='<PARTICIPANT_ETHNICITY>'::TEXT,
lastYearSchool := '<PARTICIPANT_LAST_YEAR_SCHOOL>'::TEXT,
hasDrugAbuseHist := <PARTICIPANT_DRUG_ABUSE_HIST>::BOOLEAN,
timeSeparatedFromChildren := '<PARTICIPANT_TIME_SEP_FROM_CHILDREN>'::TEXT,
timeSeparatedFromPartner := '<PARTICIPANT_TIME_SEP_FROM_PARTNER>'::TEXT,
relationshipToOtherParent := '<PARTICIPANT_REL_TO_OTHER_PARENT>'::TEXT,
hasParentingPartnershipHistory := <PARTICIPANT_PARENTING_HISTORY>::BOOLEAN,
hasInvolvementCPS := <HAS_INVOLVEMENT_CPS>::BOOLEAN,
hasPrevInvolvementCPS := '<PARTICIPANT_PREV_INVOLVEMENT_CPS>'::TEXT,
isMandatedToTakeClass := <PARTICIPANT_MANDATED_TAKE_CLASS>::BOOLEAN,
reasonForAttendence := '<PARTICIPANT_REASON_ATTENDANCE>'::TEXT,
safeParticipate := '<PARTICIPANT_SAFE_PARTICIPATION>'::TEXT,
preventParticipate := '<PARTICIPANT_PREVENT_PARTICIPATION>'::TEXT,
hasAttendedOtherParenting := <PARTICIPANT_ATTENDING_OTHER_PARENTING>::BOOLEAN,
victimChildAbuse := <PARTICIPANT_VICTIM_CHILD_ABUSE>::BOOLEAN,
hasHadTherapy := <PARTICIPANT_HAS_HAD_THERAPY>::BOOLEAN,
mostImportantLikeToLearn := '<PARTICIPANT_LESSONS_TO_LEARN>'::TEXT,
hasDomesticViolenceHistory := <PARTICIPANT_DOMESTIC_VIOLENCE_HIST>::BOOLEAN,
hasHistoryChildAbuseOriginFam := <PARTICIPANT_CHILD_ABUSE_ORIGIN>::BOOLEAN,
hasHistoryViolenceNuclearFamily := <PARTICIPANT_VIOLENCE_NUCLEAR>::BOOLEAN, -- Has History of Abuse in Nuclear Family
ordersOfProtectionInvolved := <PARTICIPANT_ORDERS_PROTECTION>::BOOLEAN,
hasBeenArrested := <PARTICIPANT_ARRESTED>::BOOLEAN, -- Has Been Arrested
hasBeenConvicted := <PARTICIPANT_CONVICTED>::BOOLEAN,
hasJailRecord := <PARTICIPANT_JAIL_RECORD>::BOOLEAN,
hasPrisonRecord := <PARTICIPANT_PRISON_RECORD>::BOOLEAN,
currentlyOnParole := <PARTICIPANT_CURRENTLY_PAROLE>::BOOLEAN,
ptpMainFormSignedDate := '<PARTICIPANT_MAIN_FORM_SIGNED_DATE>'::DATE,
ptpEnrollmentSignedDate := '<PARTICIPANT_ENROLLMENT_SIGNED_DATE>'::DATE,
ptpConstentReleaseFormSignedDate := '<PARTICIPANT_CONSENT_RELEASED_SIGNED_DATE>'::DATE,
employeeEmail := '<EMPLOYEE_SIGNED>'::TEXT
);
</pre>
