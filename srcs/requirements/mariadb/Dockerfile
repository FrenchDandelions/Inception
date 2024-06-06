FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./conf/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
