#!/bin/bash

THIS_PATH=$(dirname $(realpath $0))

IMAGE='fferriere/nginx-php-fpm'
if [ -n "$FFERRIERE_NGINX_PHP_FPM_IMAGE" ]; then
    IMAGE="$FFERRIERE_NGINX_PHP_FPM_IMAGE"
fi

INSTALL_PATH="$THIS_PATH/files/packages-to-install"
if [ -n "$FFERRIERE_NGINX_PACKAGES_TO_INSTALL" ]; then
    if [ -f "$FFERRIERE_NGINX_PACKAGES_TO_INSTALL" ]; then
        cp "$FFERRIERE_NGINX_PACKAGES_TO_INSTALL" $INSTALL_PATH
    else
        echo -n "$FFERRIERE_NGINX_PACKAGES_TO_INSTALL" > $INSTALL_PATH
    fi
else
    echo -n '' > $INSTALL_PATH
fi

docker build -t $IMAGE $@ $THIS_PATH/.

rm $INSTALL_PATH
