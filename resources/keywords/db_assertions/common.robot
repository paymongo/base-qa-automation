# Note: Place db assertions that can be used across the project here
# Below are the commonly used db assertions
# Each module should have a separate file for db assertion (Ex. organizations, payments, payment methods, etc.)

*** Keywords ***
metabase record value should be equal to
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    should be equal    ${expected_value}    @{table_result}[0]

metabase record value should be equal as strings to
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    should be equal as strings    ${expected_value}    @{table_result}[0]

metabase record value should be not equal as strings to
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    should not be equal as strings    ${expected_value}    @{table_result}[0]

metabase record value should be equal as strings to - multiple filters
    [Arguments]    ${return_column}    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column1}='${search_value1}' AND ${search_column2}='${search_value2}';
    should be equal as strings    ${expected_value}    @{table_result}[0]

joined metabase record value should be equal to 
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column} = '${search_value}';
    should be equal    ${expected_value}    @{table_result}[0]

joined metabase record value should be equal as strings to 
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}    ${expected_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column} = '${search_value}';
    should be equal as strings    ${expected_value}    @{table_result}[0]

joined metabase record should not be existing
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column} = '${search_value}';
    should be empty    ${table_result}

return metabase record value
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        ${return_value}=    get from list    @{table_result}    0
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

#return multiple values in list form
return metabase record values
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}    ${sort_column}=created_at    ${sort_order}=asc
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}' ORDER BY ${sort_column} ${sort_order};
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        #query returns list of tuples by default. convert it to list
        ${return_value}    Evaluate    [x[0] for x in @{table_result}]
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

return metabase record value - multiple filters
    [Arguments]    ${return_column}    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column1}='${search_value1}' AND ${search_column2}='${search_value2}';
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        ${return_value}=    get from list    @{table_result}    0
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

#return multiple values in list form
return metabase record values - multiple filters
    [Arguments]    ${return_column}    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}    ${sort_column}=created_at    ${sort_order}=asc
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column1}='${search_value1}' AND ${search_column2}='${search_value2}' ORDER BY ${sort_column} ${sort_order};
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        #query returns list of tuples by default. convert it to list
        ${return_value}    Evaluate    [x[0] for x in @{table_result}]
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

return joined metabase record value
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column} = '${search_value}';
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        ${return_value}=    get from list    @{table_result}    0
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

#return multiple values in list form
return joined metabase record values
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}    ${sort_column}=created_at    ${sort_order}=asc
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column} = '${search_value}' ORDER BY ${sort_column} ${sort_order};
    IF    ${table_result_length} > 0
        #query returns list of tuples by default. convert it to list
        ${return_value}    Evaluate    [x[0] for x in @{table_result}]
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

return joined metabase record value - multiple filters
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column1} = '${search_value1}' AND ${search_column2}='${search_value2}';
    ${table_result_length}=    get length    ${table_result}
    IF    ${table_result_length} > 0
        ${return_value}=    get from list    @{table_result}    0
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}

#return multiple values in list form
return joined metabase record values - multiple filters
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}    ${sort_column}=created_at    ${sort_order}=asc
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1}.${table_name1_column} = ${table_name2}.${table_name2_column} WHERE ${search_column1} = '${search_value1}' AND ${search_column2}='${search_value2}' ORDER BY ${sort_column} ${sort_order};
    IF    ${table_result_length} > 0
        #query returns list of tuples by default. convert it to list
        ${return_value}    Evaluate    [x[0] for x in @{table_result}]
    ELSE
        ${return_value}=    ${EMPTY}
    END
    [Return]    ${return_value}
    
metabase record value should be populated
    [Arguments]    ${return_column}    ${table_name}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column}='${search_value}';
    should not be equal as strings    None    @{table_result}[0]    msg=The value of ${return_column} is null

metabase record value should be populated - multiple filters
    [Arguments]    ${return_column}    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name} WHERE ${search_column1}='${search_value1}';
    should not be equal as strings    None    @{table_result}[0]    msg=The value of ${return_column} is null

joined metabase record value should be populated
    [Arguments]      ${return_column}    ${table_name1}    ${table_name2}    ${table_name1_column}    ${table_name2_column}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT ${return_column} FROM ${table_name1} JOIN ${table_name2} ON ${table_name1_column} = ${table_name2_column} WHERE ${search_column} = '${search_value}';
    should not be equal as strings    None    @{table_result}[0]    msg=The value of ${return_column} is null
    
metabase record should be existing
    [Arguments]    ${table_name}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT * FROM ${table_name} WHERE ${search_column}='${search_value}';
    should not be empty    ${table_result}    msg=Record from ${table_name} does not exist

metabase record should be existing - multiple filters
    [Arguments]    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}
    @{table_result}=    query    SELECT * FROM ${table_name} WHERE ${search_column1}='${search_value1}' AND ${search_column2}='${search_value2}';
    should not be empty    ${table_result}    msg=Record from ${table_name} does not exist

metabase record should not be existing
    [Arguments]    ${table_name}    ${search_column}    ${search_value}
    @{table_result}=    query    SELECT * FROM ${table_name} WHERE ${search_column}='${search_value}';
    should be empty    ${table_result}    msg=Record from ${table_name} exists

metabase record should not be existing - multiple filters
    [Arguments]    ${table_name}    ${search_column1}    ${search_value1}    ${search_column2}    ${search_value2}
    @{table_result}=    query    SELECT * FROM ${table_name} WHERE ${search_column1}='${search_value1}' AND ${search_column2}='${search_value2}';
    should be empty    ${table_result}    msg=Record from ${table_name} exists

get metabase columns and records
    [Arguments]    ${table_name}    ${table_column}    ${table_id} 
    #Get column names from table; given as list
    ${table_columns}=    query    SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '${table_name}';
    ${table_size}=    get length    ${table_columns}

    #Start building string for second query
    ${query}    set variable    SELECT col_name, col_value FROM ${table_name} t, LATERAL (VALUES
    FOR    ${loop}    IN RANGE    ${table_size}
        ${col_name}    set variable    @{table_columns}[${loop}]
        IF    "${loop}" == "${table_size-1}"
            ${query}=    catenate    ${query}('${col_name}', t.${col_name}::text)) s(col_name, col_value) WHERE ${table_column} = '${table_id}';
        ELSE
            ${query}=    catenate    ${query}('${col_name}', t.${col_name}::text),
        END
    END
    log    ${query}
    
    sleep    7.5s
    #Run query and create dictionary
    ${table_dict}=    query    ${query} 
    &{table_dict}=    convert to dictionary    ${table_dict}

    set suite variable    &{table_dict}
    set suite variable    ${table_size}
    set suite variable    ${table_columns}

get metabase columns and records - multiple filters
    [Arguments]    ${table_name}    ${table_column1}    ${table_id1}    ${table_column2}    ${table_id2}
    #Get column names from table; given as list
    ${table_columns}=    query    SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '${table_name}';
    ${table_size}=    get length    ${table_columns}

    #Start building string for second query
    ${query}    set variable    SELECT col_name, col_value FROM ${table_name} t, LATERAL (VALUES
    FOR    ${loop}    IN RANGE    ${table_size}
        ${col_name}    set variable    @{table_columns}[${loop}]
        IF    "${loop}" == "${table_size-1}"
            ${query}=    catenate    ${query}('${col_name}', t.${col_name}::text)) s(col_name, col_value) WHERE ${table_column1} = '${table_id1}' AND ${table_column2} = '${table_id2}';
        ELSE
            ${query}=    catenate    ${query}('${col_name}', t.${col_name}::text),
        END
    END
    log    ${query}
    
    sleep    7.5s
    #Run query and create dictionary
    ${table_dict}=    query    ${query} 
    &{table_dict}=    convert to dictionary    ${table_dict}

    set suite variable    &{table_dict}
    set suite variable    ${table_size}
    set suite variable    ${table_columns}

#Accepts a list of column names separate by comma. If present the column name will be expected as null instead of checked that it isn't null
#Eg. If column_exclusion=payment_id,user_id,blahdee_id, 'payment_id', 'user_id', 'blahdee_id' is expected to be null
verify if table dictionary values are not empty
    [Arguments]    ${column_exclusion}=None
    IF    "${column_exclusion}" == "None"
        FOR    ${loop}    IN RANGE    ${table_size}
            ${col_name}    set variable    @{table_columns}[${loop}]
            ${value}=    convert to string    ${table_dict}[${col_name}]
            should not be equal as strings    None    ${value}    msg=Table dictionary value ${col_name} is empty
            Log    ${table_dict}[${col_name}]
        END
    ELSE
        @{column_exclusion_list}    split string    ${column_exclusion}    ,
        FOR    ${loop}    IN RANGE    ${table_size}
            ${col_name}    set variable    @{table_columns}[${loop}]
            ${value}=    convert to string    ${table_dict}[${col_name}]
            IF    "${col_name}" in ${column_exclusion_list}
                should be equal as strings    None    ${value}
            ELSE
                should not be equal as strings    None    ${value}    msg=Table dictionary value ${col_name} is empty
            END
            Log    ${table_dict}[${col_name}]
        END
    END

number of created metabase record should be
    [Arguments]    ${table_name}    ${search_column}    ${search_value}    ${expected_value}
    ${table_result}=    query    SELECT * FROM ${table_name} WHERE ${search_column}='${search_value}';
    ${no_of_records}=    get length    ${table_result}
    ${expected_value}=    convert to integer    ${expected_value}
    should be equal    ${expected_value}    ${no_of_records}