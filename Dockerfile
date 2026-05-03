# -------------------------
# Base image
# -------------------------
FROM php:8.2-apache

# -------------------------
# System dependencies
# -------------------------
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev \
    libicu-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# -------------------------
# PHP extensions
# -------------------------
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    intl

# -------------------------
# Apache config
# -------------------------
RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# -------------------------
# Composer
# -------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# -------------------------
# App files
# -------------------------
WORKDIR /var/www/html
COPY . .

# -------------------------
# Permissions
# -------------------------
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# -------------------------
# Install PHP dependencies
# -------------------------
RUN COMPOSER_MEMORY_LIMIT=-1 composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --prefer-dist

# -------------------------
# IMPORTANT:
# Don't run artisan storage:link here on Render build
# (run it in runtime/start command if needed)
# -------------------------

RUN php artisan migrate --force

# -------------------------
# Expose Apache port
# -------------------------
EXPOSE 80

# -------------------------
# Start Apache
# -------------------------
CMD ["apache2-foreground"]
