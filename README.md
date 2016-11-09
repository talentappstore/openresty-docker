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

## Debugging

The docker image also contains the [stapxx](https://github.com/openresty/stapxx) and [FlameGraph](https://github.com/bredangregg/FlameGraph) projects. Example usage (could be improved):

    docker run -it -v /lib/modules:/lib/modules -v /usr/src/linux-headers-4.4.0-45-generic:/usr/src/linux-headers-4.4.0-45-generic -v /sys/kernel/debug:/sys/kernel/debug -v /usr/src/linux-headers-4.4.0-45:/usr/src/linux-headers-4.4.0-45 --privileged --pid=host --name otest21 talentappstore/openresty bash
    ps aux | grep nginx # find the worker process id
    lj-lua-stacks.xss -x 3124 --skip-badvars > a.bt

## Developement

Alternatively, to use a developement platform just add the relavent volumes:

    docker run \
        -d \
        -v /path/to/my/nginx/files:/srv/nginx \
        -p 80:80 \
        -p 443:443 \
        talentappstore/openresty
