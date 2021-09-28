FROM ubuntu:focal
COPY scripts /opt/syslog/scripts
EXPOSE 514/udp 9001
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    HTTPPORT=9001 \
    HOSTNAME=syslogsrvr
RUN apt-get update \
    && \
    apt-get install -y \
    tzdata \
    iproute2 \
    wget \
    syslog-ng \
    && \
    wget -q https://github.com/mthenw/frontail/releases/download/v4.9.1/frontail-linux -O /usr/local/bin/frontail \
    && \
    chmod 755 /usr/local/bin/frontail \
    && \
    mkdir -p /var/log/remote \
    && \
    touch /var/log/remote/syslog.log \
    && \
    apt-get remove -y \
    wget \
    && \
    apt-get autoremove -y \
    && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /opt/syslog/
CMD ["/opt/syslog/scripts/startup.sh"]
