#!/bin/bash

sudo apt-get update -y
sudo apt-get install mariadb-server -y
sudo mysql -e "CREATE USER 'devopscilsy'@'%' IDENTIFIED BY '1234567890';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'devopscilsy'@'%';"
sudo mysql -e "FLUSH PRIVILEGES"
sudo mysql -e "CREATE DATABASE dbsosmed"
sudo sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb && sudo systemctl enable mariadb