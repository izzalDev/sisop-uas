# Konfigurasi Server

## Konfigurasi jaringan

1. Untuk mengonfigurasi jaringan pada Alpine Linux, Anda dapat menggunakan dua
   metode:

   - **Metode CLI interaktif:** Jalankan perintah berikut untuk menggunakan
     antarmuka interaktif:

     ```bash
     setup-interfaces
     ```

   - **Metode manual dengan mengedit file konfigurasi:**

     Kita akan menggunakan metode kedua, yaitu dengan mengubah file konfigurasi
     secara langsung. Gunakan perintah berikut untuk membuka file konfigurasi:

     ```bash
     vi /etc/network/interfaces
     ```

     Setelah file terbuka, tekan tombol `a` untuk masuk ke mode edit. Lakukan
     perubahan sebagai berikut:

     ![Mengedit file konfigurasi jaringan di Alpine Linux menggunakan editor teks vi.](../assets/images/capture%2031.png)

     Jika selesai, simpan perubahan dengan langkah berikut:

     - Tekan tombol `Esc` untuk keluar dari mode edit.
     - Ketikkan `:wq` di pojok kiri bawah untuk menyimpan dan keluar dari
       editor.
     - Tekan `Enter` untuk mengonfirmasi.

2. Setelah selesai mengubah file konfigurasi pada network interface, Anda perlu
   merestart layanan jaringan agar perubahan diterapkan. Jalankan perintah
   berikut:

   ```bash
   service networking restart
   ```

   Perintah ini akan menghentikan dan memulai kembali layanan jaringan
   menggunakan file konfigurasi yang telah dimodifikasi.

   ![Merestart layanan jaringan setelah konfigurasi pada Alpine linux](../assets/images/capture%2032.png)

3. Untuk melakukan konfigurasi jaringan pada linux alpine dapat menggunakan
   interactive cli dengan mengetikkan perintah `setup-interfaces` atau dapat
   juga dengan merubah file konfigurasi dengan mengetikkan perintah
   `vi /etc/network/interfaces`, kali ini kita akan menggunakan metode merubah
   file konfigurasi tekan tombol `a` untuk mengedit file konfigurasi, jika sudah
   tekan `esc` kemudian ketikkan `:qw` (akan muncul pada pojok kiri bawah) dan
   tekan enter.

   ![konfigurasi ip server](../assets/images/capture%2031.png)

4. Setelah merubah file konfigurasi pada network interface jalankan perintah
   `service networking restart` untuk merestart network service supaya
   menggunakan file konfigurasi yang telah kita modifikasi.

   ![restrart network service\label{restart-network}](../assets/images/capture%2032.png)

   jika muncul seperti pada **Gambar \ref{restart-network}**. maka konfigurasi
   jaringan berhasil dilakukan

## Konfigurasi User dan Group

1. Membuat Subdirektori untuk Home Directory. Buat tiga subdirektori untuk
   masing-masing grup yang akan dibuat:

   ```bash
   mkdir /home/mhs /home/dsn /home/lab
   ```

   Perintah ini akan membuat direktori khusus untuk masing-masing grup:

   - mhs untuk mahasiswa/siswa.
   - dsn untuk dosen/guru.
   - lab untuk administrator/laboratorium.

   ![mkdir](../assets/images/capture%2037.png)

2. Menambahkan user, untuk menamabahkan user jalankan perintah berikut satu
   persatu, kemudian isi password dan konfirmasi password:

   ```bash
   adduser -h /home/mhs/rizal rizal
   adduser -h /home/mhs/badali badali
   adduser -h /home/dsn/salam salam
   ```

   ![Menambahkan user](../assets/images/capture%2038.png)

3. Membuat group mhs dan dsn, jalankan perintah dibawah ini satu persatu;

   ```bash
   addgroup mhs
   addgroup dsn
   ```

   ![Menambahkan group mhs dan dsn](../assets/images/capture%2039.png)

4. Menambahkan rizal ke grup wheel dan mhs. Grup wheel memberikan hak akses
   superuser, sedangkan grup mhs memberikan hak akses untuk peran mahasiswa.
   Perintah yang digunakan adalah sebagai berikut:

   ```bash
   addgroup rizal wheel
   addgroup rizal mhs
   ```

   Dengan perintah ini, rizal berhasil ditambahkan ke grup wheel, memberi hak
   akses yang diperlukan untuk superuser, dan juga dimasukkan ke grup mhs untuk
   akses sebagai mahasiswa.

   ![Menambahkan rizal ke group wheel dan mhs](../assets/images/capture%2040.png)

5. Selanjutnya, salam dimasukkan ke grup dsn dan badali ke grup mhs. Grup dsn
   memberikan hak akses dosen, sementara grup mhs memberikan hak akses
   mahasiswa. Perintah yang digunakan adalah:

   ```bash
   addgroup salam dsn
   addgroup badali mhs
   ```

   Setelah menjalankan perintah tersebut, salam kini berada dalam grup dsn,
   sementara badali tergabung dalam grup mhs.

   ![Menambahkan salam dan badali sesuai peran](../assets/images/capture%2041.png)

## Instalasi dan Konfigurasi MariaDB

1. Jalankan perintah perintah berikut untuk menginstall MariaDB
   `doas apk add mariadb`.

   ![Instalasi MariaDB](../assets/images/capture%2042.png)

2. Inisialisasi MariaDB. Setelah menginstall MariaDB kita perlu melakukan
   inisialisasi dengan perintah `doas /etc/init.d/mariadb setup`.

   ![Inisialisasi MariaDB](../assets/images/capture%2043.png)

3. Agar MariaDB dijalankan secara otomatis ketika server dinyalakan ubah
   run-level MariaDB menjadi default dengan perintah
   `doas rc-update add mariadb default`.

   ![Mengubah run-level MariaDB](../assets/images/capture%2044.png)

4. Jalankan MariaDB dengan perintah `doas service mariadb start`

   ![Menjalankan service MariaDB](../assets/images/capture%2045.png)

5. Jalankan `doas mysql_secure_installation`. Proses ini akan melalui beberapa
   tahap. Tahap pertama akan meminta memasukkan kata sandi root.

   ```bash
   NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

   In order to log into MariaDB to secure it, we'll need the current password for
   the root user. If you've just installed MariaDB, and you haven't set the root
   password yet, the password will be blank, so you should just press enter here.

   Enter current password for root (enter for none):

   ```

6. Selanjutnya masukkan `N` jika tidak ingin merubah password root.

   ```bash
   OK, successfully used password, moving on...

   Setting the root password ensures that nobody can log into the MariaDB
   root user without the proper authorisation.

   Set root password? [Y/n] N
   ```

7. Mulai dari ini masukkan Y dan kemudian ENTER untuk menerima pengaturan
   default untuk semua pertanyaan berikutnya. Ini akan menghapus beberapa
   pengguna anonim dan database uji, menonaktifkan login root jarak jauh, serta
   memuat aturan-aturan baru ini agar MariaDB langsung menerapkan perubahan yang
   telah Anda buat.

   ![MariaDB secure installation](../assets/images/capture%2047.png)

8. Jangan lupa untuk melakukan instalasi mariadb-client jika ingin mengakses
   langsung mariadb melalui terminal dengan perintah
   `doas apk add mariadb-client`

   ![Instalasi mariadb-client](../assets/images/capture%2046.png)

9. Selanjutnya kita akan melakukan penyesuaian pada MariaDB untuk menjalankan
   Wordpress. Pertama masuk ke konsol mariadb dengan perintah
   `mariadb -u root -p` kemudian masukkan password jika ada.

   ![Masuk ke console mariadb](../assets/images/capture%2048.png)

10. Tambahkan user wp_service dengan perintah

    ```sql
    CREATE USER 'wp_service'@'localhost' IDENTIFIED BY 'rizal123';
    ```

    rizal123 merupakan password yang akan digunakan oleh user wp_service

    ![Membuat user di mariadb](../assets/images/capture%2049.png)

11. Tambahkan database wp_db dengan perintah `CREATE DATABASE wp_db;`

    ![Membuat database di mariadb](../assets/images/capture%2050.png)

12. Berikan semua akses ke user wp_service terhadap database wp_db dengan
    menjalankan perintah:

    ```sql
    GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_service'@'localhost';
    FLUSH PRIVILEGES;
    ```

    ![Memberikan akses ke user](../assets/images/capture%2051.png)

## Instalasi FrankenPHP

```

```
