#!/bin/sh

# Env vars
export APACHE_RUN_USER=${RUN_USER}
export APACHE_RUN_GROUP=${RUN_GROUP}
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOG_DIR=/var/log/apache2

# Setup directories
chown -R ${RUN_USER}:${RUN_GROUP} /var/log/apache2
chown ${RUN_USER}:${RUN_GROUP} /var/www/zotero/tmp
mkdir -p /var/log/zotero/ && chown ${RUN_USER}:${RUN_GROUP} /var/log/zotero/

# Start Stream server
cd /var/www/stream-server && nodejs index.js &

# Start Clean server
cd /var/www/tinymce-clean-server && nodejs server.js &

# Start Apache2
exec apache2 -DNO_DETACH -k start
