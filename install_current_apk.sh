# Get current directory
current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"
android_build_directory=$unity_build_directory"/Builds/Android/"
current_commit=$(git log --pretty=format:'%h' -n 1)
apk_path=$android_build_directory"*_"$current_commit".apk"

adb install $1 $apk_path