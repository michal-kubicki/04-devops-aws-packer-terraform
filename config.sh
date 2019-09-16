#!/bin/bash

# Set the time zone to Europe/London
sudo timedatectl set-timezone Europe/London

# Update & upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Install NTP server
sudo apt-get install ntp -y

# Print the last log-in time
sudo sed -i "/#PrintLastLog yes/c\PrintLastLog yes" /etc/ssh/sshd_config

# Install and setup fail2ban
sudo apt-get install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i "/bantime  = 10m/c\bantime  = 60m" /etc/fail2ban/jail.local
sudo sed -i "/maxretry = 5/c\maxretry = 2" /etc/fail2ban/jail.local

# Install The Apache HTTP Server
sudo apt-get install apache2 -y

# Enable Apache to automatically start at system boot time
sudo systemctl enable apache2

# Update firewall rules and open ports 80,443/tcp
sudo ufw allow in "Apache Full"

# Set www-data (Apache user) as the owner of document root
sudo chown www-data:www-data /var/www/html/ -R

# Install MariaDB Database Server
sudo apt-get install mariadb-server -y

# Enable MariaDB to automatically start at system boot time
sudo systemctl enable mariadb

# Install PHP 7.2
sudo apt-get install php7.2 libapache2-mod-php7.2 php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline -y

# Set the default page served by the server to index.php
sudo sed -i "s|DirectoryIndex index.html|DirectoryIndex index.php index.html|g" /etc/apache2/mods-available/dir.conf

# Create a test index.php file
echo '<?php phpinfo() ?>' | sudo tee -a /var/www/html/index.php

# Restart Apache
sudo systemctl restart apache2
