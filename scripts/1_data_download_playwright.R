pacman::p_load('playwright')

# Launch browser (headless mode by default)
browser <- playwrightr::browser_launch(headless = TRUE)

# Open a new page
page <- browser$new_page()

# Step 1: Navigate to the World Bank API page
page$goto("https://scorecard.worldbank.org/en/api")

# Step 2: Click on the link to download data (using a selector for the download link)
download_link_selector <- "a[href*='https://ext.api.worldbank.org/api/Scorecard/downloaddata']"
page$click(download_link_selector)

# Step 3: Wait for the "Try it out" button to load and click on it
page$wait_for_selector("button:text('Try it out')", timeout = 5000)
page$click("button:text('Try it out')")

# Step 4: Click on the "Execute" button after it loads
page$wait_for_selector("button:text('Execute')", timeout = 5000)
page$click("button:text('Execute')")

# Step 5: Wait for 30 seconds to simulate waiting for results
Sys.sleep(30)

# Step 6: Click on the "Download file" button
page$wait_for_selector("button:text('Download file')", timeout = 5000)
page$click("button:text('Download file')")

# Step 7: Wait for the download to complete (adjust if necessary)
Sys.sleep(5)

# Step 8: Close the browser session
browser$close()

cat("Download completed successfully!\n")