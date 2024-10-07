# Use the official PHP image with Apache
FROM 715841355495.dkr.ecr.us-east-1.amazonaws.com/nginx:latest

# Install necessary PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache mod_rewrite
#RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy existing application files (if any)
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WordPress using Composer (optional)
# Uncomment the line below if you want to use Composer to set up WordPress
# RUN composer create-project --no-interaction --prefer-dist johnstevenson/wp-composer .

# Set proper permissions (adjust the user and group as necessary)
RUN chown -R www-data:www-data /var/www/html

# Expose the port Apache is running on
EXPOSE 80

# Start Apache
#CMD ["apache2-foreground"]

