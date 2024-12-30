


# Automated Testing of Login and Signup Pages Using Robot Framework

## Introduction
This project automates the login and signup functionalities of two websites: OrangeHRM and RCMS. The automation scripts are written using Robot Framework, a keyword-driven test automation framework that simplifies writing and maintaining test cases.

### What is Robot Framework?
Robot Framework is an open-source, general-purpose automation framework. It uses human-readable keywords to create test scripts and supports external libraries like SeleniumLibrary for browser automation. It is highly extensible and ideal for automating web applications, APIs, and more.

## Features
- Automated testing of login functionality for OrangeHRM.
- Automated testing of signup functionality for RCMS.
- Uses SeleniumLibrary for browser automation.
- Validates successful and unsuccessful attempts.

## Prerequisites
Before running the tests, ensure the following:
1. Python is installed on your machine.
2. Robot Framework and SeleniumLibrary are installed.
3. A compatible web driver (e.g., ChromeDriver) is installed and added to your system's PATH.

## Installation
Follow these steps to set up the project:

1. **Install Python**
   Download and install Python from [python.org](https://www.python.org/).

2. **Install Robot Framework**
   ```bash
   pip install robotframework
   ```

3. **Install SeleniumLibrary**
   ```bash
   pip install robotframework-seleniumlibrary
   ```

4. **Download WebDriver**
   Download the appropriate web driver for your browser (e.g., ChromeDriver for Chrome) and ensure it matches the browser version.

5. **Add WebDriver to PATH**
   Add the web driver executable to your system's PATH environment variable.

## Usage

### Folder Structure
```
project/
├── test.robot  # Automation script for OrangeHRM login
└── test2.robot       # Automation script for RCMS signup
```

### Running Tests
Run the following commands to execute the test cases:

1. **OrangeHRM Login Tests:**
   ```bash
   robot orangehrm_login.robot
   ```

2. **RCMS Signup Tests:**
   ```bash
   robot rcms_signup.robot
   ```

### Test Scripts

#### OrangeHRM Login Automation

```robot
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
```

#### RCMS Signup Automation

```robot
*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${URL}                  https://beta.rcms.gov.bd/login/
${VALID_USER_ID}        MoFAU_OF@iom.int
${VALID_PASSWORD}       Secr3t
${INVALID_USER_ID}      InvalidUser
${INVALID_PASSWORD}     invalidPass
${DASHBOARD_URL}        https://beta.rcms.gov.bd/login/designation  # Ensure this URL matches the actual dashboard URL after signup.

*** Test Cases ***

Signup Test With Valid Credentials
    [Documentation]    Test signup functionality with valid credentials
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=userId    30s
    Input Signup Credentials    ${VALID_USER_ID}    ${VALID_PASSWORD}
    Signup Should Be Successful    ${DASHBOARD_URL}

Signup Test With Invalid Credentials
    [Documentation]    Test signup functionality with invalid credentials
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=userId    30s
    Input Signup Credentials    ${INVALID_USER_ID}    ${INVALID_PASSWORD}
    Signup Should Fail    ${URL}

*** Keywords ***

Input Signup Credentials
    [Arguments]    ${user_id}    ${password}
    Wait Until Element Is Visible    name=userId    10s
    Input Text    name=userId    ${user_id}
    Press Keys    xpath=//*[@id="loginPass"]    ${password}
    Click Button    xpath=//*[@id="loginForm"]/div[4]/button

Signup Should Be Successful
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'
    ...    Log    Signup successful, redirected to Dashboard!
    ...    ELSE
    ...    Fail    Expected to be on the Dashboard page, but was on ${current_url}

Signup Should Fail
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Run Keyword If    '${current_url}' == '${expected_url}'
    ...    Log    Signup failed, still on the signup page.
    ...    ELSE
    ...    Fail    Expected to be on the Signup page, but was on ${current_url}
```

## Explanation of OrangeHRM Login Test

### Login Test With Valid Credentials

```robot
Login Test With Valid Credentials
    [Documentation]    Test login functionality with valid credentials
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible    name=username    10s
    Input Login Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Login Should Be Successful    ${DASHBOARD_URL}
```

#### Step-by-Step Breakdown
1. **`[Documentation]`**
   - Provides a description of the test case.
   - States that this test verifies login with valid credentials.

2. **`Open Browser`**
   - Opens a browser window using the specified URL (`${URL}`) and browser type (`Chrome`).

3. **`Wait Until Element Is Visible`**
   - Waits for the username input field (located by `name=username`) to appear before proceeding.
   - The wait time is set to a maximum of 10 seconds.

4. **`Input Login Credentials`**
   - A custom keyword that inputs the username and password into the respective fields.
   - It then submits the form by clicking the login button.

5. **`Login Should Be Successful`**
   - Verifies that the login was successful by checking if the current URL matches the expected dashboard URL (`${DASHBOARD_URL}`).
   - Logs success or fails with a detailed error message.

## Conclusion
This project demonstrates the automation of login functionalities for OrangeHRM and signup functionalities for RCMS using Robot Framework. It highlights how Robot Framework's simplicity and extensibility make it an excellent choice for web application testing.

