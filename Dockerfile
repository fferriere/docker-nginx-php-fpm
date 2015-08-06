FROM fferriere/base

MAINTAINER ferriere.florian@gmail.com

ADD files/packages-to-install /tmp/packages-to-install

RUN apt-get install -y nginx php5-fpm php5-cli $(cat /tmp/packages-to-install) && \
    rm /tmp/packages-to-install

RUN echo 'date.timezone = Europe/Paris' >> /etc/php5/cli/php.ini && \
    echo 'date.timezone = Europe/Paris' >> /etc/php5/fpm/php.ini && \
    echo 'cgi.fix_pathinfo = 0' >> /etc/php5/fpm/php.ini && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf

RUN mkdir -p /var/www && \
    chown www-data:www-data /var/www

ADD files/nginx/default /etc/nginx/sites-enabled/default
ADD files/entrypoint.sh /usr/local/bin/entrypoint.sh

ADD files/run-after/ /tmp/run-after/
RUN /tmp/run-after/run-build.sh

VOLUME [ "/etc/nginx/sites-enabled", "/var/www" ]

EXPOSE 80

CMD [ "/usr/local/bin/entrypoint.sh" ]
