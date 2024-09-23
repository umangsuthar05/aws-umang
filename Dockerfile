# Use a lightweight PHP image
FROM php:8.3-cli

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Nginx
RUN apt-get install -y nginx

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create necessary directories for Nginx
RUN mkdir /run/nginx

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
CMD service nginx start && php -S 0.0.0.0:80 -t /var/www/html

