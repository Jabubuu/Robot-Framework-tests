*** Settings ***
Library           OperatingSystem
Library           String
Library           SeleniumLibrary

*** Test Cases ***
vertaa kuvia ja luo comparison kuva
    ${polku}=    set variable    P://Temppi//
    ${rc}=    run and return rc and output    C://ImageMagick//magick ${polku}calc_aito.png ${polku}calc_changed.png -metric RMSE -compare -format "%[distortion]" info:
    ${rc}    convert to string    ${rc}
    ${rc}    get substring    ${rc}    5    10
    ${rc}    evaluate     ${rc}*100
    run keyword and continue on failure    should be true    ${rc}<1
    run keyword if     ${rc}>1    run    C://ImageMagick//magick ${polku}calc_aito.png ${polku}calc_changed.png -metric RMSE -compare ${polku}difference.png
    log to console    ${rc}

Ota Baseline kuva Google sivusta
    ${baseline}=    set variable    P://Temppi//GoogleBaseline
    ${kuvakaappaus}=    set variable    selenium-screenshot-1.png
    create directory     ${baseline}
    empty directory    ${baseline}
    set screenshot directory    ${baseline}
    open browser    https://www.google.fi    Chrome
    maximize browser window
    element should be visible    xpath: //*[@id="hplogo"]
    capture page screenshot

Ota baseline kuva elementistä kissa
    ${baseline}=    set variable    P://Temppi//KissaBaseline//
    ${kuvakaappaus}=    set variable    selenium-screenshot-1.png
    create directory     ${baseline}
    empty directory    ${baseline}
    set screenshot directory    ${baseline}
    input text    xpath: //*[@id="tsf"]/div[2]/div[1]/div[1]/div/div[2]/input    Kissa
    wait until element is enabled    xpath: //*[@id="tsf"]/div[2]/div[1]/div[2]/div[2]/div[2]/center/input[1]
    click element    xpath: //*[@id="tsf"]/div[2]/div[1]/div[2]/div[2]/div[2]/center/input[1]
    wait until element is visible    xpath: /html/body/div[7]/div[3]/div[10]/div[1]/div[3]/div/div[1]/div[1]/div[1]/div/div[1]/div[2]/div[1]/div/div/div/div/div[1]/div[2]/div/div/div[1]/a/g-img/img
    capture element screenshot    xpath: /html/body/div[7]/div[3]/div[10]/div[1]/div[3]/div/div[1]/div[1]/div[1]/div/div[1]/div[2]/div[1]/div/div/div/div/div[1]/div[2]/div/div/div[1]/a/g-img/img
    close browser

Ota kuva Google sivusta ja vertaa baseline kuvaan
    ${baseline}=    set variable    P://Temppi//GoogleBaseline//
    ${polku}=    set variable    P://Temppi//GoogleTest//
    ${kuvakaappaus}=    set variable    selenium-screenshot-1.png
    create directory     ${polku}
    empty directory    ${polku}
    set screenshot directory    ${polku}
    open browser    https://www.google.fi    Chrome
    maximize browser window
    element should be visible    xpath: //*[@id="hplogo"]
    input text    xpath: //*[@id="tsf"]/div[2]/div[1]/div[1]/div/div[2]/input    Kissa
    capture page screenshot
    ${rc}=    run and return rc and output    C://ImageMagick//magick ${baseline}${kuvakaappaus} ${polku}${kuvakaappaus} -metric RMSE -compare -format "%[distortion]" info:
    ${rc}=    convert to string    ${rc}=
    ${pituus}    get length    ${rc}=
    ${rc}=    run keyword if     ${pituus}>8    get substring    ${rc}    5    10
    ${rc}=    run keyword if     ${pituus}>8    evaluate    ${rc}*100
    run keyword if     ${pituus}>8    run keyword and continue on failure     should be true    ${rc}<0.0001
    run keyword if     ${pituus}>8    run keyword if     ${rc}>0.001    run     C://ImageMagick//magick ${baseline}${kuvakaappaus} ${polku}${kuvakaappaus} -metric RMSE -compare ${polku}difference.png
