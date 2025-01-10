# Konfigurasi Server

## Konfigurasi jaringan

1. Untuk melakukan konfigurasi jaringan pada linux alpine dapat menggunakan
   interactive cli dengan mengetikkan perintah `setup-interfaces` atau dapat
   juga dengan merubah file konfigurasi dengan mengetikkan perintah
   `vi /etc/network/interfaces`, kali ini kita akan menggunakan metode merubah
   file konfigurasi tekan tombol `a` untuk mengedit file konfigurasi, jika sudah
   tekan `esc` kemudian ketikkan `:qw` (akan muncul pada pojok kiri bawah) dan
   tekan enter.

   ![konfigurasi ip server](<../assets/images/capture 31.png>)

2. Setelah merubah file konfigurasi pada network interface jalankan perintah
   `service networking restart` untuk merestart network service supaya
   menggunakan file konfigurasi yang telah kita modifikasi.

   ![restrart network service\label{restart-network}](<../assets/images/capture 32.png>)

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

   ![mkdir](<../assets/images/capture 37.png>)

2. Menambahkan user, untuk menamabahkan user jalankan perintah berikut satu
   persatu, kemudian isi password dan konfirmasi password:

   ```bash
   adduser -h /home/mhs/rizal rizal
   adduser -h /home/mhs/badali badali
   adduser -h /home/dsn/salam salam
   ```

   ![Menambahkan user](<../assets/images/capture 38.png>)

3. Membuat group mhs dan dsn, jalankan perintah dibawah ini satu persatu;

   ```bash
   addgroup mhs
   addgroup dsn
   ```

   ![Menambahkan group mhs dan dsn](<../assets/images/capture 39.png>)

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

   ![Menambahkan rizal ke group wheel dan mhs](<../assets/images/capture 40.png>)

5. Selanjutnya, salam dimasukkan ke grup dsn dan badali ke grup mhs. Grup dsn
   memberikan hak akses dosen, sementara grup mhs memberikan hak akses
   mahasiswa. Perintah yang digunakan adalah:

   ```bash
   addgroup salam dsn
   addgroup badali mhs
   ```

   Setelah menjalankan perintah tersebut, salam kini berada dalam grup dsn,
   sementara badali tergabung dalam grup mhs.

   ![Menambahkan salam dan badali sesuai peran](<../assets/images/capture 41.png>)

## Instalasi dan Konfigurasi MariaDB

1. Jalankan perintah perintah berikut untuk menginstall MariaDB
   `doas apk add mariadb`.

   ![Instalasi MariaDB](<../assets/images/capture 42.png>)

2. Inisialisasi MariaDB. Setelah menginstall MariaDB kita perlu melakukan
   inisialisasi dengan perintah `doas /etc/init.d/mariadb setup`.

   ![Inisialisasi MariaDB](<../assets/images/capture 43.png>)

3. Agar MariaDB dijalankan secara otomatis ketika server dinyalakan ubah
   run-level MariaDB menjadi default dengan perintah
   `doas rc-update add mariadb default`.

   ![Mengubah run-level MariaDB](<../assets/images/capture 44.png>)

4. Jalankan MariaDB dengan perintah `doas service mariadb start`

   ![Menjalankan service MariaDB](<../assets/images/capture 45.png>)

5. Jalankan `doas mysql_secure_installation`. Proses ini akan melalui beberapa
   tahap. Tahap pertama akan meminta memasukkan kata sandi root.

   ```txt
   NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

   In order to log into MariaDB to secure it, we'll need the current password
   for the root user. If you've just installed MariaDB, and you haven't set the
   root password yet, the password will be blank, so you should just press
   enter here.

   Enter current password for root (enter for none):
   ```

6. Selanjutnya masukkan `N` jika tidak ingin merubah password root.

   ```txt
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

   ![MariaDB secure installation](<../assets/images/capture 47.png>)

8. Jangan lupa untuk melakukan instalasi mariadb-client jika ingin mengakses
   langsung mariadb melalui terminal dengan perintah
   `doas apk add mariadb-client`

   ![Instalasi mariadb-client](<../assets/images/capture 46.png>)

9. Selanjutnya kita akan melakukan penyesuaian pada MariaDB untuk menjalankan
   Wordpress. Pertama masuk ke konsol mariadb dengan perintah
   `mariadb -u root -p` kemudian masukkan password jika ada.

   ![Masuk ke console mariadb](<../assets/images/capture 48.png>)

10. Tambahkan user wp_service dengan perintah

    ```sql
    CREATE USER 'wp_service'@'localhost' IDENTIFIED BY 'rizal123';
    ```

    rizal123 merupakan password yang akan digunakan oleh user wp_service

    ![Membuat user di mariadb](<../assets/images/capture 49.png>)

11. Tambahkan database wp_db dengan perintah `CREATE DATABASE wp_db;`

    ![Membuat database di mariadb](<../assets/images/capture 50.png>)

12. Berikan semua akses ke user wp_service terhadap database wp_db dengan
    menjalankan perintah:

    ```sql
    GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_service'@'localhost';
    FLUSH PRIVILEGES;
    ```

    ![Memberikan akses ke user](<../assets/images/capture 51.png>)

## Instalasi FrankenPHP

1. Install package curl sebelum melakukan instalasi FrankenPHP dengan perintah
   `doas apk add curl`

   ![Instalasi curl](<../assets/images/capture 52.png>)

2. Jalankan perintah berikut untuk menginstall FrankenPHP

   ```bash
   curl https://frankenphp.dev/install.sh | sh
   doas mv frankenphp /usr/local/bin/
   ```

   ![Proses instalasi FrankenPHP](<../assets/images/capture 53.png>)

3. Untuk mengecek instalasi jalankan perintah `frankenphp --version`, jika
   muncul tampilan seperti berikut maka instalasi berhasil dengan sukses.

   ![Cek instalasi FrankenPHP](<../assets/images/capture 54.png>)

## Konfigurasi Wordpress

1. Unduh source code Wordpress.

   ```bash
   curl https://wordpress.org/latest.zip -o latest.zip
   ```

   ![Mengunduh source code wordpress](<../assets/images/capture 55.png>)

2. Buat folder /var/www/html dan extract file latest.zip yang telah diunduh
   kedalam folder yang baru saja dibuat. Kemudian hapus latest.zip sebagai
   berikut:

   ```bash
   doas mkdir -p /var/www/html
   doas unzip latest.zip -d /var/www/html
   rm -f latest.zip
   ```

   ![Ekstrak hasil unduhan Wordpress](<../assets/images/capture 56.png>)

3. Buat service baru untuk menjalankan Wordpress dengan FrankenPHP. Untuk
   membuat service dapat dilakukan dengan membuat file baru didalam direktori
   "/etc/init.d" dengan nama file "wordpress". Gunakan vi untuk membuat dan
   mengedit file `doas vi /etc/init.d/wordpress`

   ![Membuat openrc service dengan vi](<../assets/images/capture 57.png>)

4. Tulis kode sebagai berikut

   ```bash
   #!/sbin/openrc-run

   ROOT_DIR="/var/www/html/wordpress"

   name="Wordpress"
   description="Wordpress FrankenPHP PHP Application Server"
   command="/usr/local/bin/frankenphp"
   command_args="php-server -r ${ROOT_DIR}"
   command_background="yes"
   pidfile="/run/${RC_SVCNAME}.pid"

   depend() {
      need net
      use logger dns
      after firewall
   }

   start_pre() {
      checkpath --directory --owner www-data:www-data --mode 0755 ${ROOT_DIR}
   }

   stop() {
      ebegin "Stopping Wordpress FrankenPHP"
      start-stop-daemon --stop --pidfile "$pidfile" --retry SIGTERM/30/SIGKILL/5
      eend $?
   }
   ```

   ![Membuat wordpress web service](<../assets/images/capture 60.png>)

5. Jangan lupa untuk memberikan ijin untuk eksekusi

   ```bash
   chmod +x /etc/init.d/wordpress
   ```

6. Jalankan atur run-level wordpress service sebagai default agar dapat berjalan
   secara otomatis ketika server dinyalakan.

   ```bash
   doas rc-update add wordpress default
   ```

7. Jalankan service dengan perintah `doas service wordpress start`.

   ![Mengatur run-level dan menjalankan service](<../assets/images/capture 59.png>)

8. Buka http://\serverIP{} browser pada perangkat yang terhubung dijaringan yang
   sama. Jika berhasil akan menampilkan setup wordpress, klik continue.

   ![Tampilan setup wordpress](<../assets/images/capture 61.png>)

9. Masukkan konfigurasi database sebagai berikut, lalu tekan submit.

   ![Konfigurasi database wordpress](<../assets/images/capture 63.png>)

10. Saat muncul tampilan seperti ini, tekan Run the Instalation

    ![Wordpress run installation](<../assets/images/capture 67.png>)

11. Masukkan konfigurasi user admin, dan tekan Install Wordpress.

    ![Konfigurasi Admin](<../assets/images/capture 68.png>)

12. Login dengan akun admin yang sebelumnya dibuat.

    ![Konfigurasi Admin](<../assets/images/capture 70.png>)

13. Lanjutkan dengan membuat postingan dan jangan lupa untuk dipublish.
