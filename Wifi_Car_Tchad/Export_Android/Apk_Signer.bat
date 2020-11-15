jarsigner -verbose -keystore debug.keystore -storepass android -keypass android Wifi_Car_Tchad.apk androiddebugkey
pause
adb install Wifi_Car_Tchad.apk
pause