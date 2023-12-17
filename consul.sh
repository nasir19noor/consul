apt update -y
apt install unzip -y
cd /usr/local/bin
sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.6.0/consul_1.6.0_linux_amd64.zip
unzip consul.zip
sudo mkdir -p /etc/consul.d/scripts
sudo mkdir /var/consul
sudo cat <<EOF > /etc/consul.d/config.json
{
    "bootstrap_expect": 3,
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
        "172.16.0.17",
        "172.16.0.18",
        "172.16.0.19"
    ],
    "ui": true
}
EOF
sudo cat <<EOF > /etc/systemd/system/consul.service
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
sudo systemctl daemon-reload
sudo systemctl enable --now consul
sudo systemctl restart consul
