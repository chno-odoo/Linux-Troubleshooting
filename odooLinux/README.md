# odooLinux

A Linux system diagnostics tool with Odoo integration. This tool provides comprehensive system diagnostics, network analysis, and reporting capabilities for Linux systems.

## Features

- Network diagnostics and testing
  - Speed testing
  - Ping and connectivity checks
  - WiFi information and analysis
  - Network interface details
- System monitoring and reporting
  - System resource usage
  - Process monitoring
  - Hardware information
- Battery status checking
- Disk usage analysis
- PDF report generation with beautiful formatting

## Installation

### Method 1: Using pipx (Recommended)

```bash
# 1. Install system dependencies
sudo apt update
sudo apt install python3-pip python3-venv wkhtmltopdf pipx

# 2. Ensure pipx is in your PATH
pipx ensurepath

# 3. Install the package
pipx install -e .
```

### Method 2: Using pip and virtual environment

```bash
# 1. Install system dependencies
sudo apt update
sudo apt install python3-pip python3-venv wkhtmltopdf

# 2. Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate

# 3. Install the package
pip install -e .
```

### Troubleshooting Installation

If you encounter any issues during installation:

1. Make sure all dependencies are installed:
```bash
sudo apt install python3-pip python3-venv python3-dev wkhtmltopdf build-essential
```

2. If you get permission errors:
```bash
# Fix permissions
sudo chown -R $USER:$USER .
```

3. If you need to uninstall and reinstall:
```bash
# For pipx installation
pipx uninstall odooLinux
pipx install -e .

# For pip installation
pip uninstall odooLinux
pip install -e .
```

## Usage

### Basic Commands

```bash
# Show help and available commands
odoo-linux --help

# Show help for a specific command group
odoo-linux network --help
odoo-linux system --help
```

### Network Diagnostics

```bash
# Generate network report (formats: pdf, json, text)
odoo-linux network report --format pdf
odoo-linux network report --format json --output report.json

# Run speed test
odoo-linux network speedtest

# Ping a host
odoo-linux network ping google.com --count 5

# Get WiFi information
odoo-linux network wifi
```

### System Diagnostics

```bash
# Generate system report
odoo-linux system report

# Check battery status
odoo-linux system battery

# Analyze disk usage
odoo-linux system disk
```

## Requirements

### System Requirements
- Python 3.6 or higher
- Linux operating system
- wkhtmltopdf (for PDF report generation)

### Python Dependencies
- click>=8.0.0
- psutil>=5.9.0
- weasyprint>=60.0
- speedtest-cli>=2.1.3
- requests>=2.31.0
- pandas
- matplotlib

## Development

To contribute to the project:

1. Clone the repository
2. Install development dependencies:
```bash
pip install -e ".[dev]"
```

3. Run tests:
```bash
pytest
```

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 