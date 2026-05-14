# Day 02 – Linux Architecture, Processes, and systemd

## 1. Linux Architecture (Core Components)

- **Kernel**
  - Core of Linux OS
  - Manages CPU, memory, devices, and system calls
  - Acts as bridge between hardware and software

- **User Space**
  - Where applications run (nginx, java apps, bash, etc.)
  - Cannot directly access hardware
  - Uses system calls to interact with kernel

- **Init System (systemd)**
  - First process started by kernel (PID 1)
  - Manages services, startup, shutdown, and background processes

---

## 2. Processes in Linux

A process is a running instance of a program.

### Process Lifecycle States:
- **Running (R)** → Actively executing on CPU
- **Sleeping (S)** → Waiting for event/input
- **Stopped (T)** → Manually paused (kill -STOP)
- **Zombie (Z)** → Process finished but entry still in process table
- **Idle** → Waiting for CPU time

### Process Management Commands:
- `ps -ef` → Show all running processes
- `top` → Real-time process monitoring
- `kill <pid>` → Terminate a process
- `nice` → Set process priority
- `pstree` → Show process hierarchy

---

## 3. systemd (Service Manager)

- Used to start, stop, and manage services
- Handles boot process and service dependencies
- Replaces older init systems

### Common systemd Commands:
- `systemctl start nginx` → Start service
- `systemctl stop nginx` → Stop service
- `systemctl status nginx` → Check service status
- `systemctl enable nginx` → Start at boot
- `journalctl -u nginx` → View service logs

---

## 4. Daily Linux Commands (DevOps Use)

- `ls -ltr` → List files with details (sorted by time)
- `cd /var/log` → Navigate directories
- `tail -f logfile` → Monitor logs in real time
- `df -h` → Check disk usage
- `free -m` → Check memory usage

---

## 5. Why This Matters

- Helps in debugging production issues
- Useful for monitoring CPU/memory spikes
- Essential for managing servers and services
- Foundation for DevOps troubleshooting

---
