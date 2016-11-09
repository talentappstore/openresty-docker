#!/bin/bash
/usr/local/openresty/nginx/sbin/nginx -g 'daemon off;' -p /srv/nginx -c /srv/nginx/conf/nginx.conf
tail -f /srv/nginx/logs/error.log /srv/nginx/logs/access.log
