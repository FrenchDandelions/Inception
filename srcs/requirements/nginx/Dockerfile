FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx

RUN mkdir -p /etc/nginx/ssl && apt install -y openssl

RUN rm -rf /etc/nginx/sites-enabled/default

COPY ./conf/thole.42.fr /etc/nginx/sites-available/thole.42.fr

RUN ln -s /etc/nginx/sites-available/thole.42.fr /etc/nginx/sites-enabled/thole.42.fr

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=thole.42.fr/CN=thole.42.fr/UID=thole"

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
