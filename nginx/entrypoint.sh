#!/usr/bin/env bash
set -e

envsubst '${AWS_ENDPOINT_URL}' < /etc/nginx/conf.d/default.conf.in > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
