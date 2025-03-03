library(rvest)
library(httr)
library(magrittr)

pacman::p_load(
  'rvest',
  'httr',
  'magrittr'
)

# Step 1: Read the World Bank API page
url <- "https://scorecard.worldbank.org/en/api"
page <- read_html(url)

# Step 2: Extract the download data link using a CSS selector
download_link <- page %>% 
  html_nodes("a[href*='https://ext.api.worldbank.org/api/Scorecard/downloaddata']") %>% 
  html_attr("href")


if (length(download_link) == 0) {
  cat("Download link not found. The page content may be generated dynamically by JavaScript.\n")
} else {
  cat("Download link found:", download_link[1], "\n")


