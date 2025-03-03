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
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&
	chmod +x wp-cli.phar &&
	mv wp-cli.phar /usr/local/bin/wp

wp config set WP_REDIS_HOST "redis" --add --allow-root
wp config set WP_REDIS_PORT "6379" --add --allow-root
wp config set WP_CACHE "true" --allow-root

wp install redis-cache --allow-root --path="/var/www/wordpress"
wp plugin activate redis-cache --allow-root --path="/var/www/wordpress/"
wp redis enable --allow-root

chown -R www-data:www-data /var/www/wordpress

exec php-fpm7.4 -F
