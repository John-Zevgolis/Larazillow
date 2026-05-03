# Χρησιμοποιούμε PHP image με Apache
FROM php:8.2-apache

# Εγκατάσταση απαραίτητων εργαλείων και PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm

# Καθαρισμός cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Εγκατάσταση PHP extensions για Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Ενεργοποίηση mod_rewrite του Apache
RUN a2enmod rewrite

# Αλλαγή του Document Root του Apache στο /public της Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Εγκατάσταση Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Αντιγραφή των αρχείων του project μέσα στο container
WORKDIR /var/www/html
COPY . .

# Δικαιώματα φακέλων για Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Build του frontend (Vue)
RUN npm install
RUN npm run build

# Build των PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Δημιουργία του storage symlink
RUN php artisan storage:link

EXPOSE 80
