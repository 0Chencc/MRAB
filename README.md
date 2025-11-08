# MRAB

*Make Rog Ally Better*

English | [简体中文](README_zh.md)

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/0chencc/MRAB)](https://github.com/0chencc/MRAB/releases/latest)
[![GitHub all releases](https://img.shields.io/github/downloads/0chencc/MRAB/total)](https://github.com/0chencc/MRAB/releases)
[![License](https://img.shields.io/github/license/0chencc/MRAB)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/0chencc/MRAB)](https://github.com/0chencc/MRAB/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/0chencc/MRAB)](https://github.com/0chencc/MRAB/issues)

One-click configuration script to optimize button mapping for ROG Ally running SteamOS.

## Features

- Automatic InputPlumber capability map configuration
- Optimized Start/Select button layout for ROG Ally
- Support for rear paddle buttons
- One-click installation, simple and quick

## Quick Installation

### Stable Release (Recommended)

Install from the latest release:

```bash
curl -fsSL https://github.com/0chencc/MRAB/releases/latest/download/install.sh | sudo bash
```

Or download manually:

```bash
wget https://github.com/0chencc/MRAB/releases/latest/download/install.sh
sudo bash install.sh
```

### Development Version

Install from the main branch:

```bash
curl -fsSL https://raw.githubusercontent.com/0chencc/MRAB/main/install.sh | sudo bash
```

## Local Installation

If you have already cloned this repository:

```bash
cd MRAB
sudo bash install.sh
```

## Button Mapping

This configuration maps the following buttons:

- **Control Center (Short Press)** → Select
- **Armory Crate (Short Press)** → Start
- **Original Select Button** → Guide
- **Original Start Button** → Quick Access
- **Control Center (Long Press)** → Keyboard
- **Armory Crate (Long Press)** → Quick Access 2
- **Left Paddle** → Left Paddle 1
- **Right Paddle** → Right Paddle 1

## System Requirements

- ROG Ally device
- SteamOS operating system
- InputPlumber service

## Notes

- Root privileges are required to run the installation script
- A device restart may be required for changes to take effect
- Configuration file location: `/etc/inputplumber/capability_maps.d/ally_type1.yaml`

## Contributing

Issues and Pull Requests are welcome!

## License

MIT License
