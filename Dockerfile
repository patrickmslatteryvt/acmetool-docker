FROM quay.io/justcontainers/base-alpine:v0.11.1

ENV ACMETOOL_VERSION=0.0.51 \
    CONFD_VERSION=0.12.0-alpha3 \
    ACME_EMAIL=changeme@example.com \
    CERT_DOMAINS="example.com www.example.com"

# cron.d keeps acmetool from complaining.
RUN apk --no-cache add nginx && \
    apk --no-cache add --virtual .download-deps curl tar && \
    cd /usr/local/bin && \
    curl -L https://github.com/hlandau/acme/releases/download/v$ACMETOOL_VERSION/acmetool-v$ACMETOOL_VERSION-linux_amd64.tar.gz | tar xz --strip-components=2 acmetool-v$ACMETOOL_VERSION-linux_amd64/bin/acmetool && \
    apk del .download-deps && \
    mkdir /etc/cron.d

COPY rootfs /

EXPOSE 80

ENTRYPOINT ["/init"]
