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
    curl -o Makefile https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/remnawave/Makefile

    sed -i "s/^JWT_AUTH_SECRET=.*/JWT_AUTH_SECRET=$(openssl rand -hex 64)/" .env && sed -i "s/^JWT_API_TOKENS_SECRET=.*/JWT_API_TOKENS_SECRET=$(openssl rand -hex 64)/" .env
    sed -i "s/^METRICS_PASS=.*/METRICS_PASS=$(openssl rand -hex 64)/" .env && sed -i "s/^WEBHOOK_SECRET_HEADER=.*/WEBHOOK_SECRET_HEADER=$(openssl rand -hex 64)/" .env
    pw=$(openssl rand -hex 24) && sed -i "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=$pw/" .env && sed -i "s|^\(DATABASE_URL=\"postgresql://postgres:\)[^\@]*\(@.*\)|\1$pw\2|" .env
}

install_npm() {
    mkdir /opt/npm && cd /opt/npm
    curl -o docker-compose.yml https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/nginx-proxy-manager/docker-compose.yml
    curl -o .env https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/nginx-proxy-manager/.env.sample
    curl -o Makefile https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/nginx-proxy-manager/Makefile
    
    pw=$(openssl rand -hex 24) && sed -i "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=$pw/" .env && sed -i "s|^\(DATABASE_URL=\"postgresql://postgres:\)[^\@]*\(@.*\)|\1$pw\2|" .env
}

message() {
    echo "finish .env filling and run:"
    echo "cd /opt/remnawave && docker compose up -d && docker compose logs -f -t"
}

main() {
    update_packages
    
    install_docker

    docker network create proxy-network
    
    install_remnawave
    
    install_npm

    message
}

main
