# Laporan Simulasi Koneksi Client-Server Menggunakan Linux Alpine di QEMU

**Disusun oleh:**

- Nama Anggota 1 (NIM)
- Nama Anggota 2 (NIM)

**Program Studi:**  
Program Studi Universitas XYZ

**Tahun:**  
2025

<!-- 
## Daftar Isi

1. **Pendahuluan**
   - Latar Belakang
   - Tujuan
2. **Perencanaan dan Desain Sistem**
   - Arsitektur Sistem
   - Pembagian Peran dan Tugas
3. **Instalasi dan Konfigurasi**
   - Persiapan Lingkungan
   - Instalasi dan Konfigurasi Server
   - Instalasi dan Konfigurasi Client
4. **Uji Coba dan Pembuktian**
   - Uji Koneksi
   - Uji Layanan
5. **Evaluasi dan Kesimpulan**
6. **Role Report**
7. **Daftar Pustaka**

-->

## 1. Pendahuluan

### 1.1. Latar Belakang

Simulasi koneksi client-server bertujuan untuk memahami implementasi layanan
berbasis jaringan. Pada laporan ini, digunakan **Linux Alpine** sebagai sistem
operasi pada server dan client yang dijalankan menggunakan **QEMU**. Untuk web
server, digunakan kombinasi **WordPress** sebagai CMS dan **FrankenPHP** sebagai
server PHP.

### 1.2. Tujuan

- Mengimplementasikan koneksi client-server dengan layanan WordPress (web) dan
  database (MySQL).
- Membuktikan bahwa client dapat mengakses layanan yang disediakan oleh server
  melalui IP yang dikonfigurasi.


## 2. Perencanaan dan Desain Sistem

### 2.1. Arsitektur Sistem

Sistem terdiri dari dua virtual machine:

- **Server**: Menyediakan layanan WordPress (menggunakan FrankenPHP) dan
  database (MySQL).
- **Client**: Mengakses layanan web dan database yang disediakan oleh server.

### 2.2. Pembagian Peran dan Tugas

- **Anggota 1**: Membuat dan mengonfigurasi server.
- **Anggota 2**: Membuat dan mengonfigurasi client serta melakukan pengujian
  koneksi.


## 3. Instalasi dan Konfigurasi

### 3.1. Persiapan Lingkungan

1. Unduh dan pasang QEMU di host machine.
2. Unduh _image_ Linux Alpine untuk arsitektur **aarch64**.
3. Buat dua VM di QEMU dengan spesifikasi:
   - **Server**:
     - CPU: 2 Core
     - RAM: 1 GB
     - Disk: 10 GB
   - **Client**:
     - CPU: 1 Core
     - RAM: 512 MB
     - Disk: 5 GB

### 3.2. Instalasi dan Konfigurasi Server

#### 3.2.1. Instalasi Layanan

1. **FrankenPHP**:
   ```sh
   apk add frankenphp
   rc-update add frankenphp
   service frankenphp start
   ```
2. **MySQL**:
   ```sh
   apk add mariadb mariadb-client
   rc-update add mariadb
   service mariadb start
   ```
3. **WordPress**:
   - Unduh WordPress:
     ```sh
     wget https://wordpress.org/latest.tar.gz
     tar -xzvf latest.tar.gz -C /var/www/localhost/htdocs/
     ```
   - Setel konfigurasi WordPress untuk terhubung ke MySQL.

#### 3.2.2. Konfigurasi IP

- Atur IP Address pada server:
  ```sh
  ip addr add 192.168.22.<DA1>/24 dev eth0
  ```

### 3.3. Instalasi dan Konfigurasi Client

1. Konfigurasi IP Address:
   ```sh
   ip addr add 192.168.22.<DA2>/24 dev eth0
   ```
2. Uji koneksi ke server:
   ```sh
   ping 192.168.22.<DA1>
   ```
3. Instalasi alat pengujian (misalnya `curl` untuk mengakses web server).


## 4. Uji Coba dan Pembuktian

### 4.1. Uji Koneksi

- Uji koneksi menggunakan perintah `ping` dari client ke server.
- Screenshot hasil pengujian.

### 4.2. Uji Layanan

- **Web Server**:
  - Akses WordPress dari client menggunakan perintah:
    ```sh
    curl http://192.168.22.<DA1>
    ```
  - Screenshot hasil akses WordPress.
- **Database Server**:
  - Uji koneksi ke MySQL server:
    ```sh
    mysql -h 192.168.22.<DA1> -u root -p
    ```
  - Screenshot hasil pengujian.


## 5. Evaluasi dan Kesimpulan

### 5.1. Evaluasi

- Keberhasilan instalasi WordPress dan FrankenPHP.
- Analisis kendala yang dihadapi selama konfigurasi.

### 5.2. Kesimpulan

- Apakah sistem berjalan sesuai rencana?
- Apa saja yang dapat ditingkatkan?


## 6. Role Report

### 6.1. Anggota 1

- Tugas: Instalasi dan konfigurasi FrankenPHP, WordPress, dan MySQL pada server.

### 6.2. Anggota 2

- Tugas: Instalasi client, pengujian koneksi, dan akses layanan.


## 7. Daftar Pustaka

- Dokumentasi Linux Alpine: [https://alpinelinux.org](https://alpinelinux.org)
- Dokumentasi FrankenPHP: [https://frankenphp.dev](https://frankenphp.dev)
- Dokumentasi WordPress: [https://wordpress.org](https://wordpress.org)
