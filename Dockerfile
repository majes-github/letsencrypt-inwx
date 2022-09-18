FROM alpine:3

# Install
RUN apk --no-cache add certbot openssl

# Files
COPY letsencrypt-inwx /usr/bin/
COPY renew-certificate.bash /
RUN mkdir -p /usr/lib/letsencrypt-inwx/
COPY certbot-inwx-auth /usr/lib/letsencrypt-inwx/
COPY certbot-inwx-cleanup /usr/lib/letsencrypt-inwx/
COPY crontab /var/spool/cron/crontabs/root

# Entrypoint
ENTRYPOINT ["/usr/sbin/crond", "-f"]
