AAR_FILE=$1.aar
JAR_FILE=$1.jar
TEMP_FOLDER=Temp
TEMP_ZIP=temp.zip

echo "Extract JAR from "${AAR_FILE}

mkdir ${TEMP_FOLDER}
cp ${AAR_FILE} ${TEMP_FOLDER}/${TEMP_ZIP}
cd ${TEMP_FOLDER}
unzip ${TEMP_ZIP}
mv classes.jar ../${JAR_FILE}
ls libs/
cd ..
rm -rf ${TEMP_FOLDER}
rm ${AAR_FILE}
