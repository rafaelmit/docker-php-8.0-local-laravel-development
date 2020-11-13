FROM rafaelmit/docker-php-8.0

LABEL maintainer="Rafael Meira <rafaelmeira@me.com>"

# COPY CRONTAB CONFIGS
COPY ./docker/crontabs/artisan /etc/cron.d/artisan
RUN chmod 0644 /etc/cron.d/artisan

# COPY SUPERVISOR CONFIG
COPY ./docker/supervisor/supervisord.conf /etc/supervisord.conf

# COPY SHELLSCRIPT
COPY ./docker/scripts/init.sh /scripts/init.sh
RUN chmod +x /scripts/init.sh

# FINAL POINT
ENTRYPOINT ["/scripts/init.sh"]
