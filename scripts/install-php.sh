#!/usr/bin/env ash

# Installing Composer
install-php-extensions @composer-${COMPOSER_VERSION} imagick zip
# note: install-php-extensions installs are much easier than docker-php-ext-install

# Installing PHP Extensions
docker-php-ext-configure imap --with-imap --with-imap-ssl

docker-php-ext-configure opcache --enable-opcache &&
  docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp &&
  docker-php-ext-configure intl &&
  docker-php-ext-install -j "$(nproc)" \
    mysqli \
    pdo_mysql \
    sockets \
    bz2 \
    pcntl \
    bcmath \
    exif \
    imap

# note: for some reason if we build gd,intl with the rest of the extensions it will trow an error in php -v
docker-php-ext-install -j "$(nproc)" gd
docker-php-ext-install -j "$(nproc)" intl

# Enable production environment
mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
