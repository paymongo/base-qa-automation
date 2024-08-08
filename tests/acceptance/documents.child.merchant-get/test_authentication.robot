# Note: test_authentication.robot is only applicable for api automation
# This file should include endpoint authentication validations

*** Settings ***
# Import the resource_collection.robot file
Resource      ../../resource_collection.robot
# Add tags
Force Tags    regression    get_documents_child_org_onboarding    documents_child_org_onboarding
# Add any setup or tear down keywords if applicable
Test Setup    run keyword    prepare organization keys    SPLIT_ROBINSONS_BANK

*** Test Cases ***
# Sample test cases
Request should return child organization's documents WHEN auth and child_organization_id is valid
    GIVEN a child organization with all documents
    WHEN get child merchant documents is called
    THEN response status code should be    200

Request should NOT return child organization's documents WHEN auth is blank
    GIVEN a child organization with all documents
    WHEN get child merchant documents is called    auth=${EMPTY}
    THEN response status code should be    401
    AND schema should be valid versus response    error-code-detail_schema.json
    AND error code should be    access_denied
    AND error detail should be    You did not provide a valid API key. Go to https://developers.paymongo.com/docs/authentication to know more about our API authentication.