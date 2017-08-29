FROM alpine
MAINTAINER Leo <liaohuqiu@gmail.com>

# use git checkout instead of downloading tar ball because:
#   https://github.com/shadowsocks/simple-obfs/issues/58#issuecomment-288294991
ENV SIMPLE_OBFS_TAG v0.0.3
ENV SIMPLE_OBFS_URL https://github.com/shadowsocks/simple-obfs.git
ENV SIMPLE_OBFS_DIR simple-obfs

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
                             git \
    && git clone $SIMPLE_OBFS_URL \
    && cd $SIMPLE_OBFS_DIR \
        && git checkout tags/$SIMPLE_OBFS_TAG \
        && git submodule update --init --recursive \
        && ./autogen.sh \
        && ./configure --disable-documentation \
        && make install \
        && cd .. \
        && rm -rf $SIMPLE_OBFS_DIR \
    && apk del TMP
