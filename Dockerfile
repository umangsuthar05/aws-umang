# Use the official PHP image with Apache
FROM php:8.0-apache

# Set environment variables
ENV WORDPRESS_VERSION=6.2.0 \
    WORDPRESS_DB_HOST=db \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_PASSWORD=root_password \
    WORDPRESS_DB_NAME=wordpress

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer globally
COPY --from=composer:2.3 /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Download and set up WordPress using Composer
RUN composer create-project --no-interaction --prefer-dist johnstevenson/wp-composer .

# Copy local WordPress files (if any)
COPY . .

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
