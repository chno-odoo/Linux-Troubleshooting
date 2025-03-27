from setuptools import setup, find_packages

setup(
    name="odooLinux",
    version="0.1.0",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'click>=8.0.0',
        'debugpy>=1.6.0',
        'psutil>=5.9.0',
        'weasyprint>=60.0',
        'pydyf>=0.8.0',
        'speedtest-cli>=2.1.3',
        'requests>=2.31.0',
        'tqdm>=4.65.0',
        'pandas',
        'matplotlib',
        'pdfkit'
    ],
    entry_points={
        'console_scripts': [
            'odoo-linux=odooLinux.cli:cli',
        ],
    },
    author="Joseph Maiarana",
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