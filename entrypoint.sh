#!/bin/bash
set -e

PATH=/usr/local/bin:$PATH
PUBLIC_IP=$(curl -s icanhazip.com)

[ -z "$BIND_NG_IP" ] && { export BIND_NG_IP='0.0.0.0'; }
[ -z "$BIND_NG_PORT" ] && { export BIND_NG_PORT=22222; }
[ -z "$BIND_HTTP_IP" ] && { export BIND_HTTP_IP='0.0.0.0'; }
[ -z "$BIND_HTTP_PORT" ] && { export BIND_HTTP_PORT=8080; }
[ -z "$PORT_MIN" ] && { export PORT_MIN=10000; }
[ -z "$PORT_MAX" ] && { export PORT_MAX=10500; }
[ -z "$LOG_LEVEL" ] && { export LOG_LEVEL=0; }

sed -i -e "s/MY_IP/$PUBLIC_IP/g" /etc/rtpengine.conf
sed -i -e "s/BIND_NG_IP/$BIND_NG_IP/g" /etc/rtpengine.conf
sed -i -e "s/BIND_NG_PORT/$BIND_NG_PORT/g" /etc/rtpengine.conf
sed -i -e "s/BIND_HTTP_IP/$BIND_HTTP_IP/g" /etc/rtpengine.conf
sed -i -e "s/BIND_HTTP_PORT/$BIND_HTTP_PORT/g" /etc/rtpengine.conf
sed -i -e "s/PORT_MIN/$PORT_MIN/g" /etc/rtpengine.conf
sed -i -e "s/PORT_MAX/$PORT_MAX/g" /etc/rtpengine.conf
sed -i -e "s/LOG_LEVEL/$LOG_LEVEL/g" /etc/rtpengine.conf

if [ "$1" = 'rtpengine' ]; then
  shift
  exec rtpengine --config-file /etc/rtpengine.conf  "$@"
fi

exec "$@"
