#!/bin/bash

# Lockfile directory
LOCKFILE="/tmp/.desktop_started"

# Check for tty1
if [ "$(tty)" = "/dev/tty1" ]; then
    # Check for lockfile
    if [ ! -f "$LOCKFILE" ]; then
        # Create lockfile
        touch "$LOCKFILE"
        # Start desktop environment
        exec startxfce4
    else
    	exec tty-menu
    fi
fi

