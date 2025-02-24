pacman::p_load('playwright')

# Launch browser (headless mode by default)
browser <- playwright::launch(headless = TRUE)

# Open a new page
page <- browser$new_page()

# Step 1: Navigate to the World Bank API page
page$goto("https://scorecard.worldbank.org/en/api")



# Make the GET request to the World Bank API

api_url<-'https://scorecard.worldbank.org/en/api'

response <- GET(api_url, 
                add_headers("accept" = "*/*"))

# Check the status of the request
status_code(response)

# If the status code is 200, it means the request was successful
if(status_code(response) == 200) {
  # Parse the response content (e.g., save it to a file or process the JSON)
  content <- content(response, "text")
  
  # Optionally, you can write the content to a file
  writeLines(content, "worldbank_data.json")
  
  cat("Download completed successfully!")
} else {
  cat("Request failed with status:", status_code(response))
}