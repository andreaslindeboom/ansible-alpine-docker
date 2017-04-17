FROM alpine:3.5

ENV ANSIBLE_VERSION 2.3.0.0

RUN apk add --no-cache \
        py-pip \
        gcc \
        musl-dev \
        python-dev \
        libffi-dev \
        openssl-dev && \
    pip install --upgrade \
        pip \
        ansible==$ANSIBLE_VERSION

WORKDIR /ansible/

VOLUME /ansible/
