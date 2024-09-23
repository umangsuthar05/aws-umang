# Use an official PHP-FPM image
FROM php:8.3-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    nginx \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Set the working directory
WORKDIR /var/www/html

# Copy the WordPress files
COPY . .

# Install WordPress dependencies
RUN composer install

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Expose the port
EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["sh", "-c", "nginx && php-fpm"]

