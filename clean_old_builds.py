import commands
import fnmatch
import os
from os.path import join

current_branch = 'master'
print('Analyzing commits from branch ' + current_branch)

command_output=commands.getoutput('git log --pretty=format:\'%h %ad | %s%d [%an]\' --graph --date=short ' + current_branch)
# print(command_output)
lines = command_output.split('\n')

hashes = []

# List commit hashes
for i in range(0, len(lines)):
    hashes.append(lines[i][3:9])
    # print(lines[i][3:9])
    # For each hash,

current_directory=commands.getoutput('pwd')
# print(current_directory)
android_build_directory=current_directory+"-unity-build/Builds/Android/"
print('Searching for APKs at ' + android_build_directory)

removed = 0

for root, subFolders, files in os.walk(android_build_directory):
    for filename in fnmatch.filter(files, '*.apk'):
        obsolete_build = True

        for i in range(0, len(hashes)):
            if hashes[i] in filename:
                obsolete_build = False
                # print(filename + ' is not obsolete')
                break
        if obsolete_build:
            print('Removing ' + filename)
            commands.getoutput('rm ' + android_build_directory + filename)
            removed = removed + 1

print(str(removed) + ' APKs removed')


