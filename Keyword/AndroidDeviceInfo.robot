*** Settings ***
Library    AppiumLibrary
Library    Process
Library    String
Library    ../DeviceSetting/AndroidBaseUICore.py

*** Variables ***
${devicename}
${port}

*** Keywords ***
Android Open Chrome Browser
    @{DeviceInfo} =    AndroidBaseUICore.GetDeviceInfo    ${devicename}    ${port}
    Open Application    ${DeviceInfo}[0]    platformName=${DeviceInfo}[1]    platformVersion=${DeviceInfo}[2]    deviceName=${DeviceInfo}[3]    appPackage=com.android.chrome   appActivity=com.google.android.apps.chrome.Main
    ...        automationName=${DeviceInfo}[6]    systemPort=${DeviceInfo}[7]    autoDismissAlerts=${True}     noReset=${True}    autoGrantPermissions=${True}    chromedriverExecutable=/Users/mikehsieh/Downloads/chromedriver
