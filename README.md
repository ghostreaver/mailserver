## Onion Server

Setup for a server hosting Postfix service based on Ubuntu 22.04 server freshly installed and using Python as mailer to blast the email.

* * *

#### Prepare the environment

Change user password

```shell
passwd <username>
```

Configure APT sources

```shell
sudo add-apt-repository -y main && sudo add-apt-repository -y restricted && sudo add-apt-repository -y universe && sudo add-apt-repository -y multiverse
```

Keep system safe

```shell
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get -y remove && sudo apt-get -y autoremove
sudo apt-get -y clean && sudo apt-get -y autoclean
```

Disable error reporting

```shell
sudo sed -i "s/enabled=1/enabled=0/" /etc/default/apport
```

Edit SSH settings

```shell
sudo sed -i "s/#Port 22/Port 49622/" /etc/ssh/sshd_config
sudo sed -i "s/#LoginGraceTime 2m/LoginGraceTime 2m/" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/#StrictModes yes/StrictModes yes/" /etc/ssh/sshd_config
sudo systemctl restart sshd.service
```

Install Postfix on Ubuntu Server

```shell
sudo apt-get -y install postfix mailutils
sudo sed -i s/"^inet_interfaces = .*"/"inet_interfaces = loopback-only"/g /etc/postfix/main.cf
sudo systemctl restart postfix.service
sudo systemctl status postfix.service
```

Send a test email

```shell
echo "This is the body of the email" | mail -s "This is the subject line" <address@example.com>
```

Enabling SMTP Encryption

```shell
sudo apt-get -y install certbot
sudo certbot certonly --standalone --rsa-key-size 4096 --agree-tos --preferred-challenges http -d <domain-name>
sudo postconf -e 'smtpd_tls_cert_file = /etc/letsencrypt/live/<domain-name>/fullchain.pem'
sudo postconf -e 'smtpd_tls_key_file = /etc/letsencrypt/live/<domain-name>/privkey.pem'
echo "This is the body of an encrypted email" | mail -s "This is the subject line" <address@example.com>
```

Install Python

```shell
sudo apt-get -y install python3-flask python3-future python3-geoip python3-httplib2 python3-nmap python3-numpy python3-paramiko python3-pip python3-psutil python3-pycurl python3-pyqt5 python3-requests python3-scapy python3-scipy python3-setuptools python-socks python3-urllib3 python3-virtualenv python3-wheel
sudo ln -s /usr/bin/python3 /usr/bin/python
```

Install `Simple Mailer`

```shell
cd $HOME
git clone https://github.com/ghostreaver/simplemailer
```

To use `Simple Mailer`, simply run the following command

```shell
cd simplemailer
python simplemailer.py
```

* * *

#### Conclusion

We can now send our email using **Simple Mailer** or installing any additional tool such as `sendemail`.