# This cheat sheet covers essential networking troubleshooting commands for Windows (CMD/PowerShell) and Linux/macOS.


# Basic Connectivity & Testing

ping <destination> (Windows/Linux) - Test connectivity to a host.
Usage: ping 8.8.8.8 or ping google.com
Continuous: ping -t <IP> (Win) or ping <IP> (Linux)
tracert <destination> (Windows) - Trace the route packets take.
traceroute <destination> (Linux/macOS) - Trace the path to a destination.
pathping <destination> (Windows) - Combines ping and tracert for better analysis.
mtr <destination> (Linux) - "Traceroute on steroids," combines ping and traceroute.


# Interface & Configuration

ipconfig (Windows) - Show current network configuration (IP, subnet, gateway).
ipconfig /all (Windows) - Detailed IP information, including MAC address.
ifconfig (Linux - older) - Display or configure network interfaces.
ip addr show or ip a (Linux - modern) - Modern command to view IP addresses.
ipconfig /release & ipconfig /renew (Windows) - Release/renew IP address via DHCP.
ifup / ifdown (Linux) - Enable/disable a network interface.


# DNS & Name Resolution

nslookup <domain> (Windows/Linux) - Query DNS for domain details.
dig <domain> (Linux/macOS) - Advanced DNS lookup tool.
ipconfig /flushdns (Windows) - Clear local DNS cache.
host <domain> (Linux) - Simple, quick DNS lookup.


# Network Statistics & Active Connections

netstat -an (Windows/Linux) - Show all active network connections and ports.
netstat -tulpn (Linux) - Show listening TCP/UDP ports and PIDs.
ss -tulpn (Linux) - Faster replacement for netstat.
arp -a (Windows/Linux) - Show ARP cache (IP-to-MAC mappings).
netsh interface ip show config (Windows) - Detailed network settings.


# Advanced Tools & Port Testing

telnet <IP> <port> (Windows/Linux) - Test if a specific TCP port is open.
nc -zv <IP> <port> (Netcat - Linux) - Test port connectivity.
nmap <target> (Linux/Windows) - Scan network for open ports and services.
tcpdump -i <interface> (Linux) - Capture network packets.
route print (Windows) or route -n (Linux) - Display routing table.


# Common Troubleshooting Flows

Check Physical Connection: "Is it plugged in?"
Verify IP Address: ipconfig / ip a (Is it a 169.x.x.x address?)
Ping Gateway: ping <gateway_ip> (Test local router)
Ping External: ping 8.8.8.8 (Test internet connectivity)
Check DNS: nslookup google.com (Test name resolution)
Trace Path: tracert / traceroute (Find where packets stop)
