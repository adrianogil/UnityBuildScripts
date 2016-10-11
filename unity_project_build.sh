build_method=$1
current_commit=$2
unity_app=$3

if [ -z "$3" ]
then
    unity_app=/Applications/Unity5.3.5/Unity5.3.5.app/Contents/MacOS/Unity
fi

# Get current directory
project_directory=$(pwd)

log_folder=$project_directory"/Builds/Android/logs"
log_file=$log_folder"/log"$current_commit".txt"

if ! [ -f "$log_folder" ]
then
    mkdir $log_folder
fi

echo "Starting project building using method "$build_method

 $unity_app -quit -batchmode \
 -projectPath $project_directory -logFile $log_file \
 -executeMethod $build_method $current_commit