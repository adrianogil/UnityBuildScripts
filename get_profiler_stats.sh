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

stats_folder=$unity_build_directory"/Builds/Android/stats"
stats_log_file=$log_folder"/logcat_internal_profiler_"$current_commit".txt"

mkdir $stats_folder

python /Users/SIDIA/workspace/scripts/unity/UnityBuildScripts/get_internal_profiler.py $log_file $stats_log_file
echo 'Opening file: '$stats_log_file
sublime $stats_log_file

