#!/usr/bin/env bash

## Run the commands to make it all work
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

service syslog-ng stop
service syslog-ng start
service syslog-ng status
frontail -d -p $HTTPPORT /var/log/remote/syslog.log

# Keep docker running
bash
