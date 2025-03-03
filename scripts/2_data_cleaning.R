############################################################################## #
# Project: WBG Scorecard Data Cleaner
# Sub-routine: Data-Cleaning
# Authors:
#   - Juan Margitic (jmargitic@worldbank.org)
############################################################################## #
# Pre-requisite
# Before running this script, please ensure that you're able to access the current Scorecard WBG Data FY24 from https://scorecard.worldbank.org/en/api. In particular, looking for the download data button displaying this URL: https://ext.api.worldbank.org/api/Scorecard/downloaddata, and following instructions to end with the 'Download File' button, This will download the 'IndicatorData.zip' file we'll use.

############################################################################## #
# 1. Unzipping main data files
# 1.1. Zip File URL
zip_url<-""
# 1.2. Unzipping
unzip(zip_url, exdir = str_c(fldr_temp,'/'), overwrite = TRUE)

############################################################################## #
# 2. Appending main files
#----------------------------------------------------------------------------- #
# 2.1. Listing main files
ind_file_list<-list.files(fldr_temp, pattern = "\\.xlsx$", full.names = TRUE)

#----------------------------------------------------------------------------- #
# 2.2. For each file, get the sheet names and create a data frame with one row per file-sheet combination
sheet_data_ext <- map_dfr(ind_file_list, function(file) {
  sheets <- excel_sheets(file)
  tibble(file = basename(file), sheet = sheets)
})

#----------------------------------------------------------------------------- #
# 2.3. Creating a binary (wide) data frame:
#    - One row per file
#    - One column per unique sheet name
#    - Value is 1 if the file contains that sheet, otherwise 0
binary_df <- sheet_data_ext %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = sheet, values_from = present, values_fill = list(present = 0))

# Summary
binary_df |> select(-file) |>  
  summarise(across(everything(), sum)) |>  
  pivot_longer(everything(), names_to = "sheet", values_to = "count")



#----------------------------------------------------------------------------- #
# 2.4 Appending Disaggregate Sheet
process_dis_sheet<-function(ind_file_n){
  # 1.2.1 Loading disaggregate page
  dis_page<-read_xlsx(path = ind_file_n,
                      sheet = 'Disaggregate')
  return(dis_page)
}

dis_df<-bind_rows(lapply(ind_file_list,process_dis_sheet))

write_csv(dis_df,
          str_c(fldr_out,'/disagg_df.csv'))


#----------------------------------------------------------------------------- #
# 2.5 Appending Project Sheet
# Listing all df with proj sheets
proj_list<-binary_df |> filter(`Project Information`==1) |> pull(file)

conditional_mutate <- function(df, var, fun) {
  if (var %in% names(df)) {
    # Use tidy evaluation to update the column
    df <- df %>% mutate(!!sym(var) := fun(!!sym(var)))
  }
  df
}

process_proj_sheet<-function(ind_file_n){
  # 1.2.1 Loading disaggregate page
  proj_page<-read_xlsx(path = str_c(fldr_temp,'/',ind_file_n),
                      sheet = 'Project Information')
  proj_page<-proj_page |> 
    conditional_mutate('Reporting_FY',as.character) 
  proj_page<-proj_page |> 
    conditional_mutate('Target_Date',as.character)
  
    #mutate(Reporting_FY = as.character(Reporting_FY)) |>  
    #mutate(Target_Date = as.character(Target_Date)) 
  return(proj_page)
}

proj_df<-bind_rows(lapply(proj_list,process_proj_sheet)) |> 
  mutate(Baseline_Date = as.character(Baseline_Date)) |> 
  mutate(Progress_Date = as.character(Progress_Date)) |> 
  bind_rows(
   read_excel(str_c(fldr_temp,'/CSC_RES_ELC_ACCS.xlsx'), sheet = 'Direct Access')|> 
             conditional_mutate('Reporting_FY',as.character) |> 
             conditional_mutate('Target_Date',as.character) |> 
     mutate(across(all_of(c('Baseline_Date',
                            'Baseline_Value',
                            'Progress_Value',
                            'Target_Value')), as.character))
     )

write_csv(proj_df,
          str_c(fldr_out,'/proj_df.csv'))

#----------------------------------------------------------------------------- #
# 2.6 Appending Country Information Sheet
# Listing all df with Country Information sheets
ci_list<-binary_df |> filter(`Country Information`==1) |> pull(file)

ci_df<-read_xlsx(path = str_c(fldr_temp,'/',ci_list[1]),
          sheet = 'Country Information') |> 
  bind_rows(read_xlsx(path = str_c(fldr_temp,'/',ci_list[2]),
                      sheet = 'Country Information'))

write_csv(ci_df,
          str_c(fldr_out,'/ci_df.csv'))













