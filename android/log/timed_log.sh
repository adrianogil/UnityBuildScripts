
logcat_file=$1
echo "===== Jorge Log - Start =====" > $logcat_file

for i in `seq 1 10`;
do
    adb logcat  -d -v time >> $logcat_file
    adb logcat -c
    sleep 150
done

echo "===== Jorge Log - END =====" >> $logcat_file

terminal-notifier -title "Jorge Log finished" -message "Let's see if it really works"
