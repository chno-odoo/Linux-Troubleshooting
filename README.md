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
- Battery health checking
- Power consumption analysis
- Charging status monitoring

### 3. Disk-Usage
Disk space analysis and management tools.
- Storage usage reporting
- Directory size analysis
- File system monitoring

### 4. Network
Network analysis and diagnostics.
- WiFi diagnostics
- Network performance testing
- Connectivity troubleshooting

### 5. ReportCreation
Report generation tools for all components.
- PDF report generation
- Network analytics
- System status reports

## Installation

### System Dependencies

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
    jq

# Ensure pipx is in PATH
pipx ensurepath
```

### Installing Components

1. **odooLinux Installation**:
```bash
cd odooLinux
pipx install -e .
```

2. **Network Tools**:
```bash
# Install network analysis dependencies
sudo apt install -y \
    net-tools \
    wireless-tools \
    speedtest-cli
```

3. **Battery Tools**:
```bash
sudo apt install -y \
    acpi \
    upower
```

## Python Dependencies

Create a virtual environment for development:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

Install Python packages:
```bash
pip install -r odooLinux/requirements.txt
```

Main dependencies include:
- click>=8.0.0
- psutil>=5.9.0
- weasyprint>=60.0
- pdfkit
- pandas
- matplotlib
- speedtest-cli>=2.1.3
- requests>=2.31.0
- tqdm>=4.65.0

## Usage

### odooLinux Commands
```bash
# Show available commands
odoo-linux --help

# Network diagnostics
odoo-linux network report
odoo-linux network speedtest
odoo-linux network wifi

# System diagnostics
odoo-linux system report
odoo-linux system battery
odoo-linux system disk
```

### Network Diagnostics
```bash
# Run WiFi diagnostics
./Network/Wifi-Diagnostic.sh

# Generate network analytics
python3 ReportCreation/networkAnalytics.py
```

### Battery Analysis
```bash
# Check battery health
./Battery/battery-health.sh
```

### Disk Usage Analysis
```bash
# Analyze disk usage
./Disk-Usage/analyze-disk.sh
```

## Troubleshooting Installation

If you encounter issues:

1. **Permission Issues**:
```bash
# Fix ownership
sudo chown -R $USER:$USER .

# Make scripts executable
find . -name "*.sh" -exec chmod +x {} \;
```

2. **Python Environment Issues**:
```bash
# Recreate virtual environment
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r odooLinux/requirements.txt
```

3. **System Dependencies**:
```bash
# Install additional development tools
sudo apt install -y \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev
```

## Development

To set up the development environment:

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Linux-Troubleshooting.git
cd Linux-Troubleshooting
```

2. Create virtual environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

3. Install development dependencies:
```bash
pip install -e "odooLinux[dev]"
```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License
