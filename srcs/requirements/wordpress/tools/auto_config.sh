#! /bin/sh

sleep 7;

if [ -f wp-config.php ];
then
    echo "Configuration already exists"
else

    wp config create --allow-root \
                --dbname=$SQL_DATABASE \
                --dbuser=$SQL_USER \
                --dbpass=$SQL_PASSWORD \
                --dbhost=mariadb --path='/var/www/wordpress';
    
    wp core install --allow-root --url=thole.42.fr --title=Inception --admin_user=$WP_ADMIN --admin_email=$WP_ADMIN_MAIL --admin_password=$WP_ADMIN_PASS ;
    
    wp user create --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=editor --porcelain;
fi

php-fpm7.4 -F;
