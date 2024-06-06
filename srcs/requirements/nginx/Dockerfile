FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx

RUN mkdir -p /etc/nginx/ssl && apt install -y openssl

RUN mkdir -p /var/run/nginx && rm -rf /etc/nginx/sites-enabled/default

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=thole.42.fr/UID=thole"

RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
