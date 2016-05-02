#!/bin/bash
openssl dhparam -out dhparam.pem 4096
mv dhparam.pem /etc/ssl/certs
