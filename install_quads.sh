#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Install rootless quadlets."
   # Destination directory for quadlet files
   DEST_DIR="${HOME}/.config/containers/systemd/"
   SYSTEMD_ARG="--user"
else
   echo "Install root quadlets."
   # Destination directory for quadlet files
   DEST_DIR="/etc/containers/systemd"
   SYSTEMD_ARG=""
fi

# Directory containing the quadlet files
QUADLET_DIR=$(pwd)

# Ensure the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating destination directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

# # Copy quadlet files to the destination directory
echo "Installing quadlet files from $QUADLET_DIR to $DEST_DIR"
cp "$QUADLET_DIR"/*.container "$DEST_DIR" 2>/dev/null
cp "$QUADLET_DIR"/*.volume "$DEST_DIR" 2>/dev/null
cp "$QUADLET_DIR"/*.network "$DEST_DIR" 2>/dev/null
cp "$QUADLET_DIR"/*.env "$DEST_DIR"/env 2>/dev/null

# # Reload systemd to apply changes
echo "Reloading systemd daemon"
systemctl ${SYSTEMD_ARG} daemon-reload

# echo "Quadlet files installed successfully."
