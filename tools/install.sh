adb disconnect
$UNITY_BUILD_SCRIPTS_DIR/install_current_apk.sh -r $1$2
adb logcat -c
# Connect to remote device
# adb tcpip 5555
# adb connect 105.112.147.64