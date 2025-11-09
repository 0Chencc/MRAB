#!/bin/bash

# MRAB (Make Rog Ally Better)
# One-click installation script for ROG Ally on SteamOS
# GitHub: https://github.com/0chencc/MRAB
#
# Inspired by: https://github.com/ValveSoftware/SteamOS/issues/1937
# This script implements the community-suggested solutions for ROG Ally
# button mapping issues on SteamOS, including InputPlumber configuration
# and atomic update persistence.

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  MRAB - Make Rog Ally Better"
echo "  ROG Ally SteamOS Configuration Tool"
echo "=========================================="
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo "Please run with: sudo bash install.sh"
    exit 1
fi

# Create directories if they don't exist
TARGET_DIR="/etc/inputplumber/capability_maps.d"
TARGET_FILE="${TARGET_DIR}/ally_type1.yaml"
ATOMIC_UPDATE_DIR="/etc/atomic-update.conf.d"
ATOMIC_UPDATE_FILE="${ATOMIC_UPDATE_DIR}/mrab.conf"

echo -e "${YELLOW}Creating directory: ${TARGET_DIR}${NC}"
mkdir -p "${TARGET_DIR}"

# Write configuration file
echo -e "${YELLOW}Installing configuration file...${NC}"
cat > "${TARGET_FILE}" << 'EOF'
# yaml-language-server: $schema=https://raw.githubusercontent.com/ShadowBlip/InputPlumber/main/rootfs/usr/share/inputplumber/schema/capability_map_v1.json
version: 1
kind: CapabilityMap
name: Ally Type 1 - Start/Select Swap
id: aly1

mapping:
  - name: Control Center (Short)
    source_events:
      - keyboard: KeyF16
    target_event:
      gamepad:
        button: Select

  - name: Armory Crate (Short)
    source_events:
      - keyboard: KeyProg1
    target_event:
      gamepad:
        button: Start

  - name: Armory Crate (Short)
    source_events:
      - keyboard: KeyF19
    target_event:
      gamepad:
        button: Start

  - name: Select (Original Button)
    source_events:
      - gamepad:
          button: Select
    target_event:
      gamepad:
        button: Guide

  - name: Start (Original Button)
    source_events:
      - gamepad:
          button: Start
    target_event:
      gamepad:
        button: QuickAccess

  - name: Control Center (Long)
    source_events:
      - keyboard: KeyLeftCtrl
      - keyboard: KeyLeftAlt
      - keyboard: KeyDelete
    target_event:
      gamepad:
        button: Keyboard

  - name: Control Center (Long)
    source_events:
      - keyboard: KeyF20
    target_event:
      gamepad:
        button: Keyboard

  - name: Armory Crate (Long)
    source_events:
      - keyboard: KeyF17
    target_event:
      gamepad:
        button: QuickAccess2

  - name: Left Paddle
    source_events:
      - keyboard: KeyF14
    target_event:
      gamepad:
        button: LeftPaddle1

  - name: Right Paddle
    source_events:
      - keyboard: KeyF15
    target_event:
      gamepad:
        button: RightPaddle1

filtered_events: []
EOF

# Check if file was created successfully
if [ -f "${TARGET_FILE}" ]; then
    echo -e "${GREEN}Configuration file installed successfully!${NC}"
    echo -e "${GREEN}Location: ${TARGET_FILE}${NC}"
else
    echo -e "${RED}Error: Failed to create configuration file${NC}"
    exit 1
fi

# Create atomic update whitelist to preserve configuration across SteamOS updates
echo -e "${YELLOW}Creating atomic update whitelist...${NC}"
mkdir -p "${ATOMIC_UPDATE_DIR}"
cat > "${ATOMIC_UPDATE_FILE}" << 'EOF'
# MRAB (Make Rog Ally Better) - Whitelist for SteamOS atomic updates
# This file ensures MRAB configuration is preserved during SteamOS updates
/etc/inputplumber/capability_maps.d/ally_type1.yaml
EOF

if [ -f "${ATOMIC_UPDATE_FILE}" ]; then
    chmod 644 "${ATOMIC_UPDATE_FILE}"
    echo -e "${GREEN}Atomic update whitelist created successfully!${NC}"
    echo -e "${GREEN}Location: ${ATOMIC_UPDATE_FILE}${NC}"
    echo -e "${GREEN}Your MRAB configuration will now persist across SteamOS updates!${NC}"
else
    echo -e "${YELLOW}Warning: Failed to create atomic update whitelist${NC}"
    echo -e "${YELLOW}Configuration may be removed during SteamOS updates${NC}"
fi

# Restart InputPlumber service if it exists
if systemctl list-units --full -all | grep -Fq "inputplumber.service"; then
    echo -e "${YELLOW}Restarting InputPlumber service...${NC}"
    systemctl restart inputplumber.service
    echo -e "${GREEN}Service restarted successfully!${NC}"
else
    echo -e "${YELLOW}InputPlumber service not found. You may need to restart manually.${NC}"
fi

echo
echo -e "${GREEN}=========================================="
echo -e "  Installation Complete!"
echo -e "==========================================${NC}"
echo
echo "Your ROG Ally is now configured with optimized button mappings."
echo
echo "Key features:"
echo "  - Button mappings configured for ROG Ally on SteamOS"
echo "  - Configuration protected from SteamOS updates via whitelist"
echo "  - InputPlumber service restarted (if available)"
echo
echo "If the changes don't take effect immediately, please restart your device."
echo
