
export UNITY_HUB_APPS_DIR=/Applications/Unity/Hub/Editor
source $UNITY_BUILD_SCRIPTS_DIR/doxygen/doxygen_bashrc.sh

alias unity-version='python3 '${UNITY_BUILD_SCRIPTS_DIR}'/python/get_unity_version.py'
alias unv='unity-version'

# Dynamic Unity versions alias
# Check if there is any Unity folder in UNITY_HUB_APPS_DIR
if [ ! "$(ls -A ${UNITY_HUB_APPS_DIR})" ]; then
    # echo "No Unity editor is installed"
else
    for file in ${UNITY_HUB_APPS_DIR}/*/ ; do
        if [[ -d "$file" && ! -L "$file" ]]; then
            base_file=`basename $file`
            alias open-unity-${base_file}="${file}/Unity.app/Contents/MacOS/Unity -projectPath \$PWD"
        fi;
    done
fi


function unity()
{
    if [ -z "$1" ]
    then
        target_directory=$PWD
    else
        target_directory=$1
    fi

    # Check if there is any Unity folder in UNITY_HUB_APPS_DIR
    if [ ! "$(ls -A ${UNITY_HUB_APPS_DIR})" ]; then
        echo "No Unity editor is installed"
        return
    fi

    best_unity_version=$(python3 ${UNITY_BUILD_SCRIPTS_DIR}/python/best_installed_unity_version.py $target_directory)

    if [ -z "$best_unity_version" ]
    then
        echo 'Not found a suitable version'
    else
        echo 'Loading unity version: '$best_unity_version

        if test -n "$STY"
        then
            printf "This is a screen session named '$STY'.\n"
            ${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity -projectPath $target_directory
        else
            screen_name=$(basename $PWD)
            screen_name=$(echo $screen_name | tr '[:upper:]' '[:lower:]')
            if [[ $screen_name == *"nity"* ]]; then
                screen_name=${screen_name}
            else
                screen_name=${screen_name}-unity
            fi

            printf "Started a new screen session: "${screen_name}

            screen -S $screen_name -dm ${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity -projectPath $target_directory
        fi


    fi
}

function unity-fz()
{
    if [ -z "$1" ]
    then
        target_directory=$PWD
    else
        target_directory=$1
    fi

    best_unity_version=$(ls ${UNITY_HUB_APPS_DIR} | default-fuzzy-finder)

    if [ -z "$best_unity_version" ]
    then
        echo 'Not found a suitable version'
    else
        # echo 'Loading unity version: '$best_unity_version

        if test -n "$STY"
        then
            printf "This is a screen session named '$STY'.\n"
            ${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity -projectPath $target_directory
        else
            screen_name=$(basename $PWD)
            screen_name=$(echo $screen_name | tr '[:upper:]' '[:lower:]')
            if [[ $screen_name == *"nity"* ]]; then
                screen_name=${screen_name}
            else
                screen_name=${screen_name}-unity
            fi

            target_platform=$(echo -e "Standalone\niOS\nAndroid\nCurrent" | default-fuzzy-finder)

            echo "Open project using Unity "${best_unity_version}" and platform "${target_platform}
            echo "Started a new screen session: "${screen_name}

            if [ "$target_platform" = "Current" ]; then
                screen -S $screen_name -dm ${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity -projectPath $target_directory
            else
                screen -S $screen_name -dm ${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity -projectPath $target_directory -buildTarget ${target_platform}
            fi

        fi


    fi
}

function unity-build()
{
    target_directory=$PWD

    build_method=$1

    best_unity_version=$(python3 ${UNITY_BUILD_SCRIPTS_DIR}/python/best_installed_unity_version.py $target_directory)

    echo "Using Unity "$best_unity_version

    unity_app=${UNITY_HUB_APPS_DIR}/${best_unity_version}/Unity.app/Contents/MacOS/Unity

    $unity_app -quit -batchmode \
     -projectPath $target_directory -logFile $target_directory/log_build.txt \
     -executeMethod $build_method
}


function unity-build-droidvrmode()
{
    unity-build 'UnityBuilder.BuildVRMode'
}

function unity-build-android()
{
    unity-build 'UnityBuilder.BuildAndroid'
}

alias u='unity'
alias ufz='unity-fz'
alias ub='unity-build'

# Extract JAR from AAR files in current directory
alias extract-jar-from='ls *.aar | rev | cut -c5- | rev | xargs -I {}  $UNITY_BUILD_SCRIPTS_DIR/android/aar/extract_jar_from_aar.sh {}'

# OLD ALIASES
# Useful alias for unity build tools
alias fix-aar-unity-plugin='~/workspace/scripts/android/aar/fix_aar_unity_plugin.sh '
# alias unity-build='time ~/workspace/scripts/unity/UnityBuildScripts/unity_build.sh'
alias create-unity-build='~/workspace/scripts/unity/UnityBuildScripts/create_unity_build.sh'
alias apk-install='~/workspace/scripts/unity/UnityBuildScripts/install_current_apk.sh'
alias show-build-log-error=${UNITY_BUILD_SCRIPTS_DIR}'/show_build_log_error.sh'

alias rm-build-temp-tags='python '${UNITY_BUILD_SCRIPTS_DIR}'/rm_build_temp_tags.py build'

alias get-logcat=${UNITY_BUILD_SCRIPTS_DIR}'/get_project_logcat.sh'
alias get-logcat-errors=${UNITY_BUILD_SCRIPTS_DIR}'/get_logcat_errors.sh'
alias get-unity-stats=${UNITY_BUILD_SCRIPTS_DIR}'/get_profiler_stats.sh'

alias get-screenshot='~/workspace/scripts/unity/UnityBuildScripts/get_screenshot.sh'
alias git-update-private-setup='git tag -d private/setup && git tag private/setup && git push local :private/setup && git push local private/setup'
alias clean-old-builds='python '$UNITY_BUILD_SCRIPTS_DIR'/clean_old_builds.py'
alias rm-gil-logs='python '${UNITY_BUILD_SCRIPTS_DIR}'/remove_gil_logs.py'
alias available-devices='python '${UNITY_BUILD_SCRIPTS_DIR}'/get_available_devices.py'

alias run-and-install='../tools/run_and_install.sh'
alias last-unity-build-error='../tools/show_build_log_error.sh'

# alias g='python '$UNITY_BUILD_SCRIPTS_DIR'/commit_build.py'

# # Short aliases
# alias r='echo "Unity Build and Run" && ../tools/run_and_install.sh'
# alias i='echo "Installing Current APK" && ../tools/install.sh'

# alias otg='echo "Unity Build and Run" && ../tools/runOTG_and_install.sh'

# alias 2d='echo "Unity 2D Build and Run" && ../tools/run2d_and_install.sh'
# alias 2dotg='echo "Unity 2D Build and Run" && ../tools/run2dOTG_and_install.sh'

# Test
alias py-unity-build='python '${UNITY_BUILD_SCRIPTS_DIR}'/unity_build.py'
