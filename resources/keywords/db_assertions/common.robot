# Note: Place db assertions that can be used across the project here
# Each module should have a separate file for db assertion (Ex. organizations, payments, payment methods, etc.)

*** Keywords ***
# Sample db assertion
metabase record value should be equal to
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    should be equal    ${expected_value}    @{table_result}[0]