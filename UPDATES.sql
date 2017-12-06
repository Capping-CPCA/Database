--Participants
UPDATE 
Participants
SET 
dateOfBirth = newDateOfBirth,
race = newRace,
sex = newSex
WHERE 
participantID = newParticipantID;

--Addresses
UPDATE
Addresses
SET
addressNumber = newAddressNumber,
aptInfo = newAptInfo,
street = newStreet,
zipCode = newZipCode
WHERE
addressID = newAddressID;

--Self Referral
UPDATE 
SelfReferral
SET 
referralSource = newReferralSource,
hasInvolvementCPS = newHasInvolvementCPS,
hasAttendedPEP = newHasAttendedPEP,
reasonAttendingPEP = newReasonAttendingPEP,
dateFirstCall = newDateFirstCall,
returnClientCallDate = newReturnClientCallDate,
tentativeStartDate = newTentativeStartDate,
classAssignedTo = newClassAssignedTo,
introLetterMailedDate = newIntroLetterMailedDate,
Notes = newNotes
WHERE
selfReferralID = newSelfReferralID;

--Agency Referral
UPDATE
AgencyReferral
SET
agencyReferralID = newAgencyReferralID,
reason = newReason.
hasAgencyConsentForm = newHasAgencyConsentForm,
additionalInfo = newAdditionalInfo,
hasSpecialNeeds = newHasSpecialNeeds,
hasSubstanceAbuseHistory = newHasSubstanceAbuseHistory,
hasInvolvementCPS = newHasInvolvementCPS,
isPregnant = newIsPregnant
hasIQDoc = newHasIQDoc,
hasMentalHealth = newHasMentalHealth,
hasDomesticViolenceHistory = newHasDomesticViolenceHistory,
childrenLiveWithIndividual = newChildrenLiveWithIndividual,
dateFirstContact = newDateFirstContact,
meansOfContact = newMeansOfContact,
dateOfInitialMeet = newDateOfInitialMeet,
location = newLocation,
comments = newComments
WHERE
agencyReferralID = newAgencyReferralID;

--Intake
UPDATE 
IntakeInformation
WHERE
occupation = newoccupation,
religion = newreligion,
handicapsOrMedication = newhandicapsOrMedication,
lastYearOfSchoolCompleted = newlastYearOfSchoolCompleted,
hasSubstanceAbuseHistory = newhasSubstanceAbuseHistory,
substanceAbuseDescription = newsubstanceAbuseDescription,
timeSeparatedFromChildren = newtimeSeparatedFromChildren,
timeSeparatedFromPartner = newtimeSeparatedFromPartner,
relationshipToOtherParent = newrelationshipToOtherParent,
hasParentingPartnershipHistory = newhasParentingPartnershipHistory,
hasInvolvementCPS = newhasInvolvementCPS,
previouslyInvolvedWithCPS = newpreviouslyInvolvedWithCPS,
isMandatedToTakeClass = newisMandatedToTakeClass,
mandatedByWhom = newmandatedByWhom,
reasonForAttendence = newreasonForAttendence,
safeParticipate = newsafeParticipate,
preventativeBehaviors = newpreventativeBehaviors,
attendedOtherParentingClasses = newattendedOtherParentingClasses,
previousClassInfo = newpreviousClassInfo,
wasVictim = newwasVictim,
formOfChildhoodAbuse = newformOfChildhoodAbuse,
hasHadTherapy = newhasHadTherapy,
feelStillHasIssuesFromChildAbuse = newfeelStillHasIssuesFromChildAbuse,
mostImportantLikeToLearn = newmostImportantLikeToLearn,
hasDomesticViolenceHistory = newhasDomesticViolenceHistory,
hasDiscussedDomesticViolence = newhasDiscussedDomesticViolence,
hasHistoryOfViolenceInOriginFamily = newhasHistoryOfViolenceInOriginFamily,
hasHistoryOfViolenceInNuclearFamily = newhasHistoryOfViolenceInNuclearFamily,
ordersOfProtectionInvolved = newordersOfProtectionInvolved,
reasonForOrdersOfProtection = newreasonForOrdersOfProtection,
hasBeenArrested = newhasBeenArrested,
hasBeenConvicted = newhasBeenConvicted,
reasonForArrestOrConviction = newreasonForArrestOrConviction,
hasJailOrPrisonRecord = newhasJailOrPrisonRecord,
offenseForJailOrPrison = newoffenseForJailOrPrison,
currentlyOnParole = newcurrentlyOnParole,
onParoleForWhatOffense = newonParoleForWhatOffense,
language = newlanguage,
otherFamilyTakingClass = newotherFamilyTakingClass,
familyMembersTakingClass = newfamilyMembersTakingClass,
ptpFormSignedDate = newptpFormSignedDate,
ptpEnrollmentSignedDate = newptpEnrollmentSignedDate,
ptpConstentReleaseFormSignedDate
WHERE 
intakeInformationID = newIntakeInformationID;

--Contact Agency Members
UPDATE 
ContactAgencyMembers
SET
agency = newAgency,
phone = newPhone,
email = newEmail
WHERE 
contactAgencyID = newContactAgencyID;

--Family Members
UPDATE 
FamilyMembers
SET 
relationship = newRelationship,
dateOfBirth = newDateOfBirth,
race = newRace,
sex = newSex
WHERE
familyMemberID = newFamilyMemberID;


