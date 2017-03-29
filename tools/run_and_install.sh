current_commit=''

# Verify if the commit was passed as argument
if [ $# -eq 0 ]
then
	# if didn't received a commit, let's get the current commit
	current_commit=$(git log --pretty=format:'%h' -n 1)
fi

# unity_app=/Applications/Unity5.4.2/Unity5.4.2.app/Contents/MacOS/Unity
# unity_app=/Applications/Unity5.3.6/Unity5.3.6.app/Contents/MacOS/Unity
unity_app=/Applications/Unity5.3.5/Unity5.3.5.app/Contents/MacOS/Unity
build_method='AutoBuilder.PerformAndroidBuild'

time $UNITY_BUILD_SCRIPTS_DIR/unity_build.sh $current_commit $build_method $unity_app

../tools/install.sh $current_commit