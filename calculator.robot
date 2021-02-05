*** Variables ***
@{Laskin}         On

*** Test Cases ***
Onnistunut lasku
    [Template]    Valid addition
    ## Laskin    luku1    luku2    summa    tarkistus
    On    ${5}    ${8}    ${13}    ${empty}

*** Keywords ***
Valid addition
    [Arguments]    ${arg1}    ${arg2}    ${arg3}    ${arg4}    ${arg5}
    Given laskin is open    ${arg1}
    When user has input number 1    ${arg2}
    And user has input number 2    ${arg3}
    Then numbers are calculated    ${arg2}    ${arg3}    ${arg4}    ${arg5}

Given laskin is open
    [Arguments]    ${arg1}
    should contain    ${laskin}    ${arg1}
    log to console    ${empty}
    log to console    Laskin avattu: ${arg1}

When user has input number 1
    [Arguments]    ${arg2}
    should be true    ${arg2} > 0
    log to console    Number ${arg2} given

And user has input number 2
    [Arguments]    ${arg3}
    should be true    ${arg3} > 0
    log to console    Number ${arg3} given

Then numbers are calculated
    [Arguments]    ${arg2}    ${arg3}    ${arg4}    ${arg5}
    ${arg5}=    evaluate    ${arg2}+${arg3}
    should be true    ${arg5} == ${arg4}
    log to console    Lukujen ${arg2} ja ${arg3} summa on ${arg5}
    log to console    ${empty}
    log to console    Janne Puurtinen
