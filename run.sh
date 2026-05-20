#!/bin/bash
cd "$(dirname "$0")"

# Compile UI files if the generated Python file is missing or older than the source
if [ src/NanoVNASaver/Windows/ui/about.ui -nt src/NanoVNASaver/Windows/ui/about.py ]; then
    echo "Recompiling UI files..."
    .venv/bin/pyside6-uic src/NanoVNASaver/Windows/ui/about.ui -o src/NanoVNASaver/Windows/ui/about.py --from-imports
    .venv/bin/pyside6-rcc src/NanoVNASaver/Windows/ui/main.qrc -o src/NanoVNASaver/Windows/ui/main_rc.py
fi

SETUPTOOLS_SCM_PRETEND_VERSION=0.7.3 .venv/bin/NanoVNASaver "$@"
