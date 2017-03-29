import sys
import subprocess

git_files_cmd = 'git diff-tree --no-commit-id --name-status -r HEAD'
git_files_output = subprocess.check_output(git_files_cmd, shell=True)

git_files_output = git_files_output.decode('UTF-8')
git_files_output = git_files_output.split('\n')

for i in range(0, len(git_files_output)):
    # print(git_files_output[i])
    if git_files_output[i] == '':
        break;
    if git_files_output[i][0] != 'D':
        git_file = git_files_output[i][1:].strip()
        # print('Deleted ' + git_file)
        log_remove_cmd = "sed -i -e '/GilLog/d' " + git_file
        subprocess.check_output(log_remove_cmd, shell=True)
