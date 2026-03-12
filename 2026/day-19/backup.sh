#!/bin/bash

SOURCE=$1
DEST=$2
DATE=$(date +%Y-%m-%d)

if [ ! -d "$SOURCE" ]; then
  echo "Error: Source directory does not exist!"
  exit 1
fi

mkdir -p "$DEST"

ARCHIVE="$DEST/backup-$DATE.tar.gz"

tar -czf "$ARCHIVE" "$SOURCE"

if [ $? -eq 0 ]; then
  SIZE=$(du -h "$ARCHIVE" | cut -f1)
    echo "Backup created successfully!"
    echo "Archive: $ARCHIVE"
    echo "Size: $SIZE"
else
  echo "Backup failed!"
  exit 1
fi

echo "Removing backups older than 14 days..."

find "$DEST" -name "backup-*.tar.gz" -mtime +14 -delete

echo "Backup process completed."
