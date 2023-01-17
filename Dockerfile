FROM alpine
LABEL maintainer="igops <hi@igops.me>"

RUN apk add --no-cache netcat-openbsd

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]