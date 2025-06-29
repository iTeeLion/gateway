#!/bin/bash

change_root_password() {
  echo "Let's change root password!"
  passwd root
}

install_packages() {
  echo "Installing packages..."
  apt update && apt install -y sudo mc htop fail2ban
}

upgrade_packages() {
  echo "Upgrade system..."
  apt upgrade -y
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

  read -s -p "SSH key (or leave empty to generate): " SSH_KEY
  echo " "
  if [ -z "$HOSTNAME" ]; then
    ssh-keygen -t ed25519 -f /home/$USER/.ssh/server.key
    cat /home/$USER/.ssh/server.key.pub >> /home/$USER/.ssh/authorized_keys
  else
    echo "$SSH_KEY" > /home/$USER/.ssh/authorized_keys
  fi
  
  echo "Setting user permissions..."
  chmod 700 /home/$USER/.ssh
  chmod -R 600 /home/$USER/.ssh/*
  chown -R $USER:$USER /home/$USER
}

allow_user_sudo() {
  echo "Granting user sudo access..."
  echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
}

setup_ssh_port() {
  read -p "SSH port: " SSH_PORT
  sed -i "s/^#*Port .*/Port $SSH_PORT/" /etc/ssh/sshd_config
}

disable_ssh_root() {
  sed -i "s/^#*PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
}

setup_ssh() {
  echo "Configuring SSH"
  setup_ssh_port
  disable_ssh_root
  systemctl restart sshd
}

install_docker() {
  echo "Install docker..."
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
  upgrade_packages
  install_docker
}

main

