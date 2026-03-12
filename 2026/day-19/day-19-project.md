Task 1: Log Rotation Script

Create log_rotate.sh that:

Takes a log directory as an argument (e.g., /var/log/myapp)

Compresses .log files older than 7 days using gzip

Deletes .gz files older than 30 days

Prints how many files were compressed and deleted

Exits with an error if the directory doesn't exist


Task 2: Server Backup Script

Create backup.sh that:

Takes a source directory and backup destination as arguments

Creates a timestamped .tar.gz archive (e.g., backup-2026-02-08.tar.gz)

Verifies the archive was created successfully

Prints archive name and size

Deletes backups older than 14 days from the destination

Handles errors — exit if source doesn't exist

Task 3: Crontab

Read: crontab -l — what's currently scheduled?

Understand cron syntax:

* * * * *  command

│ │ │ │ │

│ │ │ │ └── Day of week (0-7)

│ │ │ └──── Month (1-12)

│ │ └────── Day of month (1-31)

│ └──────── Hour (0-23)

└────────── Minute (0-59)

Write cron entries (in your markdown, don't apply if unsure) for:

Run log_rotate.sh every day at 2 AM

Run backup.sh every Sunday at 3 AM

Run a health check script every 5 minutes


Task 4: Combine — Scheduled Maintenance Script

Create maintenance.sh that:

Calls your log rotation function

Calls your backup function

Logs all output to /var/log/maintenance.log with timestamps

Write the cron entry to run it daily at 1 AM


What I Learned

How to automate system maintenance using Bash scripts.

How to schedule scripts using cron jobs.

How to handle file management like compression, deletion, and backup rotation.

Make Scripts Executable

chmod +x log_rotate.sh

chmod +x backup.sh

chmod +x maintenance.sh
