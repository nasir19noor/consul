FROM ubuntu:22.04
RUN apt update -y
RUN apt install unzip -y
RUN cd /usr/local/bin
RUN sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.6.0/consul_1.6.0_linux_amd64.zip
RUN unzip consul.zip
RUN mkdir -p /etc/consul.d/scripts
RUN sudo mkdir /var/consul
RUN cat <<EOF > /etc/consul.d/config.json
{
    "bootstrap_expect": 1,
    "client_addr": "0.0.0.0",
    "datacenter": "nasir-dc",
    "data_dir": "/var/consul",
    "domain": "consul",
    "enable_script_checks": true,
    "dns_config": {
        "enable_truncate": true,
        "only_passing": true
    },
    "enable_syslog": true,
    "encrypt": "xxx",
    "leave_on_terminate": true,
    "log_level": "INFO",
    "rejoin_after_leave": true,
    "server": true,
    "start_join": [
        "localhost",
    ],
    "ui": true
}
EOF
RUN cat <<EOF > /etc/systemd/system/consul.service
[Unit]
Description=Consul Startup process
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/local/bin/consul agent -config-dir /etc/consul.d/'
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF
RUN systemctl daemon-reload
RUN systemctl enable --now consul
RUN systemctl restart consul
