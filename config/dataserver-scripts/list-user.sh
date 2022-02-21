#!/bin/sh

if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
        echo "Environment variables not set"
        exit 1
fi

MYSQL="mysql -h $DB_HOST -P 3306 -u $DB_USER -p$DB_PASS"

echo "SELECT * FROM users;" | $MYSQL zotero_master
