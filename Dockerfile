FROM ubuntu:latest
RUN \
  apt -y update && \
  apt -y full-upgrade && \
  apt -y install \
    openjdk-8-jdk-headless \
    wget && \
  wget https://dl.ui.com/unifi/6.4.54/unifi_sysvinit_all.deb && \
  apt -y install ./unifi_sysvinit_all.deb && \
  apt -y autoremove && \
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && \
  export PATH=$PATH:$JAVA_HOME/bin
COPY \
  ./system.properties /var/lib/unifi/system.properties
RUN \
  /etc/init.d/mongodb start
EXPOSE 8443
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "-f", "-k", "L", "https://127.0.0.1:8443" ]
ENTRYPOINT ["sleep", "inf"]