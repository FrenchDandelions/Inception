#! /bin/sh

sleep 3;

if [ ! -f "/var/www/wordpress-6.5.3/wp-config.php" ]; then

    wp config create --allow-root \
                --dbname=$SQL_DATABASE \
                --dbuser=$SQL_USER \
                --dbpass=$SQL_PASSWORD \
                --dbhost=mariadb --path='/var/www/wordpress-6.5.3';
    
    wp core install --allow-root --url=localhost --title=Inception --admin_user=$WP_ADMIN --admin_email=$WP_ADMIN_MAIL --admin_password=$WP_ADMIN_PASS --path='/var/www/wordpress-6.5.3';
    
    wp user create --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=editor --path='/var/www/wordpress-6.5.3';
fi

exec /usr/sbin/php-fpm7.4 -F;
