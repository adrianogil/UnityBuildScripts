repo='local'

# find build directory
current_directory=$(pwd)
unity_build_directory=$current_directory"-unity-build"

repo_url=$(git remote get-url $repo)
repo_url=$current_directory'/'$repo_url

echo 'Creating directory '$unity_build_directory
mkdir $unity_build_directory
cd $unity_build_directory
mkdir -p Builds/Android

git init
echo "Using local repository URL as "$repo_url
git remote add $repo $repo_url
git remote update
git reset --hard $repo/master