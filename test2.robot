*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${URL}                  https://beta.rcms.gov.bd/login/
${VALID_USER_ID}        MoFAU_OF@iom.int
${VALID_PASSWORD}       Secr3t
${INVALID_USER_ID}      InvalidUser
${INVALID_PASSWORD}     invalidPass
${DASHBOARD_URL}        https://beta.rcms.gov.bd/login/designation  # Ensure this URL matches the actual dashboard URL after login.

*** Test Cases ***

Login Test With Valid Credentials
    [Documentation]    Test login functionality with valid credentials
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=userId    30s
    Input Login Credentials    ${VALID_USER_ID}    ${VALID_PASSWORD}
    Login Should Be Successful    ${DASHBOARD_URL}

Login Test With Invalid Credentials
    [Documentation]    Test login functionality with invalid credentials
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=userId    30s
    Input Login Credentials    ${INVALID_USER_ID}    ${INVALID_PASSWORD}
    Login Should Fail    ${URL}


*** Keywords ***

Input Login Credentials
    [Arguments]    ${user_id}    ${password}
    Wait Until Element Is Visible    name=userId    10s
    Input Text    name=userId    ${user_id}
   
    Press Keys   xpath= //*[@id="loginPass"]   ${password}
 
    Click Button    xpath=//*[@id="loginForm"]/div[4]/button

Login Should Be Successful
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'    
    ...    Log    Login successful, redirected to Dashboard!
    ...    ELSE
    ...    Fail    Expected to be on the Dashboard page, but was on ${current_url}

Login Should Fail
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'    
    ...    Log    Login failed, still on the login page.
    ...    ELSE
    ...    Fail    Expected to be on the Login page, but was on ${current_url}
