Network mode host 3X-UI:
```
services:
  3x-ui:
    image: ghcr.io/mhsanaei/3x-ui:latest
    container_name: 3x-ui
    hostname: yourhostname
    volumes:
      - $PWD/db/:/etc/x-ui/
      - $PWD/cert/:/root/cert/
    environment:
      XRAY_VMESS_AEAD_FORCED: "false"
      X_UI_ENABLE_FAIL2BAN: "true"
    tty: true
    network_mode: host
    restart: unless-stopped
```

Docker open x-ui menu:
```
sudo su
cd /opt/3x-ui/
docker exec -it 3xui_app sh -c 'x-ui'
```

Windows flush DNS
```
ipconfig /flushdns
```
