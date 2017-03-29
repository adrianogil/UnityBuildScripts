
current_commit=''
repo=''
project_build_method=''
unity_app=''
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
        project_build_method='AutoBuilder.PerformAndroidBuild'
    else
        project_build_method=$2
    fi

    if [ -z "$3" ]
    then
        unity_app=''
    else
        unity_app=$3
    fi

    if [ -z "$4" ]
    then
        repo='local'
    else
        repo=$4
    fi

    if [ -z "$5" ]
    then
        internal_folder=''
    else
        internal_folder=$5
    fi

fi

tag_name='temp-unity-build-'$current_commit
git tag $tag_name $current_commit
git push $repo $tag_name

current_directory=$(pwd)


if [ -z "$5" ]
    then
        unity_build_directory=$current_directory"-unity-build"
    else
        unity_build_directory=$current_directory"-unity-build/"$internal_folder
    fi

# Enter directory of Unity build
cd $unity_build_directory

# Set the desired commit
git fetch $repo --tags
git reset --hard $tag_name
# Setup the project with build tools
setup_commit='private/setup'
git cherry-pick $setup_commit

# build this commit version
~/workspace/scripts/unity/UnityBuildScripts/unity_project_build.sh $project_build_method '_'$current_commit $unity_app

# Delete Tag
git tag -d $tag_name
git push $repo :$tag_name
cd $current_directory

android_build_directory=$unity_build_directory"/Builds/Android/"
apk_path=$android_build_directory"*_"$current_commit".apk"

# Notifify script build is finished
# (using terminal-notifier - installed by using command 'sudo gem install terminal-notifier')
# if [ -f "$apk_path" ]
# then
#     terminal-notifier -title "Unity Script Build" -message "Build Finished Successfully" -execute 'open Builds/Android/'
# else
#     terminal-notifier -title "Unity Script Build" -message "Build Finished with Errors" -execute 'open Builds/Android/'
# fi
