# Note: Place reusable variables here, grouped by environment.

#Staging Environment
${STAGING_CORE_HOST}    https://api.staging.paymongo.dev

#SuperUser Keys
${STAGING_TEST_SUPERUSER_ENCR}    crypt:${${env}_TEST_SUPER}
${STAGING_LIVE_SUPERUSER_ENCR}    crypt:${${env}_LIVE_SUPER}

# Database
# ${STAGING_DB_HOST}    docker.for.mac.host.internal - connection inside docker via ssh tunnel
${STAGING_DB_PASSWORD}    crypt:${DB_PASS}

#UAT Environment
${UAT_CORE_HOST}    https://api.uat.paymongo.dev

# Database
${UAT_DB_PASSWORD}    crypt:${DB_PASS}

#Airtable
${AIRTABLE_API_KEY}    crypt:${AIRTABLE_PASS}

#SuperUser Keys
${UAT_TEST_SUPERUSER_ENCR}    crypt:${${env}_TEST_SUPER}
${UAT_LIVE_SUPERUSER_ENCR}    crypt:${${env}_LIVE_SUPER}