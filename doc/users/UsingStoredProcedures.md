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

## RegisterParticipantIntake
**@returns** VOID

- SQL

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

- PHP

```php
$con = pg_connect('host=**** port=5432 user=**** password=**** dbname=****');
pg_query($con, 'BEGIN;');
$result = pg_query_params($con,
    'SELECT registerParticipantIntake(
      fName := $1::TEXT,
      lName := $2::TEXT,
      dob := $3::DATE,
      race:= $4::TEXT,
      houseNum := $5::INT,
      streetAddress := $6::TEXT,
      zipCode := $7::INT,
      city := $8::TEXT,
      state := $9::TEXT,
      secondaryPhone := $10::TEXT,
      occupation := $11::TEXT,
      religion := $12::TEXT,
      ethnicity := $13::TEXT,
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
      employeeEmail := $42::TEXT
    )',
    array('PARTICIPANT_FIRSTNAME',
        'PARTICIPANT_LASTNAME',
        'PARTICIPANT_DOB',
        'PARTICIPANT_RACE',
        PARTICIPANT_HOUSE_NUM,
        'PARTICIPANT_STREET_ADDRESS',
        PARTICIPANT_ZIP_CODE,
        'PARTICIPANT_CITY',
        'PARTICIPANT_STATE',
        'PARTICIPANT_SECONDARY_PHONE',
        'PARTICIPANT_OCCUPATION',
        'PARTICIPANT_RELIGION',
        'PARTICIPANT_ETHNICITY',
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
        'EMPLOYEE_SIGNED'));
```

## ParticipantAttendanceInsert
**@returns** VOID

- SQL
```sql
SELECT ParticipantAttendanceInsert(
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
    'SELECT ParticipantAttendanceInsert(
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
