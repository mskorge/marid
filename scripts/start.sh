#!/bin/bash 

CONF_PATH=${CONF_PATH:-'/etc/opsgenie/marid/marid.conf'}
LOG_CONF_PATH=${LOG_CONF_PATH:-'/etc/opsgenie/marid/log.properties'}
SCRIPTS_DIR=${SCRIPTS_DIR:-'/var/opsgenie/marid/scripts'}
MEM_LIMIT=${MEM_LIMIT:-'-Xmx512m'}
DJAVAX_NET_DEBUG=${DJAVAX_NET_DEBUG:-''}

# Set config variables
sed -i "s/^apiKey=.*$/apiKey=${MARID_API_KEY}/g" /etc/opsgenie/marid/marid.conf
sed -i "s/^opsgenie\.api\.url=.*$/opsgenie\.api\.url=${MARID_API_URL}/g" /etc/opsgenie/marid/marid.conf
sed -i "s/^maridKey=.*$/maridKey=${MARID_KEY}/g" /etc/opsgenie/marid/marid.conf

java \
  -Dmarid.config=/etc/opsgenie/marid \
  -Dmarid.conf.path="$CONF_PATH" \
  -Dmarid.log.conf.path="$LOG_CONF_PATH" \
  -Dmarid.scripts.dir="$SCRIPTS_DIR" \
  -Djava.io.tmpdir=/tmp/marid "$MEM_LIMIT" -server \
  -Djavax.net.debug="$DJAVAX_NET_DEBUG" \
  -cp MARID_CLASSPATH:/var/lib/opsgenie/marid/* com.ifountain.opsgenie.client.marid.Bootstrap
