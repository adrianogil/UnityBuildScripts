# Python script to collect errors from a logcat source
# Script usage:
# python get_logcat_errors.py $LOGCAT_FILE $ERRORS_FILE

import sys

def filter_log(source_log, error_log, commit):
    with open(source_log) as f:
        lines = f.readlines()

    log_error_text = "Logcat from commit " + commit + "\n\n" + source_log + ":\n"

    exception_found = False

    line_number = 1;

    for line in lines:
        if exception_found and line.find('at ') != -1:
            log_error_text +=  "  " + str(line_number) + ": " + line
        elif exception_found:
            exception_found = False
        if line.find("Exception") != -1 or line.find("NullReference") != -1:
            log_error_text += "  " + str(line_number) + ": " + line
            exception_found = True
        line_number = line_number + 1


    f = open(error_log, 'w')
    f.write(log_error_text)
    f.close

filter_log(sys.argv[1], sys.argv[2], sys.argv[3])