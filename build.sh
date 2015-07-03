#!/bin/bash

THIS_PATH=$(dirname $(realpath $0))

IMAGE='fferriere/nginx-php-fpm'
if [ -n "$FFERRIERE_NGINX_PHP_FPM_IMAGE" ]; then
    IMAGE="$FFERRIERE_NGINX_PHP_FPM_IMAGE"
fi

docker build -t $IMAGE $@ $THIS_PATH/.
