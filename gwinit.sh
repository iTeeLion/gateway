#!/bin/bash

passwd root

read -p "Hostname: " HOSTNAME
hostname $HOSTNAME
echo "$HOSTNAME" > /etc/hostname

read -p "New user: " USER
useradd -m -U -G sudo -s /bin/bash $USER
passwd $USER

chown -R $USER:$USER /home/$USER
mkdir /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/*

echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

mkdir /home/$USER/.ssh
read -p -s "SSH key: " SSH_KEY
echo "$SSH_KEY" > /home/$USER/.ssh/authorized_keys

read -p "SSH port: " SSH_PORT
sudo sed -i 's/^#*Port .*/Port $SSH_PORT/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

sudo apt upgrade -y

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
