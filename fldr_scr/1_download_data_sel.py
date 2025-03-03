import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

# Configure Chrome options for a visible window and automatic downloads
chrome_options = Options()
# Uncomment the next line to run headless (invisible)
# chrome_options.add_argument("--headless")
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument("--window-size=1280,800")

# Set the download directory (update this to a valid folder on your system)
download_dir = "/path/to/your/download/directory"
prefs = {
    "download.default_directory": download_dir,  # Set download folder
    "download.prompt_for_download": False,         # Disable download prompt
    "download.directory_upgrade": True,
    "safebrowsing.enabled": True
}
chrome_options.add_experimental_option("prefs", prefs)

# Initialize the Chrome driver
driver = webdriver.Chrome(ChromeDriverManager().install(), options=chrome_options)
wait = WebDriverWait(driver, 20)  # Explicit wait of up to 20 seconds

# Step 1: Navigate to the World Bank API page
driver.get("https://scorecard.worldbank.org/en/api")
wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))

# Step 2: Click on the link that displays the download URL
download_link = wait.until(EC.element_to_be_clickable(
    (By.CSS_SELECTOR, "a[href*='https://ext.api.worldbank.org/api/Scorecard/downloaddata']")))
download_link.click()

# Step 3: Click on the "Try it out" button
try_it_button = wait.until(EC.element_to_be_clickable(
    (By.XPATH, "//button[contains(text(), 'Try it out')]")))
try_it_button.click()

# Step 4: Click on the "Execute" button
execute_button = wait.until(EC.element_to_be_clickable(
    (By.XPATH, "//button[contains(text(), 'Execute')]")))
execute_button.click()

# Step 5: Wait for 30 seconds for the process to complete
time.sleep(30)

# Step 6: Click on the "Download file" button
download_file_button = wait.until(EC.element_to_be_clickable(
    (By.XPATH, "//button[contains(text(), 'Download file')]")))
download_file_button.click()

# Wait a few seconds to ensure the download completes
time.sleep(5)
print("Download completed successfully!")

# Close the browser session
driver.quit()
