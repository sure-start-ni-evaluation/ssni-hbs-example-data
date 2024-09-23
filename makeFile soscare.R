# makeFile soscare --------------------------------------------------------
## soscare is another database where data is arranged in paitent-episode style

library(tidyverse)

## Load a master index of hcn ---------------------------------------------

master_hcn <-
  data.frame(
    id_hcn =  c(1:10e3, 1:15e3 %>% paste0('c'))
    
  )


# functions ---------------------------------------------------------------

sample_generic <- 
  function(x, size = 20e3){x %>% sample(size = size, replace = T)}

sample_date <-
  function(...){
    seq(as.Date('2010/01/01'), as.Date('2023/01/01'), by="day") %>%
             sample_generic(...)
  }

sample_char <- function(...){letters[1:10] %>% sample_generic(...)}
sample_number <- function(...){1:10 %>% sample_generic(...)}


# referrals ---------------------------------------------------------------

soscare_referrals <- 
  data.frame(
    id_hcn =  master_hcn$id_hcn %>% sample_generic()#HCN (linkage only) 
  ) %>%
  mutate(
    site = sample_char(), #site
    date_referred = sample_date(),#date_referred
    referral_type_description = sample_char(),#referral_type_description
    REASON_REFERRED_CODE_DESC= sample_char(),#REASON_REFERRED_CODE_DESC
    date_closed= sample_date(),#date_closed
    REASON_CLOSED_CODE_DESC = sample_char(),#REASON_CLOSED_CODE_DESC
    REASON_TERM_CODE_DESC= sample_char()#REASON_TERM_CODE_DESC
  )


# child in need module ----------------------------------------------------
soscare_in_need <- 
  data.frame(
    id_hcn =  master_hcn$id_hcn %>% sample_generic()#HCN (linkage only) 
  ) %>%
  mutate(
    site = sample_char(),# site/trust
    date_int_ref= sample_date(),# date_int_ref
    DATE_INIT_ASSESS = date_int_ref + sample_generic(1:20),# DATE_INIT_ASSESS
    OUTCOME_CATEGORY_DESC = sample_char()# OUTCOME_CATEGORY_DESC
  )


# child protection --------------------------------------------------------
soscare_child_prot <- 
  data.frame(
    id_hcn =  master_hcn$id_hcn %>% sample_generic()#HCN (linkage only) 
  ) %>%
  mutate(
    date_regd = sample_date(),
    date_removed = date_regd + sample_generic(10:200),
    primary_abuse_desc = sample_char(),
    cp_code2_desc = sample_char(),
    cp_code3_desc = sample_char(),
    cp_code4_desc = sample_char(),
    site = sample_char()
  )


# children in care --------------------------------------------------------

soscare_in_care <-
  data.frame(
    id_hcn =  master_hcn$id_hcn %>% sample_generic()#HCN (linkage only) 
  ) %>%
  mutate(
    site = sample_char(),
    CIN_SEQ = sample_char(), # seq no. of episode - Need to identify first episode/ order of epsidoes
    REASON_CO_OPENED_DESC = sample_char(), # reason in care
    DATE_OPENED = sample_date() # episode start
  )


# save --------------------------------------------------------------------

soscare_child_prot %>% write_csv('outputs/soscare-prot.csv')
soscare_in_care %>% write_csv('outputs/soscare-care.csv')
soscare_in_need %>% write_csv('outputs/soscare-need.csv')
soscare_referrals %>% write_csv('outputs/soscare-refer.csv')

