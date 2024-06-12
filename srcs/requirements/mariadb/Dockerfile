FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server \
&& rm -rf /var/lib/apt/lists/*

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

VOLUME [ "/var/lib/mysql" ]

CMD [ "/usr/local/bin/script.sh" , "mysqld_safe" ]
