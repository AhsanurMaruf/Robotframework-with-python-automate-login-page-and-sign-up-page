*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${URL}        https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin
${VALID_PASSWORD}    admin123
${INVALID_USERNAME}  InvalidUser
${INVALID_PASSWORD}  invalidPass
${DASHBOARD_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/dashboard/index

*** Test Cases ***

Login Test With Valid Credentials
    [Documentation]    Test login functionality with valid credentials
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible    name=username    10s
    Input Login Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Login Should Be Successful    ${DASHBOARD_URL}

Login Test With Invalid Credentials
    [Documentation]    Test login functionality with invalid credentials
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible    name=username    10s
    Input Login Credentials    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Login Should Fail    ${URL}

*** Keywords ***

Input Login Credentials
    [Arguments]    ${username}    ${password}
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    xpath=//button[@type='submit']

Login Should Be Successful
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'    Log    Login successful, redirected to Dashboard!    ELSE    Fail    Expected to be on the Dashboard page, but was on ${current_url}

Login Should Fail
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'    Log    Login failed, still on the login page.    ELSE    Fail    Expected to be on the Login page, but was on ${current_url}
