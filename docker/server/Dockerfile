FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
    bash curl nano net-tools zip unzip \
    jq dnsutils iputils-ping

ADD https://releases.hashicorp.com/consul/1.17.1/consul_1.17.1_darwin_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

# Consul ports
EXPOSE 8300 8301 8302 8400 8500 8600

ADD consul_server.sh /opt
RUN mkdir -p /data
VOLUME /data

CMD ["/opt/consul_server.sh"]