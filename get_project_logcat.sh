current_commit=""

if [ -z "$2" ]
then
    current_commit=$(git log --pretty=format:'%h' -n 1)
else
    current_commit=$2
fi

current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"

log_folder=$unity_build_directory"/Builds/Android/logs"
log_file=$log_folder"/logcat_"$current_commit".txt"

echo 'Getting logcat'
adb shell logcat -d -v time > $log_file

echo 'Opening file: '$log_file
sublime $log_file