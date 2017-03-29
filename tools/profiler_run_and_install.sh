current_commit=''

# Verify if the commit was passed as argument
if [ $# -eq 0 ]
then
    # if didn't received a commit, let's get the current commit
    current_commit=$(git log --pretty=format:'%h' -n 1)
fi

time $UNITY_BUILD_SCRIPTS_DIR/unity_build.sh $current_commit 'AutoBuilder.PerformAndroidProfilerBuild'

../tools/install.sh $current_commit