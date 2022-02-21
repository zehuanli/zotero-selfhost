#!/bin/sh

if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$ADMIN_HASH" ]; then
	echo "Environment variables not set"
	exit 1
fi

MYSQL="mysql -h $DB_HOST -P 3306 -u $DB_USER -p$DB_PASS"

#echo "SET @@global.innodb_large_prefix = 1;" | $MYSQL
#echo "SET GLOBAL sql_mode='' " | $MYSQL
#echo "set global sql_mode = '' " | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_master" | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_shard_1" | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_shard_2" | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_ids" | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_www" | $MYSQL

echo "CREATE DATABASE zotero_master" | $MYSQL
echo "CREATE DATABASE zotero_shard_1" | $MYSQL
echo "CREATE DATABASE zotero_shard_2" | $MYSQL
echo "CREATE DATABASE zotero_ids" | $MYSQL
echo "CREATE DATABASE zotero_www" | $MYSQL

# Load in master schema
$MYSQL zotero_master < master.sql
$MYSQL zotero_master < coredata.sql

# Set up shard info
echo "INSERT INTO shardHosts VALUES (1, '$DB_HOST', 3306, 'up');" | $MYSQL zotero_master
echo "INSERT INTO shards VALUES (1, 1, 'zotero_shard_1', 'up', '1');" | $MYSQL zotero_master
echo "INSERT INTO shards VALUES (2, 1, 'zotero_shard_2', 'up', '1');" | $MYSQL zotero_master

# Create first group & user
echo "INSERT INTO libraries VALUES (1, 'user', CURRENT_TIMESTAMP, 0, 1)" | $MYSQL zotero_master
echo "INSERT INTO libraries VALUES (2, 'group', CURRENT_TIMESTAMP, 0, 2)" | $MYSQL zotero_master
echo "INSERT INTO users VALUES (1, 1, 'admin')" | $MYSQL zotero_master
echo "INSERT INTO groups VALUES (1, 2, 'Shared', 'shared', 'Private', 'members', 'all', 'members', '', '', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1)" | $MYSQL zotero_master
echo "INSERT INTO groupUsers VALUES (1, 1, 'owner', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)" | $MYSQL zotero_master

# Load in www schema
$MYSQL zotero_www < www.sql

echo "INSERT INTO users VALUES (1, 'admin', '$ADMIN_HASH', 'normal')" | $MYSQL zotero_www
echo "INSERT INTO users_email (userID, email) VALUES (1, 'admin@zotero.org')" | $MYSQL zotero_www
echo "INSERT INTO storage_institutions (institutionID, domain, storageQuota) VALUES (1, 'zotero.org', 10000)" | $MYSQL zotero_www
echo "INSERT INTO storage_institution_email (institutionID, email) VALUES (1, 'contact@zotero.org')" | $MYSQL zotero_www


# Load in shard schema
cat shard.sql | $MYSQL zotero_shard_1
cat triggers.sql | $MYSQL zotero_shard_1
cat shard.sql | $MYSQL zotero_shard_2
cat triggers.sql | $MYSQL zotero_shard_2

echo "INSERT INTO shardLibraries VALUES (1, 'user', CURRENT_TIMESTAMP, 0)" | $MYSQL zotero_shard_1
echo "INSERT INTO shardLibraries VALUES (2, 'group', CURRENT_TIMESTAMP, 0)" | $MYSQL zotero_shard_2

# Load in schema on id servers
$MYSQL zotero_ids < ids.sql

# Fix table structure due to new version
echo "ALTER TABLE libraries ADD hasData TINYINT( 1 ) NOT NULL DEFAULT '0' AFTER version , ADD INDEX (hasData)" | $MYSQL zotero_master
echo "UPDATE libraries SET hasData=1 WHERE version > 0 OR lastUpdated != '0000-00-00 00:00:00'" | $MYSQL zotero_master
