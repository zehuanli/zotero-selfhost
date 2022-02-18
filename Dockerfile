# Use the official Docker Hub Ubuntu 18.04 base image
FROM ubuntu:18.04

# Update the base image
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade

# Setup PHP5
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pkg-config re2c
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php7.2 sudo wget mysql-client curl unzip python python-pip git
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php7.2-cli php7.2-xml php7.2-mysql php7.2-pgsql php7.2-json php7.2-curl php7.2-mbstring php7.2-intl php7.2-dev composer vim php-http-request2 php-igbinary php-msgpack
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install npm nodejs

RUN sed -i 's/memory_limit = 128M/memory_limit = 1G/g' /etc/php/7.2/apache2/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php/7.2/apache2/php.ini
RUN sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.2/apache2/php.ini
RUN sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.2/cli/php.ini
RUN sed -i 's/display_errors = On/display_errors = Off/g' /etc/php/7.2/apache2/php.ini
RUN sed -i 's/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/g' /etc/php/7.2/apache2/php.ini

# Setup PHP mods
RUN phpenmod igbinary
RUN phpenmod msgpack

# Setup Apache2
RUN a2enmod headers
RUN a2enmod rewrite
RUN a2dissite 000-default

# Copy server programs
COPY ./src/server/dataserver/ /var/www/zotero/
RUN cd /var/www/zotero && composer install

COPY ./src/server/stream-server/ /var/www/stream-server/
RUN cd /var/www/stream-server && npm i
COPY ./src/server/tinymce-clean-server/ /var/www/tinymce-clean-server/
RUN cd /var/www/tinymce-clean-server && npm i

# Expose and entrypoint
COPY ./config/entrypoint.sh /
RUN chmod +x /entrypoint.sh
EXPOSE 80/tcp
EXPOSE 81/TCP
ENTRYPOINT ["/entrypoint.sh"]
