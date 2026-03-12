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

# $# → number of arguments
# $1 → first argument (log file path)
# [ -f "$1" ] → checks if it is a regular file

# Task 2: Error Count
# Count total ERROR lines
error_count=$(grep -c "ERROR" "$logfile")
echo "Total errors: $error_count"
# error_count=$(grep -E "ERROR|Failed" "$logfile" | wc -l)
# echo "Total errors: $error_count"

# grep -E "ERROR|Failed" → Extended regex to match either ERROR or Failed
# wc -l → counts number of lines

# Task 3: Critical Events
echo ""
echo "--- Critical Events ---"
critical_lines=$(grep -n "CRITICAL" "$logfile")
# grep -n → prints line numbers along with the matching line
if [ -z "$critical_lines" ]; then
    echo "No critical events found."
else
    echo "$critical_lines"
fi

# Task 4: Top 5 Error Messages
echo ""
echo "--- Top 5 Error Messages ---"
top_errors=$(grep "ERROR" "$logfile" | awk '{$1=$2=$3=""; print $0}' | sort | uniq -c | sort -rn | head -5)

# awk '{$1=$2=$3=""; print $0}' → removes timestamp or first 3 columns to get the message
# sort → sorts lines alphabetically (needed for uniq -c)
# uniq -c → counts occurrences of each unique line
# sort -rn → sort numerically in reverse order (highest count first)
# head -5 → take top 5
# wc -l < "$logfile" → counts total lines without printing the filename


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

# wc -l < "$logfile" → counts total lines without printing the filename
