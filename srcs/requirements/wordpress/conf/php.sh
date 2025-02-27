#!/bin/sh

if ! grep -q "listen = 0.0.0.0:9000" /etc/php/7.4/fpm/pool.d/www.conf; then
	echo "listen = 0.0.0.0:9000" >>/etc/php/7.4/fpm/pool.d/www.conf
fi

sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

# BONUS REDIS
echo "extension=redis.so" >/etc/php/7.4/fpm/conf.d/redis.ini

if ! grep -q "define('WP_REDIS_HOST', 'redis');" wp-config.php; then
	echo "define('WP_REDIS_HOST', 'redis');" >>/var/www/wordpress/wp-config.php
	echo "define('WP_REDIS_PORT', 6379);" >>/var/www/wordpress/wp-config.php
	echo "define('WP_CACHE', true);" >>/var/www/wordpress/wp-config.php
fi

exec php-fpm7.4 -F
