import commands

command_output=commands.getoutput('adb devices')
command_output = command_output.decode('UTF-8')
output_lines = command_output.split('\n')
print(output_lines)
output_size = len(command_output)

print(command_output)

devices = []

device_start = -1

device_found = False
attached_found = False;

for i in range(0, output_size):
    # if i >= 9 :
    #     print(command_output[(i-8):i])
    # print(command_output[i])
    if attached_found:
        if command_output[i] != ' ' and command_output[i] != '\n':
            if not device_found:
                device_found = True
                device_start = i + 1
        else:
            if device_found:
                devices.append(command_output[device_start:(i)])
                device_found = False
    elif i >= 8 and command_output[(i-8):i] == 'attached':
        # print('Attached!')
        attached_found = True

# if device_found:
    # devices.append(command_output[device_start:(output_size-1)])

print(devices)