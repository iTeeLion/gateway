To run scripts need to update OS and install cURL:
```
apt update && apt install -y curl
```

Basic node preparation:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/init_node.sh && chmod +x ./init_node.sh && ./init_node.sh
```

Install 3xui:
```
curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/scripts/install_3xui.sh && chmod +x ./install_3xui.sh && ./install_3xui.sh
```
