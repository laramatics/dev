ARG NODE_VERSION=19-alpine
ARG PHP_VERSION=8.2-fpm-alpine
FROM node:${NODE_VERSION} AS node
FROM php:${PHP_VERSION}
LABEL maintainer="Pezhvak <pezhvak@imvx.org>"
# NOTE: ARGs before FROM cannot be accessed during build time (https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact)

WORKDIR /var/www/html

# Copy PHP Extension Installer (https://github.com/mlocati/docker-php-extension-installer)
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
COPY /configs/php.ini "$PHP_INI_DIR/conf.d/laramatics-container.ini"

# Copy NodeJS
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# Copy Scripts
COPY scripts /tmp
RUN chmod +x /tmp/*.sh
COPY scripts/start-container /usr/local/bin
RUN chmod +x /usr/local/bin/start-container

# Install
RUN ash /tmp/install-packages.sh
RUN ash /tmp/install-php.sh

# Setting up Supervisor
RUN sed -i "s/*.ini/*.conf/" /etc/supervisord.conf
RUN sed -i "s/;pidfile=/pidfile=/" /etc/supervisord.conf
RUN mkdir /etc/supervisor.d/

# Cleanup
RUN ash /tmp/cleanup.sh
RUN rm -rf /tmp/*

# Serving
EXPOSE 80
EXPOSE 5173

# Services supervisor config
COPY ./configs/supervisord.conf /etc/supervisor.d/supervisord.conf

# Override nginx's default config
COPY ./configs/nginx.conf /etc/nginx/http.d/default.conf

CMD ["/usr/bin/supervisord", "-n","-c", "/etc/supervisord.conf"]
ENTRYPOINT ["start-container"]
