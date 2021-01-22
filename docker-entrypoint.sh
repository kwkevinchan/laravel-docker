#!/bin/sh
set -e

usermod -s /bin/sh -u $UPID www-data
chown -R $UPID:$UPID /var/www/app

php-fpm