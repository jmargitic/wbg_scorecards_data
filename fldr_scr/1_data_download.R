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





