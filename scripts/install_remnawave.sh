#!/bin/bash

update_packages() {
    apt update && apt upgrade -y
}

install_docker() {
    sudo curl -fsSL https://get.docker.com | sh
}

install_remnawave() {
    mkdir /opt/remnawave && cd /opt/remnawave
    curl -o docker-compose.yml https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/remnawave/docker-compose.yml
    curl -o .env https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/remnawave/.env.sample
}

main() {
    update_packages
    install_docker
    install_remnawave
}

main
