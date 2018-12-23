FROM php:7.3-fpm-alpine

RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

RUN wget https://getcomposer.org/composer.phar -O /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer

RUN apk add --no-cache icu-dev libpng freetype-dev libjpeg-turbo-dev zlib-dev shadow && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install intl pdo_mysql gd bcmath

RUN apk add --no-cache nginx supervisor

COPY supervisord/supervisord.conf /etc/supervisord.conf
COPY php/php.ini /usr/local/etc/php
COPY php/www.conf php/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY nginx /etc/nginx
COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

WORKDIR /var/www

CMD ["/entrypoint.sh"]
