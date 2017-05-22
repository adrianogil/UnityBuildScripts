import sys, os
import subprocess

print('--- Automatic Git Updater and Build --- ')

symlink_verification="readlink `pwd` | xargs basename"
symlink_output = subprocess.check_output(symlink_verification, shell=True)
symlink_output = symlink_output.strip()

if symlink_output != '':
    git_files_cmd = 'git diff-tree --no-commit-id --name-status --relative=' + symlink_output + ' -r HEAD'
else :
    git_files_cmd = 'git diff-tree --no-commit-id --name-status -r HEAD'
git_files_output = subprocess.check_output(git_files_cmd, shell=True)

git_files_output = git_files_output.decode('UTF-8')
git_files_output = git_files_output.split('\n')

for i in range(0, len(git_files_output)):
    # print(git_files_output[i])
    if git_files_output[i] == '':
        break;

    git_file = git_files_output[i][1:].strip()
    # print('Deleted ' + git_file)
    # filename, file_extension = os.path.splitext(git_file)
    # if file_extension == '.cs' or file_extension == '.java':
    print('Update file ' + git_file)
    add_cmd = "git add " + git_file
    subprocess.check_output(add_cmd, shell=True)

print('\n-- Amend last commit --')
commit_cmd = "git commit --amend --no-edit"
subprocess.check_output(commit_cmd, shell=True)

print('\n-- Build and run --')
build_and_run_cmd = "../tools/run_and_install.sh"
subprocess.check_output(build_and_run_cmd, shell=True)

print('--------------------------------------')
