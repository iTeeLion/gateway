# Gateway install scripts

### Before installation
```
apt update && apt install -y curl
```

### Basic node preparation:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/init_node.sh && chmod +x ./init_node.sh && ./init_node.sh
```

### Install 3xui:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_3xui.sh && chmod +x ./install_3xui.sh && ./install_3xui.sh
```

### Install RemnaWave:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_remnawave.sh && chmod +x ./install_remnawave.sh && ./install_remnawave.sh
```

<details>
  <summary>Update remnawave</summary>

  ```
  cd /opt/remnawave && curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/remnawave/upgrade.sh && chmod +x ./upgrade.sh && ./upgrade.sh
  ```
</details>

<details>
  <summary>Update remnanode</summary>

  ```
  cd /opt/remnanode && curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/remnanode/upgrade.sh && chmod +x ./upgrade.sh && ./upgrade.sh
  ```
</details>

### Install MTProto:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_mtproto.sh && chmod +x ./install_mtproto.sh && ./install_mtproto.sh
```
