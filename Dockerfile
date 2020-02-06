FROM php:7.4-fpm

RUN docker-php-ext-install \
        pdo_mysql \
        opcache

RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
    git-core \
    curl

RUN apt-get purge -y g++ \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN rm -rf /usr/local/etc/php-fpm.d
COPY ./docker-php-entrypoint /usr/local/bin/

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php-fpm"]