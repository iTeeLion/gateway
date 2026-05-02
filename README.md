# Gateway install scripts

## First things first:

We need curl before any installation:
```
apt update && apt install -y curl
```

Configure node:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/init_node.sh && chmod +x ./init_node.sh && ./init_node.sh
```

## 3xui:

Install:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_3xui.sh && chmod +x ./install_3xui.sh && ./install_3xui.sh
```
Update:
...soon...

## RemnaWave:

Install:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_remnawave.sh && chmod +x ./install_remnawave.sh && ./install_remnawave.sh
```

Update:
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

## MTProto proxy:
Install:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_mtproto.sh && chmod +x ./install_mtproto.sh && ./install_mtproto.sh
```
Generate FakeTLS key:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/mtproto/faketls.sh && chmod +x ./faketls.sh && ./faketls.sh
```
