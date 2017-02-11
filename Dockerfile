FROM alpine
MAINTAINER Leo <liaohuqiu@gmail.com>

ENV SIMPLE_OBFS_VER 0.0.2
ENV SIMPLE_OBFS_URL https://github.com/shadowsocks/simple-obfs/archive/v$SIMPLE_OBFS_VER.tar.gz
ENV SIMPLE_OBFS_DIR simple-obfs-$SIMPLE_OBFS_VER

RUN set -ex \
    && apk add --no-cache libcrypto1.0 \
                          libev \
                          libsodium \
                          mbedtls \
                          pcre \
                          udns \
    && apk add --no-cache \
               --virtual TMP autoconf \
                             automake \
                             build-base \
                             curl \
                             gettext-dev \
                             libev-dev \
                             libsodium-dev \
                             libtool \
                             linux-headers \
                             mbedtls-dev \
                             openssl-dev \
                             pcre-dev \
                             tar \
                             udns-dev \
    && curl -sSL $SIMPLE_OBFS_URL | tar xz \
    && cd $SIMPLE_OBFS_DIR \
        && ./autogen.sh \
        && ./configure --disable-documentation \
        && make install \
        && cd .. \
        && rm -rf $SIMPLE_OBFS_DIR \
    && apk del TMP
