FROM debian:bullseye

RUN apt update && apt upgrade -y && apt-get install -y wget \
    && apt-get install -y php7.4 php-fpm php-mysql \
    && apt clean

RUN wget https://wordpress.org/wordpress-6.5.3.tar.gz -P /var/www

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

WORKDIR /var/www/
RUN tar -xzf wordpress-6.5.3.tar.gz && rm wordpress-6.5.3.tar.gz

WORKDIR /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

COPY ./tools/auto_config.sh /usr/bin/.

RUN chmod +x /usr/bin/auto_config.sh

RUN chown -R root:root /var/www/wordpress

EXPOSE 9000

CMD [ "/usr/bin/auto_config.sh" ]
