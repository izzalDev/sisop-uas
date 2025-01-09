# Persiapan Lingkungan

## Spesifikasi Hardware

### Spesifikasi untuk Server:

- **CPU**: Arsitektur **x86_64** atau **aarch64**.
- **RAM**: Minimal 2 GB.
- **Storage**: Minimal 8 GB ruang penyimpanan.
- **Peripherals**: Mendukung perangkat keras umum, kecuali untuk beberapa
  perangkat khusus yang memerlukan driver tambahan.

### Spesifikasi untuk Desktop (Client):

- **CPU**: Arsitektur **x86_64** atau **aarch64**.
- **RAM**: Minimal 1 GB.
- **Storage**: Minimal 4 GB ruang penyimpanan.
- **Peripherals**: Mendukung perangkat keras umum, dengan kompatibilitas GPU
  Intel, ATI/AMD, atau Nvidia (beberapa model).

## Instalasi Homebrew (MacOS)

Jika Anda belum memiliki **Homebrew** (untuk pengguna macOS atau Linux), Anda
dapat menginstalnya dengan menjalankan perintah berikut di terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Setelah selesai, Anda dapat memastikan Homebrew telah terinstal dengan
menjalankan perintah:

```bash
brew --version
```

Jika Homebrew terinstal dengan benar, akan muncul informasi versi Homebrew.

## Instalasi QEMU (MacOS)

Setelah Homebrew terinstal, Anda bisa melanjutkan dengan instalasi QEMU
menggunakan perintah berikut:

```bash
brew install qemu
```

## Penyiapan Skrip QEMU untuk Server dan Client

### Skrip QEMU untuk Server

Buat skrip untuk menjalankan mesin virtual server dengan konfigurasi yang
sesuai. Berikut adalah contoh skrip untuk menjalankan server:

```bash {include="vm/alpine-aarch64-virt"}
<vm/alpine-aarch64-virt>
```

Simpan skrip dengan nama yang sesuai misal `alpine-aarch64-virt`

### Skrip QEMU untuk Client

Buat skrip yang serupa untuk menjalankan mesin virtual desktop (client):

```bash {include="vm/alpine-aarch64-desktop"}
<vm/alpine-aarch64-desktop>
```

Simpan skrip dengan nama yang sesuai misal `alpine-aarch64-desktop`

## Memberikan Izin Eksekusi pada Skrip

Setelah membuat kedua skrip tersebut, Anda perlu memberikan izin eksekusi agar
dapat menjalankannya sebagai program. Gunakan perintah chmod +x untuk memberikan
izin eksekusi pada kedua skrip:

```bash
chmod +x alpine-aarch64-virt
chmod +x alpine-aarch64-desktop
```

Sesuaikan nama skrip `alpine-aarch64-virt` dan `alpine-aarch64-desktop`
berdasarkan skrip yang dibuat sebelumnya.
