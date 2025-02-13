#!/bin/bash

# Script used to find large files and directories if disk space is low.
# Written by CHNO
# Creation Date: Wed Oct  9 05:22:28 PM EDT 2024
# Last Updated: Wed Oct  9 05:22:28 PM EDT 2024
# Last Update: Initial code commit.

# Check disk usage by directory.
echo "Checking disk usage by directory..."
sudo du -sh /*
sleep 10

# Find large files and directories.
echo "Looking for large files and directories..."
sudo du -ahx / | sort -rh | head -n 20
sleep 10

# Check for Large log files.
echo "Checking for large log files..."
sudo du -sh /var/log/*
sleep 10
# Identify old package caches.
echo "Cleaning packages..."
sudo apt clean -y

# Remove unneccessary packages.
echo "Removing unneccessary packages..."
sudo apt autoremove -y