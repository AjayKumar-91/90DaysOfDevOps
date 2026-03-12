#!/bin/bash

LOG_DIR=$1

if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory does not exist!"
  exit 1
fi

echo "Starting log rotation in $LOG_DIR"

compressed=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; | wc -l)

deleted=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -delete | wc -l)

echo "Files compressed: $compressed"
echo "Files deleted: $deleted"