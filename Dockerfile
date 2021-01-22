FROM composer:2 as vendor

WORKDIR /var/www/app/

COPY ./ /var/www/app
RUN composer install

FROM php:7.4-fpm-alpine3.12 as php

RUN apk add --no-cache \
    $PHPIZE_DEPS \
    shadow \
    zip \
    zlib-dev \
    libzip-dev \
    tzdata

RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime

RUN pecl install redis

RUN docker-php-ext-enable redis && \
    docker-php-ext-install zip pdo pdo_mysql opcache

WORKDIR /var/www/app/

COPY --from=vendor /var/www/app/ /var/www/app
COPY --from=vendor /var/www/app/php-docker.ini /usr/local/etc/php/conf.d/php-docker.ini
COPY --from=vendor /var/www/app/docker-entrypoint.sh /sbin/docker-entrypoint.sh

RUN chmod 700 /sbin/docker-entrypoint.sh

ENTRYPOINT ["/sbin/docker-entrypoint.sh"]
