sudo yum update -y
sudo adduser consul --shell=/bin/false-no-create-home
sudo mkdir -p /data/consul /etc/consul/consul.d
sudo chown -R consul:consul /data/consul /etc/consul
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install consul
sudo cat <<EOF > /etc/systemd/system/consul.service
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.json

[Service]
User=consul
Group=consul
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/usr/bin/consul reload
ExecStop=/usr/bin/consul leave
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
mv /etc/consul.d/consul.hcl /etc/consul.d/consul.hcl_bak
sudo cat <<EOF > /etc/consul.d/consul.json
{
    "datacenter": "nasir-dc",
    "bootstrap_expect": 1,
    "data_dir": "/data/consul",
    "log_level": "INFO",
    "node_name": "consul-2",
    "ui_config": {
                "enabled": true,
                "content_path":"/ui/"
        },
    "server": true,
    "leave_on_terminate": true,
    "encrypt": "V++fphCcR8ppDG1Y0S2wGyDVWipJcZjJqKKNSJkEaUg=",
    "rejoin_after_leave": true,
    "retry_join": ["consul-1.local:8301", "consul-2.local:8301", "consul-3.local:8301"],
    "enable_script_checks": true,
    "advertise_addr": "34.87.58.210",
    "bind_addr": "0.0.0.0",
    "client_addr": "0.0.0.0",
    "log_file": "/var/log/consul/consul.log"
}
EOF
sudo service consul start
