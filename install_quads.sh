#!/bin/bash

# Directory containing the quadlet files
QUADLET_DIR=$(pwd)

# Destination directory for quadlet files
DEST_DIR="/etc/containers/systemd"

# Ensure the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating destination directory: $DEST_DIR"
    sudo mkdir -p "$DEST_DIR"
fi

# Copy quadlet files to the destination directory
echo "Installing quadlet files from $QUADLET_DIR to $DEST_DIR"
sudo cp "$QUADLET_DIR"/*.container "$DEST_DIR" 2>/dev/null
sudo cp "$QUADLET_DIR"/*.volume "$DEST_DIR" 2>/dev/null
sudo cp "$QUADLET_DIR"/*.network "$DEST_DIR" 2>/dev/null
sudo cp "$QUADLET_DIR"/*.env "$DEST_DIR"/env 2>/dev/null

# Reload systemd to apply changes
echo "Reloading systemd daemon"
sudo systemctl daemon-reload

echo "Quadlet files installed successfully."