# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## 1. Script: `log_analyzer.sh`

```bash
#!/bin/bash

# -------------------------------
# log_analyzer.sh
# Bash script to analyze log files and generate a daily report
# -------------------------------

# Task 1: Input and Validation
if [ $# -eq 0 ]; then
    echo "Error: No log file provided."
    echo "Usage: $0 <path-to-log-file>"
    exit 1
fi

logfile="$1"

if [ ! -f "$logfile" ]; then
    echo "Error: File $logfile does not exist."
    exit 1
fi

# Task 2: Error Count
error_count=$(grep -E "ERROR|Failed" "$logfile" | wc -l)
echo "Total errors: $error_count"

# Task 3: Critical Events
echo ""
echo "--- Critical Events ---"
critical_lines=$(grep -n "CRITICAL" "$logfile")
if [ -z "$critical_lines" ]; then
    echo "No critical events found."
else
    echo "$critical_lines"
fi

# Task 4: Top 5 Error Messages
echo ""
echo "--- Top 5 Error Messages ---"
top_errors=$(grep "ERROR" "$logfile" | awk '{$1=$2=$3=""; print $0}' | sort | uniq -c | sort -rn | head -5)
if [ -z "$top_errors" ]; then
    echo "No ERROR messages found."
else
    echo "$top_errors"
fi

# Task 5: Generate Summary Report
report_file="log_report_$(date +%Y-%m-%d).txt"

{
echo "Log Analysis Report - $(date)"
echo "Log file: $logfile"
echo "Total lines processed: $(wc -l < "$logfile")"
echo "Total errors: $error_count"
echo ""
echo "--- Top 5 Error Messages ---"
echo "$top_errors"
echo ""
echo "--- Critical Events ---"
echo "$critical_lines"
} > "$report_file"

echo ""
echo "Report generated: $report_file"

# Task 6: Archive Processed Logs (Optional)
mkdir -p archive
mv "$logfile" archive/
echo "Log file moved to archive/"


| Purpose                     | Command/Tool     |
| --------------------------- | ---------------- |
| Check if file exists        | `[ -f "$1" ]`    |
| Count lines                 | `wc -l`          |
| Search for text             | `grep`           |
| Line numbers                | `grep -n`        |
| Extended regex              | `grep -E`        |
| Extract parts of line       | `awk`            |
| Sort lines                  | `sort`           |
| Count unique occurrences    | `uniq -c`        |
| Sort numerically descending | `sort -rn`       |
| Get top N lines             | `head -5`        |
| Create directories          | `mkdir -p`       |
| Move files                  | `mv`             |
| Date for report filename    | `date +%Y-%m-%d` |


Key Learnings

Text processing in Bash: Combining grep, awk, sort, and uniq allows powerful log analysis with concise commands.

Dynamic report generation: Using variables and date commands enables automatic naming of reports per day.

Automation and archiving: Scripts can automate repetitive tasks like log analysis and archiving, saving manual effort and reducing errors.