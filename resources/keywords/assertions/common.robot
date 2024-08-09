# Note: Place assertions that can be used across the project here
# Below are the commonly used assertions for api automation
# Each module should have a separate file for assertion (Ex. organizations, payments, payment methods, etc.)

*** Keywords ***
response status code should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${response.status_code}

response field should not be empty
    [Arguments]    ${json_path}
    should not be empty    ${json_path}

response body should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${response.content}    

schema should be valid versus response
    [Arguments]    ${schema}
    ${response_json}    convert string to json    ${response.content}
    validate json    ${schema}    ${response_json}

object id and type should be
    [Arguments]    ${variable_id}    ${variable_type}
    ${resp_id}=    get value from response via json path    $.data.id
    ${resp_type}=    get value from response via json path    $.data.type
    should contain    ${resp_id}     ${variable_id}       
    should be equal    ${variable_type}    ${resp_type}    

object livemode should be
    [Arguments]    ${variable}
    ${livemode}=    get value from response via json path   $.data.attributes.livemode
    ${boolean}    convert to string    ${livemode}
    run keyword if    ${variable} == True    should be equal    ${boolean}    True
    run keyword if    ${variable} == False    should be equal    ${boolean}    False

response field length should be
    [Arguments]    ${json_path}    ${expected_value}
    ${expected_value}=    convert to integer    ${expected_value}
    ${response_list}=    get value from response via json path    ${json_path}
    ${actual_value}=    get length    ${response_list}
    should be equal    ${expected_value}    ${actual_value}

browser url should be
    [Arguments]    ${expected_value}
    ${return_url}=    get location
    should match    ${expected_value}    ${return_url}

response body should contain
    [Arguments]    ${expected_value}
    @{resp_data}=    get value from response via json path    $.data
    should contain    ${resp_data}     ${expected_value}

response field value should be
    [Arguments]    ${json_path}    ${expected_value}
    ${actual_value}=    get value from response via json path    ${json_path}
    ${actual_value}     convert to string     ${actual_value}
    should be equal    ${expected_value}    ${actual_value}