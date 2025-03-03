############################################################################## #
# Project: WBG Scorecard Data Cleaner
# DOC:
# Authors:
#   - Juan Margitic (jmargitic@worldbank.org)
############################################################################## #
# 0. Setting Up Environment 
# 0.1 Package management
rm(list=ls())
#install.packages('pacman')
pacman::p_load(
  'tidyverse', # General Tidyverse tools
  'tidylog',   # Operations summary for Tidyverse tools
  'readxl',   # package used to manipulate xlsx/xls data 
  'janitor'    # Useful pieces of code: - 
)

# 0.2 Defining directory
fldr_main<-''
fldr_in<-str_c(fldr_main,'/input')
fldr_temp<-str_c(fldr_main,'/temp')
fldr_out<-str_c(fldr_main,'/out')
fldr_scr<-str_c(fldr_main,'/scripts')

# Creating sub-directories (if absent)
c(fldr_in, fldr_temp, fldr_out, fldr_scr) |> walk(~ fs::dir_create(.x))

# 0.3 Options setting
options(scipen=999)

###################################
# 1. Sub-routine: Data-Downloading
#source(str_c(fldr_scr,'/1_data_download.R')) 
# This has been deprecated for now. Company policy states that we can't use Selenium tools with web-drivers

# 2. Sub-routine: Data-Cleaning
#source(str_c(fldr_scr,'/1_data_cleaning.R'))
