import sys
from dateutil.parser import parse
import matplotlib.pyplot as plt
import pylab

def filter_log(source_log, stats_log):
    with open(source_log) as f:
        lines = f.readlines()
    log_stats_text = ""

    next_lines_to_get = 0;

    profiler_data = []
    event_data = []

    avg_frametime = []

    current_time = ""

    for line in lines:

        if line.find("GilEvent: ") != -1:
            for i in range(7, len(line)):
                if line[i-7:i] == "I/Unity":
                    current_time = parse(line[:i-7].strip())
                elif line > 10 and line[i-10:i] == "GilEvent: ":
                    event_data.append({"time" : current_time, "event" : line[i:].strip()})
                    break;

        if line.find("frametime") != -1:
            min_i = -1;
            max_i = -1;

            min_value = 0.0
            max_value = 0.0

            for i in range(6, len(line)):

                if line[i-5:i] == 'min: ':
                    min_i = i;
                elif line[i-5:i] == 'max: ':
                    max_i = i;
                    # print("min_value " + line[min_i:(i-5)].strip())
                    min_value = float(line[min_i:(i-5)].strip())

                elif line[i-5:i] == 'avg: ':
                    # print(line)
                    # print("max_value " + line[max_i:(i-5)].strip())
                    max_value = float(line[max_i:(i-5)].strip())

                    frametime_avg_medium = float(line[i:].strip())
                    avg_frametime.append(frametime_avg_medium)
                    profiler_data.append({"time": current_time, 'frametime' : {"avg" : frametime_avg_medium, "min" : min_value, "max": max_value}})
                    break;

        if next_lines_to_get > 0:
            log_stats_text += line
            next_lines_to_get = next_lines_to_get - 1
        elif line.find("Unity internal profiler stats:") != -1:
            log_stats_text += line
            next_lines_to_get = 15

            for i in range(7, len(line)):
                if line[i-7:i] == "D/Unity":
                    current_time = parse(line[:i-7].strip())
                    break;

    avg_fps = 0
    min_fps = sys.float_info.max
    max_fps = sys.float_info.min
    current_fps = 0

    for i in range(0, len(avg_frametime)):
        current_fps = 1000.0 / avg_frametime[i]
        avg_fps = avg_fps + current_fps
        if current_fps < min_fps:
            min_fps = current_fps
        if current_fps > max_fps:
            max_fps = current_fps
        log_stats_text += "Average frames per second in an interval: " + str(current_fps) + "\n"

    avg_fps = avg_fps / (1.0 * len(avg_frametime))

    log_stats_text += "\n ================= FPS Analysis ================= \n"
    log_stats_text += "\n Min frames per second: " + str(min_fps)
    log_stats_text += "\n Max frames per second: " + str(max_fps)
    log_stats_text += "\n Average frames per second: " + str(avg_fps)

    f = open(stats_log, 'w')
    f.write(log_stats_text)
    f.close

    xs = []
    avg_data = []
    min_data = []
    max_data = []

    min_value = 10000.0
    max_value = 0.0

    initial_time = profiler_data[0]['time']

    for p in profiler_data:
        xs.append((p['time'] - initial_time).total_seconds())
        avg_value = 1000.0 / p['frametime']['avg'];
        avg_data.append(avg_value)
        min_data.append(1000.0 / p['frametime']['min'])
        max_data.append(1000.0 / p['frametime']['max'])

        if avg_value < min_value:
            min_value = avg_value
        if avg_value > max_value:
            max_value = avg_value

    print("Plot " + str(len(xs)) + " samples")
    plt.xlabel('Time (s)')
    plt.ylabel('AVG FPS')
    plt.plot(xs, avg_data, 'bo-', label="AVG")

    for e in event_data:
        print('Event data: ' +  e["event"])
        plt.text((e["time"] - initial_time).total_seconds(), min_value +(max_value -min_value)/2.0, r'' + e["event"])
    # line2, = plt.plot(xs, min_data, 'go-', label="MAX")
    # line3, = plt.plot(xs, max_data, 'ro-', label="MIN")

    # pylab.legend(loc='upper left')

    plt.show()


filter_log(sys.argv[1], sys.argv[2])