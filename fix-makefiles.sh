#!/bin/bash
# Helper script to add PREFIX support to qmake-generated Makefiles
# Run this AFTER 'make' to enable 'make PREFIX=/custom/path install'
#
# Important: This must be run AFTER building (make), not just after qmake,
# because subdirectory Makefiles (like app/Makefile) are generated during make.

set -e

echo "Adding PREFIX support to Makefiles..."

patched_count=0
missing_count=0

# Add include to root Makefile if it exists and doesn't already have it
if [ -f Makefile ]; then
    if ! grep -q "^\-include \.prefix_default\.mk" Makefile; then
        sed -i '1i-include .prefix_default.mk' Makefile
        echo "✓ Updated Makefile"
        ((patched_count++))
    else
        echo "  Makefile already patched"
    fi
else
    echo "⚠ Makefile not found - run 'qmake' first"
    ((missing_count++))
fi

# Add include to app/Makefile if it exists and doesn't already have it
if [ -f app/Makefile ]; then
    if ! grep -q "^\-include \.prefix_default\.mk" app/Makefile; then
        sed -i '1i-include .prefix_default.mk' app/Makefile
        echo "✓ Updated app/Makefile"
        ((patched_count++))
    else
        echo "  app/Makefile already patched"
    fi
else
    echo "⚠ app/Makefile not found - run 'make' first to generate it"
    ((missing_count++))
fi

echo ""
if [ $missing_count -gt 0 ]; then
    echo "❌ Warning: Some Makefiles were not found!"
    echo "   Make sure to run this script AFTER 'make', not just after 'qmake'."
    echo ""
    echo "   Correct order:"
    echo "   1. qmake"
    echo "   2. make"
    echo "   3. bash fix-makefiles.sh  ← you are here"
    echo "   4. make PREFIX=/custom/path install"
    echo ""
    echo "   Missing Makefiles will be patched when you run this script again after make."
    exit 0
elif [ $patched_count -eq 0 ]; then
    echo "✓ All Makefiles already patched"
else
    echo "✓ Done! You can now use: make PREFIX=/custom/path install"
fi
