#!/bin/sh

MYSQL="mysql -h $DB_HOST -P 3306 -u $DB_USER -p$DB_PASS"

echo "SELECT * FROM users;" | $MYSQL zotero_master
