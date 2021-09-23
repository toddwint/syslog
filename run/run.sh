#!/usr/bin/env bash
source config.txt
cp template/webadmin.html.template webadmin.html
sed -i "s/IPADDR/$IPADDR:$HTTPPORT/g" webadmin.html
docker run -dit --rm \
    --name syslog \
    -p $IPADDR:514:514/udp \
    -p $IPADDR:$HTTPPORT:$HTTPPORT \
    -v syslog:/var/log/remote/ \
    -e TZ=$TZ \
    -e HTTPPORT=$HTTPPORT \
    --cap-add=NET_ADMIN \
    toddwint/syslog
