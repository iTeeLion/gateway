#!/bin/bash

apt install -y snapd
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot certonly --standalone

apt install git
cd /srv
git clone https://github.com/MHSanaei/3x-ui.git
cd /srv/3x-ui
# ADD: - /etc/letsencrypt:/etc/letsencrypt (TO volumes)
docker compose up -d

# /etc/letsencrypt/live/DOMAINHERE/cert.pem
# /etc/letsencrypt/live/DOMAINHERE/privkey.pem
