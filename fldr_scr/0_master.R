############################################################################## #
# WBG Scorecard 
# DOC:
# Authors:
#   - Juan Margitic (jmargitic@worldbank.org)
############################################################################## #
# 0. Setting Up Environment 
# 0.1 Package management
rm(list=ls())
install.packages('pacman')
pacman::p_load(
  'tidyverse', # General Tidyverse tools
  'tidylog',   # Operations summary for Tidyverse tools
  # 'readxl',   # package used to manipulate xlsx/xls data 
  'janitor'    # Useful pieces of code: - 
)

# 0.2 Defining directory
fldr_main<-'C:/Users/wb637397/OneDrive - WBG/ds_doo/2025/02/wbg_scorecards_data'
fldr_in<-str_c(fldr_main,'/input')
fldr_temp<-str_c(fldr_main,'/temp')
fldr_out<-str_c(fldr_main,'/out')
fldr_scr<-str_c(fldr_main,'/scripts')

# Creating sub-directories (if absent)
ls() |> walk(~ fs::dir_create(.x))

# 0.3 Options setting
options(scipen=999)

###################################
# 1. Sub-routine: Data-cleaning
#source(str_c(fldr_scr,'/1_data_download.R'))

