current_commit=''

# Verify if the commit was passed as argument
if [ $# -eq 0 ]
then
    # if didn't received a commit, let's get the current commit
    current_commit=$(git log --pretty=format:'%h' -n 1)
fi

time ~/workspace/scripts/unity/unity_dev_build.sh $current_commit

../tools/dev_install.sh $current_commit