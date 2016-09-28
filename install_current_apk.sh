current_commit=""

if [ -z "$2" ]
then
    current_commit=$(git log --pretty=format:'%h' -n 1)
else
    current_commit=$2
fi

# Get current directory
current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"
android_build_directory=$unity_build_directory"/Builds/Android/"

apk_path=$android_build_directory*$3"*_"$current_commit".apk"

adb install $1 $apk_path

notif_message="APK Installed from commit "$current_commit

# Notifify script build is finished
# (using terminal-notifier - installed by using command 'sudo gem install terminal-notifier')
terminal-notifier -title "Terminal" -message "$notif_message"