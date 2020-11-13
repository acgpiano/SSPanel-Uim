FROM acgpiano/sspanel:env
LABEL maintainer="acgpiano"

COPY . /var/www
WORKDIR /var/www

RUN cp config/.config.example.php config/.config.php && \
    cp config/appprofile.example.php config/appprofile.php && \
    chmod -R 755 storage && \
    chmod -R 777 /var/www/storage/framework/smarty/compile/ && \
    curl -SL https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php && \
    php composer.phar config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    php composer.phar install && \
    php xcat initQQWry && \
    php xcat initdownload && \
    { \
    echo '[program:crond]'; \
    echo 'command=cron -f'; \
    echo 'autostart=true'; \
    echo 'autorestart=true'; \
    echo 'killasgroup=true'; \
    echo 'stopasgroup=true'; \
    } | tee /etc/supervisor/crond.conf
