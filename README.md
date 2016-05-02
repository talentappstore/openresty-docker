# openresty docker

Basic docker image for openresty based on Ubuntu 16.04. The build is configured to be used as a reverse proxy for http requests, so protocols such as uwsgi and fastCGI have been disabled.

Nginx configuration is held under `/srv/nginx` as

    /srv
      /nginx
        /conf
        /lua
        /logs
        ...

## Usage

Simply make a Dockerfile as follows (note that the working directory is `/srv`:

    FROM talentappstore/openresty

    COPY /path/to/my/nginx nginx

In addition, the bash file `generate-dhparam.sh` is included to generate a 4096 bit Diffie Hellman parameter, placed in `/etc/ssl/certs/dhparam.pem`. If you wish to use this, you will have to run it yourself either in a `RUN` statement or as part of you command script. E.g.

    RUN ./generate-dhparam.sh


## Developement

Alternatively, to use a developement platform just add the relavent volumes:

    docker run \
        -d \
        -v /path/to/my/nginx/files:/srv/nginx \
        -p 80:80 \
        -p 443:443 \
        talentappstore/openresty
