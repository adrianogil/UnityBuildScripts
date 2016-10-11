# Create Unity Build
#  - Setup folders
#
# Requisites:
#  - Needs a local repository
#  - Your current unity project must be a git repository
#  Usage: Run this command in a directory of your unity project
#     ./create_unity_build.sh
#
# Expected folder structure
# - /pathto/current_unity_project/
# - /pathto/current_unity_project.git/
# - /pathto/current_unity_project-unity-build/
# - /pathto/tools/

# Setup some variables
repo='local'
target_branch='master'

# define directories
current_directory=$(pwd)
repo_url=$current_directory".git"
unity_build_directory=$current_directory"-unity-build"
tools_directory=$current_directory/../tools
builder_script_directory=$current_directory/Assets/Editor/Build

repo_url=$(git remote get-url $repo)
repo_url=$current_directory'/'$repo_url

echo 'Creating local git repository '$repo_url
mkdir $repo_url
cd $repo_url
git init --bare
cd $current_directory
git remote add $repo $repo_url
git remote update
git push $repo $target_branch

echo 'Creating directory '$unity_build_directory
mkdir $unity_build_directory
cd $unity_build_directory
mkdir -p Builds/Android

git init
echo "Using local repository URL as "$repo_url
git remote add $repo $repo_url
git remote update
git reset --hard $repo/$target_branch

echo "Creating tools directory at "$tools_directory
cp -r $UNITY_BUILD_SCRIPTS_DIR/tools $tools_directory

echo "Creating private/setup commit"
mkdir -p $builder_script_directory
cp $UNITY_BUILD_SCRIPTS_DIR/AutoBuilder.cs builder_script_directory/
git add builder_script_directory/AutoBuilder.cs
git commit -m "Private Setup"
git tag private/setup
git push $repo private/setup
git reset --hard HEAD~1