#!/bin/bash

# HOW TO RUN THIS SCRIPT! $ ./setup-apache2-ubnt.sh 192.168.2.9 1234567890

# store database ip address configuration as variable
DB_HOST=$1
DB_PASSWORD=$2

# do update & then install httpd server, git, and mysql client
sudo apt-get update -y && sudo apt-get install apache2 git mariadb-client php php-mysql -y

# do git clone apps from source code
sudo git clone https://github.com/sdcilsy/sosial-media.git

# move sosial media content to /var/www/html
sudo mv sosial-media/* /var/www/html

# check if there is no input and return exit code
function checkPassingArguments() {
        if [[ -z $DB_HOST ]]; then
            echo "##########################"
            echo "##        ERROR         ##"
            echo "##########################"
            echo "Please pass an argument of database host ip address"
            echo "Error: exit status 1"
            return 1
        elif [[ -n $DB_HOST ]]; then
            # replace database host with ip address of database server
            sudo sed -i "s/localhost/${DB_HOST}/" /var/www/html/config.php
        fi
}

# run function
checkPassingArguments

# delete default apache2 index.html
sudo rm /var/www/html/index.html

# Dump database dependecy
sudo mysql -h ${DB_HOST} -u devopscilsy -p${DB_PASSWORD} dbsosmed < /var/www/html/dump.sql

# restart httpd daemon 
sudo systemctl enable apache2 && sudo systemctl restart apache2