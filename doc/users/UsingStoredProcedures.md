Using Stored Procedures
=====================================

Stored Procedures use keyword arguments, for example if you have the stored procedure `foo` with the parameter `bar`, in PostgreSQL to call procedure `foo` you must do the following

<p style="text-align:center;"><code>foo(bar = 2)</code></p>

where `bar = 2` refers to the parameter that we are passing, which we are setting to the value of `2`. **NOTE** this is the general idea of using Postgres functions in this database. More specifically, for this database, if a user/developer was to call the stored procedure `RegisterParticipantIntake` it would look something like the following

```sql
SELECT registerParticipantIntake(
  fName := 'PARTICIPANT_FIRST_NAME'::TEXT,
  lName := 'PARTICIPANT_LAST_NAME'::TEXT,
  dob := 'PARTICIPANT_DOB'::DATE,
  race:= 'PARTICIPANT_RACE'::TEXT,
  houseNum := PARTICIPANT_HOUSE_NUM::INT,
  streetAddress := 'PARTICIPANT_STREET_ADDRESS'::TEXT,
  zipCode := PARTICIPANT_ZIP_CODE::INT,
  city := 'PARTICIPANT_CITY'::TEXT,
  state := 'PARTICIPANT_STATE'::TEXT,
  secondaryPhone := 'PARTICIPANT_SECONDARY_PHONE'::TEXT,
  occupation := 'PARTICIPANT_OCCUPATION'::TEXT,
  religion := 'PARTICIPANT_RELIGION'::TEXT,
  ethnicity :='PARTICIPANT_ETHNICITY'::TEXT,
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
  victimChildAbuse := PARTICIPANT_VICTIM_CHILD_ABUSE::BOOLEAN,
  hasHadTherapy := PARTICIPANT_HAS_HAD_THERAPY::BOOLEAN,
  mostImportantLikeToLearn := 'PARTICIPANT_LESSONS_TO_LEARN'::TEXT,
  hasDomesticViolenceHistory := PARTICIPANT_DOMESTIC_VIOLENCE_HIST::BOOLEAN,
  hasHistoryChildAbuseOriginFam := PARTICIPANT_CHILD_ABUSE_ORIGIN::BOOLEAN,
  hasHistoryViolenceNuclearFamily := PARTICIPANT_VIOLENCE_NUCLEAR::BOOLEAN,
  ordersOfProtectionInvolved := PARTICIPANT_ORDERS_PROTECTION::BOOLEAN,
  hasBeenArrested := PARTICIPANT_ARRESTED::BOOLEAN,
  hasBeenConvicted := PARTICIPANT_CONVICTED::BOOLEAN,
  hasJailRecord := PARTICIPANT_JAIL_RECORD::BOOLEAN,
  hasPrisonRecord := PARTICIPANT_PRISON_RECORD::BOOLEAN,
  currentlyOnParole := PARTICIPANT_CURRENTLY_PAROLE::BOOLEAN,
  ptpMainFormSignedDate := 'PARTICIPANT_MAIN_FORM_SIGNED_DATE'::DATE,
  ptpEnrollmentSignedDate := 'PARTICIPANT_ENROLLMENT_SIGNED_DATE'::DATE,
  ptpConstentReleaseFormSignedDate := 'PARTICIPANT_CONSENT_RELEASED_SIGNED_DATE'::DATE,
  employeeEmail := 'EMPLOYEE_SIGNED'::TEXT
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
  zipCode := PARTICIPANT_ZIP_CODE::INT,
  city := 'PARTICIPANT_CITY'::TEXT,
  state := 'PARTICIPANT_STATE'::TEXT,
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
  victimChildAbuse := PARTICIPANT_VICTIM_CHILD_ABUSE::BOOLEAN,
  hasHadTherapy := PARTICIPANT_HAS_HAD_THERAPY::BOOLEAN,
  mostImportantLikeToLearn := 'PARTICIPANT_LESSONS_TO_LEARN'::TEXT,
  hasDomesticViolenceHistory := PARTICIPANT_DOMESTIC_VIOLENCE_HIST::BOOLEAN,
  hasHistoryChildAbuseOriginFam := PARTICIPANT_CHILD_ABUSE_ORIGIN::BOOLEAN,
  hasHistoryViolenceNuclearFamily := PARTICIPANT_VIOLENCE_NUCLEAR::BOOLEAN,
  ordersOfProtectionInvolved := PARTICIPANT_ORDERS_PROTECTION::BOOLEAN,
  hasBeenArrested := PARTICIPANT_ARRESTED::BOOLEAN,
  hasBeenConvicted := PARTICIPANT_CONVICTED::BOOLEAN,
  hasJailRecord := PARTICIPANT_JAIL_RECORD::BOOLEAN,
  hasPrisonRecord := PARTICIPANT_PRISON_RECORD::BOOLEAN,
  currentlyOnParole := PARTICIPANT_CURRENTLY_PAROLE::BOOLEAN,
  ptpMainFormSignedDate := 'PARTICIPANT_MAIN_FORM_SIGNED_DATE'::DATE,
  ptpEnrollmentSignedDate := 'PARTICIPANT_ENROLLMENT_SIGNED_DATE'::DATE,
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
      timeSeparatedFromChildren := $16::TEXT,
      timeSeparatedFromPartner := $17::TEXT,
      relationshipToOtherParent := $18::TEXT,
      hasParentingPartnershipHistory := $19::BOOLEAN,
      hasInvolvementCPS := $20::BOOLEAN,
      hasPrevInvolvementCPS := $21::TEXT,
      isMandatedToTakeClass := $22::BOOLEAN,
      reasonForAttendence := $23::TEXT,
      safeParticipate := $24::TEXT,
      preventParticipate := $25::TEXT,
      hasAttendedOtherParenting := $26::BOOLEAN,
      victimChildAbuse := $27::BOOLEAN,
      hasHadTherapy := $28::BOOLEAN,
      mostImportantLikeToLearn := $29::TEXT,
      hasDomesticViolenceHistory := $30::BOOLEAN,
      hasHistoryChildAbuseOriginFam := $31::BOOLEAN,
      hasHistoryViolenceNuclearFamily := $32::BOOLEAN,
      ordersOfProtectionInvolved := $33::BOOLEAN,
      hasBeenArrested := $34::BOOLEAN,
      hasBeenConvicted := $35::BOOLEAN,
      hasJailRecord := $36::BOOLEAN,
      hasPrisonRecord := $37::BOOLEAN,
      currentlyOnParole := $38::BOOLEAN,
      ptpMainFormSignedDate := $39::DATE,
      ptpEnrollmentSignedDate := $40::DATE,
      ptpConstentReleaseFormSignedDate := $41::DATE,
      eID := $42::TEXT
    )',
    array('pID',
        'PARTICIPANT_DOB',
        'PARTICIPANT_RACE',
        'PARTICIPANT_SEX',
        PARTICIPANT_HOUSE_NUM,
        'PARTICIPANT_STREET_ADDRESS',
        'PARTICIPANT_APT_INFO',
        PARTICIPANT_ZIP_CODE,
        'PARTICIPANT_CITY',
        'PARTICIPANT_STATE',
        'PARTICIPANT_OCCUPATION',
        'PARTICIPANT_RELIGION',
        'PARTICIPANT_HANDICAPS_OR_MEDICATION',
        'PARTICIPANT_LAST_YEAR_SCHOOL',
        PARTICIPANT_DRUG_ABUSE_HIST,
        'PARTICIPANT_TIME_SEP_FROM_CHILDREN',
        'PARTICIPANT_TIME_SEP_FROM_PARTNER',
        'PARTICIPANT_REL_TO_OTHER_PARENT',
        PARTICIPANT_PARENTING_HISTORY,
        HAS_INVOLVEMENT_CPS,
        'PARTICIPANT_PREV_INVOLVEMENT_CPS',
        PARTICIPANT_MANDATED_TAKE_CLASS,
        'PARTICIPANT_REASON_ATTENDANCE',
        'PARTICIPANT_SAFE_PARTICIPATION',
        'PARTICIPANT_PREVENT_PARTICIPATION',
        PARTICIPANT_ATTENDING_OTHER_PARENTING,
        PARTICIPANT_VICTIM_CHILD_ABUSE,
        PARTICIPANT_HAS_HAD_THERAPY,
        'PARTICIPANT_LESSONS_TO_LEARN',
        PARTICIPANT_DOMESTIC_VIOLENCE_HIST,
        PARTICIPANT_CHILD_ABUSE_ORIGIN,
        PARTICIPANT_VIOLENCE_NUCLEAR,
        PARTICIPANT_ORDERS_PROTECTION,
        PARTICIPANT_ARRESTED,
        PARTICIPANT_CONVICTED,
        PARTICIPANT_JAIL_RECORD,
        PARTICIPANT_PRISON_RECORD,
        PARTICIPANT_CURRENTLY_PAROLE,
        'PARTICIPANT_MAIN_FORM_SIGNED_DATE',
        'PARTICIPANT_ENROLLMENT_SIGNED_DATE',
        'PARTICIPANT_CONSENT_RELEASED_SIGNED_DATE',
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
**@returns** INT: corresponds to the participantID that you are inserting

- SQL
```sql
SELECT createOutOfHouseParticipant(
   participantFirstName := 'PARTICIPANT_FIRST_NAME'::TEXT,
   participantMiddleInit := 'PARTICIPANT_MIDDLE_INITIAL'::TEXT,
   participantLastName := 'PARTICIPANT_LAST_NAME'::TEXT,
   participantAge := PARTICIPANT_AGE::INT,
   participantRace := 'PARTICIPANT_RACE'::RACE,
   participantSex := 'PARTICIPANT_SEX'::SEX,
   participantDescription := 'PARTICIPANT_DESCRIPTION'::TEXT)
```
- PHP
```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT createOutOfHouseParticipant(
       participantFirstName := $1::TEXT,
       participantMiddleInit := $2::TEXT,
       participantLastName := $3::TEXT,
       participantAge := $4::INT,
       participantRace := $5::RACE,
       participantSex := $6::SEX,
       participantDescription := $7::TEXT)',
    array('PARTICIPANT_FIRST_NAME',
          'PARTICIPANT_MIDDLE_INITIAL',
          'PARTICIPANT_LAST_NAME',
          PARTICIPANT_AGE,
          'PARTICIPANT_RACE',
          'PARTICIPANT_SEX',
          'PARTICIPANT_DESCRIPTION'));
```

## addAgencyReferral
**@returns** INT: formID

- SQL

```sql
SELECT addAgencyReferral(
  agencyReferralParticipantID := ID_FROM_PEOPLE_INSERT_GOES_HERE::INT,
  agencyReferralParticipantDateOfBirth := 'PERSON_DATE_OF_BIRTH_GOES_HERE'::DATE,
  houseNum := PARTICIPANT_NUM::INTEGER,
  streetAddress := 'PARTICIPANT_ADDRESS'::TEXT,
  apartmentInfo := 'PARTICIPANT_APARTMENT_INFO'::TEXT,
  zipCode := PARTICIPANT_ZIP_CODE::INTEGER,
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
          houseNum := $3::INTEGER,
          streetAddress := $4::TEXT,
          apartmentInfo := $5::TEXT,
          zipCode := $6::INTEGER,
          city := $7::TEXT,
          state := $8::STATES,
          referralReason := $9::TEXT,
          hasAgencyConsentForm := $10::BOOLEAN,
          referringAgency := $11::TEXT,
          referringAgencyDate := $12::DATE,
          additionalInfo := $13::TEXT,
          hasSpecialNeeds :=$14::BOOLEAN,
          hasSubstanceAbuseHistory :=$15::BOOLEAN,
          hasInvolvementCPS :=$16::BOOLEAN,
          isPregnant :=$17::BOOLEAN,
          hasIQDoc := $18::BOOLEAN,
          mentalHealthIssue := $19::BOOLEAN,
          hasDomesticViolenceHistory := $20::BOOLEAN,
          childrenLiveWithIndividual := $21::BOOLEAN,
          dateFirstContact := $22::DATE,
          meansOfContact := $23::TEXT,
          dateOfInitialMeeting := $24::DATE,
          location := $25::TEXT,
          comments := $26::TEXT,
          eID := $27::INTEGER)',
              array(
              '$pers_firstname',
              '$pers_lastname',
              '$pers_middlein',
               $pers_dob,
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

- SQL
```sql
SELECT agencyMemberInsert(
fname := agencyMember_Fist_Name::TEXT,
lname := agencyMember_Last_Name::TEXT,  
mInit := agencyMember_M_Init::VARCHAR,
agen := agencyMember_Referral_Type::referraltype,
phn := agencyMember_Phone::int,
em := agencyMember_Email::text,
isMain := is_Main_Agency::boolean,
arID := formIDreturnedFromOtherProcedureGoesHere::int
)
```
In the above function, isMain should be marked TRUE for adding the main agency filling out the referral form (e.g. the one on the front page) and marked FALSE for the agencies that come from the "other agencies working with referred individual" page.

## createFamilyMember
**@returns** VOID

- SQL
```sql
SELECT createFamilyMember(  
fname := Family_Member_First_Name::TEXT,
lname := Family_Member_Last_Name::TEXT,  
mInit := Family_Member_M_Init::VARCHAR,
rel := Family_Member_Relationship::relationship,
dob := Family_Member_DOB::DATE,
rac := Family_Member_Race::RACE,
gender := Family_Member_Sex::SEX,
child := If_Child_Set_True_If_Not_Set_False::BOOLEAN,
cust := Child_Custody_Info::TEXT,
loc := Child_Location::TEXT,
fID := formIDreturnedFromOtherProcedureGoesHere::int)
```
