# Note: Place reusable utilities related keywords here

*** Settings ***
Library    String
Library  JSONSchemaLibrary

*** Keywords ***
# Common utilities related keywords for api automation
get value from response via json path
    [Arguments]    ${json_path}
    ${resp}    convert string to json    ${response.content}
    ${attribute_value}    get value from json    ${resp}    ${json_path}
    [Return]    ${attribute_value[0]}

replace payload dynamic variables
    [Arguments]    ${payload}    ${search_string}    ${new_value}
    ${modified_payload}    replace string    ${payload}    ${search_string}    ${new_value}
    [Return]    ${modified_payload}

replace request payload attribute
    [Arguments]    ${payload}    ${attribute_list}=${attribute_list}
    @{attribute_list}    split string    ${attribute_list}    ;
    ${flag}    set variable   false
    FOR    ${attribute}    IN    @{attribute_list}
    @{attribute}    split string    ${attribute}    ,
    ${json_path}    set variable    ${attribute}[0]
    ${json_attribute}    set variable    ${attribute}[1]
    ${json_value}    set variable    ${attribute}[2]
    ${type}    convert to string    ${attribute}[3]
    ${json_value}=    run keyword if    "${type}"=="integer"    convert to integer    ${json_value}
    ...    ELSE IF    "${type}"=="string"    set variable    ${json_value}
    ...    ELSE IF    "${type}"=="boolean"    convert to boolean    ${json_value}
    ...    ELSE IF    "${type}"=="decimal"    convert to number    ${json_value}
    ...    ELSE IF    "${type}"=="null" or "${type}"=="delete"    set variable    ${json_value}
    ...    ELSE IF    "${type}"=="array"    split string    ${json_value}    |
    IF    "${json_attribute}"=="website" or "${json_attribute}"=="config_value"
        IF    "${type}"=="string"
            ${json_value}=    replace string    ${json_value}    |    ,
        END
    END
    ${payload}=    evaluate    json.loads('''${payload}''')    json
    Set To Dictionary    	${payload${json_path}}    ${json_attribute}=${json_value}
    ${modified_payload}=    evaluate    json.dumps(${payload})    json
    ${modified_payload}=    run keyword if     "${type}"=="null"    replace payload dynamic variables    ${modified_payload}    "${json_value}"    ${json_value}
    ...    ELSE IF    "${type}"=="delete"    delete from payload    ${modified_payload}    ${json_attribute}    ${json_value}
    ...    ELSE    set variable    ${modified_payload}
    ${payload}=    set variable    ${modified_payload}
    ${payload}=    run keyword if    "${flag}" == "true"     set variable    ${modified_payload}
    ...    ELSE    set variable    ${payload}
    set suite variable    ${flag}    true
    END
    [Return]    ${modified_payload}

delete from payload
    [Arguments]    ${payload}    ${json_attribute}    ${json_value}
    ${item_last}=    run keyword and return status    should contain    ${payload}    "${json_attribute}": "${json_value}"}
    ${modified_payload}=    run keyword if    "${item_last}" == "True"    replace string    ${payload}    , "${json_attribute}": "${json_value}"    ${EMPTY}
    ...    ELSE    replace string    ${payload}    "${json_attribute}": "${json_value}",    ${EMPTY}
    [Return]    ${modified_payload}

decrypt superuser keys
    ${env}=    convert to upper case    ${env}
    set suite variable    ${env}
    IF    "${env}" == "STAGING"
        ${STAGING_TEST_SUPERUSER}    get decrypted text    ${STAGING_TEST_SUPERUSER_ENCR}
        ${STAGING_LIVE_SUPERUSER}    get decrypted text    ${STAGING_LIVE_SUPERUSER_ENCR}
        set suite variable    ${STAGING_TEST_SUPERUSER}
        set suite variable    ${STAGING_LIVE_SUPERUSER}
    ELSE IF    "${env}" == "UAT"
        ${UAT_TEST_SUPERUSER}    get decrypted text    ${UAT_TEST_SUPERUSER_ENCR}
        ${UAT_LIVE_SUPERUSER}    get decrypted text    ${UAT_LIVE_SUPERUSER_ENCR}
        set suite variable    ${UAT_TEST_SUPERUSER}
        set suite variable    ${UAT_LIVE_SUPERUSER}
    END

object id and type should be
    [Arguments]    ${variable_id}    ${variable_type}
    ${resp_id}=    get value from response via json path    $.data.id
    ${resp_type}=    get value from response via json path    $.data.type
    should contain    ${resp_id}     ${variable_id}       
    should be equal    ${variable_type}    ${resp_type}

# Common utilities related keywords for front-end automation
start browser instance
    [Arguments]    ${URL}=${URL}
    IF    "${BROWSER}" == "firefox"
        setup firefoxdriver
    ELSE
        setup chromedriver
    END
    set selenium speed    0.5 second
    set selenium implicit wait    10 seconds
    set screenshot directory    EMBED
    go to    ${URL}

end browser instance
    close all browsers

setup firefoxdriver
    ${firefox_options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    #use platform.system() to identify platform
    ${system}=    Evaluate    platform.system()    platform
    log    OS is ${system}
    log    HEADFUL=${HEADFUL} xvfb_running=${xvfb_running}
    call method    ${firefox_options}   add_argument    --width\=1920
    call method    ${firefox_options}   add_argument    --height\=1080
    IF    ${HEADFUL} and ${xvfb_running}
        call method    ${firefox_options}   add_argument    --disable-gpu
    ELSE IF    "${system}" == "Linux"
        call method    ${firefox_options}   add_argument    --headless
    END
    ${firefox_options.binary_location}=    set variable    /usr/bin/firefox
    ${firefox_service}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxService()    sys, selenium.webdriver
    #check existence of geckodriver from docker container. otherwise, fallback to local geckodriver
    ${geckodriver_exists}=    run process    /bin/ls /usr/bin/geckodriver    shell=yes
    IF    "${geckodriver_exists.stdout}" == "/usr/bin/geckodriver"
        set local variable    ${geckodriver}    /usr/bin/geckodriver
    ELSE
        set local variable    ${geckodriver}    ${EXECDIR}/geckodriver_linux
    END
    #create webdriver based on OS
    IF    "${system}" == "Linux"
        ${firefox_service.executable_path}=    set variable    ${geckodriver}
        create webdriver     Firefox    service=${firefox_service}    options=${firefox_options}
    ELSE IF    "${system}" == "Darwin"
        create webdriver     Firefox    executable_path=${EXECDIR}/geckodriver_mac   options=${firefox_options}
    END

setup chromedriver
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #use platform.system() to identify platform
    ${system}=    Evaluate    platform.system()    platform
    log    OS is ${system}
    log    HEADFUL=${HEADFUL} xvfb_running=${xvfb_running}
    IF    ${HEADFUL} and ${xvfb_running}
        call method    ${chrome_options}   add_argument    window-size\=1920,1080
        call method    ${chrome_options}   add_argument    window-position\=0,0
    ELSE
        call method    ${chrome_options}   add_argument    headless
    END
    call method    ${chrome_options}   add_argument    disable-gpu
    call method    ${chrome_options}   add_argument    no-sandbox
    call method    ${chrome_options}   add_argument    disable-dev-shm-usage
    call method    ${chrome_options}   add_argument    remote-debugging-port\=9222
    ${options}=     call method     ${chrome_options}    to_capabilities
    ${chrome_options.desired_capabilities}=    set variable    ${options}
    #check existence of chromedriver from docker container. otherwise, fallback to local chromedriver
    ${chromedriver_exists}=    run process    /bin/ls /usr/bin/chromedriver    shell=yes
    IF    "${chromedriver_exists.stdout}" == "/usr/bin/chromedriver"
        set local variable    ${chromedriver}    /usr/bin/chromedriver
    ELSE
        #select webdriver based on OS
        IF    "${system}" == "Linux"
            set local variable    ${chromedriver}    ${EXECDIR}/chromedriver_linux
        ELSE IF    "${system}" == "Darwin"
            set local variable    ${chromedriver}    ${EXECDIR}/chromedriver_mac
        END
    END
    #create webdriver based on OS
    IF    "${system}" == "Linux"
        ${chrome_service}=    Evaluate    sys.modules['selenium.webdriver'].ChromeService()    sys, selenium.webdriver
        ${chrome_service.executable_path}=    set variable    ${chromedriver}
        create webdriver     Chrome     service=${chrome_service}    options=${chrome_options}
    ELSE IF    "${system}" == "Darwin"
        log    OS is ${system}. Local non-docker run is not supported using Chrome, reverting to Firefox.    warn
        setup firefoxdriver
    END