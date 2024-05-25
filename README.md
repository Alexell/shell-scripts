# Shell scripts

## memory_usage.sh
**ENG:**
This script provides data on RAM usage by all running processes in the system. It iterates over all processes, extracts memory usage information from the `/proc/[PID]/status files`, sums the memory usage for each unique process, and displays the results in a table format. The script only considers processes that consume more than 1 MB of RAM. The script also calculates the total memory usage and displays this value at the end.

**RUS:**
Этот скрипт позволяет получить данные о потреблении оперативной памяти (RAM) всеми запущенными процессами в системе. Он проходит по всем процессам, извлекает информацию о потреблении памяти из файлов `/proc/[PID]/status`, суммирует использование памяти для каждого уникального процесса и выводит результаты в виде таблицы. Скрипт учитывает только процессы, потребляющие более 1 MB памяти. Скрипт также подсчитывает общее использование памяти и выводит это значение в конце.

## swap_usage.sh
**ENG:**
This script provides current data on swap usage by all running processes in the system. It iterates over all processes, extracts swap information from the `/proc/[PID]/smaps files`, sums the swap usage for each unique process, and displays the results in a table format. The script also calculates the total swap usage and displays this value at the end.

**RUS:**
Этот скрипт позволяет получить текущие данные о потреблении подкачки (swap) всеми запущенными процессами в системе. Он проходит по всем процессам, извлекает информацию о подкачке из файлов `/proc/[PID]/smaps`, суммирует использование подкачки для каждого уникального процесса и выводит результаты в виде таблицы. Скрипт также подсчитывает общее использование подкачки и выводит это значение в конце.
