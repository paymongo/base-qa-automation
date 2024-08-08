# Below are the commonly used database utilities keywords

*** Keywords ***
establish core database connection
    decrypt superuser keys
	${DB_PASSWORD}    get decrypted text    ${${env}_DB_PASSWORD}
	connect to database    psycopg2     ${${env}_DB_NAME}    ${${env}_DB_USERNAME}    ${DB_PASSWORD}    ${${env}_DB_HOST}    ${${env}_DB_PORT}
	${WITH_DB_CHECKING}=    set variable    True
	set suite variable    ${WITH_DB_CHECKING}

disconnect all database connections
	disconnect from database
	${WITH_DB_CHECKING}=    set variable    False
	set suite variable    ${WITH_DB_CHECKING}