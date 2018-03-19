# Shadowsocks-Kcptun
![Build Status](https://travis-ci.org/cnproxy/shadowsocks-kcptun.svg?branch=master)

#### Usage
mkdir -p ~/.docker/shadowsocks-kcptun/supervisor  
mkdir -p ~/.docker/shadowsocks-kcptun/shadowsocks

vi ~/.docker/shadowsocks-kcptun/shadowsocks/shadowsocks.json

```
{
  "server": "0.0.0.0",
  "timeout": 300,
  "method": "aes-256-cfb",
  "fast_open": false,                                                                                          
  "workers": 1,                                                                                                                                                          
  "port_password": {                                                                                               
     "8888": "cnproxy"
  }                                                                                                                                   
}
```

```
docker run --privileged --name shadowsocks --restart=unless-stopped \
    -p 8888-8898:8888-8898 -p 18888-18898:18888-18898/udp \
    -v ~/.docker/shadowsocks-kcptun/supervisor:/etc/supervisor/conf.d \
    -v ~/.docker/shadowsocks-kcptun/shadowsocks:/etc/shadowsocks -d cnproxy/shadowsocks-kcptun
```
