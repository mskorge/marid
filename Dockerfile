FROM openjdk:8-jdk-stretch
LABEL maintainer="Michael Skorge (Forked from: oliver nad)"
ENV MARID_API_KEY="<api-key>"
ENV MARID_API_URL="https://api.eu.opsgenie.com"
ENV MARID_KEY="yourSecretk3y"
ENV MARID_HTTP_ENABLED="true"
#ENV MARID_HTTP_HOST="localhost" //If not set use container ip. Fix later
ENV MARID_HTTP_PORT="8080"

ARG MARID_VERSION=1.1.3
RUN wget https://s3-us-west-2.amazonaws.com/opsgeniedownloads/repo/opsgenie-librenms_${MARID_VERSION}_all.deb -O /tmp/marid.dpkg && \
  dpkg -i /tmp/marid.dpkg
ADD scripts/start.sh /start.sh
ADD etc/log.properties /etc/opsgenie/marid/log.properties
#ADD etc/marid.conf /etc/opsgenie/marid/marid.conf
RUN chmod 755 /start.sh
#EXPOSE 8080
CMD ["/bin/bash", "/start.sh"]