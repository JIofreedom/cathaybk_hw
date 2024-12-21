*** Settings ***
Library    AppiumLibrary
Library    Collections
Resource   ../Variable/Mortgage_loan_calculationVariable.robot

*** Keywords ***
# Open chrome app
Open url from Chrome
    [Arguments]    ${url}
    Run Process    adb    shell    am start -a android.intent.action.VIEW -d  ${url} com.android.chrome

# Click operation
Click Element After It Is Visible
    [Arguments]    ${locator}    ${timeout}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}

Click Element If It Is Visible
    [Arguments]    ${locator}    ${timeout}=5
    TRY
        Click Element After It Is Visible    ${locator}    ${timeout}
    EXCEPT
        Log    PASS
    END

# Input operation
Input Text After It Is Visible
    [Arguments]    ${locator}    ${text}    ${timeout}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Input Text    ${locator}    ${text}

# Scroll operation
Scroll from locatorA to locatorB if keyword is unvisible
    [Arguments]    ${keyword}    ${locatorA}    ${locatorB}
    Wait Until Element Is Visible    ${locatorB}    15
    ${is_visible} =  Run Keyword And Return Status    Page Should Contain Element    ${keyword}
    Run Keyword If    ${is_visible}==${False}    Scroll    ${locatorA}    ${locatorB}

Scroll Down Until Element Found
    [Arguments]    ${locator}    ${end_locator}=${bottom}
    FOR    ${i}    IN RANGE    30
        Log To Console    往下捲動 ${i}
        ${is_found}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
        ${is_bottom}=    Run Keyword And Return Status    Page Should Contain Element    ${end_locator}
        Exit For Loop If    '${is_found}' == 'True'
        Run Keyword If  ('${i}' == '49') or ('${is_bottom}' == 'True')  Fail    Could not find element
        Swipe By Percent     15    70    15     15    duration=500
    END

Scroll UP Until Element Found
    [Arguments]    ${locator}
    FOR    ${i}    IN RANGE    30
        ${is_found}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
        Exit For Loop If    '${is_found}' == 'True'
        Run Keyword If    '${i}' == '29'    Fail    Could not find element
        Swipe    875    1500    875    1750    duration=1000
    END

Scroll Until Element Found in Element
    [Arguments]    ${parentElement}    ${locator}
    
    FOR    ${i}    IN RANGE    30
        Log To Console    往下捲動 ${i}
        ${element}    Get Webelement In Webelement   ${parentElement}    ${locator}
        ${is_found}=  Run Keyword And Return Status   Element Attribute Should Match     ${element}    visible    True
        Log To Console    isfound ${is_found}

        Exit For Loop If    '${is_found}' == 'True'
        Run Keyword If  ('${i}' == '29')  Fail    Could not find element
        # Run Keyword If  ('${i}' == '29') or ('${is_bottom}' == 'True')  Fail    Could not find element
        Swipe By Percent     15    55    5     -35    duration=500
    END

Quick Scroll
    [Arguments]    ${count}
    FOR    ${i}    IN RANGE    ${count}
        Swipe By Percent     15    85    0    -60    duration=500
        Log To Console    queik ${i}
    END

Scroll Left Until Element Found And Click
    [Arguments]    ${locator}
    FOR    ${i}    IN RANGE    16
        Log To Console    loop ${i}
        ${is_found}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
        Exit For Loop If    '${is_found}' == 'True'
        Run Keyword If    '${i}' == '15'    Fail    Could not find element
        Swipe     80    800    -800     0    duration=250
    END
    Sleep    0.25
    Click Element     ${locator}
    Log To Console      found ${locator}

# Back operation
Back To Previous Page
    Click Element After It Is Visible    ${common_button_back}    2

Back To Previous Page Until Element Found
    [Arguments]    ${locator}        ${timeout}=2
    FOR    ${i}    IN RANGE    30
        ${is_found}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
        Exit For Loop If    '${is_found}' == 'True'
        Run Keyword If    '${i}' == '29'    Fail    Could not find element
        Click Element After It Is Visible    ${common_button_back}    ${timeout}
    END

# Assertion
Element Text Should Not Be Empty
    [Arguments]    ${locator}
    ${text} =    Get Text    ${locator}
    Should Not Be Empty    ${text}    ${locator} text is empty

Element Text Should Not Be
    [Arguments]    ${locator}    ${unexpectedText}
    ${text} =    Get Text    ${locator}
    ${text} =    Convert To String    ${text}
    IF    "${text}" == "${unexpectedText}"
        RETURN    ${False}
    ELSE
        RETURN    ${True}
    END

Element Should be Unvisible
    [Arguments]    ${locator}
    Sleep    5
    ${Element_count}    Get Matching Xpath Count    ${locator}
    Should Be Equal As Integers    ${Element_count}    0

Wait Until Element Is Visible And Element Text Should Be
    [Arguments]    ${locator}    ${expected}
    Wait Until Element Is Visible    ${locator}    5
    Element Text Should Be    ${locator}    ${expected}

Wait Until Element Is Visible And Element Text Should Contain
    [Arguments]    ${locator}    ${expected}    ${timeout}=5
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Element Should Contain Text    ${locator}    ${expected}

# Get function
Get Text Until It Is Visible
    [Arguments]    ${variable}
    Wait Until Element Is Visible    ${variable}    5
    ${text}    Get Text    ${variable}
    RETURN    ${text}

Get Nested Element
    [Arguments]    ${fromElementLocator}    ${subElementLocator}
    ${fromElement}    Get Webelement    ${fromElementLocator}
    ${subElement}    Get Webelement In Webelement   ${fromElement}    ${subElementLocator}
    RETURN    ${subElement} 