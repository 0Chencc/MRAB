#!/bin/bash

# MRAB (Make Rog Ally Better)
# Uninstallation script for ROG Ally on SteamOS
# GitHub: https://github.com/0chencc/MRAB
#
# Inspired by: https://github.com/ValveSoftware/SteamOS/issues/1937

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  MRAB - Make Rog Ally Better"
echo "  Uninstallation Tool"
echo "=========================================="
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo "Please run with: sudo bash uninstall.sh"
    exit 1
fi

# Define file paths
TARGET_FILE="/etc/inputplumber/capability_maps.d/ally_type1.yaml"
ATOMIC_UPDATE_FILE="/etc/atomic-update.conf.d/mrab.conf"

echo -e "${YELLOW}This will remove MRAB configuration and restore default button mappings.${NC}"
echo

# Track if any files were removed
FILES_REMOVED=false

# Remove InputPlumber configuration
if [ -f "${TARGET_FILE}" ]; then
    echo -e "${YELLOW}Removing InputPlumber configuration...${NC}"
    rm -f "${TARGET_FILE}"
    if [ ! -f "${TARGET_FILE}" ]; then
        echo -e "${GREEN}✓ Removed: ${TARGET_FILE}${NC}"
        FILES_REMOVED=true
    else
        echo -e "${RED}✗ Failed to remove: ${TARGET_FILE}${NC}"
    fi
else
    echo -e "${YELLOW}InputPlumber configuration not found (already removed)${NC}"
fi

# Remove atomic update whitelist
if [ -f "${ATOMIC_UPDATE_FILE}" ]; then
    echo -e "${YELLOW}Removing atomic update whitelist...${NC}"
    rm -f "${ATOMIC_UPDATE_FILE}"
    if [ ! -f "${ATOMIC_UPDATE_FILE}" ]; then
        echo -e "${GREEN}✓ Removed: ${ATOMIC_UPDATE_FILE}${NC}"
        FILES_REMOVED=true
    else
        echo -e "${RED}✗ Failed to remove: ${ATOMIC_UPDATE_FILE}${NC}"
    fi
else
    echo -e "${YELLOW}Atomic update whitelist not found (already removed)${NC}"
fi

# Restart InputPlumber service if it exists
if [ "$FILES_REMOVED" = true ]; then
    if systemctl list-units --full -all | grep -Fq "inputplumber.service"; then
        echo -e "${YELLOW}Restarting InputPlumber service...${NC}"
        systemctl restart inputplumber.service
        echo -e "${GREEN}Service restarted successfully!${NC}"
    else
        echo -e "${YELLOW}InputPlumber service not found. You may need to restart manually.${NC}"
    fi
fi

echo
echo -e "${GREEN}=========================================="
echo -e "  Uninstallation Complete!"
echo -e "==========================================${NC}"
echo

if [ "$FILES_REMOVED" = true ]; then
    echo "MRAB configuration has been removed."
    echo "Your ROG Ally will now use the default button mappings."
    echo
    echo "If the changes don't take effect immediately, please restart your device."
else
    echo "No MRAB configuration files were found."
    echo "MRAB may not have been installed, or was already uninstalled."
fi

echo
echo "To reinstall MRAB, run:"
echo "  curl -fsSL https://github.com/0chencc/MRAB/releases/latest/download/install.sh | sudo bash"
echo
