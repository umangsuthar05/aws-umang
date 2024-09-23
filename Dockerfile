# Use the official PHP image with Apache
FROM php:8.3-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
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

# Start Apache
CMD ["apache2-foreground"]

