# 1. Process Management Commands

ps -ef – View all running processes (snapshot)
top – Real-time CPU and memory usage by processes
htop – Interactive process viewer (if installed)
kill <PID> – Gracefully stop a process
kill -9 <PID> – Force kill a stuck process
pkill <name> – Kill process by name
uptime – Check system load and running time
free -m – View memory usage in MB
systemctl status <service> – Check service status
journalctl -u <service> – View service logs



# 2. File System Commands

ls -l – List files with permissions and ownership
pwd – Show current working directory
cd <dir> – Change directory
du -sh <dir> – Check directory size
df -h – Check disk usage
touch <file> – Create an empty file
mkdir <dir> – Create a directory
rm -rf <file/dir> – Delete files or directories (use carefully)
chmod 755 <file> – Change file permissions
chown user:group <file> – Change ownership


# 3. Networking Troubleshooting Commands

ping <host> – Check network connectivity
ip addr – View IP addresses and interfaces
ss -tulnp – Check listening ports and services
curl <url> – Test HTTP/HTTPS endpoints
dig <domain> – Check DNS resolution



# Connectivity & Reachability

traceroute <host> – Shows network path to destination
tracepath <host> – Traceroute alternative (no root needed)


# Port & Service Checks

netstat -tulnp – Legacy tool to check listening ports
lsof -i :80 – Find which process is using a port
nc -zv <host> <port> – Test if a port is open (netcat)



# DNS & Name Resolution

nslookup <domain> – Simple DNS lookup
host <domain> – Quick DNS resolution check
resolvectl status – Check DNS config (systemd systems)



# Network Interface & Routing

ip link – Show network interface status
ip route – View routing table
ifconfig – Old but still used interface info


# HTTP / API Debugging

curl -I <url> – Check HTTP headers only
curl -v <url> – Verbose request (debug SSL, headers)
wget <url> – Download & test endpoint reachability



# Firewall / Access Issues

iptables -L – View firewall rules (legacy)
ufw status – Check firewall status (Ubuntu)


# Live DevOps Project Tip

**When debugging network issues, think in this order:**

Connectivity (ping, traceroute)
DNS (dig, nslookup, getent)
Port (ss, nc, lsof)
Firewall (ufw, iptables)
Packets (tcpdump)


# More Command Advanced Networking Commands

Traffic & Packet Analysis

tcpdump -i eth0 – Capture live network packets
tcpdump -nn port 80 – Capture traffic on a specific port
ss -s – Summary of socket statistics



# Connection Testing & Debugging

telnet <host> <port> – Test TCP connectivity to a port
nc -l 8080 – Start a test listener on a port
timeout 5 bash -c '</dev/tcp/host/port' – Low-level port test



# Bandwidth & Performance

iftop – Real-time bandwidth usage per connection
nload – Network traffic per interface
ethtool eth0 – Check NIC speed/duplex info



# Routing & Network State

arp -a – View ARP table
ip neigh – Show neighbor table (ARP replacement)
route -n – View routing table (legacy)



# Name Resolution & System Network

getent hosts <domain> – DNS lookup using system resolver
hostname -I – Show system IP addresses
hostnamectl – Hostname & network-related system info




# Cloud / Production Debugging (Very Useful)

curl http://169.254.169.254 – Cloud metadata check (AWS/Azure)
watch ss -tulnp – Monitor port changes in real time
watch ip addr – Watch IP changes (VPN, DHCP issues)
