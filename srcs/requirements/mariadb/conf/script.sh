#!/bin/bash

service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS \`$MYSQL_USER\`@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO \`$MYSQL_USER\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
fi

# restart mariadb
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
