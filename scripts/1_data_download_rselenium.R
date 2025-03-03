library(RSelenium)

# Set up Chrome options for headless mode
chrome_options <- list(
  chromeOptions = list(
    args = c("--headless", "--disable-gpu", "--window-size=1280,800")
  )
)



# Start RSelenium server with headless Chrome
# rsDriver will auto-manage the Selenium server and driver versions
rD <- rsDriver(browser = "chrome", extraCapabilities = chrome_options)
remDr <- rD$client



