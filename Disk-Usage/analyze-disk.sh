#!/bin/bash

# Print disk usage summary
echo "Disk Usage Summary:"
echo "-----------------"
df -h

# Print detailed disk usage for root directory
echo -e "\nLargest Directories in Root:"
echo "-------------------------"
sudo du -h --max-depth=1 / 2>/dev/null | sort -hr | head -n 10

# Print inode usage
echo -e "\nInode Usage:"
echo "-----------"
df -i

# Print detailed filesystem information
echo -e "\nFilesystem Information:"
echo "---------------------"
sudo tune2fs -l $(df -h / | tail -n 1 | awk '{print $1}') 2>/dev/null

# Print SMART status if available
echo -e "\nSMART Status:"
echo "------------"
if command -v smartctl &> /dev/null; then
    for disk in $(lsblk -d -o name | grep -v "name"); do
        echo "Disk /dev/$disk:"
        sudo smartctl -H /dev/$disk 2>/dev/null
    done
else
    echo "smartctl not installed. Install with: sudo apt install smartmontools"
fi 