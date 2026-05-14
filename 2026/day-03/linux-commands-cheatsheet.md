# Linux Commands Cheat Sheet – Day 03

## 1. Process Management

- `ps -ef` → Show all running processes in full format
- `top` → Real-time view of system processes and CPU usage
- `htop` → Interactive process viewer (enhanced top)
- `kill <PID>` → Terminate a process by ID
- `kill -9 <PID>` → Force kill a process
- `pgrep <name>` → Find process ID by name
- `pkill <name>` → Kill process by name
- `jobs` → Show background jobs in current shell
- `fg` → Bring background job to foreground
- `bg` → Resume job in background

---

## 2. File System Management

- `ls -l` → List files with details
- `cd /path` → Change directory
- `pwd` → Show current directory path
- `mkdir folder` → Create new directory
- `rmdir folder` → Remove empty directory
- `rm file.txt` → Delete file
- `rm -rf folder` → Force delete directory
- `cp file1 file2` → Copy file
- `mv file1 file2` → Move or rename file
- `find / -name file.txt` → Search file in system
- `du -sh *` → Show folder size
- `df -h` → Show disk usage

---

## 3. Networking & Troubleshooting

- `ping google.com` → Check network connectivity
- `ip addr` → Show IP addresses of interfaces
- `curl https://example.com` → Fetch data from URL
- `wget https://example.com/file` → Download file from internet
- `netstat -tulnp` → Show active ports and services
- `ss -tulnp` → Modern alternative to netstat
- `dig google.com` → DNS lookup information
- `traceroute google.com` → Track network route
- `hostname -I` → Show system IP address

---

## 4. Log & System Monitoring

- `dmesg` → Kernel logs
- `journalctl -xe` → System logs (systemd)
- `tail -f /var/log/syslog` → Live log monitoring
- `uptime` → System running time and load average
- `whoami` → Show current user
- `id` → Show user and group IDs

---

## 5. Permissions & Users

- `chmod 755 file` → Change file permissions
- `chown user:user file` → Change file owner
- `sudo <command>` → Run command as admin
- `useradd username` → Create new user
- `passwd username` → Set/change password

---

## 6. Compression & Archiving

- `tar -cvf file.tar folder/` → Create tar archive
- `tar -xvf file.tar` → Extract tar archive
- `gzip file` → Compress file
- `gunzip file.gz` → Decompress file

---

## 7. Utility Commands

- `echo "text"` → Print text
- `clear` → Clear terminal screen
- `history` → Show command history
- `alias ll='ls -l'` → Create shortcut command
