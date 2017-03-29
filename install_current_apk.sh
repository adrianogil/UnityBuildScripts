current_commit=""

if [ -z "$2" ]
then
    current_commit=$(git log --pretty=format:'%h' -n 1)
else
    current_commit=$2
fi

if [ -z "$3" ]
then
    internal_folder=''
else
    internal_folder='/'$3
fi

# Get current directory
current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"$internal_folder
android_build_directory=$unity_build_directory"/Builds/Android/"

apk_path=$android_build_directory"*"$current_commit".apk"

adb install $1 $apk_path

notif_message="APK Installed from commit "$current_commit

# Notifify script build is finished
# (using terminal-notifier - installed by using command 'sudo gem install terminal-notifier')
terminal-notifier -title "Terminal" -message "$notif_message"