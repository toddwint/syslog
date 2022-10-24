FROM toddwint/mybaseimage
COPY app /opt/syslog
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    HTTPPORT1=8080 \
    HTTPPORT2=8081 \
    HTTPPORT3=8082 \
    HTTPPORT4=8083 \
    HOSTNAME=syslogsrvr \
    APPNAME=syslog
RUN apt-get update \
    && \
    apt-get install -y \
    syslog-ng \
    && \
    mkdir -p /var/log/remote \
    && \
    touch /var/log/remote/syslog.log \
    && \
    echo $HOSTNAME > /etc/hostname \
    && \
    apt-get autoremove -y \
    && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /opt/syslog/debug
CMD ["/opt/syslog/scripts/startup.sh"]
