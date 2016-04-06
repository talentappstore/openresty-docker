FROM ubuntu:14.04

ENV OPENRESTY_VERSION 1.9.7.4
ENV OPENSSL_VERSION 1.0.2g

RUN sudo apt-get update && \
    sudo apt-get -y install \
        curl \
        libreadline-dev \
        libncurses5-dev \
        libpcre3-dev \
        perl \
        make \
        zlib1g-dev \
        build-essential && \
    curl https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz | tar -xz && \
    curl https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz | tar -xz && \
    cd openresty-${OPENRESTY_VERSION} && \
    ./configure --with-openssl=/openssl-${OPENSSL_VERSION} && \
    make && \
    sudo make install && \
    cd .. && \
    rm -r openresty-${OPENRESTY_VERSION} && \
    rm -r openssl-${OPENSSL_VERSION} && \
    sudo mkdir -p /srv/nginx/logs

WORKDIR /srv

VOLUME ["/srv/nginx/conf", "/srv/nginx/logs", "/srv/nginx/lua"]

COPY start-nginx.sh start-nginx.sh

EXPOSE 80 443

CMD ["sh", "start-nginx.sh"]
