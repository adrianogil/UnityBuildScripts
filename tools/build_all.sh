# Build an Android project and copy plugin to Unity folder
# Build Unity project
# Install on android device
current_commit=''

# Verify if the commit was passed as argument
if [ $# -eq 0 ]
then
    # if didn't received a commit, let's get the current commit
    current_commit=$(git log --pretty=format:'%h' -n 1)
fi

current_directory=$(pwd)
plugin_directory=$(current_directory)AndroidPlugin

cd $plugin_directory

./gradlew build

cd $current_directory

time $UNITY_BUILD_SCRIPTS_DIR/unity_build.sh $current_commit

../tools/install.sh $current_commit