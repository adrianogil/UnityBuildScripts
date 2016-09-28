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
log_file=$log_folder"/log_"$current_commit".txt"

/usr/local/bin/sublime $log_file