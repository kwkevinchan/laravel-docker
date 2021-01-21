FROM nginx:1.19.6-alpine

RUN mkdir -p /var/www/app/public/
RUN touch /var/www/app/public/index.php

COPY ./nginx.conf /etc/nginx/conf.d/default.conf