# Below are the commonly used error assertions for api automation

*** Keywords ***
error code should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].code
    should be equal    ${expected_value}    ${resp_error}

error detail should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].detail
    should be equal    ${expected_value}    ${resp_error}

error detail should contain
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].detail
    should contain    ${resp_error}    ${expected_value}

error source.pointer should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].source.pointer
    should be equal    ${expected_value}    ${resp_error}

error source.attribute should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].source.attribute
    should be equal    ${expected_value}    ${resp_error}

error sub_code should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.errors[${error_number}].sub_code
    should be equal    ${expected_value}    ${resp_error}