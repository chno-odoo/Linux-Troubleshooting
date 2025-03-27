from setuptools import setup, find_packages

setup(
    name="linux-troubleshooting",
    version="0.1.0",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'click>=8.0.0',
        'psutil>=5.9.0',
        'weasyprint>=60.0',
        'pdfkit',
        'pandas',
        'matplotlib',
        'speedtest-cli>=2.1.3',
        'requests>=2.31.0',
        'tqdm>=4.65.0'
    ],
    entry_points={
        'console_scripts': [
            'odoo-linux=odooLinux.cli:cli',
        ],
    },
    author="Josm-odoo",
    author_email="josm@odoo.com",
    description="A Linux system diagnostics tool with Odoo integration",
    long_description=open('README.md').read(),
    long_description_content_type="text/markdown",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: POSIX :: Linux",
    ],
    python_requires='>=3.6',
) 