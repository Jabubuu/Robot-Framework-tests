*** Variables ***
${valid_username}    janne
${valid_password}    1234
${invalid_data}    qwerty

*** Test Cases ***
Valid login
    [Template]    Successful login
    ## username    password
    janne    1234

Invalid login
    [Template]    Unsuccesful login
    ## user name    password
    ${valid_username}    ${invalid_data}
    ${invalid_data}    ${valid_password}
    ${invalid_data}    ${invalid_data}

*** Keywords ***
Successful login
    [Arguments]    ${arg1}    ${arg2}
    Given login page is open
    And username is typed in
    And password is typed in
    When login button is clicked    ${arg1}    ${arg2}
    Then home page is opened

login page is open
    log to console    ${empty}
    log to console    Login sivu on auki

username is typed in
    log to console    Username on annettu

password is typed in
    log to console    Password on annettu

When login button is clicked
    [Arguments]    ${arg1}    ${arg2}
    should be equal    ${valid_username}    ${arg1}
    should be equal    ${valid_password}    ${arg2}

home page is opened
    log to console    Kotisivu aukesi

Unsuccesful login
    [Arguments]    ${arg1}    ${arg2}
    Given login page is open
    And username is typed in
    And password is typed in
    When login is clicked
    Then error message is displayed

login is clicked
    log to console    Login nappia on painettu

error message is displayed
    log to console    Username or password incorrect
