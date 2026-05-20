#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "Installing system dependencies..."
sudo apt-get install -y libxcb-cursor0

echo "Creating virtual environment..."
python3 -m venv .venv

echo "Installing Python dependencies..."
.venv/bin/pip install --upgrade pip
.venv/bin/pip install "pyserial~=3.5" "pyside6~=6.8" "numpy~=2.1" "scipy~=1.14"

echo "Installing NanoVNASaver..."
SETUPTOOLS_SCM_PRETEND_VERSION=0.7.3 .venv/bin/pip install -e .

echo "Compiling Qt UI files..."
.venv/bin/pyside6-uic src/NanoVNASaver/Windows/ui/about.ui -o src/NanoVNASaver/Windows/ui/about.py --from-imports
.venv/bin/pyside6-rcc src/NanoVNASaver/Windows/ui/main.qrc -o src/NanoVNASaver/Windows/ui/main_rc.py

echo "Done. Run ./run.sh to start NanoVNA Saver."
