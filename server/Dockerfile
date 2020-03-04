FROM registry.access.redhat.com/ubi7-minimal

ENV KEYCLOAK_VERSION 9.0.0
ENV JDBC_POSTGRES_VERSION 42.2.5
ENV JDBC_MYSQL_VERSION 5.1.46
ENV JDBC_MARIADB_VERSION 2.2.3
ENV JDBC_MSSQL_VERSION 7.4.1.jre11

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING true
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG GIT_REPO
ARG GIT_BRANCH
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/9.0.0/keycloak-9.0.0.tar.gz

USER root

RUN microdnf update -y && microdnf install -y gzip hostname java-11-openjdk-headless openssl tar which && microdnf clean all

ADD tools/cli/TCPPING.cli /opt/jboss/tools/cli/jgroups/discovery/
ADD tools/cli/JDBC_PING.cli /opt/jboss/tools/cli/jgroups/discovery/

ADD tools /opt/jboss/tools
RUN /opt/jboss/tools/build-keycloak.sh

COPY tools/add-iptable-rules.sh /usr/local/bin/add-iptable-rules.sh
RUN chmod +x /usr/local/bin/add-iptable-rules.sh 
CMD add-iptable-rules.sh

USER 1000

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
