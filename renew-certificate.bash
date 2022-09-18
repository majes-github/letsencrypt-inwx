#!/bin/sh

DOMAIN=example.com
EXTRA_DOMAINS='*.test.example.com'
EMAIL=admin@example.com
days=${1:-10}
cert_file=/etc/letsencrypt/live/$DOMAIN/cert.pem
if [ -e $cert_file ]; then
    if openssl x509 -checkend $(expr 86400 \* $days) -in $cert_file >/dev/null; then
        # cert will not expire in the next $days days
        exit 0
    fi
fi
# renew cert
certbot certonly -n --agree-tos --email $EMAIL --preferred-challenges=dns-01 --manual --manual-auth-hook /usr/lib/letsencrypt-inwx/certbot-inwx-auth --manual-cleanup-hook /usr/lib/letsencrypt-inwx/certbot-inwx-cleanup --manual-public-ip-logging-ok $(for domain in $DOMAIN *.$DOMAIN $EXTRA_DOMAINS; do echo "-d $domain"; done | xargs)
