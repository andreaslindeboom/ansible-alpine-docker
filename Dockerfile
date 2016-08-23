FROM alpine:3.4

RUN apk add --no-cache \
    ansible \
    py-pip

WORKDIR /workdir/

VOLUME /workdir/
