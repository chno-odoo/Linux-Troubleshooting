def generate_html_report(info):
    """Generate HTML report from network information."""
    html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Network Diagnostics Report</title>
        <style>
            body {{
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 40px;
                color: #333;
            }}
            h1, h2, h3 {{
                color: #2c3e50;
            }}
            .section {{
                margin-bottom: 30px;
                padding: 20px;
                border: 1px solid #eee;
                border-radius: 5px;
            }}
            .status {{
                display: inline-block;
                padding: 3px 8px;
                border-radius: 3px;
                font-size: 0.9em;
                font-weight: bold;
            }}
            .status-success {{
                background-color: #d4edda;
                color: #155724;
            }}
            .status-failure {{
                background-color: #f8d7da;
                color: #721c24;
            }}
            .interface {{
                margin: 10px 0;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 3px;
            }}
            .timestamp {{
                color: #6c757d;
                font-size: 0.9em;
            }}
        </style>
    </head>
    <body>
        <h1>Network Diagnostics Report</h1>
        <div class="timestamp">Generated: {info['timestamp']}</div>

        <div class="section">
            <h2>System Information</h2>
            <p><strong>Hostname:</strong> {info['system']['hostname']}</p>
            <p><strong>OS:</strong> {info['system']['os']}</p>
            <p><strong>OS Version:</strong> {info['system']['os_version']}</p>
        </div>

        <div class="section">
            <h2>Network Interfaces</h2>
            {''.join(f'''
            <div class="interface">
                <h3>{interface['name']}</h3>
                {''.join(f'''
                <div>
                    <strong>{addr['family']}:</strong><br>
                    Address: {addr['address']}<br>
                    Netmask: {addr['netmask']}
                    {f"<br>Broadcast: {addr['broadcast']}" if addr['broadcast'] else ''}
                </div>
                ''' for addr in interface['addresses'])}
            </div>
            ''' for interface in info['network_interfaces'])}
        </div>

        <div class="section">
            <h2>Connectivity</h2>
            <p>
                <strong>Internet Access:</strong>
                <span class="status {'status-success' if info['connectivity']['internet'] else 'status-failure'}">
                    {'Yes' if info['connectivity']['internet'] else 'No'}
                </span>
            </p>
        </div>

        <div class="section">
            <h2>DNS Configuration</h2>
            <pre>{info['dns']['resolv_conf']}</pre>
        </div>
    </body>
    </html>
    """
    return html_content 