#!/bin/bash 

CONF_PATH=${CONF_PATH:-'/etc/opsgenie/conf/opsgenie-integration.conf'}
LOG_CONF_PATH=${LOG_CONF_PATH:-'/etc/opsgenie/marid/log.properties'}
SCRIPTS_DIR=${SCRIPTS_DIR:-'/var/opsgenie/marid/scripts'}
MEM_LIMIT=${MEM_LIMIT:-'-Xmx512m'}
DJAVAX_NET_DEBUG=${DJAVAX_NET_DEBUG:-''}
CONTAINER_IP=$(hostname -i)

# Set config variables
sed -i "s/^apiKey\s=.*$/apiKey=${MARID_API_KEY}/g" $CONF_PATH
sed -i "s#\(^opsgenie\.api\.url\s=\)\(.*$\)#\1${MARID_API_URL}#g" $CONF_PATH
#sed -i "s/^\maridKey=.*$/maridKey=${MARID_KEY}/g" $CONF_PATH

#sed -i "s#\(^http\.server\.enabled=\)\(.*$\)#\1${MARID_HTTP_ENABLED}#g" $CONF_PATH
#sed -i "s#\(^http\.server\.host=\)\(.*$\)#\1${CONTAINER_IP}#g" $CONF_PATH
#sed -i "s#\(^http\.server\.port=\)\(.*$\)#\1${MARID_HTTP_PORT}#g" $CONF_PATH

sed -i "s#\(^librenms\.url\s=\)\(.*$\)#\1${MARID_LIBRENMS_URL}#g" $CONF_PATH
sed -i "s#\(^librenms\.apiToken\s=\)\(.*$\)#\1${MARID_LIBRENMS_APITOKEN}#g" $CONF_PATH

java \
  -Dmarid.config=/etc/opsgenie/marid \
  -Dmarid.conf.path="$CONF_PATH" \
  -Dmarid.log.conf.path="$LOG_CONF_PATH" \
  -Dmarid.scripts.dir="$SCRIPTS_DIR" \
  -Djava.io.tmpdir=/tmp/marid "$MEM_LIMIT" -server \
  -Djavax.net.debug="$DJAVAX_NET_DEBUG" \
  -cp MARID_CLASSPATH:/var/lib/opsgenie/marid/* com.ifountain.opsgenie.client.marid.Bootstrap
