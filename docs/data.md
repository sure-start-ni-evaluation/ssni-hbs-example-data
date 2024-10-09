# Description of data and variables

Note: Variable names may not be exact in the real data. Everything is linked by an individuals Health and Care Number (HCN, de-identified)


# SOA to ward code lookup

Lookup for SOA codes (2001) to ward codes (1992). All SOAs are either wards or sub-divisions of wards (with minor exceptions). 

# NIMATS summary

The Northern Ireland Maternity System (NIMATs) contains a range of demographic and clinical information on mothers and infants. It captures data relating to the current complete maternity process, but also contains details about the mother’s past medical and obstetric history. It is a key source for data on birth numbers, interventions, maternal risk factors, birth weights, maternal smoking, BMI and breastfeeding on discharge.

## nimats main 
Core variables on mothers and infants. One row = one infant - mother dyad.


- birth_ward = Birth ward code 1992 (M)
- birth_soa =  Birth SOA (2001 code)
- current_soa_202x =  SOA of mother on Jan 202X (2001 SOA code, mother) 
- dob_mon_i = DOB Month (Infant)
- dob_year_i = DOB Year (Infant)
- age_m = Age at birth (Mother)
- emp_m = Employment status (Mother)
- bmi_book_m = Mother BMI at booking
- married_m = Martial status (Mother)
- eth_white_m = Ethnic group (banded, mother)
- cob_ireuk_m = Country of birth (banded UK/ non-UK, mother)
- prev_births_m = Number of previous births (Mother)
- booking_ward = Ward 1992 of residence (Mother) at booking appointment
- booking_soa = 2001 SOA code (mother) at booking appointment


## nimats previous obsteric history
One row = one pregancy event. 

- whooley_1 = Whooley Mood question 1 (Mood Q1). The Whooley questionnaire is a two question screening tool for depression. 
- whooley_2 = Whooley Mood question 2 (Mood Q2)
- prev_ment_disorder_m = Previous mental health and mother reported disorders 
- birth_this_n = Births this pregnancy
- sw_at_preg = Social worker at pregnancy (changed to social services in 2017)
- smoke_preg_m = Smoking during pregnancy (mother)
- smoke_preg_p = Smoking during pregnancy (partner)
- alc_preg_m = alcohol (mother, units drunk)

## nimats breastfeeding
- bfeed_meth = Feeding Method (Description of feeding method used during hospital stay)
- bfeed_cd = Feeding Code
- bfeed_attempt = Breast Feeding Attempted (This object identifies whether or not the mother attempted to breastfeed during the stay in hospital (Y/N)):
- bfeed_help_home = Help at home (This object indicates if the mother has been offered support to ensure that she can access help when at home (Y/N))

## nimats delivery 
Details of mother at delivery. One row = one delivery event

- bmi_deliv_m = Mother's BMI at delivery


## nimats parenting 
Related to parenting, one row = one mother-infant dyad. 

- comm_baby_parent = Communicate with baby
- resp_baby_parent = Responding to baby
- skin2skin_birth = Skin to skin/ skin to skin at birth (recorded at various times)
- skin2skin_feed = Skin to skin contact until after first feed
- skin2skin_1hr = Skin to skin contract for after one hour
- bfeed_offer_birth = Breastfeeding offered at birth
- bfeed_init_birth = Breastfeeding initiated at birth
- formula_birth = Formula fed by mum at birth
- response_parent = Responsiveness for mother

## nimats postnatal 
Post-birth details (recorded by health visitors?)

- smoke_12hr_m = Smoking last 12 hours 
- smoke_postnatal_cd_m = Currently smoking code
- smoke_postnatal_m = Currently smoking description
- cigs_n_m = Number of cigaretters smoked per day
- smoke_refer_m =  Refer to smoking cessation
- smoke_refer_acpt_m = Referal accepted 
- meds_m = Uptake of maternal medication (vitamins, folic acid, iron)


## nimats referrals 
Referrals to other services. 

- grfb_refer = Getting Ready For Baby (GRFB) suitable/offered/ accepted/ completed
- stop_smoke_refer = Attend stop smoking service



# Non-NIMATS paitent data 

This is a collection of other de-identified health and social care records. 

## PAS (patient administration system)
This is inpatient administration system used by all five health and social care trusts in NI. 1 row = 1 paitent and episode

- id_hcn = HCN
- `03ADMIT_DATE` = admission date
- hosp_m = Hospitalisation event (mother)
- hosp_i = Hospitalisation event (infant)
- `55CATEGORYONADMISSION` = category of admission
- `22AGE` = age of mother
- `23AGEOFINFANT` = age of infant 
- `25PRIME_DIAG` = primary diagnosis
- STAY_DUR = stay duration
- SEC_DIAGNOSIS1 [....] 15 = Secondary diagnoses (several fields) 

## NIRAES 
Accident and Emergency System for *some* health and social care trusts. Not all trusts use NIRAES (see symphony below).

- id_hcn = HCN
- arrive_niraes = Arrival date
- dept_nirases = Departure date
- incid_typ_niraes = Incident type description
- incid_cd_niraes = Incident type code

## symphony 
Accident and Emergency System for *some* health and social care trusts.

- id_hcn = HCN
- attend_typ_symp = Attend type
- incid_typ_symp = Incident type
- diag_typ_symp = Diagnosis type description
- arrive_symp = Arrival Date
- dept_symp = Discharge Date
  

## GP registration database

- id_hcn = HCN
- Sex = Sex
- dob_yr = Year Birth
- dob_mn = Month of Birth
- reg200x = Registration status in Jan 200x
 
## Dental payment system

- TreatmentCodeId = TreatmentCodeId.  Information on the treatment information recorded for the visit (i.e. x-ray, scale & polish, routine exam, fillings etc.) 
- NumberOfTreatments = Number of treatments (of that particular SDR code)
- RemissionExemptionId = Remission Exemption . Patients who may be eligible for reduced rates/  free treatment
- AcceptanceDate = treatment acceptance date
- CompletionDate = treatment completion date
- special_need = Special Needs Flag (using special needs registration fee)  


# SOSCARE

Social care database. One row is one individual - episode. Some sites stopped using SOSCARE. 


## referrals 

- site = site
- date_referred = date referred
- referral_type_description = referral_type_description
- REASON_REFERRED_CODE_DESC= reason referred
- date_closed= date_closed
- REASON_CLOSED_CODE_DESC 
- REASON_TERM_CODE_DESC

# child in need module 

- site = site/trust
- date_int_ref= date of initial referral
- DATE_INIT_ASSESS = initial assessment date
- OUTCOME_CATEGORY_DESC = outcome category


# child protection 
- date_regd 
- date_removed 
- primary_abuse_desc 
- cp_code2_desc 
- cp_code3_desc 
- cp_code4_desc 
- site 


# children in care 

- site 
- CIN_SEQ =  seq no. of episode - Need to identify first episode/ order of epsidoes
- REASON_CO_OPENED_DESC = reason in care
- DATE_OPENED =  episode start


