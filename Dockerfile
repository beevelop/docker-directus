FROM php:apache
MAINTAINER Maik Hummel <m@ikhummel.com>

# Install modules
RUN apt-get update && apt-get install -yq git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev && \
    apt-get install -yq libmagickwand-dev --no-install-recommends && \
    docker-php-ext-install iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd mysqli pdo pdo_mysql && \
    pecl install imagick-beta && \
    docker-php-ext-enable imagick

WORKDIR /var/www/html

RUN curl -sL 'https://github.com/RNGR/Directus/tarball/master' | tar xz -C . --strip-components=1 && ls -la && \
    cd api && curl -sL 'https://getcomposer.org/installer' | php && \
    php composer.phar install --no-dev && \
    chown -R www-data:www-data /var/www/html && \
    a2enmod rewrite && \
    
    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean
