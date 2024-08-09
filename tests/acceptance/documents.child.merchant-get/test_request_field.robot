# Note: test_request_field.robot is applicable for both front-end and api automation
# This file should include endpoint/field validations

*** Settings ***
# Import the resource_collection.robot file
# Import the relevant page actions / utilities files for front-end automation
Resource      ../../resource_collection.robot
# Add tags
Force Tags    regression    get_documents_child_org_onboarding    documents_child_org_onboarding
# Add any setup or tear down keywords if applicable
Test Setup    run keyword    prepare organization keys    SPLIT_ROBINSONS_BANK

*** Test Cases ***
# Sample test cases
Request should return child organization's documents WHEN purpose is alien_cert_registration
    GIVEN a child organization with all documents
    AND get child merchant documents is called    purpose=alien_cert_registration
    THEN response status code should be    200
    AND child organization file purpose should be    alien_cert_registration
    AND schema should be valid versus response    get-child-merchant-documents_schema.json

Request should NOT return child organization's documents WHEN child_organization_id is invalid
    GIVEN a child organization with all documents
    AND get child merchant documents is called    child_organization_id=org_invalid123
    THEN response status code should be    404
    AND schema should be valid versus response    error-code-detail_schema.json
    AND error code should be    child_merchant_not_found
    AND error detail should be    No such child merchant with ID org_invalid123.