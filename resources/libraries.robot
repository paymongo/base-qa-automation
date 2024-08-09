# Place relevant library packages here
# Below are the commonly used library packages

*** Settings ***
Library    base64/base64code.py
Library    BuiltIn
Library    Collections
Library    CryptoLibrary    key_path=${CURDIR}/../resources/keys
Library    DatabaseLibrary
Library    DateTime
Library    JSONLibrary
Library    JSONSchemaLibrary    ../../../schemas
Library    OperatingSystem
Library    Process
Library    requests
Library    RequestsLibrary
Library    Screenshot
Library    SeleniumLibrary    run_on_failure=Nothing
Library    String