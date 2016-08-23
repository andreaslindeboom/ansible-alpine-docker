FROM alpine:3.4

RUN apk add --no-cache ansible

WORKDIR /workdir/

VOLUME /workdir/
