# Dockerfile

# Menggunakan image PHP 8.4 FPM sebagai base image
FROM php:8.4-fpm-alpine

# Menginstal dependensi sistem yang dibutuhkan
RUN apk update && apk add --no-cache \
    curl \
    git \
    nginx \
    oniguruma-dev \
    sqlite-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && rm -rf /var/cache/apk/*

# Menginstal ekstensi PHP yang dibutuhkan oleh Laravel
RUN docker-php-ext-install pdo_mysql opcache bcmath exif pcntl zip

# Menginstal Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Mengatur working directory ke direktori aplikasi
WORKDIR /var/www/html

# Mengatur user kontainer ke www-data, yang merupakan user umum untuk web server
# dan PHP-FPM di banyak distribusi Linux.
# Pastikan user www-data dan group www-data ada.
RUN addgroup -g 82 -S www-data && adduser -u 82 -D -S -G www-data www-data

# Mengubah kepemilikan direktori aplikasi ke www-data
RUN chown -R www-data:www-data /var/www/html

# Mengatur user kontainer ke www-data
USER www-data
