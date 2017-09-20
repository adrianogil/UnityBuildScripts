plugin_lib=$1
plugin_manifest_backup=../../../../bkp/plugin_manifest.bkp 

# Unpack AAR plugin
mkdir $plugin_lib && cp $plugin_lib.aar $plugin_lib/$plugin_lib.zip && cd $plugin_lib && unzip $plugin_lib.zip && rm $plugin_lib.zip

# Copy manifest files
cp $plugin_manifest_backup AndroidManifest.xml
cp $plugin_manifest_backup aapt/AndroidManifest.xml

# Remove libraries
rm libs/*.jar

# Pack AAR plugin
zip -r ../$plugin_lib.zip * && cd .. && rm $plugin_lib.aar && rm -rf $plugin_lib && mv $plugin_lib.zip $plugin_lib.aar

# Remove meta files in case of Unity create a lot of them
# rm res/*.meta && rm res/*/*.meta && rm *.meta && rm aapt/*.meta && find . | grep *.meta

# Unpack classes
# mv classes.jar classes.zip