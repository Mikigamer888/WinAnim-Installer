# This is the official WinAnim's Installer repo

Build using batch script. Made by me and fixed by [Gemini](https://gemini.google.com).

## Why this exists
Legacy Windows versions (like Windows 7) often fail to download files automatically due to modern security protocols. This installer detects your Windows version and chooses the best way to get WinAnim onto your system.

## How did i made it as EXE?
Using an app called [Bat To Exe Converter](https://github.com/l-urk/Bat-To-Exe-Converter-64-Bit/releases) i converted the batch to exe. It also allows me to embed an icon (.ico).

## Features
- Detects Windows build numbers (e.g., Build 7601).
- Provides a manual browser download fallback for legacy systems.
- Uses curl and PowerShell with TLS 1.2 for modern systems.
- Makes sharing on Discord easier.
