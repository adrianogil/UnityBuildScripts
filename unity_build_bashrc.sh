

# Useful alias for unity build tools
alias fix-aar-unity-plugin='~/workspace/scripts/android/aar/fix_aar_unity_plugin.sh '
alias unity-build='time ~/workspace/scripts/unity/UnityBuildScripts/unity_build.sh'
alias create-unity-build='~/workspace/scripts/unity/UnityBuildScripts/create_unity_build.sh'
alias apk-install='~/workspace/scripts/unity/UnityBuildScripts/install_current_apk.sh'
alias show-build-log-error=${UNITY_BUILD_SCRIPTS_DIR}'/show_build_log_error.sh'

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
