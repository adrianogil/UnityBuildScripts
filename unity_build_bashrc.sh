
# Useful alias for unity build tools
alias fix-aar-unity-plugin='~/workspace/scripts/android/aar/fix_aar_unity_plugin.sh '
alias unity-build='time ~/workspace/scripts/unity/UnityBuildScripts/unity_build.sh'
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

alias g='python '$UNITY_BUILD_SCRIPTS_DIR'/commit_build.py'

# Short aliases
alias r='echo "Unity Build and Run" && ../tools/run_and_install.sh'
alias i='echo "Installing Current APK" && ../tools/install.sh'

alias otg='echo "Unity Build and Run" && ../tools/runOTG_and_install.sh'

alias 2d='echo "Unity 2D Build and Run" && ../tools/run2d_and_install.sh'
alias 2dotg='echo "Unity 2D Build and Run" && ../tools/run2dOTG_and_install.sh'

# Test
alias py-unity-build='python '${UNITY_BUILD_SCRIPTS_DIR}'/unity_build.py'

# Android
alias gilcat='adb logcat | grep GilLog'

# Dynamic Unity versions alias
for file in /Applications/Unity*/ ; do
  if [[ -d "$file" && ! -L "$file" ]]; then
    base_file=`basename $file`
    base_file=${base_file:5}
    # echo "$base_file is a directory";
    alias open-unity-${base_file}="${file}/Unity${base_file}.app/Contents/MacOS/Unity -projectPath \$PWD"
  fi;
done