#!/bin/bash

LOGFILE="/var/log/maintenance.log"

echo "$(date) - Maintenance started" >> $LOGFILE

./log_rotate.sh /var/log/myapp >> $LOGFILE 2>&1

./backup.sh /home/abhi/data /home/abhi/backups >> $LOGFILE 2>&1

echo "$(date) - Maintenance finished" >> $LOGFILE