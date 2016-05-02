FROM ubuntu:16.04

ENV OPENRESTY_VERSION 1.9.7.4

COPY openresty.asc openresty.asc

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        libreadline-dev \
        libncurses5-dev \
        libpcre3-dev \
        perl \
        make \
        zlib1g-dev \
        libssl-dev \
        build-essential && \
    curl -O https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz && \
    curl -O https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz.asc && \
    gpg --keyserver keys.gnupg.net --recv-key A0E98066 && \
    gpg --verify openresty-${OPENRESTY_VERSION}.tar.gz.asc openresty-${OPENRESTY_VERSION}.tar.gz && \
    ls && \
    tar -xvzf openresty-${OPENRESTY_VERSION}.tar.gz && \
    cd openresty-${OPENRESTY_VERSION} && \
    ./configure \
        --with-pcre-jit \
        --without-http_memcached_module \
        --without-http_uwsgi_module \ 
        --without-http_scgi_module \
        --without-http_ssi_module \
        --without-http_auth_basic_module && \
    make && \
    make install && \
    cd .. && \
    rm -r openresty-${OPENRESTY_VERSION}* && \
    mkdir -p /srv/nginx/logs && \
    ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin && \
    ln -sf /dev/stdout /srv/nginx/logs/access.log && \
    ln -sf /dev/stderr /srv/nginx/logs/error.log

WORKDIR /srv

COPY start-nginx.sh start-nginx.sh
COPY generate-dhparam.sh generate-dhparam.sh

VOLUME ["/srv/nginx/conf", "/srv/nginx/lua"]

EXPOSE 80 443

CMD ["sh", "start-nginx.sh"]
