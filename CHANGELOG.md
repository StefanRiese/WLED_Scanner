# Changelog

The section for a version becomes its GitHub release note (see `.github/scripts/release-notes.sh`).
Add a `## vX.Y.Z – YYYY-MM-DD` section before pushing the tag.

## v1.1.0 – 2026-10-15

The device list now stays up to date while the scanner is running.

### What's new
- **Devices refresh automatically.** Every WLED announcement (every 30 seconds) re-reads the device's info, so name, version and uptime stay current. Before, each device was only queried once when it was found.
- **New "Last seen" column** shows when each device last announced itself ("just now", "45 s ago", "3 min ago", …).
- **Offline devices are greyed out** after three missed announcements (more than 90 seconds) instead of staying unchanged. They return to normal as soon as they announce themselves again. *Clear list* still removes everything.
- **Uptime keeps counting** between refreshes and stops at the last known value once a device goes offline.
- The window opens a bit wider to fit the new column.

## v1.0.0 – 2026-10-15

First release of the cross-platform WLED Scanner. It replaces the Windows-only C# WinForms version with a Rust app that runs on Windows, Linux and macOS.

### Features
- Finds WLED devices automatically: listens for the UDP node broadcasts on port 65506 and lists the name, IP, version, architecture and uptime of each device.
- **Open in browser** (or a double-click) opens a device's web UI.
- **Clear list** empties the list; devices reappear with their next broadcast.
- New app icon in the window, the taskbar/Dock and the Windows `.exe`.

### Improvements over the C# version
- Devices are queried in the background, so the window no longer freezes during a lookup.
- A device that doesn't answer no longer crashes the app; it is retried on its next broadcast.
- Runs on Linux and macOS (universal: Apple Silicon and Intel) as well as Windows.
