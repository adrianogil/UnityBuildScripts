# Get Unity Version in current project
# Usage python3 get_unity_version.py [<dir>]
import sys, os


def get_unity_version_from_project(unity_project_dir):
    # Verify if there is ProjectVersion file
    projversion_file = unity_project_dir + '/ProjectSettings/ProjectVersion.txt'

    with open(projversion_file, 'r') as f:
            lines = f.readlines()

    for line in lines:
        for i in range(0, len(line)-8):
            line = line.strip()
            if 'ersion: ' in line[i:i+8]:
                return line[i+8:]


if __name__ == '__main__':
    if len(sys.argv) > 1:
        unity_project_dir = sys.argv[1]
    else:
        unity_project_dir = os.getcwd()

    print('Found version: ' + get_unity_version_from_project(unity_project_dir))