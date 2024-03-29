#!/usr/bin/env ash
apk --update add --no-cache --virtual .build-deps \
  gnupg \
  zlib-dev \
  libjpeg-turbo-dev \
  freetype-dev \
  libpng-dev \
  libxml2-dev \
  bzip2-dev \
  libzip-dev

# Add Production Dependencies
apk add --update --no-cache \
  libpng \
  freetype \
  libjpeg-turbo \
  mysql-client \
  libwebp-dev \
  icu-dev \
  su-exec \
  sudo \
  nginx \
  supervisor \
  imap-dev
