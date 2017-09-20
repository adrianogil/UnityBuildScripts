adb shell screencap -p /sdcard/screen.png
adb pull /sdcard/screen.png
adb shell rm /sdcard/screen.png
mv screen.png screenshot_$(date +%F-%H:%M).png