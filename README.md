# shadowsocks-kcptun
![Build Status](https://travis-ci.org/cnproxy/shadowsocks-kcptun.svg?branch=master)

#### Usage
mkdir -p ~/.docker/shadowsocks-kcptun/supervisor  
mkdir -p ~/.docker/shadowsocks-kcptun/shadowsocks

vi ~/.docker/shadowsocks-kcptun/supervisor/shadowsocks.conf
```
[program:shadowsocks]
command=ssserver -c /etc/shadowsocks/shadowsocks.json
user=root
```

#### shadowsocks suport Multi-port
vi ~/.docker/shadowsocks-kcptun/shadowsocks/shadowsocks.json

```
{
  "server": "0.0.0.0",
  "timeout": 300,
  "method": "aes-256-cfb",
  "fast_open": false,                                                                                          
  "workers": 1,                                                                                                                                                          
  "port_password": {                                                                                               
     "8888": "cnproxy",
     "8889": "test"
  }                                                                                                                                   
}
```

#### kcptun: Multi-port write multiple configuration files

vi ~/.docker/shadowsocks-kcptun/supervisor/kcptun18888.conf
```
[program:kcptun18888]
command=server_linux_amd64 -t "127.0.0.1:8888" -l ":18888" -key cnproxy -mode fast2 -nocomp -crypt aes
user=root
```

#### Run with Docker
```
docker run --privileged --name shadowsocks --restart=unless-stopped \
    -p 8888-8898:8888-8898 -p 18888-18898:18888-18898/udp \
    -v ~/.docker/shadowsocks-kcptun/supervisor:/etc/supervisor/conf.d \
    -v ~/.docker/shadowsocks-kcptun/shadowsocks:/etc/shadowsocks -d cnproxy/shadowsocks-kcptun
```
