#!/bin/bash

echo '
      Welkom, het script is nu geopend. Kies een nummer

      Typ 1 om apache2 te installeren.
      Typ 2 om de mysql-server te installeren.
      Typ 3 om php te installeren.
      Typ 4 om Nextcloud te downloaden en te installeren.
      Typ 5 om de Nextcloud database aan te maken.
      Typ 6 om een gebruiker voor de Nextcloud database te maken.
      Typ 7 om de firewall op te zetten.
      Typ 8 om Fail2ban te installeren.
      Typ 9 om LetsEncrypt te installeren.
      Typ opnieuwladen om het script opnieuw te laden. '


read a
if [ "$a" = "1" ]
then
  echo "Apache installeren."
  sudo apt install apache2
fi

read a
if [ "$a" = "2" ]
then
  echo "Mysql installeren."
  sudo apt install mysql-server
  sudo apt install mariadb-server
fi

read a
if [ "$a" = "3" ]
then
  echo "PHP installeren."
  sudo apt install php libapache2-mod-php php-mysql
fi

read a
if [ "$a" = "4" ]
then
sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
sudo apt install unzip

sudo unzip nextcloud-21.0.1.zip -d /var/www/
sudo chown www-data:www-data /var/www/nextcloud/ -R
sudo mysql
fi

read a
if [ "$a" = "5" ]
then
  echo "Database aanmaken"
sudo create database nextcloud;
fi

read a
if [ "$a" = "6" ]
then
  echo "Gebruiker aanmaken"
create user nextclouduser@localhost identified by 'your-password';
grant all privileges on nextcloud.* to nextclouduser@localhost identified by 'your-password';
fi

read a
if [ "$a" = "7" ]
then
  echo "De firewall wordt nu opgezet"
  sudo iptables -A INPUT -p tcp --dport 21 -j ACCEPT
  sudo iptables -A INPUT -p tcp --dport 20 -j ACCEPT
  sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  sudo ufw allow 'Apache Full'
  sudo ufw delete allow 'Apache'
fi

read a
if [ "$a" = "8" ]
then
  echo "Fail2ban installeren"
sudo apt update
sudo apt install fail2ban
sudo systemctl status fail2ban
fi

read a
if [ "$a" = "8" ]
then
  echo "Certificaat genereren met letsencrypt"
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
fi

read opnieuwladen
while [ "$opnieuwladen" = "Y" "$opnieuwladen"  = "J" ]
do
 echo "Het script begint opnieuw"
 read opnieuwladen
done
