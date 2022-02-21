#!/bin/sh

if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$ADMIN_HASH" ]; then
        echo "Environment variables not set"
        exit 1
fi

MYSQL="mysql -h $DB_HOST -P 3306 -u $DB_USER -p$DB_PASS"

echo "INSERT INTO libraries VALUES (${1}, 'user', CURRENT_TIMESTAMP, 0, 1)" | $MYSQL zotero_master
echo "INSERT INTO users VALUES (${1}, ${1}, '${2}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)" | $MYSQL zotero_master
echo "INSERT INTO groupUsers VALUES (1, ${1}, 'member', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)" | $MYSQL zotero_master
echo "INSERT INTO users VALUES (${1}, '${2}', '$ADMIN_HASH')" | $MYSQL zotero_www
echo "INSERT INTO users_email (userID, email) VALUES (${1}, '${4}')" | $MYSQL zotero_www
echo "INSERT INTO shardLibraries VALUES (${1}, 'user', 0, 0)" | $MYSQL zotero_shard_1

# Set user's personal quota to a large value
echo "INSERT INTO storageAccounts VALUES (${1}, 10000000, '2038-01-01 00:00:00')" | $MYSQL zotero_master;
