#!/bin/bash

NAME='fferriere-nginx-php-fpm'
if [ -n "$FFERRIERE_NGINX_PHP_FPM_NAME" ]; then
    NAME="$FFERRIERE_NGINX_PHP_FPM_NAME"
fi

docker exec -ti -u user $NAME /bin/bash
