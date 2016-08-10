# Get current directory
project_directory=$(pwd)

/Applications/Unity5.3.5/Unity5.3.5.app/Contents/MacOS/Unity -quit -batchmode -projectPath $project_directory -executeMethod AutoBuilder.PerformAndroidBuild $1