*** Settings ***
Library           Dialogs
Library           Collections
Library           OperatingSystem
Library           String
Library           C:/Anaconda2019.03/Lib/site-packages/ExcelLibrary.py
Library           testaus

*** Variables ***
${sana}           Sovellustesti
${sana2}          on kivaa
@{numerot}        3    100    47    23    55    19
@{nimet}          Roope    Kroisos    Aku    Iines    Hessu    Minni
@{numbers}        ${3}    ${100}

*** Test Cases ***
Tulosta testit ruudulle
    log to console    ${sana} ${sana2}

Kysy inputtia
    ${annettu}=    Get value from user    ${sana} ${sana2}?
    log to console    ${annettu}

Tulosta listan ensimmäinen arvo pihalle
    log to console    @{numerot}[0]

Add value to list
    ${luku}=    set variable    333
    append to list    ${numerot}    ${luku}
    log to console    @{numerot}[6]
    should be equal    @{numerot}[6]    333

hae listan pituus muuttujaan
    sort list    ${nimet}
    log to console    @{nimet}[0]
    remove from list    ${nimet}    0
    log to console    @{nimet}[0]

tulosta nimet ruudulle
    ${pituus}    get length    ${nimet}
    : FOR    ${INDEX}    IN RANGE    0    ${pituus}
    \    log to console    @{nimet}[${INDEX}]

make stuff with folders and files
    ${path}=    set variable    c:/temp//sovellustestaus
    remove directory    ${path}

pingaa www sivua
    ${rc}=    run and return RC and output    ping www.iltalehti.fi
    log to console    ${rc}

get text from file
    ${teksti}=    get file    P://Sovelluskehitys/esimerkki.txt
    ${teksti}=    remove string    ${teksti}    ,    .
    @{sanat}=    split string    ${teksti}
    ${luku}=    get index from list    ${sanat}    students
    ${arvo}=    convert to integer    24
    Should be equal    ${arvo}    ${luku}

avainsanat
    ${lause}=    set variable    Sovellustestaus on mukavaa!
    ${palautus}=    pilko teksti    ${lause}
    log to console    ${palautus}

Excel
    ${polku}=    set variable    P://Sovelluskehitys//
    Create excel document    test
    write excel cell    2    2    Testaus    Sheet
    : FOR    ${INDEX}    IN RANGE    1    21
    \    write excel cell    5    ${INDEX}    Henkilö${INDEX}    Sheet
    save excel document    ${polku}testi.xlsx

hae listalta maksimi
    ${arvo}=    get max from list    ${numbers}
    log to console    ${arvo}

*** Keywords ***
pilko teksti
    [Arguments]    ${lause}
    @{lista}=    split string    ${lause}
    ${palautus}=    set variable    @{lista}[2]
    return from keyword    ${palautus}
