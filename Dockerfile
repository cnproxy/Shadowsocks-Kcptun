FROM alpine:edge                                                                                                                                                        
LABEL maintainer="cnproxy <freedomain888@gmail.com>"                                                                                                                            
                                                                                                                                                                        
ARG KCP_VERSION=20170525                                                                                                                                                
ENV KCP_VERSION $KCP_VERSION                                                                                                                                            
ENV KCP_DOWNLOAD_URL https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-amd64-${KCP_VERSION}.tar.gz                                         

WORKDIR /opt/shadowsocks-kcptun

RUN apk upgrade --update \
    && apk add bash curl git python python-dev py-pip supervisor && rm -rf /tmp/* /var/cache/apk/* \
    && pip install --upgrade pip && pip install git+https://github.com/shadowsocks/shadowsocks.git@master \
    && mkdir -p /etc/shadowsocks/ \
    && curl -sSLO ${KCP_DOWNLOAD_URL} \
    && tar -zxf kcptun-linux-amd64-${KCP_VERSION}.tar.gz \
    && mv server_linux_amd64 /usr/bin/server_linux_amd64 \
    && rm -rf client_linux_amd64 \
    && rm -rf kcptun-linux-amd64-${KCP_VERSION}.tar.gz                                                                                                                  
                                                                                                                                                                        
ADD supervisord.conf /etc/

VOLUME ["/etc/supervisor/conf.d", "/etc/shadowsocks"]
                                                                                                                                                             
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
