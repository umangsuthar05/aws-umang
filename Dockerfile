k# Use the official WordPress image
FROM wordpress:6.6.1

# Install system dependencies and PHP extensions if needed
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

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

# Start Apache
CMD ["apache2-foreground"]
