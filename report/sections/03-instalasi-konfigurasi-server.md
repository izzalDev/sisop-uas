# Instalasi dan Konfigurasi Server

## Instalasi Sistem Operasi pada Server

Untuk memulai instalasi sistem operasi pada server, Anda perlu memastikan bahwa
VM server yang telah Anda siapkan dapat di-boot menggunakan file ISO yang
sesuai. Dalam hal ini, kita menggunakan Alpine Linux sebagai sistem operasi
untuk server.

1. Menjalankan VM untuk Instalasi Pastikan bahwa skrip `alpine-aarch64-virt`
   sudah dapat dijalankan dengan memberikan izin eksekusi menggunakan perintah:

   ```bash
   chmod +x alpine-aarch64-virt
   ```

   Sesuaikan nama skrip `alpine-aarch64-virt` berdasarkan skrip yang dibuat
   sebelumnya.

   ![Ijin eksekusi ke skrip server](report/assets/images/server-script-permission.png)

2. Menjalankan Mesin Virtual (VM) Jalankan mesin virtual dengan perintah berikut
   untuk memulai instalasi:

   ```bash
   ./alpine-aarch-virt install
   ```

   Skrip ini akan mengunduh file ISO Alpine Linux jika belum ada, membuat disk
   virtual jika perlu, dan kemudian memulai proses instalasi.

   ![Menginstall Operating Sistem](report/assets/images/menginstall-os-pada-vm.png)

3. Tunggu skrip mengunduh file ISO Alpine Linux jika belum ada, membuat disk
   virtual, dan melakukan booting dengan ISO Alpine Linux

   ![Proses peyiapkan kebutuhan untuk menjalankan skrip](report/assets/images/proses-penyiapan-kebutuhan.png)

4. Jika proses booting berhasil akan muncul tampilan sebagai berikut pada
   terminal emulator.

   ![Booting ke ISO Alpine Linux](report/assets/images/booting-berhasil.png)

5. Login dengan username `root`

   ![Login sebagai root](report/assets/images/input-user-root.png)

6. Jika berhasil akan menampilkan teks sebagai berikut di terminal

   ![Login sebagai root](report/assets/images/login-success.png)

7. Jalankan perintah `setup-alpine`

   ![Menjalankan perintah `setup-alpine`](report/assets/images/perintah-setup-alpine.png)

8. Masukkan hostname misalkan `sisop-server`

   ![Memasukkan hostname](report/assets/images/masukkan-hostname.png)

9. Tekan enter untuk mengkonfigurasi interface eth0 (jaringan nat/shared)

   ![Konfigurasi jaringan nat/shared](report/assets/images/konfigurasi-eth0.png)

10. Tekan enter untuk menggunakan ip dari dhcp server pada eth0 (jaringan
    nat/shared)

    ![Set dhcp pada eth0](report/assets/images/jaringan-eth0-dhcp.png)

11. Tekan enter untuk mengkonfigurasi interface eth0 (jaringan bridged)

    ![Konfigurasi jaringan bridged](report/assets/images/konfigurasi-eth1.png)

12. Masukkan ip \serverIp{} untuk eth1(jaringan bridged)

    ![Konfigurasi ip pada eth1](report/assets/images/ip-server.png)

13. Tekan enter jika tidak menggunakan gateway

    ![Konfigurasi ip gateway pada eth1](report/assets/images/eth1-gateway.png)

14. Masukkan `n` jika tidak ingin membuka file konfigurasi

    ![Konfirmasi konfigurasi ip](report/assets/images/confirm-interface.png)

15. Masukkan root password

    ![input root password](report/assets/images/new-password.png)

16. Masukkan `Asia/Jakarta` untuk mengkonfigurasi zona watku yang digunakan oleh
    operating sistem.

    ![konfigurasi zona waktu](report/assets/images/set-timezone.png)

17. Tekan enter jika tidak ingin menggunakan proxy.

    ![konfigurasi proxy](report/assets/images/proxy.png)

18. Masukkan NTP server yang ingin digunakan untuk sinkronisasi waktu. disini
    kita menggunakan none karena ingin menggunakan waktu dari host os.

    ![set ntp server](report/assets/images/set-ntp.png)

19. Tekan enter jika ingin menggukan default setting untuk mirror dari pakage
    manager.

    ![set apk mirror](report/assets/images/apk-setup.png)

18. Tekan enter karena kita akan menambahkan user pada tahap konfigurasi.

    ![set ntp server](report/assets/images/user-setup-no.png)

18. Tekan enter jika ingin menggunakan openssh sebagai ssh server.

    ![set openssh server](report/assets/images/openssh-server.png)

20. Proses Instalasi Sistem Operasi Setelah VM berjalan, Anda akan diminta untuk
    mengikuti langkah-langkah instalasi sistem operasi Alpine Linux. Proses ini
    meliputi pemilihan partisi disk, konfigurasi jaringan, dan pengaturan
    password untuk root.

## Konfigurasi Jaringan Server

Setelah instalasi selesai, Anda perlu mengonfigurasi jaringan pada server.
Alpine Linux menggunakan konfigurasi jaringan berbasis ifup dan ifdown untuk
mengelola interface jaringan.

1. Mengonfigurasi Interface Jaringan Anda dapat mengonfigurasi interface
   jaringan secara manual atau menggunakan file konfigurasi
   /etc/network/interfaces. Untuk konfigurasi statis, contoh pengaturan dapat
   dilakukan sebagai berikut:

   - Edit file konfigurasi jaringan:

     vi /etc/network/interfaces

   - Tambahkan konfigurasi berikut untuk mengatur IP statis:

     iface eth0 inet static address 192.168.1.10 netmask 255.255.255.0 gateway
     192.168.1.1

2. Mengaktifkan Jaringan Untuk mengaktifkan jaringan, jalankan perintah:

   /etc/init.d/networking restart

3. Verifikasi Koneksi Jaringan Setelah konfigurasi jaringan selesai, Anda dapat
   memverifikasi koneksi menggunakan perintah:

   ping 8.8.8.8

   Jika ping berhasil, maka koneksi jaringan telah terkonfigurasi dengan benar.

Instalasi dan Konfigurasi Web Server (FrankenPHP)

Setelah sistem operasi terinstal dan terkonfigurasi dengan baik, Anda dapat
melanjutkan dengan instalasi dan konfigurasi web server menggunakan FrankenPHP
untuk menjalankan WordPress.

1. Menginstal FrankenPHP Untuk menginstal FrankenPHP, jalankan perintah berikut:

   apk add --no-cache php php-fpm php-mysqli php-cli

   Ini akan menginstal PHP dan dependencies yang diperlukan.

2. Mengonfigurasi FrankenPHP untuk WordPress Edit file konfigurasi PHP untuk
   memastikan bahwa PHP-FPM berjalan dengan benar. Biasanya file konfigurasi
   berada di /etc/php/php-fpm.conf. Sesuaikan pengaturan pool PHP-FPM sesuai
   dengan kebutuhan Anda.

3. Menjalankan FrankenPHP Setelah konfigurasi selesai, jalankan FrankenPHP
   dengan perintah:

   /etc/init.d/php-fpm start

4. Verifikasi Instalasi Web Server Anda dapat memverifikasi apakah web server
   berjalan dengan baik dengan mengakses alamat IP server di browser menggunakan
   port yang sesuai (misalnya, http://192.168.1.10:80).

Konfigurasi Layanan dan Keamanan

1. Firewall dan Keamanan Untuk mengamankan server Anda, pastikan untuk
   mengaktifkan firewall dan mengonfigurasi aturan yang diperlukan agar hanya
   port yang diperlukan (misalnya, port 80 untuk HTTP dan port 443 untuk HTTPS)
   yang terbuka.

   Anda dapat menggunakan iptables atau ufw (Uncomplicated Firewall) untuk
   mengelola aturan firewall.

2. Mengonfigurasi Layanan Otomatis Pastikan layanan yang dibutuhkan oleh server
   (seperti PHP-FPM) diatur untuk dimulai secara otomatis saat boot. Gunakan
   perintah berikut untuk mengaktifkan layanan:

   rc-update add php-fpm default

Dengan langkah-langkah tersebut, server Anda akan siap untuk digunakan dan dapat
meng-host aplikasi yang diperlukan.
