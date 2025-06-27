RUN:
```
apt update \
&& apt install -y curl \
&& curl -O https://raw.githubusercontent.com/iTeeLion/gateway/refs/heads/main/gwinit.sh \
&& chmod +x ./gwinit.sh \
&& ./gwinit.sh
```
