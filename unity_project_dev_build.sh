current_commit=$1

# Get current directory
project_directory=$(pwd)

log_folder=$project_directory"/Builds/Android/logs"
log_file=$log_folder"/log"$current_commit".txt"

if ! [ -f "$log_folder" ]
then
    mkdir $log_folder
fi

/Applications/Unity5.3.5/Unity5.3.5.app/Contents/MacOS/Unity -quit -batchmode \
 -projectPath $project_directory -logFile $log_file \
 -executeMethod AutoBuilder.PerformAndroidDevelopmentBuild $current_commit"_dev"