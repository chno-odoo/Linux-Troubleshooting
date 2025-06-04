#!/bin/bash

# Prompt the user for a new hostname
read -p "Enter the new hostname: " new_hostname

# Validate the input
if [[ -z "$new_hostname" ]]; then
    echo "Hostname cannot be empty. Exiting."
    exit 1
fi

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


