# QEMU Virtual Machine Setup Script

Skrip ini mengotomatisasi proses pembuatan dan pengelolaan mesin virtual menggunakan QEMU, yang dirancang untuk emulasi sistem berbasis arsitektur ARM (aarch64). Skrip ini juga dapat digunakan untuk membuat dan menjalankan mesin virtual dengan berbagai konfigurasi, termasuk pengaturan CPU, RAM, disk, serta mode tampilan (GUI atau non-GUI).

## Fitur

- **Emulasi Arsitektur**: Mendukung arsitektur `aarch64` (ARM 64-bit).
- **Pembuatan Disk Virtual**: Otomatis membuat disk virtual jika belum ada.
- **Mengunduh ISO**: Mendukung pengunduhan file ISO secara otomatis jika diperlukan.
- **Mode Operasi Fleksibel**: Mendukung beberapa mode QEMU, seperti mode GUI (`base`), mode tanpa GUI (`nographic`), dan mode inti (`core`).
- **Kustomisasi**: Memungkinkan untuk menyesuaikan pengaturan jumlah core CPU, ukuran RAM, dan ukuran disk virtual.

## Persyaratan

- QEMU
- curl (untuk mengunduh ISO)
- Sistem operasi Linux atau macOS

## Instalasi

1. Pastikan QEMU terinstal pada sistem Anda. Di Linux, Anda bisa menginstalnya dengan:

   ```bash
   sudo apt-get install qemu
   ```

2. Salin skrip ini ke dalam folder di sistem Anda.

3. Sesuaikan pengaturan pada skrip sesuai kebutuhan Anda, seperti pengaturan arsitektur, RAM, dan ukuran disk.

## Konfigurasi

### Pengaturan Utama

- **ARCH**: Arsitektur CPU untuk emulasi, `aarch64` (untuk ARM) atau `x86_64` (untuk Intel/AMD).
- **CPU_CORES**: Jumlah core CPU yang akan dialokasikan ke VM.
- **RAM_SIZE**: Ukuran RAM untuk VM (misalnya, `1G` untuk 1 GB).
- **DISK_SIZE**: Ukuran disk virtual (misalnya, `1G` untuk 1 GB).
- **DISK_NAME**: Nama file disk virtual (otomatis dibuat berdasarkan nama skrip).
- **ISO_FILE**: Nama file ISO atau URL untuk file ISO yang akan digunakan untuk instalasi.
- **DEFAULT_MODE**: Mode default untuk menjalankan VM, dapat berupa:
  - `base`: Mode GUI penuh.
  - `nographic`: Mode tanpa GUI.
  - `core`: Mode minimal dengan akses hanya ke terminal.
- **ARGS**: Argumen tambahan untuk QEMU (misalnya, pengaturan jaringan atau perangkat tambahan).

### Direktori dan Path

- **CURRENT_PATH**: Direktori tempat skrip ini berada.
- **RESOURCES_PATH**: Direktori tempat file ISO dan sumber daya lain disimpan.

## Penggunaan

### 1. Menjalankan VM dalam Mode GUI (base)

Untuk menjalankan VM dengan antarmuka grafis (GUI), cukup jalankan skrip ini seperti berikut:

```bash
./nama_skrip.sh
```

### 2. Menjalankan VM tanpa GUI (nographic)

Jika Anda ingin menjalankan VM tanpa antarmuka grafis (misalnya, hanya menggunakan terminal), gunakan mode `nographic`:

```bash
./nama_skrip.sh nographic
```

### 3. Menjalankan VM dengan Mode Minimal (core)

Mode `core` hanya akan memberikan akses ke terminal dan tidak memiliki GUI. Anda dapat menjalankannya dengan perintah berikut:

```bash
./nama_skrip.sh core
```

### 4. Pengaturan ISO dan Disk Virtual

Jika disk virtual belum ada, skrip ini akan membuatnya secara otomatis. Jika disk tersebut kosong, skrip ini akan mengunduh ISO yang ditentukan dan memasangnya pada disk tersebut. 

## Catatan

- Skrip ini secara otomatis akan memeriksa apakah disk virtual kosong dan akan meminta Anda untuk menyediakan file ISO jika diperlukan.
- Pada sistem macOS, pengaturan `OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES` digunakan untuk mencegah crash yang terkait dengan fork di lingkungan Objective-C.
- Pastikan Anda memiliki akses yang cukup untuk membuat file di direktori yang digunakan oleh skrip ini.

## Penyesuaian

Anda dapat menyesuaikan pengaturan CPU, RAM, ukuran disk, atau file ISO dengan mengubah variabel dalam skrip ini sebelum menjalankannya.

## Lisensi

Skrip ini tersedia di bawah lisensi [MIT License](LICENSE).
