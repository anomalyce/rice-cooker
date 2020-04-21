FROM php:7.3-fpm

RUN apt-get update --fix-missing && \
    apt-get install -y curl wget build-essential libxml2-dev libzip-dev zip libgmp-dev

RUN docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install pdo pdo_mysql mysqli bcmath ctype json mbstring xml zip gmp

# xdiff extension
RUN cd ~/ && \
    wget 'http://www.xmailserver.org/libxdiff-0.23.tar.gz' && \
    tar -xvzf libxdiff-0.23.tar.gz && \
    cd libxdiff-0.23 && \
    ./configure && \
    make && \
    \
    make install && \
    wget 'https://pecl.php.net/get/xdiff-2.0.1.tgz' && \
    tar -xvzf xdiff-2.0.1.tgz && \
    cd xdiff-2.0.1 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    \
    echo ";xdiff-ext" >> "$PHP_INI_DIR/php.ini" && \
    echo "extension=xdiff.so" >> "$PHP_INI_DIR/php.ini"

RUN usermod -u 1000 www-data

