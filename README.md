# Unity Build Scripts
Scripts to build Unity3D projects in background.

All build process runs in a separated folder. So, it doesn't block your current Unity instance.

This repository contains:
- create_unity_build - must be called first, you should have a local git repository called 'local'
- unity_build - must be called every time you have a build to be generated from a specified commit
- unity_project_build - launch Unity build process using command line arguments.
- show_build_log_error.sh - show errors of build process related to current commit
- install_current_apk.sh - install a apk related to a given commit
- get_project_logcat.sh - get logcat related to current commit
