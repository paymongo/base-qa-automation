# Note: Test cases under the integration folder includes the end-to-end flow of the application (Ex. Links payments and refunds using different payment methods)
# Add nested folders if necessary to group the tests better

*** Settings ***
# Import the resource_collection.robot file
# Import the relevant page actions / utilities files for front-end automation
Resource      ../../resource_collection.robot
# Add tags
Force Tags    regression    get_documents_child_org_onboarding    documents_child_org_onboarding
# Add any setup or tear down keywords if applicable
Test Setup    run keyword    prepare organization keys    SPLIT_ROBINSONS_BANK

*** Test Cases ***
# Sample test case
User should be able to pay links using GCash as a payment method - Live Mode 
    GIVEN user created a link successfully
    WHEN user clicks the link url
    AND user chooses GCash payment method
    AND user inputs customer information
    AND user proceeds to gcash live payment
    THEN user should have successfully completed the links payment using GCash
