# Shadowsocks-Kcptun

#### Usage

```
docker run --privileged --name shadowsocks --restart=unless-stopped \
    -p 8888-8898:8888-8898 -p 18888-18898:18888-18898/udp \
    -v ~/.docker/shadowsocks-kcptun/supervisor:/etc/supervisor/conf.d \
    -v ~/.docker/shadowsocks-kcptun/shadowsocks:/etc/shadowsocks -d cnproxy/shadowsocks-kcptun
```
