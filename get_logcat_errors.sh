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
echo 'Get stats from file: '$log_file

error_folder=$current_directory"/../logcat-searches/"
errors_log_file=$error_folder"/logcat_errors_"$current_commit".sublime-search"

python /Users/SIDIA/workspace/scripts/unity/get_logcat_errors.py $log_file $errors_log_file $current_commit
echo 'Opening file: '$errors_log_file
sublime $errors_log_file
