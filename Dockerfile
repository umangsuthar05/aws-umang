# Use the official WordPress image with PHP-FPM
FROM wordpress:6.6.1-php8.3-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Copy the WordPress files
COPY . .

# Install WordPress dependencies
RUN composer install

# Set file permissions (adjust as needed for your setup)
RUN chown -R www-data:www-data /var/www/html

# Expose the port
EXPOSE 80

# Start PHP-FPM
CMD ["php-fpm"]

