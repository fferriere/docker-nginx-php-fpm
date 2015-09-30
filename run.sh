#!/bin/bash

NAME='fferriere-nginx-php-fpm'
if [ -n "$FFERRIERE_NGINX_PHP_FPM_NAME" ]; then
    NAME="$FFERRIERE_NGINX_PHP_FPM_NAME"
fi

NB_ROWS=$(docker ps | grep -w "$NAME" | wc -l)
if [ "$NB_ROWS" -gt 0 ]; then
    echo 'already started' >&2
    exit 1
fi

NB_ROWS=$(docker ps -a | grep -w "$NAME" | wc -l)
if [ "$NB_ROWS" -gt 0 ]; then
    docker rm "$NAME"
fi

IMAGE='fferriere/nginx-php-fpm'
if [ -n "$FFERRIERE_NGINX_PHP_FPM_IMAGE" ]; then
    IMAGE="$FFERRIERE_NGINX_PHP_FPM_IMAGE"
fi

SRC_PATH=$(pwd)
if [ -n "$FFERRIERE_NGINX_SRC_PATH" ]; then
    if [ ! -d "$FFERRIERE_NGINX_SRC_PATH" ]; then
        echo "$FFERRIERE_NGINX_SRC_PATH path doesn't exists !" >&2
        exit 2
    fi
    SRC_PATH="$FFERRIERE_NGINX_SRC_PATH"
fi

CNF_PATH=''
if [ -n "$FFERRIERE_NGINX_CNF_PATH" ]; then
    if [ ! -d "$FFERRIERE_NGINX_CNF_PATH" ]; then
        echo "$FFERRIERE_NGINX_CNF_PATH path doesn't exists !" >&2
        exit 2
    fi
    CNF_PATH="$FFERRIERE_NGINX_CNF_PATH"
fi

VOL_ARGS="-v $SRC_PATH:/var/www"
if [ -n "$CNF_PATH" ]; then
    VOL_ARGS="$VOL_ARGS -v $CNF_PATH:/etc/nginx/sites-enabled"
fi

DOCKER_ARGS=''
if [ -n "$FFERRIERE_NGINX_PHP_FPM_RUN_DOCKER_ARGS" ]; then
    DOCKER_ARGS="$DOCKER_ARGS $FFERRIERE_NGINX_PHP_FPM_RUN_DOCKER_ARGS"
fi

docker run -d $VOL_ARGS $DOCKER_ARGS \
    --name $NAME \
    $IMAGE $@
