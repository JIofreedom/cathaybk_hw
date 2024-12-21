*** Settings ***
Library    AppiumLibrary
Library    JSONLibrary
Resource    ../DeviceSetting/AndroidBaseUICore.py
Resource    ../Keyword/AndroidDeviceInfo.robot
Resource    ../Keyword/CommonMethod.robot

Suite Setup    Android Open Chrome Browser

Test Setup    Go To Url    https://www.testbk.com.tw/testbk/personal/loan/calculator/mortgage-budget/

Suite Teardown    Close Application

*** variables ***
${JSON_FILE_PATH}    ../TestData/data.json

*** Test Cases ***
頁面元素確認
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_purchaseBudgetTitle}    5
    Wait Until Element Is Visible    ${houseCalculate_text_purchaseBudgetSubTitle1}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocateTitle}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_district_afterChooseCity}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanTermTitle}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanInterestRate}    5
    Wait Until Element Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_button_retryCalculation}    5
    Wait Until Element Is Visible    ${houseCalculate_text_otherCalculateTitle}    5

檢查購屋貸款方案文字連結導向
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_purchaseBudgetTitle}    5
    Click Element After It Is Visible    ${houseCalculate_text_purchaseBudgetSubTitle2}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLoanPlan}    5
    Wait Until Element Is Visible    xpath=//*[@text="貸款選擇多元"]    5

檢查房屋座落區塊標題
    [Tags]    P3
    Wait Until Element Is Visible And Element Text Should Be   ${houseCalculate_text_houseLocateTitle}    *房屋座落區塊    

選擇縣市提示文字
    [Tags]    P2
    Wait Until Element Is Visible And Element Text Should Be    ${houseCalculate_text_houseLocate_city}    選擇縣市

選擇縣市下拉式選單
    [Tags]    P1
    ${json_data}=    Load JSON From File    ${JSON_FILE_PATH}
    ${cities}=    Get From Dictionary    ${json_data}    city
    FOR    ${city}    IN    @{cities}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    xpath=//*[@text="${city}"]    5
        Run Keyword If    not    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@text="${city}"]    Fail    Missing city: ${city}
    END

選擇行政區提示文字
    [Tags]    P2
    Wait Until Element Is Visible And Element Text Should Be    ${houseCalculate_text_houseLocate_district}     選擇行政區

選擇行政區下拉式選單_未選擇縣市
    [Tags]    P2
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_district}    5
    Wait Until Element Is Visible    xpath=//*[@text="選擇行政區"]    5

選擇行政區下拉式選單_已選擇縣市
    [Tags]    P2
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_district}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_Choose}    5

檢查房屋座落區塊選擇狀態
    [Tags]    P2
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_district}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_Choose}    5

檢查重新選擇縣市直接選擇屋座落區塊區塊
    [Tags]    Bug    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Scroll UP Until Element Found    ${houseCalculate_text_houseLocate_city}
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district}    5
    Wait Until Element Is Visible    xpath=//*[@text="選擇行政區"]    5

檢查房屋座落區塊縣市不選擇
    [Tags]    P1
    Wait Until Element Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Input Text After It Is Visible    ${homeCalculate_input_everyMonthCanPay}    3    5
    Input Text After It Is Visible    ${homeCalculate_input_loanInterestRaten}    3    5
    Click Element After It Is Visible    ${homeCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${homeCalculate_text_errorMessage_chooseCity}    5
    Wait Until Element Is Visible    ${homeCalculate_text_errorMessage_chooseLocate}    5

檢查房屋座落區塊區塊不選擇
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    3    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    3    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_chooseLocate}    5

檢查每月可負擔房貸金額區塊標題
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_everyMonthCanPayTitleMark}    5
    Wait Until Element Is Visible    ${houseCalculate_text_everyMonthCanPayTitle}    5

檢查每月可負擔房貸金額輸入欄位
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible And Element Text Should Be    ${houseCalculate_text_everyMonthCanPayUnit}    萬元    5

每月可負擔房貸金額輸入框_空白_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    3    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_everyMonthCanpay}    5

每月可負擔房貸金額輸入欄位_非數字_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    test    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    3    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_everyMonthCanpay}    5

每月可負擔房貸金額輸入欄位_標點符號_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    !@    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    3    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_everyMonthCanpay}    5

每月可負擔房貸金額_輸入欄位輸入負數
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    -1    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    3    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_everyMonthCanpay}    5

檢查貸款年限區塊標題
    [Tags]    P3
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanTermTitle}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanTermTitleMark}    5

檢查貸款利率區塊標題
    [Tags]    P3
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanInterestRate}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanInterestRateMark}    5

檢查貸款利率輸入框顯示
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_loanInterestRatePersent}    5

貸款利率輸入框_空白_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    10
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}    5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    10    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_loanInterestRate}    5

貸款利率輸入框_非數字_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    10
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    10    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    test    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    10
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_loanInterestRate}    5

貸款利率輸入框_標點符號_錯誤狀態顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    10    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    !@    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    ${houseCalculate_text_errorMessage_loanInterestRate}    5

貸款利率輸入匡_輸入負數
    [Tags]    P1
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    10    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    -1    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible And Element Text Should Be    ${houseCalculate_text_spanHousePrice}    0    5

重新試算按鈕功能_30年限
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    6    5
    Click Element After It Is Visible    xpath=//*[@text="30年"]    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    2.2    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    xpath=//*[@text="試算結果"]    5
    Wait Until Element Is Visible    xpath=//*[@text="注意事項： 本試算結果僅供參考，實際貸款條件仍依法令規範及本行提供之產品為準；本行將依您實際信用狀況、個人資力及擔保品價值等資訊，綜合評量審查決定核准與否，並同時保留調整產品規格、申貸期限及其他相關規定之權利。"]    5
    Wait Until Element Is Visible    xpath=//*[@text="還在等什麼呢？"]    5
    Wait Until Element Is Visible    ${houseCalculate_text_spanHousePrice}    5
    Scroll UP Until Element Found    ${houseCalculate_button_startCalculating}
    Click Element After It Is Visible    ${houseCalculate_button_retryCalculation}    5
    Scroll UP Until Element Found    ${houseCalculate_text_houseLocateTitle}
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district}    5

重新試算按鈕功能_其他年限
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    6    5
    Click Element After It Is Visible    xpath=//*[@text="40年"]    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    2.2    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    xpath=//*[@text="試算結果"]    5
    Wait Until Element Is Visible    xpath=//*[@text="注意事項： 本試算結果僅供參考，實際貸款條件仍依法令規範及本行提供之產品為準；本行將依您實際信用狀況、個人資力及擔保品價值等資訊，綜合評量審查決定核准與否，並同時保留調整產品規格、申貸期限及其他相關規定之權利。"]    5
    Wait Until Element Is Visible    xpath=//*[@text="還在等什麼呢？"]    5
    Wait Until Element Is Visible    ${houseCalculate_text_spanHousePrice}    5
    Scroll UP Until Element Found    ${houseCalculate_button_startCalculating}
    Click Element After It Is Visible    ${houseCalculate_button_retryCalculation}    5
    Scroll UP Until Element Found    ${houseCalculate_text_houseLocateTitle}
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district}    5

重新試算按鈕功能_其他年限
    [Tags]    P2
    Wait Until Element Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${homeCalculate_input_everyMonthCanPay}    6    5
    Click Element After It Is Visible    xpath=//*[@text="40年"]    5
    Input Text After It Is Visible    ${homeCalculate_input_loanInterestRaten}    2.2    5
    Click Element After It Is Visible    ${homeCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    xpath=//*[@text="試算結果"]    5
    Wait Until Element Is Visible    xpath=//*[@text="注意事項： 本試算結果僅供參考，實際貸款條件仍依法令規範及本行提供之產品為準；本行將依您實際信用狀況、個人資力及擔保品價值等資訊，綜合評量審查決定核准與否，並同時保留調整產品規格、申貸期限及其他相關規定之權利。"]    5
    Wait Until Element Is Visible    xpath=//*[@text="還在等什麼呢？"]    5
    Wait Until Element Is Visible    ${homeCalculate_text_spanHousePrice}    5
    Scroll UP Until Element Found    ${homeCalculate_button_startCalculating}
    Click Element After It Is Visible    ${homeCalculate_button_retryCalculation}    5
    Scroll UP Until Element Found    ${homeCalculate_text_houseLocateTitle}
    Wait Until Element Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Wait Until Element Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_district}    5

房貸試算_建議購屋預算試算結果顯示
    [Tags]    P1
    Wait Until Element Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${homeCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${homeCalculate_input_everyMonthCanPay}    6    5
    Click Element After It Is Visible    xpath=//*[@text="30年"]    5
    Input Text After It Is Visible    ${homeCalculate_input_loanInterestRaten}    2.2    5
    Click Element After It Is Visible    ${homeCalculate_button_startCalculating}    5
    Wait Until Element Is Visible    xpath=//*[@text="試算結果"]    5
    Wait Until Element Is Visible    xpath=//*[@text="注意事項： 本試算結果僅供參考，實際貸款條件仍依法令規範及本行提供之產品為準；本行將依您實際信用狀況、個人資力及擔保品價值等資訊，綜合評量審查決定核准與否，並同時保留調整產品規格、申貸期限及其他相關規定之權利。"]    5
    Wait Until Element Is Visible    xpath=//*[@text="還在等什麼呢？"]    5
    Wait Until Element Is Visible    ${homeCalculate_text_spanHousePrice}    5

檢查馬上預約諮詢按鈕導向是否正確
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocate_city_Choose}   5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_district_afterChooseCity}    5
    Click Element After It Is Visible    ${houseCalculate_text_houseLocate_Choose}   5
    Input Text After It Is Visible    ${houseCalculate_input_everyMonthCanPay}    6    5
    Click Element After It Is Visible    xpath=//*[@text="30年"]    5
    Input Text After It Is Visible    ${houseCalculate_input_loanInterestRaten}    2.2    5
    Click Element After It Is Visible    ${houseCalculate_button_startCalculating}    5
    Click Element After It Is Visible    ${houseCalculate_button_bookAppointment}    5
    Wait Until Element Is Visible    xpath=//*[@text="預約房屋貸款諮詢"]    5

檢查其他試算標題文字是否正確
    [Tags]    P3
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Scroll Down Until Element Found    ${houseCalculate_text_otherCalculateTitle}

檢查每月還款金額試算區塊顯示是否正確
    [Tags]    P3
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Scroll Down Until Element Found    ${houseCalculate_text_otherCalculateTitle}
    Scroll Down Until Element Found    ${houseCalculate_text_everyMonthCanPayCalculateTitle}
    Scroll Down Until Element Found    ${houseCalculate_text_everyMonthCanPayCalculateSubtitle}
    Scroll Down Until Element Found    ${houseCalculate_button_everyMonthCanPayCalculate}

檢查每月還款金額試算button導向是否正確
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Scroll Down Until Element Found    ${houseCalculate_text_otherCalculateTitle}
    Scroll Down Until Element Found    ${houseCalculate_text_everyMonthCanPayCalculateTitle}
    Scroll Down Until Element Found    ${houseCalculate_text_everyMonthCanPayCalculateSubtitle}
    Click Element After It Is Visible    ${houseCalculate_button_everyMonthCanPayCalculate}    5
    Wait Until Element Is Visible    xpath=//android.view.View[@text="寬限期"]    5

檢查貸款成數試算區塊顯示是否正確
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Scroll Down Until Element Found    ${houseCalculate_image_loanRatio}
    Scroll Down Until Element Found    ${houseCalculate_text_loanRatioSubtitle}
    Scroll Down Until Element Found    ${houseCalculate_text_loanRatioSubtitle}

檢查貸款成數試算button導向是否正確
    [Tags]    P2
    Wait Until Element Is Visible    ${houseCalculate_text_houseLocatePlaceHolder_city}    5
    Scroll Down Until Element Found    ${houseCalculate_image_loanRatio}
    Scroll Down Until Element Found    ${houseCalculate_text_loanRatioTitle}
    Scroll Down Until Element Found    ${houseCalculate_text_loanRatioSubtitle}
    Click Element After It Is Visible    ${houseCalculate_button_loanRatio}    5
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="房貸試算-購屋可貸成數試算"]    5

