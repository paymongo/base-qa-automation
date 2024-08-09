# Note: For front-end automation only.
# Each page should have a separate page actions file (Ex. login page, sign up page, etc.)

*** Settings ***
# Only import the corresponding page objects file
Resource    ../page_objects/loginPageObjects.robot

*** Keywords ***
# Sample page actions keywords
a user is in paymongo dashboard login page
    go to paymongo dashboard
    
sign-in button is clicked
    click element    ${loginPage_sign_in_btn}

a valid login credentials is entered
    [Arguments]    ${email}=${${ENV}_EMAIL}    ${password}=${${ENV}_PASSWORD}
    input text    ${loginPage_email_input}    ${email}
    input password    ${loginPage_password_input}    ${password}

login to paymongo dashboard
    [Arguments]    ${email}    ${password}
    a user is in paymongo dashboard login page
    a valid login credentials is entered    ${email}    ${password}
    sign-in button is clicked