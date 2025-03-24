#!/bin/bash

# This script will be used to do basic Ubuntu Troubleshooting including CPU Usage, Mem Usage, Swap Usage, Disk Usage, Disk I/O Performance, Network, and WiFi performance.
# Created By: Chno
# Created On: Mon Mar 24 08:44:48 AM EDT 2025
# Last Updated: N/A
# Last Update: Initial Commit

LOG_FILE="/tmp/system_health_report.log"
echo "System Performance Troubleshooting Report" > "$LOG_FILE"
echo "Generated on: $(date)" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# CPU Usage
echo "CPU Usage:" >> "$LOG_FILE"
top -bn1 | grep "Cpu(s)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Memory Usage
echo "Memory Usage:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Swap Usage
echo "Swap Usage:" >> "$LOG_FILE"
sudo swapon --summary >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Disk Usage
echo "Disk Usage:" >> "$LOG_FILE"
df -h >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Disk I/O Performance
echo "Disk I/O Performance:" >> "$LOG_FILE"
iostat -dx 1 3 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Install missing utilities if not present
if ! command -v iostat &>/dev/null; then
    echo "Installing sysstat for disk I/O monitoring..."
    sudo apt install -y sysstat
fi

if ! command -v speedtest-cli &>/dev/null; then
    echo "Installing speedtest-cli for network speed testing..."
    sudo apt install -y speedtest-cli
fi

if ! command -v mtr &>/dev/null; then
    echo "Installing mtr for network diagnostics..."
    sudo apt install -y mtr
fi

if ! command -v iwconfig &>/dev/null; then
    echo "Installing wireless-tools for WiFi diagnostics..."
    sudo apt install -y wireless-tools
fi

if ! command -v nmcli &>/dev/null; then
    echo "Installing NetworkManager for WiFi diagnostics..."
    sudo apt install -y network-manager
fi

# Network Connectivity
echo "Network Connectivity (ping test to 8.8.8.8):" >> "$LOG_FILE"
ping -c 4 8.8.8.8 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Network Interface Details
echo "Network Interfaces:" >> "$LOG_FILE"
ip a >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Network Diagnostics
echo "--------------------------------------------------" >> "$LOG_FILE"
echo "NETWORK DIAGNOSTICS" >> "$LOG_FILE"
echo "--------------------------------------------------" >> "$LOG_FILE"

# Network Speed Test
echo "Running Speed Test..." >> "$LOG_FILE"
speedtest-cli --simple >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Network Packet Loss & Latency Test
echo "Running MTR to Google DNS (8.8.8.8)..." >> "$LOG_FILE"
mtr -rwc 10 8.8.8.8 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Network Interface Statistics
echo "Network Interface Statistics:" >> "$LOG_FILE"
ip -s link >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for dropped packets/errors
echo "Checking Dropped Packets & Errors:" >> "$LOG_FILE"
netstat -i >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Active Network Connections
echo "Active Network Connections (Listening Ports):" >> "$LOG_FILE"
ss -tulpn >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Traceroute to Google DNS
echo "Traceroute to 8.8.8.8:" >> "$LOG_FILE"
traceroute 8.8.8.8 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# WiFi Diagnostics
echo "--------------------------------------------------" >> "$LOG_FILE"
echo "WIFI DIAGNOSTICS" >> "$LOG_FILE"
echo "--------------------------------------------------" >> "$LOG_FILE"

# Check WiFi Signal Strength
echo "WiFi Signal Strength:" >> "$LOG_FILE"
iwconfig 2>/dev/null | grep -i --color signal >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check Available WiFi Networks
echo "Available WiFi Networks:" >> "$LOG_FILE"
nmcli dev wifi list >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check WiFi Connection Status
echo "WiFi Connection Status:" >> "$LOG_FILE"
nmcli -t -f active,ssid,device dev wifi >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for WiFi Driver Issues
echo "WiFi Driver Information:" >> "$LOG_FILE"
lshw -C network >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for High Resource-Consuming Processes
echo "Top 10 Processes by CPU Usage:" >> "$LOG_FILE"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 11 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "Top 10 Processes by Memory Usage:" >> "$LOG_FILE"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# System Logs Analysis
echo "Recent System Errors (journalctl -p 3 -n 20):" >> "$LOG_FILE"
journalctl -p 3 -n 20 --no-pager >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for Outdated Packages
echo "Outdated Packages:" >> "$LOG_FILE"
sudo apt list --upgradable >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "Performance Troubleshooting Report Saved at: $LOG_FILE"
echo "Review the report for potential issues."

