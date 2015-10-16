# docker-nginx-php-fpm

This project create a docker container with nginx and php-fpm.
The container is based on [docker-base](https://github.com/fferriere/docker-base) image.

## Build

To build the container you should run `build.sh` script.
You can customize image name with `FFERRIERE_NGINX_PHP_FPM_IMAGE` variable. Example:
```
$ FFERRIERE_NGINX_PHP_FPM_IMAGE='prefix/nginx-php-fpm' ./build.sh
```

### Advanced build

Build contains light packages (mainly for php).
You can build container with more packages thanks to `FFERRIERE_NGINX_PACKAGES_TO_INSTALL` variable.
This variable can be contains a string or a file path.

Example :
```
$ export FFERRIERE_NGINX_PACKAGES_TO_INSTALL="php5-mysql php5-pgsql"
$ ./build.sh
```

Or :
```
$ echo 'php5-gd php5-pgsql php5-mcrypt' > ./to-install # or use exists file
$ FFERRIERE_NGINX_PACKAGES_TO_INSTALL=./to-install ./build.sh
```

### Ultra advanced build

It can happen you want to configure an app or execute a script after install.
You can with the `FFERRIERE_NGINX_RUN_AFTER` variable.
This variable should be a path to a directory.
This directory will be copy on `/tmp/run-after` on container.
After the copy the script `run-build.sh` is call for move files or make what you need.

Example for xdebug configuration :

`ls ./dir` :
```
run-build.sh
xdebug.conf
```

`cat ./dir/xdebug.conf` :

```
xdebug.default_enable = 1
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
```

`cat ./dir/run-build.sh`:
```
#!/bin/bash
cat /tmp/run-after/xdebug.conf >> /etc/php5/mods-available/xdebug.ini
```

```
$ export FFERRIERE_NGINX_PACKAGES_TO_INSTALL='php5-xdebug'
$ FFERRIERE_NGINX_RUN_AFTER=./dir ./build.sh
```

On build, the script copy `./dir` on `/tmp/run-after` and run `/tmp/run-after/run-build.sh` script.

## Run

To run container execute `run.sh` script.

You can customize container's name with `FFERRIERE_NGINX_PHP_FPM_NAME` variable. Example :
```
$ FFERRIERE_NGINX_PHP_FPM_IMAGE='prefix/nginx-php-fpm' FFERRIERE_NGINX_PHP_FPM_NAME='prefix-nginx-php-fpm' ./run.sh
```

By default, run use working directory as volume bind at `/var/www` on container. But you can override volume path with `FFERRIERE_NGINX_SRC_PATH` variable.

The default nginx's configuration is light. You can mount a directory on `/etc/nginx/sites-enabled` on container with `FFERRIERE_NGINX_CNF_PATH` variable. With this method you can use multiple host with nginx.

Example :
```
$ export FFERRIERE_NGINX_SRC_PATH=$(pwd)'/www'
$ export FFERRIERE_NGINX_CNF_PATH=$(pwd)'/cnf'
$ ./run.sh
```

You can also add docker options on run with `FFERRIERE_NGINX_PHP_FPM_RUN_DOCKER_ARGS` variable. Example :
```
    FFERRIERE_NGINX_PHP_FPM_RUN_DOCKER_ARGS='-p 80:80' ./run.sh
```
