FROM python:3-alpine

ARG VERSION=latest
ADD config /var/lib/radicale/config
VOLUME /var/lib/radicale

EXPOSE 5232

CMD ["radicale", "--config", "/var/lib/radicale/config"]

RUN apk add --no-cache ca-certificates openssl curl jq \
    && apk add --no-cache --virtual .build-deps gcc libffi-dev musl-dev \
    && pip install --no-cache-dir "$(curl -sL https://api.github.com/repos/Kozea/Radicale/releases/latest | jq -r '.tarball_url')" \
    && apk del .build-deps curl jq