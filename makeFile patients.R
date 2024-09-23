# patient data (non-nimats) -----------------------------------------------


# load in some examples codes  --------------------------------------------

soa_ward_list <- 
  read_csv("data/soa code to ward code lookup.csv")

## create a function for consistent SOA/ WARD
take_area <-
  function(seed = 1234, wards = F, size = 15e3){
    set.seed(seed)
    take_rows = sample(1:length(soa_ward_list), size = 15e3, replace = T)
    
    if (wards){
      return(soa_ward_list$`Ward Code`[take_rows])
    }
    return(soa_ward_list$`SOA Code`[take_rows])
  }

## Load a master index of hcn ---------------------------------------------

master_hcn <-
  data.frame(
    id_hcn =  c(1:10e3, 1:15e3 %>% paste0('c'))
    
  )


# random functions --------------------------------------------------------

take_date <-
  function(size){
    sample(seq(as.Date('2010/01/01'), as.Date('2023/01/01'), by="day"), size, replace = T)
  }


## master function
take_sample <- 
  function(x, size = nrow(master_id_df)){
    x %>% sample(size = size, replace = T)
  }

# PAS (patient administration system) -------------------------------------
# 1 row = 1 paitent and episode


pas_rows = 20e3
take_sample_pas <- 
  function(x) take_sample(x, size = pas_rows)
pas_df <- 
  data.frame(
    id_hcn = master_hcn$id_hcn %>% take_sample_pas(), # HCN
    `03ADMIT_DATE` = pas_rows %>% take_date(), # 03ADMIT_DATE
    hosp_m = letters %>% take_sample_pas(),# Hospitalisation event (mother)
    hosp_i = letters %>% take_sample_pas(),# Hospitalisation event (infant)
    `55CATEGORYONADMISSION` = letters %>% take_sample_pas(), # 55CATEGORYONADMISSION
    `22AGE` = 19:45 %>% take_sample_pas(),# 22AGE
    `23AGEOFINFANT` = 0:5 %>% take_sample_pas(),# 23AGEOFINFANT 
    `25PRIME_DIAG` = letters %>% take_sample_pas(),# 25PRIME_DIAG (primary diagnosis)
    stay_dur_pas = 1:30 %>% take_sample_pas(),# STAY_DUR
    SEC_DIAGNOSIS1 = letters %>% take_sample_pas(),# SEC_DIAGNOSIS1-15
    SEC_DIAGNOSIS2 = letters %>% take_sample_pas(),# SEC_DIAGNOSIS1-15
    SEC_DIAGNOSIS3 = letters %>% take_sample_pas(),# SEC_DIAGNOSIS1-15
    SEC_DIAGNOSIS4 = letters %>% take_sample_pas(),# SEC_DIAGNOSIS1-15
    SEC_DIAGNOSIS5 = letters %>% take_sample_pas()# SEC_DIAGNOSIS1-15
  )

# NIRAES ------------------------------------------------------------------
niraes_rows <- 20e3
take_sample_niraes <- 
  function(x) take_sample(x, size = niraes_rows)

niraes_df <- 
  data.frame(
    id_hcn = master_hcn$id_hcn %>% take_sample_niraes(), # HCN
    arrive_niraes = take_date(niraes_rows),#Arrival date
    dept_nirases = take_date(niraes_rows), #Departure date
    incid_typ_niraes = letters %>% take_sample_niraes(), #Incident type description
    incid_cd_niraes = letters %>% take_sample_niraes() #Incident type code
    
  )

# symphony ----------------------------------------------------------------
symphony_row <- 20e3
take_sample_symphony <-
  function(x) take_sample(x, size = symphony_row)

symphony_df <-
  data.frame(
    id_hcn = master_hcn$id_hcn %>% take_sample_niraes(), # HCN
    attend_typ_symp = letters %>% take_sample_symphony(), # Attend type
    incid_typ_symp = letters %>% take_sample_symphony(), # Incident type
    diag_typ_symp = letters %>% take_sample_symphony(),# Diagnosis type description
    arrive_symp = symphony_row %>% take_date(),# Arrival Date
    dept_symp = symphony_row %>% take_date()# Discharge Date
  )

# gp_reg ------------------------------------------------------------------

gp_row <- 20e3
take_sample_gp <-
  function(x) take_sample(x, size = gp_row)

gp_df <- 
  data.frame(
    id_hcn = master_hcn$id_hcn %>% take_sample_gp(), # HCN
    Sex = letters[1:2] %>% take_sample_gp(), #Sex
    dob_yr = 2006:2023 %>% take_sample_gp(), ##Year Birth
    dob_mn = 1:12 %>% take_sample_gp(), ##Month of Birth
    reg2006_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2007_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2008_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2009_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2010_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2011_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2012_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2013_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2014_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2015_gp = letters %>% take_sample_gp(), ##Registration status (every year)
    reg2016_gp = letters %>% take_sample_gp() ##Registration status (every year)
    ## .. and so on
  )

# dental_reg --------------------------------------------------------------

dental_rows <- 20e3
take_sample_dental <-
  function(x) take_sample(x, size = dental_rows)

dental_df <-
  data.frame(
    id_hcn = master_hcn$id_hcn %>% take_sample_dental()
  ) %>%
  mutate(
    TreatmentCodeId = letters %>% take_sample_dental(), # TreatmentCodeId
    # TreatmentCodeId - Description of SDR Code
    NumberOfTreatments = 1:3 %>% take_sample_dental(), # NumberOfTreatments (of that particular SDR code)
    RemissionExemptionId = letters %>% take_sample_dental(), # RemissionExemptionId
    # RemissionExemptionId - Description
    AcceptanceDate = dental_rows %>% take_date(), # AcceptanceDate
    CompletionDate = AcceptanceDate + 1:20 %>% take_sample_dental(),# CompletionDate
    special_need = letters[1:2] %>% take_sample_dental()# Special Needs Flag (using special needs registration fee)  
    
  )


# save the output ---------------------------------------------------------
dental_df %>% write_csv('outputs/dental.csv')
gp_df %>% write_csv('outputs/gp.csv')
niraes_df %>% write_csv('outputs/niraes.csv')
pas_df %>% write_csv('outputs/pas.csv')
symphony_df %>% write_csv('outputs/symphony.csv')
