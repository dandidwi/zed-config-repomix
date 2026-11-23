# 🚀 Zed Config + Repomix
[🇮🇩 Bahasa Indonesia](README.md) | [🇬🇧 English](README.en.md)

An integration of [Repomix](https://github.com/yamadashy/repomix) CLI into [Zed Editor](https://zed.dev), allowing you to package your project context directly from Zed.

Pack your entire project, the currently active file, or the active folder, then copy the output to your clipboard with a simple keyboard shortcut or through Zed's task menu.

No browser extensions or DOM automation required.

## ✨ Features

- **Pack All** — Package the entire project.
- **Pack Active File** — Package only the currently active file.
- **Pack Active Folder** — Package the folder containing the active file.
- **Instant Copy** — Automatically copy the output to your clipboard using Repomix's `--copy` option.
- **Idempotent Installation** — Safe to run the installer multiple times without creating duplicate configurations.
- **Cross-Platform Support** — Compatible with Windows, Linux, and NixOS.

## 📁 Project Structure

```text
.
├── templates/
│   ├── tasks.json
│   └── keymap.json
├── scripts/
│   ├── windows/
│   │   └── install.ps1
│   └── unix/
│       └── install.sh
├── nix/
│   └── home-manager.nix
├── .gitignore
├── LICENSE
└── README.md
```

## 📋 Prerequisites

Before installing, make sure you have:

- [Zed Editor](https://zed.dev) installed and launched at least once.
- [Node.js](https://nodejs.org/) installed.
- **Python 3** — Required on Linux and NixOS for JSONC configuration parsing.

## 📦 Installation

### Windows

1. Clone this repository:

   ```powershell
   git clone https://github.com/dandidwi/zed-config-repomix.git
   cd zed-config-repomix
   ```

2. Run the installer:

   ```powershell
   .\scripts\windows\install.ps1
   ```

### Linux

1. Clone this repository:

   ```bash
   git clone https://github.com/dandidwi/zed-config-repomix.git
   cd zed-config-repomix
   ```

2. Make the installer executable and run it:

   ```bash
   chmod +x scripts/unix/install.sh
   ./scripts/unix/install.sh
   ```

### NixOS (Home Manager)

1. Clone this repository:

   ```bash
   git clone https://github.com/dandidwi/zed-config-repomix.git
   ```

2. Import the Home Manager module into your configuration:

   ```nix
   imports = [
     /path/to/zed-config-repomix/nix/home-manager.nix
   ];
   ```

3. Apply your configuration:

   ```bash
   home-manager switch
   ```

## 🗑️ Uninstallation

To remove the installed configurations:

**Windows**

```powershell
.\scripts\windows\install.ps1 -Uninstall
```

**Linux**

```bash
./scripts/unix/install.sh --uninstall
```

**NixOS**

Remove the module import from your Home Manager configuration, then run:

```bash
home-manager switch
```

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl + Alt + R` | Repomix: Pack All & Copy to Clipboard |

## 💡 Tips

You can also run Repomix tasks manually through Zed:

1. Open the Command Palette with `Ctrl + Shift + P`.
2. Search for `Task: Spawn`.
3. Select the Repomix task you want to run.

## 📄 License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**. See the [LICENSE](LICENSE) file for details.

## 👤 Author

**Dandy Dwi Trio Setiawan**

- GitHub: [@dandidwi](https://github.com/dandidwi)
