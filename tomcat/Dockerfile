FROM tomcat:8-jdk8-corretto
ENV LD_LIBRARY_PATH /usr/lib/oracle/21/client64/lib:$LD_LIBRARY_PATH
ENV ORACLE_HOME /usr/lib/oracle/21/client64/lib
ENV TNS_ADMIN /usr/lib/oracle/21/client64/lib/network/admin
RUN set -xe \
    && yum install -y unzip libaio \
    && export URL_BASE=https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip \
    && export URL_JDBC=https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-jdbc-linux.x64-21.4.0.0.0dbru.zip \
    && export BASE_NAME=instantclient_21_4 \
    && cd /tmp \
    && curl $URL_BASE > base.zip \
    && curl $URL_JDBC > jdbc.zip \
    && mkdir -p /usr/lib/oracle/21/client64/bin \
    && unzip -d /usr/lib/oracle/21/client64 /tmp/base.zip \
    && mv /usr/lib/oracle/21/client64/${BASE_NAME} ${ORACLE_HOME} \
    && mv /usr/lib/oracle/21/client64/lib/*i /usr/lib/oracle/21/client64/bin \
    && unzip -d /tmp /tmp/jdbc.zip \
    && echo "CLASSPATH=\$ORACLE_HOME/ojdbc8.jar" > $CATALINA_HOME/bin/setenv.sh \
    && mv /tmp/${BASE_NAME}/*.so ${ORACLE_HOME} \
    && mv /tmp/${BASE_NAME}/*.jar ${ORACLE_HOME} \
    && rm -rf /tmp/* /var/cache /var/lib/yum
USER 900
