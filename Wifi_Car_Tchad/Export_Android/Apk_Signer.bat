jarsigner -verbose -keystore debug.keystore -storepass android -keypass android Wifi_Car_Tchad_192-168-010-100v3.apk androiddebugkey
pause
adb install Wifi_Car_Tchad.apk
pause