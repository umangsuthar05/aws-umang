# Use the official PHP image with FPM and Alpine
FROM php:8.3-fpm-alpine

# Set environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    PATH="/composer/vendor/bin:$PATH"

# Install necessary PHP extensions and other dependencies
RUN apk add --no-cache \
    bash \
    git \
    unzip \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    libxml2-dev \
    zip \
    mariadb-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql intl opcache soap \
    && docker-php-ext-enable opcache

# Install Composer globally
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy WordPress-specific files
COPY . /var/www/html/

# Ensure proper permissions for WordPress
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose the default PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
