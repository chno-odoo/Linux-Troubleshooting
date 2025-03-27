import subprocess
import json
import socket
import psutil
import speedtest
from datetime import datetime
import platform
import os
import webbrowser
import tempfile
from weasyprint import HTML

def run_speed_test():
    """Run a speed test and return results."""
    try:
        st = speedtest.Speedtest()
        st.get_best_server()
        download_speed = st.download() / 1_000_000  # Convert to Mbps
        upload_speed = st.upload() / 1_000_000  # Convert to Mbps
        ping = st.results.ping
        return {
            "success": True,
            "download_speed": f"{download_speed:.2f} Mbps",
            "upload_speed": f"{upload_speed:.2f} Mbps",
            "ping": f"{ping:.2f} ms"
        }
    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }

def run_ping_test(host, count=4):
    """Run ping test to a host."""
    try:
        result = subprocess.run(
            ["ping", "-c", str(count), host],
            capture_output=True,
            text=True
        )
        return {
            "success": result.returncode == 0,
            "output": result.stdout,
            "error": result.stderr if result.returncode != 0 else None
        }
    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }

def get_wifi_info():
    """Get WiFi information using iwconfig."""
    try:
        result = subprocess.run(
            ["iwconfig"],
            capture_output=True,
            text=True
        )
        return {
            "success": result.returncode == 0,
            "info": result.stdout,
            "error": result.stderr if result.returncode != 0 else None
        }
    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }

def get_network_info():
    """Gather network information."""
    info = {
        "timestamp": datetime.now().isoformat(),
        "system": {
            "hostname": socket.gethostname(),
            "os": platform.system(),
            "os_version": platform.version(),
        },
        "network_interfaces": [],
        "dns": {
            "nameservers": [],
            "resolv_conf": None
        },
        "connectivity": {
            "internet": False,
        }
    }
    
    # Get network interfaces
    for interface, addrs in psutil.net_if_addrs().items():
        interface_info = {
            "name": interface,
            "addresses": []
        }
        for addr in addrs:
            interface_info["addresses"].append({
                "family": "IPv4" if addr.family == socket.AF_INET else "IPv6",
                "address": addr.address,
                "netmask": addr.netmask,
                "broadcast": addr.broadcast if hasattr(addr, 'broadcast') else None
            })
        info["network_interfaces"].append(interface_info)
    
    # Get DNS information
    try:
        with open('/etc/resolv.conf', 'r') as f:
            info["dns"]["resolv_conf"] = f.read()
    except Exception as e:
        info["dns"]["resolv_conf"] = f"Error reading resolv.conf: {str(e)}"
    
    # Check internet connectivity
    try:
        subprocess.run(
            ["ping", "-c", "1", "8.8.8.8"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=5
        )
        info["connectivity"]["internet"] = True
    except:
        info["connectivity"]["internet"] = False
    
    return info

def generate_report(output=None, format='pdf', open_browser=True):
    """Generate a network diagnostics report."""
    info = get_network_info()
    
    if format == 'json':
        if output:
            with open(output, 'w') as f:
                json.dump(info, f, indent=2)
            return f"Report saved to {output}"
        return json.dumps(info, indent=2)
    
    elif format == 'text':
        text_report = f"""
Network Diagnostics Report
Generated: {info['timestamp']}

System Information:
- Hostname: {info['system']['hostname']}
- OS: {info['system']['os']} {info['system']['os_version']}

Network Interfaces:
"""
        for interface in info['network_interfaces']:
            text_report += f"\n{interface['name']}:\n"
            for addr in interface['addresses']:
                text_report += f"  {addr['family']}: {addr['address']}\n"
                text_report += f"  Netmask: {addr['netmask']}\n"
                if addr['broadcast']:
                    text_report += f"  Broadcast: {addr['broadcast']}\n"
        
        if output:
            with open(output, 'w') as f:
                f.write(text_report)
            return f"Report saved to {output}"
        return text_report
    
    elif format == 'pdf':
        # Generate HTML report and convert to PDF
        from .html_report import generate_html_report
        html_content = generate_html_report(info)
        
        if output:
            HTML(string=html_content).write_pdf(output)
            if open_browser:
                webbrowser.open(f"file://{os.path.abspath(output)}")
            return f"Report saved to {output}"
        
        # If no output specified, create a temporary file
        with tempfile.NamedTemporaryFile(suffix='.pdf', delete=False) as tmp:
            HTML(string=html_content).write_pdf(tmp.name)
            if open_browser:
                webbrowser.open(f"file://{tmp.name}")
            return f"Report saved to {tmp.name}" 