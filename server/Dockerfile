FROM registry.access.redhat.com/ubi7-minimal

ENV KEYCLOAK_VERSION 10.0.2
ENV JDBC_POSTGRES_VERSION 42.2.5
ENV JDBC_MYSQL_VERSION 8.0.19
ENV JDBC_MARIADB_VERSION 2.5.4
ENV JDBC_MSSQL_VERSION 7.4.1.jre11

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV DB_VENDOR mysql
ENV DB_ADDR percona
ENV DB_DATABASE keycloak
ENV DB_PASSWORD changeit
ENV JDBC_PARAMS useSSL=false
ENV JGROUPS_DISCOVERY_PROPERTIES datasource_jndi_name=java:jboss/datasources/KeycloakDS
ENV JGROUPS_DISCOVERY_PROTOCOL JDBC_PING
ENV KEYCLOAK_LOGLEVEL INFO
ENV ROOT_LOGLEVEL INFO


ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG GIT_REPO
ARG GIT_BRANCH
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

USER root

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
