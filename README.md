# toddwint/syslog

## Info

<https://hub.docker.com/r/toddwint/syslog>

<https://github.com/toddwint/syslog>

SYSLOG remote server docker image for simple lab SYSLOG testing.

This image was created for lab setups where the need to verify SYSLOG messages are being sent to a customer owned SYSLOG.

## Features

- Receive SYSLOG messages from clients.
- View remote SYSLOG messages in a web browser ([frontail](https://github.com/mthenw/frontail))
    - tail the file
    - pause the flow
    - search through the flow
    - highlight multiple rows
- SYSLOG messages are persistent if you map the directory `/var/log/remote`

## Sample `config.txt` file

```
TZ=UTC
IPADDR=127.0.0.1
HTTPPORT=9001
HOSTNAME=syslogsrvr
```

## Sample docker run command

```
#!/usr/bin/env bash
source config.txt
cp template/webadmin.html.template webadmin.html
sed -i "s/IPADDR/$IPADDR:$HTTPPORT/g" webadmin.html
docker run -dit --rm \
    --name syslog \
    -h $HOSTNAME \
    -p $IPADDR:514:514/udp \
    -p $IPADDR:$HTTPPORT:$HTTPPORT \
    -v syslog:/var/log/remote/ \
    -e TZ=$TZ \
    -e HTTPPORT=$HTTPPORT \
    -e HOSTNAME=$HOSTNAME \
    --cap-add=NET_ADMIN \
    toddwint/syslog
```

## Sample webadmin.html.template file

See my github page (referenced above).


## Login page

Open the `webadmin.html` file.

Or just type in your browser `http://<ip_address>:<port>`


## Issues?

Make sure if you set an IP that machine has the same IP configured on an interface.

