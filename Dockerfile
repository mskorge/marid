FROM openjdk:8-jdk-stretch
LABEL maintainer="Michael Skorge (Forked from: oliver nad)"
ARG MARID_VERSION=2.13.2
RUN wget https://s3-us-west-2.amazonaws.com/opsgeniedownloads/repo/opsgenie-marid_${MARID_VERSION}_all.deb -O /tmp/marid.dpkg && \
  dpkg -i /tmp/marid.dpkg
ADD scripts/start.sh /start.sh
ADD etc/log.properties /etc/opsgenie/marid/log.properties
RUN chmod 755 /start.sh
CMD ["/bin/bash", "/start.sh"]