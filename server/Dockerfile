FROM registry.access.redhat.com/ubi7-minimal

ENV KEYCLOAK_VERSION 11.0.3
ENV JDBC_POSTGRES_VERSION 42.2.5
ENV JDBC_MYSQL_VERSION 8.0.19
ENV JDBC_MARIADB_VERSION 2.5.4
ENV JDBC_MSSQL_VERSION 7.4.1.jre11

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING true
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8
ENV DB_ADDR changeme:3306,changeme2:3306
ENV DB_DATABASE keycloak
ENV DB_PASSWORD changeme
ENV DB_VENDOR mysql
ENV JDBC_PARAMS useSSL=false&failOverReadOnly=false
ENV JGROUPS_DISCOVERY_EXTERNAL_IP changeme
ENV JGROUPS_DISCOVERY_PROPERTIES initial_hosts="changeme[7600],changeme[7600]"
ENV JGROUPS_DISCOVERY_PROTOCOL TCPPING
ENV KEYCLOAK_ALWAYS_HTTPS true
ENV KEYCLOAK_HOSTNAME changeme
ENV KEYCLOAK_LOGLEVEL INFO
ENV ROOT_LOGLEVEL INFO



ENV JAVA_OPTS -XX:MetaspaceSize=128M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -XX:+UseContainerSupport -XX:InitialRAMPercentage=80 -XX:MaxRAMPercentage=80

ARG GIT_REPO
ARG GIT_BRANCH
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

USER root

RUN ln -f -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN microdnf update -y && microdnf install -y gzip hostname java-11-openjdk-headless openssl tar which && microdnf clean all

ADD cli/TCPPING.cli /opt/jboss/tools/cli/jgroups/discovery/
ADD cli/JDBC_PING.cli /opt/jboss/tools/cli/jgroups/discovery/

ADD tools /opt/jboss/tools
RUN /opt/jboss/tools/build-keycloak.sh

USER 1000

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
