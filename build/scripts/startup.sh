#!/usr/bin/env bash

## Run the commands to make it all work
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

echo $HOSTNAME > /etc/hostname

echo "##### Make a remote syslog server #####" >> /etc/syslog-ng/syslog-ng.conf
echo "source net { udp(); };" >> /etc/syslog-ng/syslog-ng.conf
echo "destination remote { file("/var/log/remote/syslog.log"); };" >> /etc/syslog-ng/syslog-ng.conf
echo "log { source(net); destination(remote); };" >> /etc/syslog-ng/syslog-ng.conf
sed -ri "\|^/var/log/syslog|a /var/log/remote/syslog.log"  /etc/logrotate.d/syslog-ng
sed -ri 's/\#(SYSLOGNG_OPTS="--no-caps")/\1/' /etc/default/syslog-ng
sed -ri 's|invoke-rc.d syslog-ng reload > /dev/null|service syslog-ng reload|' /etc/logrotate.d/syslog-ng

service syslog-ng stop
service cron stop
service syslog-ng start
service cron start
service syslog-ng status
service cron status

frontail -d -p $HTTPPORT /var/log/remote/syslog.log

# Keep docker running
bash
