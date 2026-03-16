#!/bin/bash

mkdir -p /opt/mtproto

cd /opt/mtproto

curl -o docker-compose.yml https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/mtproto/docker-compose.yml
curl -o config.env https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/configs/mtproto/config.env
