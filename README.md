# ⚡ Generic WinUSB Raw Device Driver Suite (Windows 10 / 11 64-Bit)

[![Build and Package WinUSB Driver](https://github.com/muhammadfikri-dev/generic-winusb-device-driver/actions/workflows/build-and-release.yml/badge.svg)](https://github.com/muhammadfikri-dev/generic-winusb-device-driver/actions/workflows/build-and-release.yml)
[![OS](https://img.shields.io/badge/OS-Windows%2010%20%2F%2011%20x64-0078D6.svg)](https://microsoft.com/windows)
[![Architecture](https://img.shields.io/badge/Architecture-WinUSB%20%2F%20x64-blue.svg)](https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/winusb)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)

Repositori ini menyediakan paket driver **Generic WinUSB** untuk mengaktifkan akses raw transfer berkecepatan tinggi pada endpoint USB perangkat kustom di sistem operasi **Windows 10 & 11 64-bit**.

---

## 🎯 Fitur & Kemampuan

* **Akses Raw Endpoint Tanpa Perantara:** Memungkinkan aplikasi pengguna berkomunikasi langsung dengan endpoint USB kontrol, bulk, dan interrupt melalui API WinUSB standar.
* **Tanda Tangan Digital Terverifikasi:** Dilengkapi dengan sertifikat Code Signing dan berkas katalog keamanan (`.cat`) yang dibuat otomatis oleh Microsoft WDK `Inf2Cat`.
* **Installer Otomatis 1-Klik:** Dilengkapi skrip batch dan PowerShell untuk instalasi instan tanpa konfigurasi manual.
* **CI/CD Cloud Automation:** Dikompilasi dan dikemas secara otomatis melalui GitHub Actions.

---

## 🚀 Cara Instalasi

1. Buka halaman **[Releases](https://github.com/muhammadfikri-dev/generic-winusb-device-driver/releases)**.
2. Unduh file **`Generic-WinUSB-Driver-x64.zip`**.
3. Ekstrak file ZIP ke komputer Anda.
4. Klik kanan pada **`Install-Driver.bat`** lalu pilih **"Run as Administrator"**.
5. Sambungkan perangkat USB Anda. Perangkat akan langsung terdeteksi di bawah kategori **Universal Serial Bus devices** dengan akses penuh WinUSB.

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

<p align="center">
  Dibuat dengan ❤️ oleh <b>Muhammad Fikri Dev</b>
</p>
