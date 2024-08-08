# Note: For front-end automation only.
# Place locator elements here. xpath format should be used.

*** Variables ***
${loginPage_email_input}    xpath=//input[@name="email"]
${loginPage_password_input}    xpath=//input[@name="password"]
${loginPage_sign_in_btn}    xpath=//span[contains(text(), 'Log in')]/ancestor::button