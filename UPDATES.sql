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

--SelfReferral
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
referralParticipantID = newReferralParticipantID;

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
