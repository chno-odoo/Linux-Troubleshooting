#!/bin/bash
# Script used for troubleshooting battery issues.
# Written by chno
# Creation Date: Mon Oct 14 09:59:06 AM EDT 2024
# Last Updated: Mon Oct 14 09:59:06 AM EDT 2024
# Last Update: N/A

# Functions
install_package() {
	package=$1
	if ! command -v $package &> /dev/null
	then
		echo "$package is not installed. Installing..."
		sudo apt update
		sudo apt install -y $package
		if [ $? -ne 0 ]; then
			echo "Failed to install $package. Exiting..."
			exit 1
		fi
	else
		echo "$package is already installed."
	fi
}

# Check battery status
echo "Checking battery status..."
upower -i $(upower -e | grep 'BAT')
sleep 5

# Check battery health (Check BAT0, fallback to BAT1 if necessary)
BATTERY_PATH="/sys/class/power_supply/BAT0/uevent"
if [ ! -f $BATTERY_PATH ]; then
    BATTERY_PATH="/sys/class/power_supply/BAT1/uevent"
fi

echo "Checking battery health..."
cat $BATTERY_PATH
sleep 5

# Check for battery related errors
echo "Checking for battery related errors..."
sudo journalctl -b | grep -i battery
sleep 5

# Use acpi to get battery discharge statistics
install_package acpi

# Run the acpi command to check battery status
echo "Checking battery information..."
acpi -V
sleep 5

# Device power consumption checks
# Ensure TLP is installed
install_package tlp

# Start TLP
echo "Starting TLP..."
sudo tlp start
if [ $? -ne 0 ]; then
	echo "Failed to start TLP. Exiting..."
	exit 1
fi

# Show battery stats
echo "Showing battery statistics..."
sudo tlp-stat -b