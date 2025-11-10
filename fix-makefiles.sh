#!/bin/bash
# Helper script to add PREFIX support to qmake-generated Makefiles
# Run this after 'qmake' to enable 'make PREFIX=/custom/path install'

set -e

echo "Adding PREFIX support to Makefiles..."

# Add include to root Makefile if it exists and doesn't already have it
if [ -f Makefile ] && ! grep -q "^\-include \.prefix_default\.mk" Makefile; then
    sed -i '1i-include .prefix_default.mk' Makefile
    echo "✓ Updated Makefile"
fi

# Add include to app/Makefile if it exists and doesn't already have it
if [ -f app/Makefile ] && ! grep -q "^\-include \.prefix_default\.mk" app/Makefile; then
    sed -i '1i-include .prefix_default.mk' app/Makefile
    echo "✓ Updated app/Makefile"
fi

echo "Done! You can now use: make PREFIX=/custom/path install"
