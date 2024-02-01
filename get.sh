#!/bin/bash

set -e

# Bash script to install or update raspi-safe-shutdown via web

[ "$EUID" = 0 ] || { echo 'This script must be run as root' >&2; exit 1; }

echo 'Installing the required APT packages'
apt-get update
apt-get install -y python3-rpi.gpio

echo 'Downloading the raspi-safe-shutdown.service unit file'
curl -fsSLo /etc/systemd/system/raspi-safe-shutdown.service \
    https://raw.githubusercontent.com/dmotte/raspi-safe-shutdown/main/raspi-safe-shutdown.service
systemctl daemon-reload

echo 'Stopping the raspi-safe-shutdown service (if running)'
systemctl stop raspi-safe-shutdown

echo 'Downloading the raspi-safe-shutdown script'
curl -fsSLo /opt/raspi-safe-shutdown.py \
    https://raw.githubusercontent.com/dmotte/raspi-safe-shutdown/main/raspi-safe-shutdown.py
chmod +x /opt/raspi-safe-shutdown.py

echo 'Enabling raspi-safe-shutdown service at startup'
systemctl enable raspi-safe-shutdown

echo 'Starting the raspi-safe-shutdown service'
systemctl start raspi-safe-shutdown

echo 'Installation completed successfully'
