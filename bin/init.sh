#!/bin/sh

sudo docker-compose exec app-zotero bash -c 'cd /var/www/zotero/misc && ./init-mysql.sh'
sudo docker-compose exec app-zotero bash -c 'aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero'
