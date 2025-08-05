#!/bin/sh

# Jika direktori /var/www/html kosong (misalnya, saat pertama kali mount volume),
# instal Laravel di dalamnya.
if [ ! -f "/var/www/html/composer.json" ]; then
    echo "Menginstal Laravel..."
    composer create-project laravel/laravel .
    echo "Laravel berhasil diinstal."
fi

# Jalankan perintah utama PHP-FPM
exec "$@"
