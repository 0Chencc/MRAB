# MRAB

*Make Rog Ally Better*

[English](README.md) | 简体中文

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/0chencc/MRAB)](https://github.com/0chencc/MRAB/releases/latest)
[![GitHub all releases](https://img.shields.io/github/downloads/0chencc/MRAB/total)](https://github.com/0chencc/MRAB/releases)
[![License](https://img.shields.io/github/license/0chencc/MRAB)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/0chencc/MRAB)](https://github.com/0chencc/MRAB/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/0chencc/MRAB)](https://github.com/0chencc/MRAB/issues)

一键配置脚本，用于优化 ROG Ally 刷机 SteamOS 后的按键映射。

## 功能特性

- 自动配置 InputPlumber 按键映射
- 优化 ROG Ally 的 Start/Select 按键布局
- 支持背部拨片按键
- 一键安装，简单快捷

## 快速安装

### 稳定版本（推荐）

从最新 release 安装：

```bash
curl -fsSL https://github.com/0chencc/MRAB/releases/latest/download/install.sh | sudo bash
```

或者手动下载后安装：

```bash
wget https://github.com/0chencc/MRAB/releases/latest/download/install.sh
sudo bash install.sh
```

### 开发版本

从 main 分支安装：

```bash
curl -fsSL https://raw.githubusercontent.com/0chencc/MRAB/main/install.sh | sudo bash
```

## 本地安装

如果你已经克隆了这个仓库：

```bash
cd MRAB
sudo bash install.sh
```

## 按键映射说明

此配置会将以下按键进行映射：

- **Control Center (短按)** → Select
- **Armory Crate (短按)** → Start
- **原 Select 按键** → Guide
- **原 Start 按键** → Quick Access
- **Control Center (长按)** → Keyboard
- **Armory Crate (长按)** → Quick Access 2
- **左侧拨片** → Left Paddle 1
- **右侧拨片** → Right Paddle 1

## 系统要求

- ROG Ally 设备
- SteamOS 系统
- InputPlumber 服务

## 注意事项

- 需要 root 权限执行安装脚本
- 安装完成后可能需要重启设备使配置生效
- 配置文件位置：`/etc/inputplumber/capability_maps.d/ally_type1.yaml`

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
