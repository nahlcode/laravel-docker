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

# Ganti ownership direktori ke user non-root
RUN chown -R www-data:www-data /var/www/html

# Atur permissions
RUN chmod -R 775 /var/www/html

# Perintah untuk menjalankan aplikasi
CMD ["php-fpm"]
