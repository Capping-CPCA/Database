Using Stored Procedures
=====================================

Stored Procedures use keyword arguments, for example if you have the stored procedure `foo` with the parameter `bar`, in PostgreSQL to call procedure `foo` you must do the following

<p style="text-align:center;"><code>foo(bar = 2)</code></p>

where `bar = 2` refers to the parameter that we are passing, which we are setting to the value of `2`. **NOTE** this is the general idea of using Postgres functions in this database. More specifically, for this database, if a user/developer was to call the stored procedure `RegisterParticipantIntake` it would look something like the following


## registerParticipantIntake
**@returns** VOID

Note: peopleInsert must be called before registerParticipantIntake

- SQL

```sql
SELECT registerParticipantIntake(
  intakeParticipantID := ID_FROM_PEOPLEINSERT_GOES_HERE::INT,
  intakeParticipantDOB := 'PARTICIPANT_DOB'::DATE,
  intakeParticipantRace := 'PARTICIPANT_RACE_OR_ETHNICITY'::RACE,
  intakeParticipantSex := 'PARTICIPANT_SEX'::SEX,
  houseNum := PARTICIPANT_HOUSE_NUM::INT,
  streetAddress := 'PARTICIPANT_STREET_ADDRESS'::TEXT,
  apartmentInfo := 'PARTICIPANT_APT_INFO'::TEXT,
  zipCode := PARTICIPANT_ZIP_CODE::VARCHAR(5),
  city := 'PARTICIPANT_CITY'::TEXT,
  state := 'PARTICIPANT_STATE'::STATES,
  occupation := 'PARTICIPANT_OCCUPATION'::TEXT,
  religion := 'PARTICIPANT_RELIGION'::TEXT,
  handicapsormedication := 'PARTICIPANT_HANDICAPS_OR_MEDICATIONS'::TEXT,
  lastYearSchool := 'PARTICIPANT_LAST_YEAR_SCHOOL'::TEXT,
  hasDrugAbuseHist := PARTICIPANT_DRUG_ABUSE_HIST::BOOLEAN,
  substanceabusedescr := 'PARTICIPANT_SUBSTANCE_ABUSE_DESCR'::TEXT,
  timeSeparatedFromChildren := 'PARTICIPANT_TIME_SEP_FROM_CHILDREN'::TEXT,
  timeSeparatedFromPartner := 'PARTICIPANT_TIME_SEP_FROM_PARTNER'::TEXT,
  relationshipToOtherParent := 'PARTICIPANT_REL_TO_OTHER_PARENT'::TEXT,
  hasParentingPartnershipHistory := PARTICIPANT_PARENTING_HISTORY::BOOLEAN,
  hasInvolvementCPS := HAS_INVOLVEMENT_CPS::BOOLEAN,
  hasPrevInvolvementCPS := 'PARTICIPANT_PREV_INVOLVEMENT_CPS'::TEXT,
  isMandatedToTakeClass := PARTICIPANT_MANDATED_TAKE_CLASS::BOOLEAN,
  whomandatedclass := 'PARTICIPANT_WHO_MANDATED_CLASS'::TEXT,
  reasonForAttendence := 'PARTICIPANT_REASON_ATTENDANCE'::TEXT,
  safeParticipate := 'PARTICIPANT_SAFE_PARTICIPATION'::TEXT,
  preventParticipate := 'PARTICIPANT_PREVENT_PARTICIPATION'::TEXT,
  hasAttendedOtherParenting := PARTICIPANT_ATTENDING_OTHER_PARENTING::BOOLEAN,
  kindofparentingclasstaken := 'PARTICIPANT_KIND_OF_PARENTING_CLASS'::TEXT,
  victimChildAbuse := PARTICIPANT_VICTIM_CHILD_ABUSE::BOOLEAN,
  formofchildhoodabuse := PARTICIPANT_FORM_OF_CHILD_ABUSE::TEXT,
  hasHadTherapy := PARTICIPANT_HAS_HAD_THERAPY::BOOLEAN,
  stillissuesfromchildabuse := 'PARTICIPANT_STILL_ISSUES_FROM_CHILD_ABUSE'::BOOLEAN,
  mostImportantLikeToLearn := 'PARTICIPANT_LESSONS_TO_LEARN'::TEXT,
  hasDomesticViolenceHistory := PARTICIPANT_DOMESTIC_VIOLENCE_HIST::BOOLEAN,
  hasdiscusseddomesticviolence := 'PARTICIPANT_HAS_DISCUSSED_DOMESTIC_VIOLENCE::BOOLEAN,
  hasHistoryChildAbuseOriginFam := PARTICIPANT_CHILD_ABUSE_ORIGIN::BOOLEAN,
  hasHistoryViolenceNuclearFamily := PARTICIPANT_VIOLENCE_NUCLEAR::BOOLEAN,
  ordersOfProtectionInvolved := PARTICIPANT_ORDERS_PROTECTION::BOOLEAN,
  reasonforordersofprotection  := 'PARTICIPANT_REASON_ORDERS_PROTECTION'::TEXT,
  hasBeenArrested := PARTICIPANT_ARRESTED::BOOLEAN,
  hasBeenConvicted := PARTICIPANT_CONVICTED::BOOLEAN,
  reasonforarrestorconviction := 'PARTICIPANT_REASON_FOR_ARREST'::TEXT,
  hasJailPrisonRecord := PARTICIPANT_JAIL_RECORD::BOOLEAN,
  offensejailprisonrec := 'PARTICIPANT_OFFENSE_JAIL_REC'::TEXT
  currentlyOnParole := PARTICIPANT_CURRENTLY_PAROLE::BOOLEAN,
  onparoleforwhatoffense := 'PARTICIPANT_ON_PAROLE_FOR_WHAT'::TEXT,
  ptpMainFormSignedDate := 'PARTICIPANT_MAIN_FORM_SIGNED_DATE'::DATE,
  ptpEnrollmentSignedDate := 'PARTICIPANT_ENROLLMENT_SIGNED_DATE'::DATE,
  lang := 'PARTICIPANT_LANGUAGE'::TEXT,
  ptpConstentReleaseFormSignedDate := 'PARTICIPANT_CONSENT_RELEASED_SIGNED_DATE'::DATE,
  eID := EMPLOYEE_ID_GOES_HERE::INT
);
```

- PHP

```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT registerParticipantIntake(
      intakeParticipantID := $1::INT,
      intakeParticipantDOB := $2::DATE,
      intakeParticipantRace := $3::RACE,
      intakeParticipantSex := $4::SEX,
      houseNum := $5::INT,
      streetAddress := $6::TEXT,
      apartmentInfo := $7::TEXT,
      zipCode := $8::INT,
      city := $9::TEXT,
      state := $10::TEXT,
      occupation := $11::TEXT,
      religion := $12::TEXT,
      handicapsormedication := $13::TEXT,
      lastYearSchool := $14::TEXT,
      hasDrugAbuseHist := $15::BOOLEAN,
      substanceabusedescr :$16::TEXT,
      timeSeparatedFromChildren := $17::TEXT,
      timeSeparatedFromPartner := $18::TEXT,
      relationshipToOtherParent := $19::TEXT,
      hasParentingPartnershipHistory := $20::BOOLEAN,
      hasInvolvementCPS := $21::BOOLEAN,
      hasPrevInvolvementCPS := $22::TEXT,
      isMandatedToTakeClass := $23::BOOLEAN,
      whomandatedclass := $24::TEXT,
      reasonForAttendence := $25::TEXT,
      safeParticipate := $26::TEXT,
      preventParticipate := $27::TEXT,
      hasAttendedOtherParenting := $28::BOOLEAN,
      kindofparentingclasstaken := 29::TEXT,
      victimChildAbuse := $30::BOOLEAN,
      formofchildhoodabuse := $31::TEXT,
      hasHadTherapy := $32::BOOLEAN,
      stillissuesfromchildabuse := $33::BOOLEAN,
      mostImportantLikeToLearn := $34::TEXT,
      hasDomesticViolenceHistory := $35::BOOLEAN,
      hasdiscusseddomesticviolence := $36::BOOLEAN,
      hasHistoryChildAbuseOriginFam := $37::BOOLEAN,
      hasHistoryViolenceNuclearFamily := $38::BOOLEAN,
      ordersOfProtectionInvolved := $39::BOOLEAN,
      reasonforordersofprotection  := $40::TEXT,
      hasBeenArrested := $41::BOOLEAN,
      hasBeenConvicted := $42::BOOLEAN,
      reasonforarrestorconviction := $43::TEXT,
      hasJailPrisonRecord := $44::BOOLEAN,
      offensejailprisonrec := $45::TEXT,
      currentlyOnParole := $46::BOOLEAN,
      onparoleforwhatoffense := $47::TEXT,
      ptpMainFormSignedDate := $48::DATE,
      ptpEnrollmentSignedDate := $49::DATE,
      lang := $50::TEXT,
      ptpConstentReleaseFormSignedDate := $51::DATE,
      eID := $52::TEXT
    )',
    array($participantID,
      $participantDOB,
      $participantRace,
      $participantSex,
      $participantHouseNum,
      $participantStreetAddress,
      $participantApartment,
      $participantZipcode,
      $participantCity,
      $participantState::STATES,
      $participantOccupation,
      $participantReligion,
      $handicapsOrMedication,
      $lastYearOfSchool,
      $drugHistory,
      $substanceAbuseDescr, 
      $timeSepFromChild,
      $timeSepFromPartner,
      $relToOtherParent,
      $parentingHistory,
      $hasInvolvement::BOOLEAN,
      $previousInvolvment,
      $mandatedClass,
      $whoMandatedClass, 
      $reasonAttending,
      $safeParticipation,
      $preventParticipation,
      $attendingOtherParenting,
      $kindOfParentingClass,
      $victimOfChildAbuse,
      $formOfChildAbuse,
      $hasHadTherapy,
      $stillIssuesFromChildAbuse,
      $lessonsToLearn,
      $domesticViolenceHistory,
      $hasDiscussedDomesticViolence,
      $childAbuseHistory,
      $violenceNuclear,
      $ordersProtection,
      $reasonOrdersProtection,
      $arrested,
      $convicted,
      $reasonForArrest,
      $jailRecord,
      $offenseJailReccord,
      $currentlyParole,
      $onParoleForWhat,
      $mainFormSignedDate,
      $enrollmentSignedDate,
      $language,
      $consentReleaseSignedDate
      $employeeID));
  ```

## attendanceInsert
**@returns** VOID

- SQL
```sql
SELECT participantAttendanceInsert(
    attendanceParticipantID := PARTICIPANT_ID::INT,
    attendanceParticipantAge := PARTICIPANT_AGE::INT,
    attendanceParticipantRace := 'PARTICIPANT_RACE'::RACE,
    attendanceParticipantSex := 'PARTICIPANT_SEX'::SEX,
    attendanceSite := 'CLASS_SITE'::TEXT,
    attendanceFacilitatorID := FACILITATOR_ID::INT,
    attendanceClassID := CLASS_ID::INT,
    attendanceDate := 'ATTENDANCE_DATE'::TIMESTAMP,
    attendanceCurriculumID := CURRICULUM_ID::INT,
    attendanceComments := 'ATTENDANCE_COMMENTS'::TEXT,
    attendanceNumChildren := NUMBER_OF_CHILDREN::INT,
    isAttendanceNew := NEW_ATTENDEE::BOOLEAN,
    attendanceParticipantZipCode := 'PARTICIPANT_ZIPCODE'::VARCHAR(5),
    classOfferingLang := 'CLASS_LANGUAGE'::TEXT);
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT participantAttendanceInsert(
        attendanceParticipantID := $1::INT,
        attendanceParticipantAge := $2::INT,
        attendanceParticipantRace := $3::RACE,
        attendanceParticipantSex := $4::SEX,
        attendanceSite := $5::TEXT,
        attendanceFacilitatorID := $6::INT,
        attendanceClassID := $7::INT,
        attendanceDate := $8::TIMESTAMP,
        attendanceCurriculumID := $9::INT,
        attendanceComments := $10::TEXT,
        attendanceNumChildren := $11::INT,
        isAttendanceNew := $12::BOOLEAN,
        attendanceParticipantZipCode := $13::VARCHAR(5),
        classOfferingLang := $14::TEXT)',
                          array(
                           $participantID,
                            $participantAge,
                            $participantRace,
                            $participantSex,
                            $classSite,
                            $facilitatorID,
                            $classID,
                            $attendanceDate,
                            $curriculumID,
                            $attendanceComment,
                            $numberOfChildren,
                            $newAttendee,
                            $participantZipcode,
                            $classLanguage));
```


## createOutOfHouseParticipant
**@returns** INT: corresponds to the formID of the intake packet created

Note: PeopleID Must be called before calling this procedure

- SQL
```sql
select createOutOfHouseParticipant(
  outOfHouseParticipantId := ID_FROM_PEOPLE_INSERT_GOES_HERE::INT,
  participantAge := 'OUT_OF_HOUSE_PARTICIPANT_AGE'::INT,
  participantRace := 'OUT_OF_HOUSE_PARTICIPANT_RACE'::RACE,
  participantSex := 'OUT_OF_HOUSE_PARTICIPANT_SEX'::SEX,
  participantDescription := 'OUT_OF_HOUSE_PARTICIPANT_DESCRIPTION'::TEXT,
  eID := EMPLOYEE_ID_FROM_SESSION_VARIABLE_GOES_HERE::INT
)
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT createOutOfHouseParticipant(
       outOfHouseParticipantId := $1::INT,
       participantAge := $2::INT,
       participantRace := $3::RACE,
       participantSex := $4::SEX,
       participantDescription := $5::TEXT,
       eID := $6::INT)',
          array(
            $participantID,
            $participantAge,
            $participantRace,
            $participantSex,
            $participantDescription,
            $employeeID));
```

## addAgencyReferral
**@returns** INT: formID

- SQL

```sql
SELECT addAgencyReferral(
  agencyReferralParticipantID := ID_FROM_PEOPLE_INSERT_GOES_HERE::INT,
  agencyReferralParticipantDateOfBirth := 'PARTICIPANT_DOB'::DATE,
  agencyReferralParticipantRace := 'PARTICPANT_RACE'::RACE,
  agencyReferralParticipantSex SEX DEFAULT NULL::SEX,
  houseNum := PARTICIPANT_NUM::INTEGER,
  streetAddress := 'PARTICIPANT_ADDRESS'::TEXT,
  apartmentInfo := 'PARTICIPANT_APARTMENT_INFO'::TEXT,
  zipCode := PARTICIPANT_ZIP_CODE::VARCHAR(5),
  city := 'PARTICIPANT_CITY'::TEXT,
  state := 'STATE'::STATES,
  referralReason := 'PARTICIPANT_REFERRAL_REASON'::TEXT,
  hasAgencyConsentForm :=FALSE::BOOLEAN,
  referringAgency :='REFERRING_AGENCY'::TEXT,
  referringAgencyDate := 'DATE_AS_YYYY-MM-DD'::DATE,
  additionalInfo := 'ADDITIONAL_INFO'::TEXT,
  hasSpecialNeeds :=FALSE::BOOLEAN,
  hasSubstanceAbuseHistory :=FALSE::BOOLEAN,
  hasInvolvementCPS :=FALSE::BOOLEAN,
  isPregnant :=FALSE::BOOLEAN,
  hasIQDoc :=FALSE::BOOLEAN,
  mentalHealthIssue :=FALSE::BOOLEAN,
  hasDomesticViolenceHistory :=FALSE::BOOLEAN,
  childrenLiveWithIndividual :=FALSE::BOOLEAN,
  dateFirstContact :='DATE_AS_YYYY-MM-DD'::DATE,
  meansOfContact :='MEANS_OF_CONTACT'::TEXT,
  dateOfInitialMeeting :='DATE_AS_YYYY-MM-DD'::DATE,
  location :='LOCATION'::TEXT,
  comments :='COMMENTS'::TEXT,
  eID := employeeID::INTEGER
);
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
  'SELECT addAgencyReferral(
          agencyReferralParticipantID := $1::INT,
          agencyReferralParticipantDateOfBirth := $2::DATE,
          agencyReferralParticipantRace := $3::RACE,
          agencyReferralParticipantSex := $4::SEX,
          houseNum := $5::INTEGER,
          streetAddress := $6::TEXT,
          apartmentInfo := $7::TEXT,
          zipCode := $8::INTEGER,
          city := $9::TEXT,
          state := $10::STATES,
          referralReason := $11::TEXT,
          hasAgencyConsentForm := $12::BOOLEAN,
          referringAgency := $13::TEXT,
          referringAgencyDate := $14::DATE,
          additionalInfo := $15::TEXT,
          hasSpecialNeeds :=$16::BOOLEAN,
          hasSubstanceAbuseHistory :=$17::BOOLEAN,
          hasInvolvementCPS :=$18::BOOLEAN,
          isPregnant :=$19::BOOLEAN,
          hasIQDoc := $20::BOOLEAN,
          mentalHealthIssue := $21::BOOLEAN,
          hasDomesticViolenceHistory := $22::BOOLEAN,
          childrenLiveWithIndividual := $23::BOOLEAN,
          dateFirstContact := $24::DATE,
          meansOfContact := $25::TEXT,
          dateOfInitialMeeting := $26::DATE,
          location := $27::TEXT,
          comments := $28::TEXT,
          eID := $29::INTEGER)',
              array(
               $persID,
               $pers_dob,
               $pers_race,
               $pers_sex,
               $pers_address_num,
               $pers_address_street,
               $pers_apartment,
               $pers_zip,
               $pers_city,
               $pers_state,
               $pers_reason,
               $chkSigned,
               $ref_party,
               $ref_date,
               $additional_info,
               $chkSpecialEd,
               $chkSubAbuse,
               $chkCPS,
               $chkPreg,
               $chkIQ,
               $chkMental,
               $chkViolence,
               $chkReside,
               $office_contact_date,
               $office_means,
               $office_initial_date,
               $office_location,
               $comments,
               $employeeID)); 
```

## agencyMemberInsert
**@returns** VOID

Must call peopleInsert AND createAgencyReferral before calling this function

- SQL
```sql
SELECT agencyMemberInsert(
  agencyMemberID := ID_FROM_PEOPLE_INSERT_GOES_HERE::INT,
  agen := agencyMember_Referral_Type::referraltype,
  phn := agencyMember_Phone::int,
  em := agencyMember_Email::text,
  isMain := is_Main_Agency::boolean,
  arID := FORM_ID_FROM_ADD_AGENCY_REFERRAL_GOES_HERE::int
);
```
In the above function, isMain should be marked TRUE for adding the main agency filling out the referral form (e.g. the one on the front page) and marked FALSE for the agencies that come from the "other agencies working with referred individual" page.

## createFamilyMember
**@returns** VOID

- SQL
```sql
SELECT createFamilyMember(  
  familyMemberFName := 'personfname'::TEXT,
  familyMemberLName := 'personlname'::TEXT,
  familyMemberMiddleInit := 'personminit'::VARCHAR(1),
  rel := Family_Member_Relationship::RELATIONSHIP,
  dob := Family_Member_DOB::DATE,
  race := Family_Member_Race::RACE,
  gender := Family_Member_Sex::SEX,
  child := If_Child_Set_True_If_Not_Set_False::BOOLEAN,
  cust := Child_Custody_Info::TEXT,
  loc := Child_Location::TEXT,
  fID := FORM_ID_FROM_INTAKE_OR__REFERRAL_GOES_HERE::INT);
```

## addSelfReferral
**@returns** INT (formID)

Must call peopleInsert before calling this function

- SQL
```sql
SELECT addSelfReferral(
    referralParticipantID := ID_FROM_PEOPLE_INSERT_GOES_HERE::INT,
    referralDOB := 'PARTICIPANT_DOB'::DATE,
    referralRace := 'PARTICIPANT_RACE'::RACE,
    referralSex := 'PARTICIPANT_SEX'::SEX,
    houseNum := PARTICIPANT_HOUSE_NUM::INT,
    streetAddress := 'PARTICIPANT_ADDRESS'::TEXT,
    apartmentInfo := 'PARTICIPANT_APARTMENT'::TEXT,
    zip := 'PARTICIPANT_ZIPCODE'::VARCHAR(5),
    cityName := 'PARTICIPANT_CITY'::TEXT,
    stateName := 'PARTICIPANT_STATE'::STATES,
    refSource := 'PARTICIPANT_REF_SOURCE'::TEXT,
    hasInvolvement := 'PARTICIPANT_INVOLVEMENT'::BOOLEAN,
    hasAttended := 'PARTICIPANT_PREVIOUS_ATTENDANCE'::BOOLEAN,
    reasonAttending := 'PARTICIPANT_REASON'::TEXT,
    firstCall := 'PARTICIPANT_FIRST_CALL_DATE'::DATE,
    returnCallDate := 'PARTICIPANT_RETURN_CALL_DATE'::DATE,
    startDate := 'PARTICIPANT_START_DATE'::DATE,
    classAssigned := 'PARTICIPANT_CLASS'::TEXT,
    letterMailedDate := 'PARTICIPANT_MAILED_DATE'::DATE,
    extraNotes := 'PARTICIPANT_FORM_NOTES'::TEXT,
    eID := ID_FROM_LOGGED_IN_EMPLOYEE::INT);
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'SELECT addSelfReferral(
    referralParticipantID := $1::INT,
    referralDOB := $2::DATE,
    referralRace := $3::RACE,
    referralSex := $4::SEX,
    houseNum := $5::INT,
    streetAddress := $6::TEXT,
    apartmentInfo := $7::TEXT,
    zip := $8::VARCHAR(5),
    cityName := $9::TEXT,
    stateName := $10::STATES,
    refSource := $11::TEXT,
    hasInvolvement := $12::BOOLEAN,
    hasAttended := $13::BOOLEAN,
    reasonAttending := $14::TEXT,
    firstCall := $15::DATE,
    returnCallDate := $16::DATE,
    startDate := $17::DATE,
    classAssigned := $18::TEXT,
    letterMailedDate := $19::DATE,
    extraNotes := $20::TEXT,
    eID := $21::INT)',
                array(
                $participantID,
                $dob,
                $race,
                $sex,
                $houseNum,
                $streetAddress,
                $apartmentInfo,
                $zip,
                $cityName,
                $stateName,
                $refSource,
                $hasInvolvement,
                $hasAttended,
                $reasonAttending,
                $firstCall,
                $returnCallDate,
                $startDate,
                $classAssigned,
                $letterMailedDate,
                $extraNotes,
                $employeeID));
```


## employeeInsert
**@returns** VOID

Must call peopleInsert before calling this function

- SQL
```sql
SELECT employeeInsert(
  personID := ID_FROM_PERSON_INSERT_GOES_HERE::INT,
  em := EMPLOYEE_EMAIL::TEXT,
  pPhone := EMPLOYEE_PHONE::TEXT,
  pLevel := EMPLOYEE_PERMISSION_LEVEL::PERMISSION
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'SELECT employeeInsert(
    personID := $1::INT,
    em := $2::TEXT,
    pPhone := $3::TEXT,
    pLevel := $4::PERMISSION)',
                  array(
                  $employeeID,
                  $email,
                  $phone,
                  $permissionLevel));
```


## facilitatorInsert
**@returns** VOID

Must call peopleInsert before calling this function

- SQL
```sql
SELECT facilitatorInsert(
  personID := ID_FROM_PERSON_INSERT_GOES_HERE::INT,
  em := FACILITATOR_EMAIL::TEXT,
  pPhone := FACILITATOR_PHONE::TEXT,
  pLevel := FACILITATOR_PERMISSION_LEVEL::PERMISSION
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'SELECT facilitatorInsert(
    personID := $1::INT,
    em := $2::TEXT,
    pPhone := $3::TEXT,
    pLevel := $4::PERMISSION)',
                  array(
                  $facilitatorID,
                  $email,
                  $phone,
                  $permissionLevel));
```




## peopleInsert
**@returns** INT (peopleID)

- SQL
```sql
SELECT peopleInsert(
  fName := PERSON_FIRST_NAME::TEXT,
  lName := PERSON_LAST_NAME::TEXT,
  mINIT := PERSON_MIDDLE_INITIAL::VARCHAR(1)
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'SELECT peopleInsert(
    fName := $1::INT,
    lName := $2::TEXT,
    mInit := $3::VARCHAR(1))',
                  array(
                  $firstName,
                  $lastName,
                  $middleInitial));
```




## surveyInsert
**@returns** VOID

- SQL
```sql
SELECT surveyInsert(
    surveyParticipantName := PARTICIPANT_NAME::TEXT,
    surveyMaterialPresentedScore := MATERIAL_SCORE::INT,
    surveyPresTopicDiscussedScore := TOPIC_DISCUSSED::INT,
    surveyPresOtherParentsScore := OTHER_PARENTS::INT,
    surveyPresChildPerspectiveScore := CHILD_PERSPECTIVE::INT,
    surveyPracticeInfoScore := PRACTICE_INFO::INT,
    surveyRecommendScore := RECOMMEND:INT,
    surveySuggestedFutureTopics := 'SUGGESTED_FUTURE_TOPICS'::TEXT,
    surveyComments := 'COMMENTS'::TEXT,
    surveyClassID := CLASS_ID::INT,
    surveyCurriculumID := CURRICULUM_ID::INT,
    surveyStartTime := 'CLASS_START_TIME'::TIMESTAMP,
    surveySiteName := 'SITE_NAME'::TEXT,
    firstWeek := 'FIRST_WEEK'::TEXT,
    topicName := 'TOPIC_NAME'::TEXT,
    gender := 'GENDER'::SEX,
    race := 'RACE'::RACE,
    age := AGE::INT
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'SELECT surveyInsert(
    surveyParticipantName := $1::INT,
    surveyMaterialPresentedScore := $2::INT,
    surveyPresTopicDiscussedScore := $3::INT,
    surveyPresOtherParentsScore := $4::INT,
    surveyPresChildPerspectiveScore := $5::INT,
    surveyPracticeInfoScore := $6::INT,
    surveyRecommendScore := $7::INT,
    surveySuggestedFutureTopics := $8::TEXT,
    surveyComments := $9::TEXT,
    surveyClassID := $10::INT,
    surveyCurriculumID := $11::INT,
    surveyStartTime := $12::TIMESTAMP,
    surveySiteName := $13::TEXT,
    firstWeek := $14::TEXT,
    topicName := $15::TEXT,
    gender := $16::SEX,
    race := $17::RACE,
    age := $18::INT)',
                  array(
                  $participantName,
                  $materialScore,
                  $topicDiscussed,
                  $otherParents,
                  $childPerspective,
                  $practiceInfo,
                  $recommend,
                  $futureTopics,
                  $comments,
                  $classID,
                  $curriculumId,
                  $surveyStarTime,
                  $siteName,
                  $firstWeek,
                  $topicName,
                  $gender,
                  $race,
                  $age));
```
