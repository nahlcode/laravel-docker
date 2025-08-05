# laravel-docker-rockylinux
Setup Lingkungan Pengembangan Laravel dengan Docker di Rocky Linux

Panduan ini akan memandu kita dalam penyiapan lingkungan pengembangan Laravel menggunakan Docker di Rocky Linux, sesuai dengan struktur proyek yang kita berikan.

# Prasyarat
Sebelum memulai, pastikan telah menginstal Docker dan Docker Compose di sistem Rocky Linux.

**Langkah 1: Membuat Struktur Direktori Proyek:**
Pertama, buat struktur direktori yang diminta. Ini akan menjadi fondasi proyek Anda.

Sekarang, Kita memiliki struktur dasar sebagai berikut:
<code>
laravel-docker/
├── docker/
│   ├── nginx/
│   └── php/
└── docker-compose.yml (belum dibuat)
</code>

**Langkah 2: Menyiapkan File Konfigurasi Docker:**
Selanjutnya, kita akan membuat tiga file konfigurasi utama: docker-compose.yml, docker/nginx/default.conf, dan docker/php/Dockerfile. 
- File docker-compose.yml: File ini akan mendefinisikan empat layanan kontainer (web server Nginx, PHP, database MySQL, dan PHPMyAdmin) dan bagaimana mereka saling terhubung. 
- File docker/nginx/default.conf: Konfigurasi Nginx untuk mengarahkan permintaan ke aplikasi Laravel.
- File docker/php/Dockerfile: Petunjuk untuk membangun image PHP kustom yang akan digunakan oleh aplikasi Laravel kita.
Kita dapat menyalin kode yang disediakan di bagian selanjutnya ke dalam file-file ini.

**Langkah 3: Menjalankan Kontainer:**
Setelah semua file konfigurasi disiapkan, navigasi ke direktori laravel-docker dan jalankan perintah berikut:

<code>docker compose up -d</code>

Perintah ini akan membangun image PHP dari Dockerfile dan menjalankan semua kontainer di latar belakang. Mungkin perlu beberapa saat untuk selesai saat pertama kali dijalankan.

**Langkah 4: Menginstal Laravel:**
Kontainer php sudah berjalan, tetapi belum ada aplikasi Laravel. Gunakan perintah berikut untuk masuk ke dalam kontainer php dan menginstal Laravel.
<code>
docker exec -it php sh
composer create-project laravel/laravel .
exit
</code>

Perintah composer create-project akan mengunduh semua dependensi Laravel. Setelah selesai, ketik exit untuk keluar dari kontainer PHP.

**Langkah 5: Mengonfigurasi Koneksi Database:**
Setelah Laravel terinstal, Kita perlu mengonfigurasi koneksi database di file .env. Buka file .env yang baru dibuat di direktori app/ dan ubah bagian database menjadi:
<code>
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=root
DB_PASSWORD=password
</code>

Catatan: DB_HOST disetel ke mysql karena ini adalah nama layanan yang kita definisikan di docker-compose.yml.

**Langkah 6: Mengakses Aplikasi:**
Aplikasi Laravel: Buka browser web dan navigasi ke http://localhost:8080. Kita akan melihat halaman selamat datang Laravel.
PHPMyAdmin: Buka http://localhost:8081. Kita bisa masuk dengan username "root" dan password "password" untuk mengelola database MySQL.
