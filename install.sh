#!/usr/bin/env bash

## Configure APT sources
## ---------------------
sudo add-apt-repository -y main && sudo add-apt-repository -y restricted && sudo add-apt-repository -y universe && sudo add-apt-repository -y multiverse

## Keep system safe
## ----------------
sudo apt -y update && sudo apt -y upgrade && sudo apt -y dist-upgrade
sudo apt -y remove && sudo apt -y autoremove
sudo apt -y clean && sudo apt -y autoclean

## Disable error reporting
## -----------------------
sudo sed -i "s/enabled=1/enabled=0/" /etc/default/apport

## Edit SSH settings
## -----------------
sudo sed -i "s/#Port 22/Port 49622/" /etc/ssh/sshd_config
sudo sed -i "s/#LoginGraceTime 2m/LoginGraceTime 2m/" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/#StrictModes yes/StrictModes yes/" /etc/ssh/sshd_config
sudo systemctl restart sshd.service

## Install Postfix on Ubuntu Server
## --------------------------------
sudo apt -y install postfix postfix-pcre mailutils
sudo systemctl restart postfix.service
sudo systemctl status postfix.service

## Enabling SMTP Encryption
## ------------------------
sudo apt -y install certbot
sudo certbot certonly --standalone --rsa-key-size 4096 --agree-tos --preferred-challenges http -d <domain-name>
sudo postconf -e 'smtpd_tls_cert_file = /etc/letsencrypt/live/<domain-name>/fullchain.pem'
sudo postconf -e 'smtpd_tls_key_file = /etc/letsencrypt/live/<domain-name>/privkey.pem'
echo "This is the body of an encrypted email" | mail -s "This is the subject line" <address@example.com>

## Install Python
## --------------
sudo apt -y install python3-flask python3-future python3-geoip python3-httplib2 python3-nmap python3-numpy python3-paramiko python3-pip python3-psutil python3-pycurl python3-pyqt5 python3-requests python3-scapy python3-scipy python3-setuptools python3-socks python3-urllib3 python3-virtualenv python3-wheel
sudo ln -s /usr/bin/python3 /usr/bin/python

## Install `Simple Mailer`
## -----------------------
mkdir -p $HOME/gitscripts
cd $HOME/gitscripts
git clone https://github.com/neoslab/simplemailer

## Reboot server
## -------------
sudo reboot now