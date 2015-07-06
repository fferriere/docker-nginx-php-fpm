docker-nginx-php-fpm
====================

This project create a docker container with nginx and php-fpm.
The container is based on [docker-base](https://github.com/fferriere/docker-base) image.

Build
-----

To build the container you should run `build.sh` script.
You can customize image name with `FFERRIERE_NGINX_PHP_FPM_IMAGE` variable. Example:
```
$ FFERRIERE_NGINX_PHP_FPM_IMAGE='prefix/nginx-php-fpm' ./build.sh
```

Run
---

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
