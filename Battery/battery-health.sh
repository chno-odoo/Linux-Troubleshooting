#!/bin/bash

# Check if acpi is installed
if ! command -v acpi &> /dev/null; then
    echo "Error: acpi is not installed. Please install it with: sudo apt install acpi"
    exit 1
fi

# Get battery information
echo "Battery Information:"
echo "------------------"
acpi -i

# Get detailed battery information using upower
if command -v upower &> /dev/null; then
    echo -e "\nDetailed Battery Information:"
    echo "-------------------------"
    for battery in $(upower -e | grep battery); do
        upower -i $battery
    done
fi

# Get power consumption information
echo -e "\nPower Consumption:"
echo "-----------------"
if [ -d "/sys/class/power_supply/BAT0" ]; then
    current_now=$(cat /sys/class/power_supply/BAT0/current_now 2>/dev/null)
    voltage_now=$(cat /sys/class/power_supply/BAT0/voltage_now 2>/dev/null)
    if [ ! -z "$current_now" ] && [ ! -z "$voltage_now" ]; then
        power_mw=$(echo "scale=2; $current_now * $voltage_now / 1000000000000" | bc)
        echo "Current Power Usage: ${power_mw}W"
    fi
fi 