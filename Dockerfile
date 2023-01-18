FROM alpine
LABEL maintainer="igops <hi@igops.me>"

ENV CHECK_FREQUENCY 0.1

RUN apk add --no-cache netcat-openbsd

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]