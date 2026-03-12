This process management cheat sheet covers essential Linux commands to monitor, control, and prioritize running programs. Key commands include ps for snapshots,

top/htop for real-time monitoring, kill for termination, and nice for priority management, allowing users to efficiently manage system resources. 

# Process Monitoring & Listing

ps: Displays a snapshot of current active processes.

ps aux: Shows all running processes by all users.

top: Provides a dynamic, real-time view of running processes and resource usage.

htop: An interactive, more user-friendly version of top.

pgrep [name]`: Searches for processes by name and lists their PID. 

# Process Termination (Kill)

kill [PID]`: Sends a termination signal to a process.

kill -9 [PID]: Forcefully terminates a process (SIGKILL).

pkill [name]`: Terminates processes based on their name.

killall [name]`: Kills all processes with the specified name. 



# Process Priority & Management


nice -n [value] [command]`: Starts a process with a specific priority (niceness).

renice -n [value] -p [PID]`: Changes the priority of an already running process.

jobs: Lists active jobs running in the background.

bg: Moves a suspended job to the background.

fg: Brings a background job to the foreground. 



# System Resource Monitoring


free -m: Displays memory usage in MB.

vmstat: Reports virtual memory statistics.

uptime: Shows how long the system has been running. 

