FROM php:7.4-fpm-alpine
ENV LD_LIBRARY_PATH /usr/lib/oracle/21/client64/lib
ENV ORACLE_HOME /usr/lib/oracle/21/client64/lib
ENV TNS_ADMIN /usr/lib/oracle/21/client64/lib/network/admin
# Install PHP Extensions (igbinary & memcached + memcache)
RUN apk add --no-cache --update libmemcached-libs zlib libnsl libaio libldap
RUN set -xe \
    && export URL_BASE=https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip \
    && export URL_SDK=https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sdk-linux.x64-21.4.0.0.0dbru.zip \
    && export BASE_NAME=instantclient_21_4 \
    && cd /tmp/ \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && apk add --no-cache --update --virtual .memcached-deps zlib-dev libmemcached-dev cyrus-sasl-dev \
    && apk add --no-cache --update --virtual .oci8-deps unzip \
    && apk add --no-cache --update --virtual .openldap-deps openldap-dev \
    && curl $URL_BASE > base.zip \
    && curl $URL_SDK > sdk.zip \
    && mkdir -p /usr/lib/oracle/21/client64/bin \
    && unzip -d /usr/lib/oracle/21/client64 /tmp/base.zip \
    && mv /usr/lib/oracle/21/client64/${BASE_NAME} ${ORACLE_HOME} \
    && mv /usr/lib/oracle/21/client64/lib/*i /usr/lib/oracle/21/client64/bin \
    && unzip -d /tmp /tmp/sdk.zip \
    && mv /tmp/${BASE_NAME}/sdk ${ORACLE_HOME} \
    && ln -sf /lib/libc.musl-x86_64.so.1 /lib/libresolv.so.2 \
    && ln -sf /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 \ 
    && echo "instantclient,${ORACLE_HOME}" | pecl install oci8-2.2.0 \
    && pecl install memcache-4.0.5.2 \
# Install igbinary (memcached's deps) \
    && pecl install igbinary \
# Install memcached \
    && ( \
        pecl install --nobuild memcached \
        && cd "$(pecl config-get temp_dir)/memcached" \
        && phpize \
        && ./configure --enable-memcached-igbinary \
        && make -j$(nproc) \
        && make install \
        && cd /tmp/ \
    ) \
# Enable PHP extensions \
    && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,$ORACLE_HOME \
    && docker-php-ext-install pdo_mysql pdo_oci ldap \
    && docker-php-ext-enable igbinary memcached memcache oci8 \
    && rm -rf ${ORACLE_HOME}/sdk /tmp/* \
    && apk del .memcached-deps .phpize-deps .oci8-deps .openldap-deps
USER 900
