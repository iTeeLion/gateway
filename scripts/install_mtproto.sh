#!/bin/bash

mkdir /opt/mtproto

cd /opt/mtproto

curl -o .env https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/mtproto/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/mtproto/config.env
