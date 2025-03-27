# Debian Package Creation Guide

This guide explains how to build and install the Linux Troubleshooting Tools Debian package.

## Prerequisites

1. Install the required build dependencies:
```bash
sudo apt install \
    devscripts \
    debhelper \
    dh-python \
    python3-all \
    python3-setuptools \
    python3-pip \
    python3-venv
```

2. Install runtime dependencies:
```bash
sudo apt install \
    python3-matplotlib \
    python3-pandas \
    python3-pdfkit \
    python3-tqdm \
    python3-weasyprint \
    weasyprint \
    net-tools \
    wireless-tools \
    acpi \
    upower \
    wkhtmltopdf \
    jq
```

## Building the Package

1. From the root directory of the project, run:
```bash
dpkg-buildpackage -us -uc
```

This will create several files in the parent directory:
- `linux-troubleshooting_0.1.0_all.deb` - The main package
- `linux-troubleshooting_0.1.0.dsc` - Source package description
- `linux-troubleshooting_0.1.0.tar.gz` - Source archive
- `linux-troubleshooting_0.1.0_amd64.buildinfo` - Build information
- `linux-troubleshooting_0.1.0_amd64.changes` - Changes file

## Installing the Package

There are two ways to install the package:

### Method 1: Using apt (Recommended)
```bash
# Install all dependencies first
sudo apt install \
    python3-matplotlib \
    python3-pandas \
    python3-pdfkit \
    python3-tqdm \
    python3-weasyprint \
    weasyprint \
    net-tools \
    wireless-tools \
    acpi \
    upower \
    wkhtmltopdf \
    jq

# Install the package
sudo dpkg -i ../linux-troubleshooting_0.1.0_all.deb
```

### Method 2: Using dpkg and apt
1. Install the package (this will fail with dependency errors):
```bash
sudo dpkg -i ../linux-troubleshooting_0.1.0_all.deb
```

2. Install missing dependencies:
```bash
sudo apt-get install -f
```

3. Verify the installation:
```bash
dpkg -l linux-troubleshooting
```

## Package Contents

The package installs the following components:

### Executables (in /usr/bin/)
- `odoo-linux` - Main CLI tool
- `wifi-diagnostic` - WiFi diagnostics script
- `battery-health` - Battery health check script
- `analyze-disk` - Disk usage analysis script

### Python Package
- Installed in the system Python packages
- Provides the core functionality

## Dependencies

The package automatically installs these dependencies:
- python3-click (>= 8.0.0)
- python3-psutil (>= 5.9.0)
- python3-weasyprint (>= 60.0)
- python3-pdfkit
- python3-pandas
- python3-matplotlib
- speedtest-cli (>= 2.1.3)
- python3-requests (>= 2.31.0)
- python3-tqdm (>= 4.65.0)
- wkhtmltopdf
- jq
- net-tools
- wireless-tools
- acpi
- upower

## Troubleshooting

If you encounter issues during installation:

1. Check for missing dependencies:
```bash
# List missing dependencies
dpkg -I ../linux-troubleshooting_0.1.0_all.deb | grep Depends

# Install all dependencies at once
sudo apt install -f
```

2. Check package status:
```bash
dpkg -l | grep linux-troubleshooting
```

3. View package details:
```bash
dpkg -s linux-troubleshooting
```

4. List installed files:
```bash
dpkg -L linux-troubleshooting
```

5. Common Issues:

- **Missing Dependencies**: If you see "dependency problems" errors, use Method 1 for installation (installing dependencies first)
- **Package Not Found**: Make sure you're in the correct directory when installing
- **Permission Issues**: Make sure you're using sudo for installation commands
- **Broken Package**: Try removing and reinstalling:
  ```bash
  sudo dpkg --remove --force-remove-reinstreq linux-troubleshooting
  sudo apt clean
  sudo dpkg -i ../linux-troubleshooting_0.1.0_all.deb
  ```

## Uninstalling

To remove the package:
```bash
sudo apt remove linux-troubleshooting
```

To remove the package and its configuration:
```bash
sudo apt purge linux-troubleshooting
```

## Development

For development purposes, you can modify the package by:

1. Updating version in `debian/changelog`
2. Modifying dependencies in `debian/control`
3. Adjusting installation in `debian/rules`

After changes, rebuild the package using `dpkg-buildpackage -us -uc` 