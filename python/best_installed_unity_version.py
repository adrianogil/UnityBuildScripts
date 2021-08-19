# Opens the right version of Unity in current project
# Usage python2 open_unity.py [<dir>]

import os, sys

from get_unity_version import get_unity_version_from_project

def is_int(s):
    try:
        int(s)
        return True
    except ValueError:
        pass

    return False

def adjust_version_number(i):
    if i >= 2017:
        return i - 2011
    return i

def convert_number(s):
    if is_int(s):
        return adjust_version_number(int(s))

    last_parsed_number = ''

    for i in range(1, len(s)):
        if is_int(s[:i]):
            last_parsed_number = s[:i]
        else:
            break
    if is_int(last_parsed_number):
        return adjust_version_number(int(last_parsed_number))

    return -1

unity_versions = []

unity_main_path = os.environ["UNITY_HUB_APPS_DIR"]

# Get all version of Unity already installed
files = [f for f in os.listdir(unity_main_path)]
for f in files:
    unity_versions.append(f)

# Get Unity project path
if len(sys.argv) > 1:
    unity_project_dir = sys.argv[1]
else:
    unity_project_dir = os.getcwd()

last_version_used = get_unity_version_from_project(unity_project_dir)
last_version_used = last_version_used.split('.')

last_version_indexes = []
for i in last_version_used:
    last_version_indexes.append(convert_number(i))

u_distance = {}

for u in unity_versions:
    current_version = u
    u = u.split('.')
    version_indexes = []
    for i in u:
        version_indexes.append(convert_number(i))

    distance = (version_indexes[0] - last_version_indexes[0]) * 100 + \
                (version_indexes[1] - last_version_indexes[1]) * 10

    if len(version_indexes) >= 3 and len(last_version_indexes) >= 3:
        distance = distance + (version_indexes[2] - last_version_indexes[2])

    u_distance[current_version] = distance

    # print('Testing ' + str(version_indexes) + ' into last_version_used ' + str(last_version_indexes) + \
    #     ' distance: ' + str(distance))

    # if last_version_used in u:
    #     unity_path = unity_main_path + 'Unity' + u + '.app'
    #     print('Found version: ' + unity_path)

min_distance = 100000
best_unity_version = ''

for u in u_distance:
    distance = u_distance[u]
    if distance >= 0 and distance < min_distance:
        min_distance = distance
        best_unity_version = u


# print('Found best unity version: ' + best_unity_version)
print(best_unity_version)