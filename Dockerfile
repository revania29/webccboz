# Gunakan base image PHP 8.2 dengan FPM (ini umum untuk production)
# Untuk demo ini, kita akan gunakan -cli agar bisa menjalankan 'artisan serve'
FROM php:8.2-cli

# Set working directory
WORKDIR /var/www/html

# Install dependensi sistem dan ekstensi PHP yang umum untuk Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo pdo_mysql zip exif pcntl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install Composer (dependency manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy file composer terlebih dahulu untuk caching layer
COPY composer.json composer.lock ./
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Copy sisa kode aplikasi
COPY . .

# Set permissions untuk storage dan cache (penting untuk Laravel)
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Generate application key
RUN php artisan key:generate

# Expose port yang akan digunakan oleh 'artisan serve'
EXPOSE 8000

# Perintah default untuk menjalankan aplikasi
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
