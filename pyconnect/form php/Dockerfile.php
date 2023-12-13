FROM php:apache

COPY index.php /var/www/html/index.php

RUN docker-php-ext-install mysqli

EXPOSE 80