Using Stored Procedures
=====================================

Stored Procedures use keyword arguments, for example if you have the stored procedure `foo` with the parameter `bar`, in PostgreSQL to call procedure `foo` you must do the following

<p style="text-align:center;"><code>foo(bar = 2)</code></p>

where `bar = 2` refers to the parameter that we are passing, which we are setting to the value of `2`. **NOTE** this is the general idea of using Postgres functions in this database. More specifically, for this database, if a user/developer was to call the stored procedure `RegisterParticipantIntake` it would look something like the following

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
  timeSeparatedFromChildren := 'PARTICIPANT_TIME_SEP_FROM_CHILDREN'::TEXT,
  timeSeparatedFromPartner := 'PARTICIPANT_TIME_SEP_FROM_PARTNER'::TEXT,
  relationshipToOtherParent := 'PARTICIPANT_REL_TO_OTHER_PARENT'::TEXT,
  hasParentingPartnershipHistory := PARTICIPANT_PARENTING_HISTORY::BOOLEAN,
  hasInvolvementCPS := HAS_INVOLVEMENT_CPS::BOOLEAN,
  hasPrevInvolvementCPS := 'PARTICIPANT_PREV_INVOLVEMENT_CPS'::TEXT,
  isMandatedToTakeClass := PARTICIPANT_MANDATED_TAKE_CLASS::BOOLEAN,
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
    array(pID,
      'PARTICIPANT_DOB',
      'PARTICIPANT_RACE_OR_ETHNICITY',
      'PARTICIPANT_SEX',
       PARTICIPANT_HOUSE_NUM,
      'PARTICIPANT_STREET_ADDRESS',
      'PARTICIPANT_APT_INFO',
       PARTICIPANT_ZIP_CODE,
      'PARTICIPANT_CITY',
      'PARTICIPANT_STATE'::STATES,
      'PARTICIPANT_OCCUPATION',
      'PARTICIPANT_RELIGION',
      'PARTICIPANT_HANDICAPS_OR_MEDICATIONS',
      'PARTICIPANT_LAST_YEAR_SCHOOL',
       PARTICIPANT_DRUG_ABUSE_HIST,
      'PARTICIPANT_SUBSTANCE_ABUSE_DESCR', 
      'PARTICIPANT_TIME_SEP_FROM_CHILDREN',
      'PARTICIPANT_TIME_SEP_FROM_PARTNER',
      'PARTICIPANT_REL_TO_OTHER_PARENT',
       PARTICIPANT_PARENTING_HISTORY,
       HAS_INVOLVEMENT_CPS::BOOLEAN,
      'PARTICIPANT_PREV_INVOLVEMENT_CPS',
       PARTICIPANT_MANDATED_TAKE_CLASS,
      'PARTICIAPTN_WHO_MANDATED_CLASS', 
      'PARTICIPANT_REASON_ATTENDANCE',
      'PARTICIPANT_SAFE_PARTICIPATION',
      'PARTICIPANT_PREVENT_PARTICIPATION',
       PARTICIPANT_ATTENDING_OTHER_PARENTING,
      'PARTICIPANT_KIND_OF_PARENTING_CLASS',
       PARTICIPANT_VICTIM_CHILD_ABUSE,
       PARTICIPANT_FORM_OF_CHILD_ABUSE,
       PARTICIPANT_HAS_HAD_THERAPY,
      'PARTICIPANT_STILL_ISSUES_FROM_CHILD_ABUSE',
      'PARTICIPANT_LESSONS_TO_LEARN',
       PARTICIPANT_DOMESTIC_VIOLENCE_HIST,
      'PARTICIPANT_HAS_DISCUSSED_DOMESTIC_VIOLENCE,
       PARTICIPANT_CHILD_ABUSE_ORIGIN,
       PARTICIPANT_VIOLENCE_NUCLEAR,
       PARTICIPANT_ORDERS_PROTECTION,
      'PARTICIPANT_REASON_ORDERS_PROTECTION',
       PARTICIPANT_ARRESTED,
       PARTICIPANT_CONVICTED,
      'PARTICIPANT_REASON_FOR_ARREST',
       PARTICIPANT_JAIL_RECORD,
      'PARTICIPANT_OFFENSE_JAIL_REC',
       PARTICIPANT_CURRENTLY_PAROLE,
      'PARTICIPANT_ON_PAROLE_FOR_WHAT',
      'PARTICIPANT_MAIN_FORM_SIGNED_DATE',
      'PARTICIPANT_ENROLLMENT_SIGNED_DATE',
      'PARTICIPANT_LANGUAGE',
      'PARTICIPANT_CONSENT_RELEASED_SIGNED_DATE'
       employeeID));
  ```

## participantAttendanceInsert
**@returns** VOID

- SQL
```sql
SELECT participantAttendanceInsert(
    attendanceParticipantFName := 'PARTICIPANT_FIRST_NAME'::TEXT,
    attendanceParticipantMiddleInit := 'PARTICIPANT_MIDDLE_INITIAL'::TEXT,
    attendanceParticipantLName := 'PARTICIPANT_LAST_NAME'::TEXT,
    attendanceParticipantSex := 'PARTICIPANT_SEX'::SEX,
    attendanceParticipantRace := 'PARTICIPANT_RACE'::RACE,
    attendanceParticipantAge := PARTICIPANT_AGE::INT,
    attendanceTopic := 'CLASS_TOPIC'::TEXT,
    attendanceDate := 'CLASS_DATE'::DATE,
    attendanceSiteName := 'CLASS_SITE_NAME'::TEXT,
    attendanceComments := 'FACILITATOR_COMMENTS'::TEXT,
    attendanceNumChildren := PARTICIPANT_NUM_CHILDREN::INT,
    isAttendanceNew := IS_NEW_PARTICIPANT::BOOLEAN)
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT participantAttendanceInsert(
        attendanceParticipantFName := 'PARTICIPANT_FIRST_NAME'::TEXT,
        attendanceParticipantMiddleInit := 'PARTICIPANT_MIDDLE_INITIAL'::TEXT,
        attendanceParticipantLName := 'PARTICIPANT_LAST_NAME'::TEXT,
        attendanceParticipantSex := 'PARTICIPANT_SEX'::SEX,
        attendanceParticipantRace := 'PARTICIPANT_RACE'::RACE,
        attendanceParticipantAge := PARTICIPANT_AGE::INT,
        attendanceTopic := 'CLASS_TOPIC'::TEXT,
        attendanceDate := 'CLASS_DATE'::DATE,
        attendanceSiteName := 'CLASS_SITE_NAME'::TEXT,
        attendanceComments := 'FACILITATOR_COMMENTS'::TEXT,
        attendanceNumChildren := PARTICIPANT_NUM_CHILDREN::INT,
        isAttendanceNew := IS_NEW_PARTICIPANT::BOOLEAN)',
    array('PARTICIPANT_FIRST_NAME',
        'PARTICIPANT_MIDDLE_INITIAL',
        'PARTICIPANT_LAST_NAME',
        'PARTICIPANT_SEX',
        'PARTICIPANT_RACE',
        PARTICIPANT_AGE,
        'CLASS_TOPIC',
        'CLASS_DATE',
        'CLASS_SITE_NAME',
        'FACILITATOR_COMMENTS',
        PARTICIPANT_NUM_CHILDREN,
        IS_NEW_PARTICIPANT));
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
    array(ID_FROM_PEOPLE_INSERT_GOES_HERE,
          OUT_OF_HOUSE_PARTICIPANT_AGE,
          'OUT_OF_HOUSE_PARTICIPANT_RACE',
          'OUT_OF_HOUSE_PARTICIPANT_SEX',
          'OUT_OF_HOUSE_PARTICIPANT_DESCRIPTION',
          EMPLOYEE_ID_FROM_SESSION_VARIABLE_GOES_HERE));
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
              '$pers_address_street',
              '$pers_apartment',
               $pers_zip,
              '$pers_city',
              '$pers_state',
              '$pers_reason',
               $chkSigned,
              '$ref_party',
               $ref_date,
              '$additional_info',
               $chkSpecialEd,
               $chkSubAbuse,
               $chkCPS,
               $chkPreg,
               $chkIQ,
               $chkMental,
               $chkViolence,
               $chkReside,
               $office_contact_date,
              '$office_means',
               $office_initial_date,
              '$office_location',
              '$comments',
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
)
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
fID := FORM_ID_FROM_INTAKE_OR__REFERRAL_GOES_HERE::INT)
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
    surveyRecommendScore := RECOMMEND::INT,
    surveySuggestedFutureTopics := 'SUGGESTED_FUTURE_TOPICS'::TEXT,
    surveyComments := 'COMMENTS'::TEXT,
    surveyStartTime := 'CLASS_START_TIME'::TIMESTAMP,
    surveySiteName := 'SITE_NAME'::TEXT,
    firstWeek := FIRST_WEEK::BOOLEAN,
    topicName := 'TOPIC_NAME'::TEXT,
    gender := 'GENDER'::SEX,
    race := 'RACE'::RACE,
    ageGroup := 'AGE_GROUP'::TEXT
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
    surveyStartTime := $10::TIMESTAMP,
    surveySiteName := $11::TEXT,
    firstWeek := $12::BOOLEAN,
    topicName := $13::TEXT,
    gender := $14::SEX,
    race := $15::RACE,
    ageGroup := $16::INT)',
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
                  $surveyStarTime,
                  $siteName,
                  $firstWeek,
                  $topicName,
                  $gender,
                  $race,
                  $ageGroup));
```

## addressUpdate
**@returns** VOID

- SQL
```sql
SELECT addressUpdate(
    pID := PARTICIPANT_ID::INT,
    newAddressNumber := ADDRESS_NUMBER::INT,
    newAptInfo := APARTMENT_INFO::TEXT,
    newStreet := STREET_NAME::TEXT,
    newZipcode := ZIPCODE::VARCHAR(5),
    newCity := CITY::TEXT,
    newState := STATE::STATES
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'addressUpdate(
    pID := $1::INT,
    newAddressNumber := $2::INT,
    newAptInfo := $3::TEXT,
    newStreet := $4::TEXT,
    newZipcode := $5::VARCHAR(5),
    newCity := $6::TEXT,
    newState := $7::STATES)',
                  array(
                  $pID,
                  $newAddressNumber,
                  $newAptInfo,
                  $newStreet,
                  $newZipcode,
                  $newCity,
                  $newState));
```


## classOfferingUpdate
**@returns** VOID

- SQL
```sql
SELECT classOfferingUpdate(
    date := OLD_OFFERING_DATE::TIMESTAMP WITHOUT TIME ZONE,
    siteName := OLD_OFFERING_SITE::TEXT,
    newClassID := NEW_CLASS_ID::INT,
    newCurriculumID := NEW_CURRICULUM_ID::INT,
    newDate := NEW_OFFERING_DATE::TIMESTAMP WITHOUT TIME ZONE,
    newSiteName := NEW_SITE_NAME::TEXT,
    newLang := NEW_LANGUAGE::TEXT
);
```

- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
'classOfferingUpdate(
    date := $1::INT,
    siteName := $2::INT,
    newClassID := $3::TEXT,
    newCurriculumID := $4::TEXT,
    newDate := $5::VARCHAR(5),
    newSiteName := $6::TEXT,
    newLang := $7::STATES)',
                  array(
                  $date,
                  $siteName,
                  $newClassID,
                  $newCurriculumID,
                  $newDate,
                  $newSiteName,
                  $newLang));
```