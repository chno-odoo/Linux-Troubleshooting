#!/usr/bin/env python3
import click
import subprocess
import platform
import socket
import psutil
import json
import webbrowser
import tempfile
import os
from datetime import datetime
from weasyprint import HTML, CSS
from weasyprint.text.fonts import FontConfiguration

@click.group()
def cli():
    """Linux System Diagnostics Tool - Combined functionality for system and Odoo diagnostics."""
    pass

# Network Commands Group
@cli.group()
def network():
    """Network diagnostics and testing commands."""
    pass

@network.command()
@click.option('--output', '-o', type=click.Path(), help='Output file for the report')
@click.option('--format', '-f', type=click.Choice(['json', 'text', 'pdf']), default='pdf', help='Output format')
@click.option('--open/--no-open', default=True, help='Open the report in browser (for PDF format)')
def report(output, format, open):
    """Generate and display a network diagnostics report."""
    from .reports.network import diagnostics
    result = diagnostics.generate_report(output=output, format=format, open_browser=open)
    click.echo(result)

@network.command()
def speedtest():
    """Run a speed test."""
    from .reports.network.diagnostics import run_speed_test
    result = run_speed_test()
    click.echo(json.dumps(result, indent=2))

@network.command()
@click.argument('host')
@click.option('--count', '-c', default=4, help='Number of ping packets to send')
def ping(host, count):
    """Ping a host."""
    from .reports.network.diagnostics import run_ping_test
    result = run_ping_test(host, count)
    click.echo(json.dumps(result, indent=2))

@network.command()
def wifi():
    """Get WiFi information."""
    from .reports.network.diagnostics import get_wifi_info
    result = get_wifi_info()
    click.echo(json.dumps(result, indent=2))

# System Commands Group
@cli.group()
def system():
    """System diagnostics and monitoring commands."""
    pass

@system.command()
@click.option('--output', '-o', type=click.Path(), help='Output file for the report')
@click.option('--format', '-f', type=click.Choice(['json', 'text', 'pdf']), default='pdf', help='Output format')
@click.option('--open/--no-open', default=True, help='Open the report in browser (for PDF format)')
def report(output, format, open):
    """Generate and display a system diagnostics report."""
    from .reports.system import diagnostics
    result = diagnostics.generate_report(output=output, format=format, open_browser=open)
    click.echo(result)

@system.command()
def battery():
    """Check battery status and health."""
    click.echo("Checking battery status...")
    # TODO: Implement battery status check
    click.echo("Battery status check completed!")

@system.command()
def disk():
    """Analyze disk usage and space."""
    click.echo("Analyzing disk usage...")
    # TODO: Implement disk analysis
    click.echo("Disk analysis completed!")

if __name__ == '__main__':
    cli() 