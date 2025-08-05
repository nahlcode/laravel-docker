# Dockerfile

# Menggunakan image Rocky Linux 9 sebagai base image
FROM rockylinux:9

# Menginstal dependensi sistem dan repositori Remi untuk PHP 8.2
# Remi repository menyediakan versi PHP terbaru untuk RHEL/CentOS/Rocky Linux
RUN dnf update -y && \
    dnf install -y epel-release && \
    dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    # Reset modul PHP untuk memastikan versi Remi digunakan
    dnf module reset php -y && \
    # Mengaktifkan modul PHP 8.2 dari repositori Remi
    dnf module enable php:remi-8.2 -y && \
    # Menginstal PHP-FPM dan ekstensi yang dibutuhkan Laravel
    dnf install -y \
        php-fpm \
        php-cli \
        php-mysqlnd \
        php-opcache \
        php-bcmath \
        php-exif \
        php-zip \
        php-json \
        php-mbstring \
        php-xml \
        git \
        curl \
        unzip \
    && dnf clean all

# Menginstal Composer secara global
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Mengatur working directory ke direktori aplikasi
WORKDIR /var/www/html

# Mengatur user kontainer ke www-data, yang merupakan user umum untuk web server
# dan PHP-FPM di banyak distribusi Linux.
# Di Rocky Linux, kita perlu membuatnya secara eksplisit jika tidak ada.
# UID/GID 82 adalah umum untuk www-data di beberapa sistem.
RUN groupadd -r www-data -g 82 && useradd -r -g www-data -u 82 www-data

# Mengubah kepemilikan direktori aplikasi ke www-data
RUN chown -R www-data:www-data /var/www/html

# Mengubah konfigurasi PHP-FPM agar berjalan sebagai www-data
# dan mendengarkan pada port 9000 (TCP) daripada soket default.
RUN sed -i 's/user = apache/user = www-data/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = www-data/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/listen = \/run\/php-fpm\/www.sock/listen = 9000/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.owner = nobody/listen.owner = www-data/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.group = nobody/listen.group = www-data/g' /etc/php-fpm.d/www.conf

# Mengatur user kontainer utama ke www-data
USER www-data

# Menyalin skrip entrypoint ke dalam kontainer dan membuatnya executable
COPY ./docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Mengekspos port PHP-FPM
EXPOSE 9000
