#!/bin/sh

# Update permissions on storage path
chmod -R 777 /var/www/storage

# Change to correct directory
cd /var/www

usermod -u 1000 www-data && chown -R 1000:1000 /var/www

# Install PHP/Laravel dependencies
su - www-data -s /bin/bash -c 'cp .env.local .env'
su - www-data -s /bin/bash -c 'composer install --prefer-dist'
su - www-data -s /bin/bash -c 'composer dump-autoload --optimize'
su - www-data -s /bin/bash -c 'php artisan clear-compiled'
su - www-data -s /bin/bash -c 'php artisan optimize'

exec supervisord -c /etc/supervisord.conf
