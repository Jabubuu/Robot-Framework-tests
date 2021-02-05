*** Settings ***
Library           OperatingSystem
Library           SeleniumLibrary
Library           String
Library           Collections

*** Variables ***
@{lista}
${numerot}        ${EMPTY}
${valinta}        ${EMPTY}
@{nimet}
@{vertaus}
${nimet}          ${EMPTY}

*** Test Cases ***
Lue tekstitiedosto
    ${numerot}=    Get File    D://valinnat.txt
    Set Global Variable    ${numerot}
    @{lista}=    Split to lines    ${numerot}
    Set Global Variable    @{lista}
    log to console    ${lista}

Syötä kotikunta
    open browser    https://vaalikone.yle.fi/eduskuntavaali2019/    Chrome
    maximize browser window
    wait until element is visible    //*[@id="root"]/main/div[1]/section/div[2]/img
    input text    //*[@id="root"]/main/div[1]/section/div[2]/input    Hämeenlinna
    click element    //*[@id="root"]/main/div[1]/section/div[2]/div/a
    Sleep    1s
    click button    //*[@id="root"]/main/div[1]/section/button

Syötä valinnat
    wait until element is visible    //*[@id="root"]/main/div[1]/div/article[1]/section[1]/div/div[2]/span
    log to console    ${lista}
    ${valinta}    Get From List    ${lista}    0
    select radio button    question_6    ${valinta}
    ${valinta}    Get From List    ${lista}    1
    select radio button    question_7    ${valinta}
    ${valinta}    Get From List    ${lista}    2
    select radio button    question_8    ${valinta}
    ${valinta}    Get From List    ${lista}    3
    select radio button    question_9    ${valinta}
    ${valinta}    Get From List    ${lista}    4
    select radio button    question_57    ${valinta}
    ${valinta}    Get From List    ${lista}    5
    select radio button    question_58    ${valinta}
    ${valinta}    Get From List    ${lista}    6
    select radio button    question_18    ${valinta}
    ${valinta}    Get From List    ${lista}    7
    select radio button    question_17    ${valinta}
    ${valinta}    Get From List    ${lista}    8
    select radio button    question_3    ${valinta}
    ${valinta}    Get From List    ${lista}    9
    select radio button    question_56    ${valinta}
    ${valinta}    Get From List    ${lista}    10
    select radio button    question_11    ${valinta}
    ${valinta}    Get From List    ${lista}    11
    select radio button    question_13    ${valinta}
    ${valinta}    Get From List    ${lista}    12
    select radio button    question_10    ${valinta}
    ${valinta}    Get From List    ${lista}    13
    select radio button    question_12    ${valinta}
    ${valinta}    Get From List    ${lista}    14
    select radio button    question_16    ${valinta}
    ${valinta}    Get From List    ${lista}    15
    select radio button    question_19    ${valinta}
    ${valinta}    Get From List    ${lista}    16
    select radio button    question_20    ${valinta}
    ${valinta}    Get From List    ${lista}    17
    select radio button    question_22    ${valinta}
    ${valinta}    Get From List    ${lista}    18
    select radio button    question_21    ${valinta}
    ${valinta}    Get From List    ${lista}    19
    select radio button    question_4    ${valinta}
    ${valinta}    Get From List    ${lista}    20
    select radio button    question_5    ${valinta}
    ${valinta}    Get From List    ${lista}    21
    select radio button    question_1    ${valinta}
    ${valinta}    Get From List    ${lista}    22
    select radio button    question_2    ${valinta}
    ${valinta}    Get From List    ${lista}    23
    select radio button    question_55    ${valinta}
    ${valinta}    Get From List    ${lista}    24
    select radio button    question_59    ${valinta}
    ${valinta}    Get From List    ${lista}    25
    select radio button    question_23    ${valinta}
    ${valinta}    Get From List    ${lista}    26
    select radio button    question_24    ${valinta}
    ${valinta}    Get From List    ${lista}    27
    select radio button    question_25    ${valinta}
    ${valinta}    Get From List    ${lista}    28
    select radio button    question_26    ${valinta}
    ${valinta}    Get From List    ${lista}    29
    select radio button    question_27    ${valinta}
    Sleep    1s
    click button    //*[@id="root"]/main/div[1]/div/button

Hae ehdokkaan nimi
    ${nimet}=    Get text    //*[@id="root"]/main/div[1]/div/section[1]/div[1]
    Log to console    ${nimet}
