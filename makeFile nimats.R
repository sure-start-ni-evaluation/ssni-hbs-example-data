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
    id_hcn_i = 1:15e3 #HCN (I),
  )

## create a small function to sample 
take_sample <- 
  function(x, size = nrow(master_id_df)){
    x %>% sample(size = size, replace = T)
  }


## nimat-main ---------------------------------------------------------

nimat_main_df <-
  master_id_df %>%
  mutate(
    birth_ward = take_area(wards = T),# Birth ward code 1992 (M)
    birth_soa =  take_area(),# Birth SOA (2001 code)
    current_soa_2024 = take_area(seed = 12),# Current SOA (2001 code, mother) -- OR SOA every January (as suggested by HBS) 
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

nimat_main_df

## nimats-obsteric (previous obsteric history) -------------------------



# nimats-infant -----------------------------------------------------------


# nimats-breastfeed -------------------------------------------------------


# nimats-delivery ---------------------------------------------------------


# nimats-parenting --------------------------------------------------------


# nimats-postnatal --------------------------------------------------------




