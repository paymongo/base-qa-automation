# Note: For api automation only.
# For front-end automation necessary imports should be placed in test case files

*** Settings ***
#Environment Variables
Resource    ../environment_variables.robot

#Assertions
Resource    resources/assertions/common.robot

#DB Assertions
Resource    resources/db_assertions/common.robot

#Utilities
Resource    resources/utilities/common.robot

#Requests
Resource    resources/requests/core.organizations.id-get/request.robot