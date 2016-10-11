

# Useful alias for unity build tools
alias fix-aar-unity-plugin='~/workspace/scripts/android/aar/fix_aar_unity_plugin.sh '
alias unity-build='time ~/workspace/scripts/unity/UnityBuildScripts/unity_build.sh'
alias create-unity-build='~/workspace/scripts/unity/UnityBuildScripts/create_unity_build.sh'
alias apk-install='~/workspace/scripts/unity/UnityBuildScripts/install_current_apk.sh'
alias show-build-log-error='~/workspace/scripts/unity/UnityBuildScripts/show_build_log_error.sh'
alias get-logcat='~/workspace/scripts/unity/UnityBuildScripts/get_project_logcat.sh'
alias get-logcat-errors='~/workspace/scripts/unity/UnityBuildScripts/get_logcat_errors.sh'
alias get-unity-stats='~/workspace/scripts/unity/UnityBuildScripts/get_profiler_stats.sh'
alias get-screenshot='~/workspace/scripts/unity/UnityBuildScripts/get_screenshot.sh'
alias git-update-private-setup='git tag -d private/setup && git tag private/setup && git push local :private/setup && git push local private/setup'
