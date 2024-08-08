# Note: requests folder is only applicable for api automation
# Place service request of a certain endpoint here

*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../tests/resource_collection.robot

*** Keywords ***
# Sample request keyword
get organization is requested
    [Arguments]    ${auth}=${${env}_LIVE_SUPERUSER}    ${organization_id}=${organization_id}
    ${auth}=    create list    ${auth}    ""
    @{query_param_list}    create list
	${query_parameters}    set variable    ${EMPTY}
    ${headers}    create dictionary    Authorization=Basic
    run keyword if    "${organization_id}" != "None"    append to list    ${query_param_list}    ${organization_id}
	FOR    ${param}    IN    @{query_param_list}
		${query_parameters}    set variable if    "${query_parameters}" == "${EMPTY}"    ${param}
	END
    create session    session    ${${env}_CORE_HOST}    auth=${auth}    disable_warnings=1
    ${response}    get on session    session    url=/v1/organizations/${query_parameters}    headers=${headers}    expected_status=any
    set test variable    ${response}
	log    ${response}
    log    ${response.headers}
    log    ${response.content}
    delete all sessions