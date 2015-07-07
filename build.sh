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

RUN_AFTER_PATH="$THIS_PATH/files/run-after"
RUN_AFTER_SCRIPT="$RUN_AFTER_PATH/run-build.sh"
if [ ! -d $RUN_AFTER_PATH ]; then
    mkdir -p $RUN_AFTER_PATH
fi
if [ -n "$FFERRIERE_NGINX_RUN_AFTER" ] && [ -d "$FFERRIERE_NGINX_RUN_AFTER" ]; then
    eval "cp -r $FFERRIERE_NGINX_RUN_AFTER/* $RUN_AFTER_PATH"
fi
if [ ! -f "$RUN_AFTER_SCRIPT" ]; then
    echo -e "#!/bin/bash\n\ntrue" > "$RUN_AFTER_SCRIPT"
fi
if [ ! -x "$RUN_AFTER_SCRIPT" ]; then
    chmod u+x "$RUN_AFTER_SCRIPT"
fi

docker build -t $IMAGE $@ $THIS_PATH/.

rm $INSTALL_PATH
rm -rf $RUN_AFTER_PATH
