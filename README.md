#openresty docker

Basic docker image for openresty, based on ubuntu and compiled with the latest version of OpenSSL.

Nginx configuration is held under `/srv/nginx` as

    /srv
      /nginx
        /conf
        /lua
        /logs
        ...

##Usage

Simply make a Dockerfile as follows (note that the working directory is `/srv`:

    FROM talentappstore/openresty

    COPY /path/to/my/nginx nginx

##Developement

Alternatively, to use a developement platform just add the relavent volumes:

    docker run \
        -d \
        -v /path/to/my/nginx:/srv/nginx \
        -p 80:80 \
        -p 443:443 \
        talentappstore/openresty
