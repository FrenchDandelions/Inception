#!/bin/sh

# Start the MariaDB service
echo "Starting MariaDB service..."
service mariadb start

# Wait for MariaDB to be fully up and running
sleep 2

# Check the current users and their host
echo "Checking current users..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "SELECT User, Host, Password FROM mysql.user;"

# Create a database if it does not exist
echo "Creating database if it does not exist..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create a user if it does not exist, identified by the specified password
echo "Creating user if it does not exist..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant all privileges on the specified database to the specified user, allowing access from any host
echo "Granting privileges..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Change the password for the 'root' user on the local machine
echo "Changing root password..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

# Verify the root password change
echo "Verifying root password change..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "SELECT User, Host, Password FROM mysql.user WHERE User='root';"

# Verify that the database and users were set up correctly
echo "Showing databases..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "SHOW DATABASES;"
echo "Showing Users..."
mariadb -uroot -p"$SQL_ROOT_PASSWORD" -e "SELECT user FROM mysql. user;"

# Shut down MariaDB, waiting for all slaves to catch up
echo "Shutting down MariaDB..."
mariadb-admin -uroot -p"$SQL_ROOT_PASSWORD" --wait-for-all-slaves shutdown

# Start the MariaDB server in a safe mode
echo "Starting MariaDB in safe mode..."
mysqld_safe
