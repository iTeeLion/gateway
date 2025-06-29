#!/bin/bash

ask_hostname() {
    read -p "Hostname: " HOSTNAME
    if [ -z "$HOSTNAME" ]; then
        ask_hostname
    fi
}

install_certbot() {
    apt install -y snapd
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot
}

get_3xui() {
    apt install git
    cd /srv
    git clone https://github.com/MHSanaei/3x-ui.git
    cd /srv/3x-ui
    sed -i -E "s/^([[:space:]]*)#?[[:space:]]*hostname:[[:space:]]*.+/\1hostname: $HOSTNAME/" docker-compose.yml
    sed -i "/volumes:/a\      - /etc/letsencrypt:/etc/letsencrypt" docker-compose.yml
}

run_3xui() {
    cd /srv/3x-ui
    docker compose up -d
}

main() {
    ask_hostname
    install_certbot
    certbot certonly --standalone -d $HOSTNAME
    get_3xui
    run_3xui
}

main

