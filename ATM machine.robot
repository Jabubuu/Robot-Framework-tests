*** Variables ***
@{kortit}         Visa    Diners    Amex    MasterCard

*** Test Cases ***
Onnistunut rahan nosto
    [Template]    Valid transaction
    ## kortti    tilin saldo    nostettava summa    erotus
    Visa    ${1000}    ${200}    ${800}
    Diners    ${500}    ${499}    ${1}
    Amex    ${1000}    ${200}    ${800}
    MasterCard    ${1000}    ${200}    ${800}

*** Keywords ***
Valid transaction
    [Arguments]    ${arg1}    ${arg2}    ${arg3}    ${arg4}
    Given credit card is inserted    ${arg1}
    And account has balance    ${arg2}
    When withdrawal amount is given    ${arg2}    ${arg3}
    Then account balance is recalculated    ${arg2}    ${arg3}    ${arg4}

Given credit card is inserted
    [Arguments]    ${arg1}
    should contain    ${kortit}    ${arg1}
    log to console    ${empty}
    log to console    Annettu kortti on ${arg1}-kortti

And account has balance
    [Arguments]    ${arg2}
    should be true    ${arg2} > 0
    log to console    Tilin saldo on ${arg2} euroa

When withdrawal amount is given
    [Arguments]    ${arg2}    ${arg3}
    should be true    ${arg2} > ${arg3}
    log to console    Nostettava summa on pienempi kuin tilin saldo (Saldo = ${arg2} ja nosto = ${arg3}

Then account balance is recalculated
    [Arguments]    ${arg2}    ${arg3}    ${arg4}
    ${arg2}=    evaluate    ${arg2}-${arg3}
    should be true    ${arg2} == ${arg4}
    log to console    Tilin uusi saldo on ${arg2} Euroa
