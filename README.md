# Linux Troubleshooting Tools

A comprehensive collection of Linux diagnostic and troubleshooting tools.

## Project Components

### 1. odooLinux
A system diagnostics tool with Odoo integration. [View Details](./odooLinux/README.md)
- Network diagnostics and testing
- System monitoring and reporting
- Battery status checking
- Disk usage analysis
- PDF report generation

### 2. Battery
Battery diagnostics and monitoring tools.
- Battery health checking (`batt-check`)
- Power consumption analysis
- Charging status monitoring

### 3. Disk-Usage
Disk space analysis and management tools.
- Storage usage reporting (`disk-usage-check`)
- Directory size analysis
- File system monitoring

### 4. Network
Network analysis and diagnostics.
- WiFi diagnostics (`wifi-diagnostic`)
- Network performance testing
- Connectivity troubleshooting

### 5. ReportCreation
Report generation tools for all components.
- PDF report generation
- Network analytics
- System status reports

## Installation

### Method 1: Using Debian Package (Recommended)

The easiest way to install is using the Debian package. See [Debian Package Creation Guide](./debian/README.md) for detailed instructions.

Quick install:
```bash
# Install build dependencies
sudo apt install devscripts debhelper dh-python python3-all python3-setuptools

# Install runtime dependencies
sudo apt install \
    python3-matplotlib \
    python3-pandas \
    python3-pdfkit \
    python3-tqdm \
    weasyprint \
    net-tools \
    wireless-tools \
    acpi \
    upower \
    wkhtmltopdf \
    jq

# Build and install the package
dpkg-buildpackage -us -uc
sudo dpkg -i ../linux-troubleshooting_0.1.0_all.deb
```

If you encounter any issues, refer to the [Debian Package Creation Guide](./debian/README.md) for troubleshooting steps.

### Method 2: Manual Installation

#### System Dependencies

```bash
# Update package list
sudo apt update

# Install basic dependencies
sudo apt install -y \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    wkhtmltopdf \
    pipx \
    jq \
    net-tools \
    wireless-tools \
    acpi \
    upower

# Ensure pipx is in PATH
pipx ensurepath
```

#### Installing Components

1. **odooLinux Installation**:
```bash
# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install the package
pip install -e .
```

## Usage

After installation, the following commands will be available:

### Main CLI Tool
```bash
odoo-linux [OPTIONS] COMMAND [ARGS]
```

### Battery Diagnostics
```bash
batt-check [OPTIONS]
```
Checks battery health, charging status, and power consumption.

### Disk Usage Analysis
```bash
disk-usage-check [OPTIONS]
```
Analyzes disk space usage and provides detailed reports.

### Network Diagnostics
```bash
wifi-diagnostic [OPTIONS]
```
Performs comprehensive WiFi diagnostics and network analysis.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
