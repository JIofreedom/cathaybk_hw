def GetDeviceInfo(devicename, port):

    value = "Default"

    if(devicename == "Pixel_8_Pro_API_35"):
        desired_caps = {
        'platformName' : 'Android',
        'platformVersion' : '15.0',
        'deviceName' : 'emulator-5554',
        'automationName' : 'uiautomator2',
        'systemPort' : '8203',
        'chromedriverExecutable': './chromedriver'
    }
    else:
        value = "Error devicename!"

    if value != "Error devicename!":
        webdriver_url = 'http://localhost:{}/wd/hub'.format(port)
        value = [webdriver_url, desired_caps['platformName'], desired_caps['platformVersion'], desired_caps['deviceName'], desired_caps['appPackage'], desired_caps['appActivity'], desired_caps['automationName'], desired_caps['systemPort'], desired_caps['chromedriverExecutable']]

    return value