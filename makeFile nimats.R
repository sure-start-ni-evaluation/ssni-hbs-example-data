## make nimats

library(tidyverse)


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
# create master id files of mothers and infants ---------------------------
## 10,000 unique mothers with 15,000 infants

master_id_df <-
  data.frame(
    id_hcn_m = sample(1:10e3, size = 15e3, replace = T), #HCN (M),
    id_hcn_i = 1:15e3 %>% paste0('c')
  )


## create a small function to sample 
take_sample <- 
  function(x, size = nrow(master_id_df)){
    x %>% sample(size = size, replace = T)
  }


## nimats-main ---------------------------------------------------------

nimats_main_df <-
  master_id_df %>%
  mutate(
    birth_ward = take_area(wards = T),# Birth ward code 1992 (M)
    birth_soa =  take_area(),# Birth SOA (2001 code)
    current_soa_2023 = take_area(seed = 12),# 2023 SOA (2001 code, mother) measured on Jan 2023
    current_soa_2024 = take_area(seed = 12),# residence of mother recorded Jan 2024 
    dob_mon_i = 1:12 %>% take_sample(), # DOB Month (Infant)
    dob_year_i = 2006:2022 %>% take_sample(), # DOB Year (Infant)
    age_m = 17:40 %>% take_sample(), # Age at birth (Mother)
    emp_m = c(T,F) %>% take_sample(),# Employment status (Mother)
    bmi_book_m = c(18:30, NA) %>% take_sample(), # Mother BMI at booking
    married_m = c(T, F) %>% take_sample(), # Martial status (Mother)
    eth_white_m = c(T, F) %>% take_sample(),# Ethnic group (banded, mother)
    cob_ireuk_m = c(T, F) %>% take_sample(),# Country of birth (banded UK/ non-UK, mother)
    prev_births_m = c(0, 0, 0:3) %>% take_sample(), # Number of previous births (Mother)
    booking_ward = take_area(wards = T), # Ward 1992 of residence (Mother) at booking appointment
    booking_soa = take_area() # 2001 SOA code (mother) at booking appointment
    
  )


## nimats-obsteric (previous obsteric history) -------------------------

nimats_obst_df <-
  master_id_df %>%
  mutate(
    whooley_1 = c(T,F) %>% take_sample(), #Whooley Mood question 1 (Mood Q1)
    whooley_2 = c(T,F) %>% take_sample(), #Whooley Mood question 2 (Mood Q2)
    prev_ment_disorder_m = c(T,F) %>% take_sample(), #Previous mental health and mother reported disorders 
    birth_this_n = 1:2 %>% take_sample(), #Births this pregnancy
    sw_at_preg = c(T,F) %>% take_sample(), #Social worker at pregnancy (changed to social services in 2017)
    smoke_preg_m = c(T,F) %>% take_sample(),#Smoking (mother)
    smoke_preg_p = c(T,F) %>% take_sample(), #Smoking (partner)
    alc_preg_m = 0:4 %>% take_sample() #alcohol (mother, units drunk)
    
  ) 


# nimats-infant -----------------------------------------------------------
nimats_infant_df <-
  master_id_df %>%
  mutate(
    apgar_1 = 6:10 %>% take_sample(), # APGAR score at 1 min
    apgar_5 = 6:10 %>% take_sample(),# APGAR score at 5 min
    birth_live = c(T,F) %>% take_sample(), # Birth status (live or still)
    birth_wgt = 1:5 %>% take_sample(), # Birth weight
    birth_centile = 1:100 %>% take_sample(),# Centile (assessment of infant weight relative to gestational age)
    bfeed_birth = c(T, F) %>% take_sample(),# Breastfeeding attempted (replaced by infant feeding Q later)
    deliv_meth = letters[1:4] %>% take_sample(),# Delivery method
    headcirum_i = 44:57 %>% take_sample(),# Head circumference (infant head circumference in cm)
    length_i = 19:21 %>% take_sample(), # Infant length
    sex_male_i = c(T,F) %>% take_sample()# Infant sex 
    
  )


# nimats-bfeed -------------------------------------------------------
nimats_bfeed <-
  master_id_df %>%
  mutate(
    bfeed_meth = letters[1:6] %>% take_sample(),#Feeding Method (Description of feeding method used during hospital stay)
    bfeed_cd = letters[1:6] %>% take_sample(), #Feeding Code
    bfeed_attempt = c(T, F) %>% take_sample(), #- Breast Feeding Attempted (This object identifies whether or not the mother attempted to breastfeed during the stay in hospital (Y/N)):
    bfeed_help_home = c(T, F) %>% take_sample()#  Help at home (This object indicates if the mother has been offered support to ensure that she can access help when at home (Y/N))
    
  )

# nimats-delivery ---------------------------------------------------------
nimats_delivery <-
  master_id_df %>%
  mutate(
    bmi_deliv_m = c(18:30, NA) %>% take_sample() #Mother's BMI at delivery
  )

# nimats-parenting --------------------------------------------------------

nimats_parenting <-
  master_id_df %>%
  mutate(
    comm_baby_parent = letters[1:3] %>% take_sample(),# Communicate with baby
    resp_baby_parent = letters[1:3] %>% take_sample(),# Responding to baby
    skin2skin_birth = letters[1:3] %>% take_sample(), # Skin to skin/ skin to skin at birth (recorded at various times)
    skin2skin_feed = letters[1:3] %>% take_sample(), # skin to skin contact until after first feed
    skin2skin_1hr = letters[1:3] %>% take_sample(), # skin to skin contract for after one hour
    bfeed_offer_birth = letters[1:3] %>% take_sample(),# breastfeeding offered at birth
    bfeed_init_birth = letters[1:3] %>% take_sample(), # breastfeeding initiated at birth
    formula_birth = letters[1:3] %>% take_sample(),# formula fed by mum at birth
    response_parent = letters[1:3] %>% take_sample()# responsiveness for mother
    
  )

# nimats-postnatal --------------------------------------------------------

nimats_postnatal <-
  master_id_df %>%
  mutate(
    smoke_12hr_m = letters %>% take_sample(), # Smoking last 12 hours 
    smoke_postnatal_cd_m = letters %>% take_sample(),# Currently smoking code
    smoke_postnatal_m = letters %>% take_sample(), # Currently smoking description
    cigs_n_m = 1:10 %>% take_sample(), # Number of cigaretters smoked per day
    smoke_refer_m =  letters %>% take_sample(), # Refer to smoking cessation
    smoke_refer_acpt_m = letters %>% take_sample(), # Referal accepted 
    meds_m = letters %>% take_sample() # Uptake of maternal medication (vitamins, folic acid, iron)
    
  )


# nimats_refer ------------------------------------------------------------
nimats_refer <-
  master_id_df %>%
  mutate(
    grfb_refer = letters %>% take_sample(), # Getting Ready For Baby (GRFB) suitable/offered/ accepted/ completed
    stop_smoke_refer = letters %>% take_sample()# Attend stop smoking service
    
  )


# save outputs ------------------------------------------------------------
nimats_bfeed %>% write_csv('outputs/nimats-bfeed.csv')
nimats_delivery %>% write_csv('outputs/nimats-delivery.csv')
nimats_infant_df %>% write_csv('outputs/nimats-infant.csv')
nimats_main_df %>% write_csv('outputs/nimats-main.csv')
nimats_obst_df %>% write_csv('outputs/nimats-obst.csv')
nimats_parenting %>% write_csv('outputs/nimats-parenting.csv')
nimats_postnatal %>% write_csv('outputs/nimats-postnatal.csv')
nimats_refer %>% write_csv('outputs/nimats-refer.csv')

## save a combined file
master_id_df %>%
  left_join(nimats_bfeed) %>%
  left_join(nimats_delivery) %>%
  left_join(nimats_infant_df) %>%
  left_join(nimats_main_df) %>%
  left_join(nimats_obst_df) %>%
  left_join(nimats_parenting) %>%
  left_join(nimats_postnatal) %>%
  left_join(nimats_refer) %>%
  write_csv('outputs/nimats-all.csv')
