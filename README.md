# Unity Build Scripts
Scripts to build Unity3D projects in background.

All build process runs in a separated folder. So, it doesn't block your current Unity instance.

# Usage

- Clone or download this project
- Add the lines below to your .bashrc
` export UNITY_BUILD_SCRIPTS_DIR=/path/to/UnityBuildScripts
` export PATH=$UNITY_BUILD_SCRIPTS_DIR:$PATH

# Scripts
This repository contains:
- create_unity_build - must be called first, you should have a local git repository called 'local'
- unity_build - must be called every time you have a build to be generated from a specified commit
- unity_project_build - launch Unity build process using command line arguments.
- show_build_log_error.sh - show errors of build process related to current commit
- install_current_apk.sh - install a apk related to a given commit
- get_project_logcat.sh - get logcat related to current commit

# Tools
- get-unity-version-from-proj - get unity version used in a project
- unity - open project using the best suitable unity version
