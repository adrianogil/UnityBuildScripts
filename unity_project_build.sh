build_method=$1
current_commit=$2


# Get current directory
project_directory=$(pwd)

log_folder=$project_directory"/Builds/Android/logs"
log_file=$log_folder"/log"$current_commit".txt"

if ! [ -f "$log_folder" ]
then
    mkdir $log_folder
fi

echo "Starting project building using method "$build_method

/Applications/Unity5.3.5/Unity5.3.5.app/Contents/MacOS/Unity -quit -batchmode \
 -projectPath $project_directory -logFile $log_file \
 -executeMethod $build_method $current_commit