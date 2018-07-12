
function unity_doxygen_abspath() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}

# Doxygen
function doxygen-unity()
{
    doxygen_bin=/Applications/Doxygen.app/Contents/Resources/doxygen

    doxygen_config_file=DoxyfileUnity
    doxygen_default_config=$UNITY_BUILD_SCRIPTS_DIR/doxygen/$doxygen_config_file

    doxygen_output=$(unity_doxygen_abspath $1)

    unity_directory=${PWD}
    unity_project_name=$(basename $unity_directory)

    cp $doxygen_default_config .

    sed -i -- 's@DOXYGEN_PROJECT_NAME@'${unity_project_name}'@g' ${doxygen_config_file}
    sed -i -- 's@DOXYGEN_INPUT_PATH@'${unity_directory}'/Assets/@g' ${doxygen_config_file}
    sed -i -- 's@DOXYGEN_OUTPUT_PATH@'${doxygen_output}'@g' ${doxygen_config_file}

    ${doxygen_bin} ${doxygen_config_file}

    rm -rf ${doxygen_config_file}
}
