# Konfigurasi Client

Untuk proses instalasi pada client hanya ada perbedaan pada script yaitu
ditambahkan beberapa device untuk mendukung desktop environtment, Gunakan skrip
`alpine-aarch64-desktop install` (langkah-nya sama dengan server). Kemudian
gunakan perintah `alpine-aarch64-desktop` untuk menjalanka virtual machine

## Konfigurasi jaringan

1. Sama dengan pada konfigurasi server hanya saja terdapat perbedaan alamat ip,
   kali ini kita akan menggunakan alamat ip \clientIp{}.

   ```bash
   vi /etc/network/interfaces
   ```

   Lakukan perubahan sebagai berikut:

   ![Mengedit file konfigurasi jaringan di Alpine Linux menggunakan editor teks vi.](../assets/images/capture%2075.png)

   Jika selesai, simpan perubahan dengan langkah berikut:

   - Tekan tombol `Esc` untuk keluar dari mode edit.
   - Ketikkan `:wq` di pojok kiri bawah untuk menyimpan dan keluar dari editor.
   - Tekan `Enter` untuk mengonfirmasi.

2. Setelah selesai mengubah file konfigurasi pada network interface, Anda perlu
   merestart layanan jaringan agar perubahan diterapkan. Jalankan perintah
   berikut:

   ```bash
   service networking restart
   ```

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

   ![Menambahkan user](../assets/images/capture%2076.png)

3. Membuat group mhs dan dsn, jalankan perintah dibawah ini satu persatu;

   ```bash
   addgroup mhs
   addgroup dsn
   ```

   ![Menambahkan group mhs dan dsn](../assets/images/capture%2077.png)

4. Menambahkan badali ke grup wheel dan mhs. Grup wheel memberikan hak akses
   superuser, sedangkan grup mhs memberikan hak akses untuk peran mahasiswa.
   Perintah yang digunakan adalah sebagai berikut:

   ```bash
   addgroup badali wheel
   addgroup badali mhs
   ```

   Dengan perintah ini, badali berhasil ditambahkan ke grup wheel, memberi hak
   akses yang diperlukan untuk superuser, dan juga dimasukkan ke grup mhs untuk
   akses sebagai mahasiswa.

   ![Menambahkan badali ke group wheel dan mhs](../assets/images/capture%2078.png)

5. Selanjutnya, salam dimasukkan ke grup dsn dan rizal ke grup mhs. Grup dsn
   memberikan hak akses dosen, sementara grup mhs memberikan hak akses
   mahasiswa. Perintah yang digunakan adalah:

   ```bash
   addgroup salam dsn
   addgroup rizal mhs
   ```

   Setelah menjalankan perintah tersebut, salam kini berada dalam grup dsn,
   sementara badali tergabung dalam grup mhs.

   ![Menambahkan salam dan rizal sesuai peran](../assets/images/capture%2079.png)

## Konfigurasi desktop environment

Tidak seperti server yang hanya mengandalkan command line interface, pada client
kita akan menggunakan desktop environment sebagai antarmuka grafis

1. Untuk menginstall desktop environtment jalankan perintah `setup-desktop`
   kemudian sesuaikan dengan preferensi kali ini kita akan menggunakan desktop
   environment xfce yang dapat berjalan dengan resource yang minim.

   ![Instalasi desktop environment](../assets/images/capture%2082.png)

2. Tunggu beberapa menit untuk proses instalasi.

   ![Proses instalasi desktop environment](../assets/images/capture%2083.png)

3. Jika muncul tampilan seperti dibawah ini maka proses instalasi berhasil,
   reboot operating system untuk berpindah ke desktop environment

   ![Instalasi desktop environment sukses](../assets/images/capture%2084.png)

   ![Tampilan setelah reboot](../assets/images/capture%2085.png)
