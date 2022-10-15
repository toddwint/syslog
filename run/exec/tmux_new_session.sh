#!/usr/bin/env bash
APPNAME=syslog
source "$(dirname "$(dirname "$(realpath $0)")")"/config.txt
docker exec -it -w /opt/"$APPNAME"/scripts "$HOSTNAME" ./tmux.sh
