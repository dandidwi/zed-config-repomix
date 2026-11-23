# 🚀 Zed Config + Repomix
[🇮🇩 Bahasa Indonesia](README.md) | [🇬🇧 English](README.en.md)

Integrasi CLI **[Repomix](https://github.com/yamadashy/repomix)** ke dalam **Zed Editor** secara ringan dan instan.

Proyek ini memungkinkan pengguna Zed untuk mengemas seluruh proyek, file aktif, atau folder aktif menjadi satu konteks kode dan menyalinnya langsung ke clipboard menggunakan shortcut maupun menu Task bawaan Zed.

Tidak memerlukan ekstensi browser atau DOM automation yang berat.

---

## ✨ Fitur

- **Pack All:** Mengemas seluruh codebase dalam folder kerja.
- **Pack File Aktif:** Hanya mengemas file yang sedang dibuka.
- **Pack Folder Aktif:** Mengemas seluruh isi folder tempat file aktif berada.
- **Instant Copy:** Hasil pengemasan langsung disalin ke clipboard menggunakan opsi `--copy`.
- **Idempotent:** Script instalasi dirancang agar aman dijalankan berulang kali tanpa menduplikasi konfigurasi.
- **Cross-Platform:** Mendukung Windows, Linux (Ubuntu, Arch, Fedora, Garuda, dan distribusi lainnya), serta NixOS.

---

## 📂 Struktur Direktori

```text
zed-config-repomix/
├── templates/
│   ├── tasks.json          # Template task Zed
│   └── keymap.json         # Template keybinding Zed
├── scripts/
│   ├── windows/
│   │   └── install.ps1     # Installer & uninstaller Windows
│   └── unix/
│       └── install.sh      # Installer & uninstaller Linux/macOS
├── nix/
│   └── home-manager.nix    # Modul Home Manager untuk NixOS
├── .gitignore
├── LICENSE                 # GNU GPLv3 License
└── README.md
```

---

## 🛠️ Prasyarat

Pastikan perangkat sudah memenuhi persyaratan berikut:

1. **Zed Editor:** Sudah terinstal dan pernah dijalankan minimal satu kali.
2. **Node.js:** Diperlukan untuk menjalankan perintah `npx repomix`.
3. **Python 3:** Khusus Linux/NixOS, digunakan oleh `install.sh` untuk memproses JSONC dengan aman.

---

## 📥 Panduan Instalasi

### 🪟 Windows (PowerShell 5.1 / 7+)

Jalankan PowerShell menggunakan akun Administrator atau akun pengguna biasa.

**1. Clone repository**

```powershell
git clone https://github.com/dandidwi/zed-config-repomix.git
```

**2. Masuk ke direktori proyek**

```powershell
cd zed-config-repomix
```

**3. Jalankan installer**

```powershell
.\scripts\windows\install.ps1
```

### 🐧 Linux (Ubuntu, Arch, Fedora, Garuda, dll.)

Pastikan `python3` dan `nodejs` sudah terinstal.

**1. Clone repository**

```bash
git clone https://github.com/dandidwi/zed-config-repomix.git
cd zed-config-repomix
```

**2. Berikan izin eksekusi**

```bash
chmod +x scripts/unix/install.sh
```

**3. Jalankan installer**

```bash
./scripts/unix/install.sh
```

### ❄️ NixOS (Home Manager)

Tambahkan modul berikut ke konfigurasi Home Manager Anda, misalnya melalui `home.nix` atau file konfigurasi lainnya.

```nix
{
  imports = [
    ./path/to/zed-config-repomix/nix/home-manager.nix
  ];
}
```

Setelah itu, terapkan konfigurasi:

```bash
home-manager switch
```

---

## 🗑️ Panduan Uninstall

Untuk menghapus konfigurasi Repomix dari Zed tanpa menghapus konfigurasi lain yang sudah ada, jalankan perintah sesuai sistem operasi.

### 🪟 Windows

```powershell
.\scripts\windows\install.ps1 -Uninstall
```

### 🐧 Linux

```bash
./scripts/unix/install.sh --uninstall
```

### ❄️ NixOS

Hapus atau komentari baris `imports` yang merujuk ke `home-manager.nix` pada konfigurasi Home Manager.

Kemudian terapkan kembali konfigurasi:

```bash
home-manager switch
```

---

## ⌨️ Shortcut

| Shortcut | Aksi | Deskripsi |
|---|---|---|
| `Ctrl + Alt + R` | Spawn Task | Menjalankan task Repomix: Pack All & Copy to Clipboard |

> [!TIP]
> Anda juga dapat menjalankan task secara manual melalui Command Palette Zed dengan menekan `Ctrl + Shift + P`, kemudian mengetik `Task: Spawn` dan memilih task Repomix yang diinginkan.

---

## 📜 Lisensi

Proyek ini dilisensikan di bawah **[GNU General Public License v3.0](LICENSE)**.

Anda bebas menggunakan, mempelajari, memodifikasi, dan mendistribusikan proyek ini sesuai ketentuan lisensi GPL-3.0.

---

## ❤️ Author

Dibuat dengan ❤️ oleh **[Dandy Dwi Trio Setiawan](https://github.com/dandidwi)**.

---

**Happy Coding!** 🚀
