*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://thermos.com/

*** Test Cases ***
*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://thermos.com/

*** Test Cases ***
Valid Registration
    [Documentation]  Test valid registration scenario
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    Click Element  xpath=//a[@class='site-nav__link site-nav__link--icon small--hide' and contains(.,'Log in')]
    Click Element  xpath=//a[@id='customer_register_link']
    Input Text  xpath=//input[@id='FirstName']  Tono
    Input Text  xpath=//input[@id='Email']  tono@example.com
    Input Text  xpath=//input[@id='Phone']  0812345678
    Input Text  xpath=//input[@id='CreatePassword']  Password1
    Input Text  xpath=//input[@name='customer[password_confirmation]']  Password1
    Click Button  xpath=//button[contains(text(),'CREATE AN ACCOUNT')]
    Close Browser

Invalid Email Format
    [Documentation]  Test invalid email format scenario
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    Click Element  xpath=//a[@class='site-nav__link site-nav__link--icon small--hide' and contains(.,'Log in')]
    Click Element  xpath=//a[@id='customer_register_link']
    Input Text  xpath=//input[@id='FirstName']  Tono
    Input Text  xpath=//input[@id='Email']  tono@com
    Input Text  xpath=//input[@id='Phone']  0812345678
    Input Text  xpath=//input[@id='CreatePassword']  Password1
    Input Text  xpath=//input[@name='customer[password_confirmation]']  Password1
    Click Button  xpath=//button[contains(text(),'CREATE AN ACCOUNT')]
    Wait Until Page Contains Element  xpath=//div[@class='errors']//li[contains(text(),'Email is invalid.')]
    Close Browser

Password Mismatch
    [Documentation]  Test password mismatch scenario
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    Click Element  xpath=//a[@class='site-nav__link site-nav__link--icon small--hide' and contains(.,'Log in')]
    Click Element  xpath=//a[@id='customer_register_link']
    Input Text  xpath=//input[@id='FirstName']  Tono
    Input Text  xpath=//input[@id='Email']  tono@example.com
    Input Text  xpath=//input[@id='Phone']  0812345678
    Input Text  xpath=//input[@id='CreatePassword']  Password1
    Input Text  xpath=//input[@name='customer[password_confirmation]']  Password11
    Click Button  xpath=//button[contains(text(),'CREATE AN ACCOUNT')]
    Handle Password Mismatch Alert
    Wait Until Alert Is Present
    ${alert_text}=  Get Alert Text
    Should Be Equal As Strings  ${alert_text}  Passwords do not match.
    Accept Alert
    Close Browser

Empty Required Fields
    [Documentation]  Test empty required fields scenario
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    Click Element  xpath=//a[@class='site-nav__link site-nav__link--icon small--hide' and contains(.,'Log in')]
    Click Element  xpath=//a[@id='customer_register_link']
    Click Button  xpath=//button[contains(text(),'CREATE AN ACCOUNT')]
    Wait Until Page Contains Element  xpath=//div[@class='errors']//li[contains(text(),"Password can't be blank.")]
    Wait Until Page Contains Element  xpath=//div[@class='errors']//li[contains(text(),"Email can't be blank.")]
    Close Browser

Password Criteria Not Met
    [Documentation]  Test password criteria not met scenario
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    Click Element  xpath=//a[@class='site-nav__link site-nav__link--icon small--hide' and contains(.,'Log in')]
    Click Element  xpath=//a[@id='customer_register_link']
    Input Text  xpath=//input[@id='FirstName']  Tono
    Input Text  xpath=//input[@id='Email']  tono1@example.com
    Input Text  xpath=//input[@id='Phone']  0812345678
    Input Text  xpath=//input[@id='CreatePassword']  pass
    Input Text  xpath=//input[@name='customer[password_confirmation]']  pass
    Click Button  xpath=//button[contains(text(),'CREATE AN ACCOUNT')]
    Wait Until Page Contains Element  xpath=//div[@class='errors']//li[contains(text(),'Password is too short (minimum is 5 characters)')]
    Close Browser
