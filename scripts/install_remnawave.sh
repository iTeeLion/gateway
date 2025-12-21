#!/bin/bash

update_packages() {
    apt update && apt upgrade -y
}

install_docker() {
    sudo curl -fsSL https://get.docker.com | sh
}

install_remnawave() {
    echo "ToDo"
}

main() {
    update_packages
    install_docker
    install_remnawave
}

main
