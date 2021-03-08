#!/bin/bash

set -e

cd $(dirname "$0")

# Bash script to install or update raspi-safe-shutdown via web

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

echo "Installing the required APT packages"
apt-get update
apt-get install -y wiringpi

echo "Downloading the raspi-safe-shutdown systemctl service file"
curl -Lo "/etc/systemd/system/raspi-safe-shutdown.service" \
	https://raw.githubusercontent.com/dmotte/raspi-safe-shutdown/main/raspi-safe-shutdown.service
systemctl daemon-reload

echo "Stopping the raspi-safe-shutdown service (if running)"
systemctl stop raspi-safe-shutdown

echo "Downloading raspi-safe-shutdown binary"
curl -Lo "/opt/raspi-safe-shutdown" \
	https://github.com/dmotte/raspi-safe-shutdown/releases/latest/download/raspi-safe-shutdown
chmod +x "/opt/raspi-safe-shutdown"

echo "Enabling raspi-safe-shutdown service at startup"
systemctl enable raspi-safe-shutdown

echo "Starting the raspi-safe-shutdown service"
systemctl start raspi-safe-shutdown

echo "Installation completed successfully"
