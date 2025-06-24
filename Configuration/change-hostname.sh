#!/bin/bash
#
# This script will be used to change the hostname without the need to uninstall and reinstall chrome.
# Created by: Chno
# Creation date: Tue Jun 24 09:37:54 AM EDT 2025
# Last updated: Tue Jun 24 09:37:54 AM EDT 2025
# Last update: Added a portion to remove the singleton lock file which prevents chrome from starting after a hostname change.

# Function to clear Chrome cache for a specific user
clear_chrome_cache() {
    local username=$1
    local user_home=$(eval echo ~$username)
    
    echo "Clearing Chrome cache for user: $username"
    
    # Kill Chrome processes for this user
    sudo -u "$username" pkill -f chrome 2>/dev/null || true
    
    # Clear Chrome caches and lock files
    sudo -u "$username" rm -rf "$user_home/.cache/google-chrome/" 2>/dev/null || true
    sudo -u "$username" rm -rf "$user_home/.config/google-chrome/Default/Local Storage/" 2>/dev/null || true
    sudo -u "$username" rm -rf "$user_home/.config/google-chrome/Default/Session Storage/" 2>/dev/null || true
    sudo -u "$username" rm -f "$user_home/.config/google-chrome/SingletonLock" 2>/dev/null || true
    sudo -u "$username" rm -f "$user_home/.config/google-chrome/Default/SingletonLock" 2>/dev/null || true
    
    echo "Chrome cache cleared for $username"
}

# Prompt the user for a new hostname
read -p "Enter the new hostname: " new_hostname

# Validate the input
if [[ -z "$new_hostname" ]]; then
    echo "Hostname cannot be empty. Exiting."
    exit 1
fi

echo "Preparing to change hostname to '$new_hostname'..."

# Clear Chrome cache for all users before changing hostname
echo "Clearing Chrome cache for all users..."

# Get list of users with home directories (excluding system users)
for user_home in /home/*; do
    if [[ -d "$user_home" ]]; then
        username=$(basename "$user_home")
        clear_chrome_cache "$username"
    fi
done

# Also clear for root if Chrome is installed there
if [[ -d "/root/.config/google-chrome" ]]; then
    clear_chrome_cache "root"
fi

# Clear system DNS cache
echo "Clearing system DNS cache..."
systemctl flush-dns 2>/dev/null || systemd-resolve --flush-caches 2>/dev/null || true

# Change the hostname temporarily
hostname "$new_hostname"

# Change the hostname permanently
if [[ -f /etc/hostname ]]; then
    echo "$new_hostname" > /etc/hostname
else
    echo "Hostname file not found. Exiting."
    exit 1
fi

# Update /etc/hosts file
if [[ -f /etc/hosts ]]; then
    sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/" /etc/hosts
else
    echo "Hosts file not found. Exiting."
    exit 1
fi

# Notify the user
echo "Hostname changed to '$new_hostname' successfully."
echo "Chrome cache has been cleared for all users."
echo "Please restart Chrome or reboot the system for all changes to take effect."
