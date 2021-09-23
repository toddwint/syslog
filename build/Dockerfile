FROM ubuntu:focal
COPY scripts /opt/syslog/scripts
EXPOSE 514/udp 9001
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV HTTPPORT=9001
RUN apt-get update \
    && \
    apt-get install -y \
    tzdata \
    iproute2 \
    wget \
    syslog-ng \
    && \
    mkdir -p /opt/syslog/data \
    && \
    wget -q https://github.com/mthenw/frontail/releases/download/v4.9.1/frontail-linux -O /usr/local/bin/frontail \
    && \
    chmod 755 /usr/local/bin/frontail \
    && \
    mkdir -p /var/log/remote \
    && \
    touch /var/log/remote/syslog.log \
    && \
    echo "##### Make a remote syslog server #####" >> /etc/syslog-ng/syslog-ng.conf \
    && \
    echo "source net { udp(); };" >> /etc/syslog-ng/syslog-ng.conf \
    && \
    echo "destination remote { file("/var/log/remote/syslog.log"); };" >> /etc/syslog-ng/syslog-ng.conf \
    && \
    echo "log { source(net); destination(remote); };" >> /etc/syslog-ng/syslog-ng.conf \
    && \
    sed -i "\#^/var/log/syslog#a /var/log/remote/syslog.log"  /etc/logrotate.d/syslog-ng \
    && \
    apt-get remove -y \
    wget \
    && \
    apt-get autoremove -y \
    && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /opt/syslog/
CMD ["/opt/syslog/scripts/startup.sh"]
