#!/bin/bash

change_root_password() {
  passwd root
}

install_packages() {
  apt update && apt upgrade -y && apt install -y sudo mc htop fail2ban
}

change_hostname() {
  read -p "Hostname: " HOSTNAME
  hostname $HOSTNAME
  echo "$HOSTNAME" > /etc/hostname
}

add_user() {
  read -p "New user: " USER
  useradd -m -U -G sudo -s /bin/bash $USER
  passwd $USER
}

add_user_key() {
  mkdir /home/$USER/.ssh
  read -s -p "SSH key: " SSH_KEY
  echo "$SSH_KEY" > /home/$USER/.ssh/authorized_keys
  chmod 700 /home/$USER/.ssh
  chmod -R 600 /home/$USER/.ssh/*
  chown -R $USER:$USER /home/$USER
}

allow_user_sudo() {
  echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
}

setup_ssh_port() {
  read -p "SSH port: " SSH_PORT
  sudo sed -i 's/^#*Port .*/Port $SSH_PORT/' /etc/ssh/sshd_config
}

disable_ssh_root() {
  sudo sed -i 's/^#*PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
}

setup_ssh() {
  setup_ssh_port
  disable_ssh_root
  systemctl restart sshd
}

install_docker() {
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

main() {
  change_root_password
  install_packages
  change_hostname
  add_user
  add_user_key
  allow_user_sudo
  setup_ssh
  install_docker
}

main
