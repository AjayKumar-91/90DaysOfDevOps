# Day 07 -- Linux File System Hierarchy & Scenario-Based Practice

## Part 1: Linux File System Hierarchy

### / (Root Directory)

Purpose: The root directory is the starting point of the Linux file
system. All directories originate from here.

Command: ls -l /

Observed: - bin - etc

I would use this when exploring the base structure of the Linux system.

------------------------------------------------------------------------

### /home

Purpose: Contains home directories for normal users.

Command: ls -l /home

Observed: - abhi

I would use this when accessing or troubleshooting user files.

------------------------------------------------------------------------

### /root

Purpose: Home directory of the root (administrator) user.

Command: ls -l /root

Observed: - .bashrc - .profile

I would use this when performing administrative tasks as root.

------------------------------------------------------------------------

### /etc

Purpose: Contains system configuration files.

Command: ls -l /etc

Observed: - hostname - passwd

Example: cat /etc/hostname

I would use this when modifying system or service configurations.

------------------------------------------------------------------------

### /var/log

Purpose: Stores system and application log files.

Command: ls -l /var/log

Observed: - syslog - auth.log

Find largest logs: du -sh /var/log/\* 2\>/dev/null \| sort -h \| tail -5

I would use this when debugging system or application errors.

------------------------------------------------------------------------

### /tmp

Purpose: Temporary files used by applications and the OS.

Command: ls -l /tmp

Observed: - temporary files - system caches

I would use this when checking temporary storage or clearing disk space.

------------------------------------------------------------------------

### /bin

Purpose: Contains essential system command binaries.

Command: ls -l /bin

Observed: - ls - cat

I would use this when locating core Linux commands.

------------------------------------------------------------------------

### /usr/bin

Purpose: Contains most user command binaries.

Command: ls -l /usr/bin

Observed: - python - vim

I would use this when checking installed programs.

------------------------------------------------------------------------

### /opt

Purpose: Used for installing optional or third‑party software.

Command: ls -l /opt

Observed: - application folders

I would use this when managing third‑party applications.

------------------------------------------------------------------------

## Home Directory Check

Command: ls -la \~

Observed: - .bashrc - .profile - .ssh

------------------------------------------------------------------------

# Part 2: Scenario-Based Practice

## Scenario 1: Service Not Starting

Step 1: Command: systemctl status myapp\

Why: Check if the service is running, failed, or stopped.

Step 2: Command: journalctl -u myapp -n 50\

Why: View the last 50 log lines to identify errors.

Step 3: Command: systemctl is-enabled myapp\

Why: Check if the service starts automatically on boot.

Step 4: Command: systemctl restart myapp\

Why: Restart the service after fixing the issue.

------------------------------------------------------------------------

## Scenario 2: High CPU Usage

Step 1: Command: top\

Why: Shows real‑time CPU usage of processes.

Step 2: Command: htop\

Why: Interactive process monitoring tool.

Step 3: Command: ps aux --sort=-%cpu \| head -10\

Why: Lists top processes consuming CPU.

Step 4: Command: kill `<PID>`{=html}\

Why: Stop the process using excessive CPU.

------------------------------------------------------------------------

## Scenario 3: Finding Service Logs

Step 1: Command: systemctl status docker\

Why: Check service status and recent logs.

Step 2: Command: journalctl -u docker -n 50\

Why: View the last 50 log lines.

Step 3: Command: journalctl -u docker -f\

Why: Follow logs in real time.

------------------------------------------------------------------------

## Scenario 4: File Permission Issue

Step 1: Command: ls -l /home/user/backup.sh\

Why: Check current file permissions.

Step 2: Command: chmod +x /home/user/backup.sh\

Why: Add execute permission.

Step 3: Command: ls -l /home/user/backup.sh\

Why: Verify execute permission is added.

Step 4: Command: ./backup.sh\

Why: Execute the script.

------------------------------------------------------------------------

## Key Learnings

-   Linux file system hierarchy helps locate logs, configs, and binaries

    quickly.

-   Troubleshooting usually involves checking service status, logs, CPU

    usage, and permissions.
    
-   These skills are important for DevOps production debugging.
