pacman::p_load('httr')


#/html/body/app-root/div/app-dashboard/div[2]/div/form/div/div[2]/div/div/div/div[2]/div[2]/div[3]/div[2]/div[2]/div[3]/div[2]/table/tbody/tr/td[2]/a

# Start Selenium server and browser
driver <- rsDriver(browser = "chrome", chromever = "latest", port = 4444L)
remote_driver <- driver[["client"]]

# Go to the API page
remote_driver$navigate("https://scorecard.worldbank.org/en/api")

# Click on the link to download data
download_link <- remote_driver$findElement(using = "xpath", "//a[contains(@href, 'https://ext.api.worldbank.org/api/Scorecard/downloaddata')]")
download_link$click()

# Wait for the page to load and then click "Try out" button
Sys.sleep(2)  # Give some time for the page to load
try_button <- remote_driver$findElement(using = "xpath", "//button[text()='Try it out']")
try_button$click()

# Click on the "Execute" button
Sys.sleep(2)  # Wait for the "Execute" button to appear
execute_button <- remote_driver$findElement(using = "xpath", "//button[text()='Execute']")
execute_button$click()

# Wait for 30 seconds
Sys.sleep(30)

# Now, click on the download button (this opens a download window)
download_button <- remote_driver$findElement(using = "xpath", "//button[text()='Download file']")
download_button$click()

# Wait for the file to be downloaded
Sys.sleep(5)  # Wait for the file to download

# Optionally, you can specify the download path or use the browser's default download location
# Make sure you have your browser set to automatically download files to a specific folder

# Close the session
remote_driver$close()
driver[["server"]]$stop()

cat("Download completed!")





library(chromote)

options(chromote.headless = FALSE)
# Launch a Chromote session (headless mode by default)
b <- ChromoteSession$new()

# Step 1: Navigate to the World Bank API page
b$Page$navigate("https://scorecard.worldbank.org/en/api")
b$Page$loadEventFired()  # Wait until the page is fully loaded

# Step 2: Click on the download data link using its CSS selector
download_link_selector <- "a[href*='https://ext.api.worldbank.org/api/Scorecard/downloaddata']"
js_click_download <- sprintf("document.querySelector('%s') && document.querySelector('%s').click();", 
                             download_link_selector, download_link_selector)
b$Runtime$evaluate(js_click_download)
Sys.sleep(3)

# Step 3: Click on the "Try it out" button
# Since CSS doesn't support text matching directly, we loop through buttons and click the matching one.
js_click_try_it <- "
  Array.from(document.querySelectorAll('button')).forEach(btn => {
    if(btn.innerText && btn.innerText.includes('Try it out')) { 
      btn.click(); 
    }
  });
"
b$Runtime$evaluate(js_click_try_it)
Sys.sleep(3)

# Step 4: Click on the "Execute" button
js_click_execute <- "
  Array.from(document.querySelectorAll('button')).forEach(btn => {
    if(btn.innerText && btn.innerText.includes('Execute')) { 
      btn.click(); 
    }
  });
"
b$Runtime$evaluate(js_click_execute)
Sys.sleep(30)  # Wait for results to be processed

# Step 5: Click on the "Download file" button
js_click_download_file <- "
  Array.from(document.querySelectorAll('button')).forEach(btn => {
    if(btn.innerText && btn.innerText.includes('Download file')) { 
      btn.click(); 
    }
  });
"
b$Runtime$evaluate(js_click_download_file)
Sys.sleep(5)  # Adjust if necessary to allow download to complete

# Close the Chromote session
b$close()

cat("Download completed successfully!\n")

