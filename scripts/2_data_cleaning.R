############################################################################## #
# Project: WBG Scorecard Data Cleaner
# Sub-routine: Data-Cleaning
# Authors:
#   - Juan Margitic (jmargitic@worldbank.org)
############################################################################## #
# Pre-requisite
# Before running this script, please ensure that you're able to access the current Scorecard WBG Data FY24 from https://scorecard.worldbank.org/en/api. In particular, looking for the download data button displaying this URL: https://ext.api.worldbank.org/api/Scorecard/downloaddata, and following instructions to end with the 'Download File' button, This will download the 'IndicatorData.zip' file we'll use.

# 0. Setting Up Environment 
# Zip File URL
zip_url<-"C:/Users/wb637397/OneDrive - WBG/ds_doo/2025/02/wbg_scorecards_data/input/IndicatorData.zip"
contents <- unzip(zip_url, list = TRUE)
print(contents)

a<-unzip(zip_url, exdir = str_c(fldr_temp,'/'), overwrite = TRUE)














