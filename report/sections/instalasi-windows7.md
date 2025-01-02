# Tutorial Installasi Windows 7 (Fisik & Virtual Machine)

## Persiapan

Sebelum memulai instalasi Windows 7, pastikan Anda memiliki:

1. **ISO Windows 7**: File instalasi Windows 7 dalam format `.iso`.
2. **Media Instalasi atau Virtual Machine**:
   - **Untuk Fisik**: USB/DVD yang telah dibuat bootable.
   - **Untuk Virtual Machine (VM)**: Aplikasi VM seperti VirtualBox, VMware,
     atau QEMU.
3. **Lisensi Windows 7**: Kunci produk (product key) untuk aktivasi.
4. **Spesifikasi Minimum**:
   - Prosesor: 1 GHz atau lebih.
   - RAM: 1 GB (32-bit) atau 2 GB (64-bit).
   - Penyimpanan: 16 GB (32-bit) atau 20 GB (64-bit).

---
.
## Instalasi di Virtual Machine (VM)

### 1. Siapkan Virtual Machine

1. Unduh dan instal aplikasi VM seperti **VirtualBox**, **VMware**, atau
   **QEMU**.
2. Buat VM baru dengan spesifikasi berikut:
   - **Name**: Windows 7
   - **Type**: Microsoft Windows
   - **Version**: Windows 7 (32-bit atau 64-bit, sesuai ISO).
3. Atur resource VM:
   - **Memory (RAM)**: Minimal 1 GB (32-bit) atau 2 GB (64-bit).
   - **Storage**: Buat virtual disk dengan ukuran minimal 20 GB.
4. Tambahkan ISO Windows 7 sebagai optical drive:
   - Di VirtualBox: Buka **Settings** > **Storage** > Tambahkan ISO pada
     **Controller: IDE**.

---

### 2. Jalankan Virtual Machine

1. Klik **Start** pada VM untuk memulai instalasi.
2. VM akan boot dari ISO Windows 7, menampilkan layar **Windows Setup**.

---

## Instalasi pada Sistem Fisik atau VM

Langkah berikut berlaku baik untuk instalasi fisik maupun di VM.

### 1. Mulai Proses Instalasi

1. Pilih:
   - **Language to install**: Bahasa instalasi (misalnya, English).
   - **Time and currency format**: Format waktu dan mata uang.
   - **Keyboard or input method**: Jenis keyboard.
2. Klik **Next**.
3. Klik **Install Now** untuk memulai instalasi.

---

### 2. Terima Perjanjian Lisensi

1. Centang opsi **I accept the license terms**.
2. Klik **Next**.

---

### 3. Pilih Jenis Instalasi

1. Pilih **Custom (advanced)** untuk instalasi baru.
2. Pada layar **Where do you want to install Windows?**:
   - Untuk VM, pilih disk virtual yang telah Anda buat sebelumnya.
   - Untuk sistem fisik, pilih partisi tempat Windows akan diinstal.
3. Klik **Next** untuk melanjutkan.

> ⚠️ **Peringatan**: Memformat partisi akan menghapus semua data di dalamnya.

---

### 4. Tunggu Proses Instalasi

1. Windows akan menyalin file, menginstal fitur, dan memperbarui file sistem.
2. Setelah selesai, komputer atau VM akan restart secara otomatis.

---

### 5. Konfigurasi Awal

1. Masukkan nama pengguna dan nama komputer.
2. Masukkan kunci produk (jika diminta) untuk aktivasi.
3. Pilih pengaturan keamanan:
   - **Use recommended settings** (disarankan).
4. Atur zona waktu dan tanggal.
5. Pilih jenis jaringan:
   - **Home Network**: Untuk jaringan pribadi.
   - **Work Network**: Untuk jaringan kantor.
   - **Public Network**: Untuk jaringan umum.

---

### 6. Instalasi Selesai

Setelah konfigurasi selesai, Windows 7 akan memuat ke desktop, dan Anda siap
menggunakannya.

---

## Tips Tambahan untuk Virtual Machine

1. **Driver Tambahan**:
   - Jika menggunakan VirtualBox, instal **Guest Additions** dari menu
     **Devices** untuk mendukung fitur seperti resolusi layar penuh dan
     clipboard sharing.
2. **Snapshot**:
   - Sebelum melakukan perubahan besar, buat snapshot VM untuk mempermudah
     rollback jika terjadi masalah.
3. **Kinerja VM**:
   - Atur jumlah CPU dan memori yang cukup untuk meningkatkan kinerja.

---

## Troubleshooting

- Jika VM tidak bisa boot dari ISO, periksa pengaturan boot order di VM.
- Jika instalasi gagal di sistem fisik, pastikan ISO dan media bootable tidak
  rusak.

Dengan mengikuti panduan ini, Anda dapat menginstal Windows 7 baik di perangkat
fisik maupun virtual machine. Selamat mencoba!
