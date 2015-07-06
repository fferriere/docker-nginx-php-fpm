FROM fferriere/base

MAINTAINER ferriere.florian@gmail.com

ADD files/packages-to-install /tmp/packages-to-install

RUN echo "deb http://packages.dotdeb.org wheezy-php56 all" >> /etc/apt/sources.list.d/dotdeb.list && \
    wget http://www.dotdeb.org/dotdeb.gpg -O- |apt-key add - && \
    apt-get update -y && \
    apt-get install -y nginx php5-fpm php5-cli $(cat /tmp/packages-to-install) && \
    rm /tmp/packages-to-install

RUN echo 'date.timezone = Europe/Paris' >> /etc/php5/cli/php.ini && \
    echo 'date.timezone = Europe/Paris' >> /etc/php5/fpm/php.ini && \
    echo 'cgi.fix_pathinfo = 0' >> /etc/php5/fpm/php.ini && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf

RUN mkdir /var/www && \
    chown www-data:www-data /var/www

ADD files/nginx/default /etc/nginx/sites-enabled/default
ADD files/entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME [ "/etc/nginx/sites-enabled", "/var/www" ]

EXPOSE 80

CMD [ "/usr/local/bin/entrypoint.sh" ]
