current_commit=''
repo=''
# Verify if the commit was passed as argument
if [ $# -eq 0 ]
    then
        # if didn't received a commit, let's get the current commit
        current_commit=$(git log --pretty=format:'%h' -n 1)
        repo='local'
else
    current_commit=$1
    if [ -z "$2" ]
    then
        repo='local'
    else
        repo=$2
    fi
fi

tag_name='temp-unity-build-'$current_commit
git tag $tag_name $current_commit
git push $repo $tag_name

current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"

# Enter directory of Unity build
cd $unity_build_directory

# Set the desired commit
git fetch $repo --tags
git reset --hard $tag_name
# Setup the project with build tools
setup_commit='private/setup'
git cherry-pick $setup_commit

# build this commit version
~/workspace/scripts/unity/unity_project_dev_build.sh '_'$current_commit

# Delete Tag
git tag -d $tag_name
git push $repo :$tag_name
cd $current_directory

android_build_directory=$unity_build_directory"/Builds/Android/"
apk_path=$android_build_directory"*_"$current_commit".apk"

# Notifify script build is finished
# (using terminal-notifier - installed by using command 'sudo gem install terminal-notifier')
if [ -f "$apk_path" ]
then
    terminal-notifier -title "Unity Script Build" -message "Build Finished Successfully" -execute 'open Builds/Android/'
else
    terminal-notifier -title "Unity Script Build" -message "Build Finished with Errors" -execute 'open Builds/Android/'
fi