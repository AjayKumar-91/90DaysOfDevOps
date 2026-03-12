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
  echo "Backup created successfully"
  echo "Archive: $ARCHIVE"
  du -h "$ARCHIVE"
else
  echo "Backup failed!"
  exit 1
fi

find "$DEST" -name "backup-*.tar.gz" -mtime +14 -delete
