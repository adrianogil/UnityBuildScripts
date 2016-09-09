import sys

def filter_log(source_log, stats_log):
    with open(source_log) as f:
        lines = f.readlines()

    log_stats_text = ""

    next_lines_to_get = 0;

    avg_frametime = []

    for line in lines:

        if line.find("frametime") != -1:
            for i in range(0, len(line)):
                if i > 5 and line[i-5] == 'a' and line[i-4] == 'v' and line[i-3] == 'g' and line[i-2] == ':' and line[i-1] == ' ':
                    avg_frametime.append(float(line[i:].strip()))

        if next_lines_to_get > 0:
            log_stats_text += line
            next_lines_to_get = next_lines_to_get - 1
        elif line.find("Unity internal profiler stats:") != -1:
            log_stats_text += line
            next_lines_to_get = 15

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

filter_log(sys.argv[1], sys.argv[2])