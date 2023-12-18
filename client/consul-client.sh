sudo apt update
sudo apt install unzip -y
cd /opt
sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip
sudo unzip consul.zip
sudo mv consul /usr/bin/
sudo mkdir -p /etc/consul.d/client
mkdir /var/consul
sudo cat <<EOF > /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "nasir-dc",
    "data_dir": "/var/consul",
    "encrypt": "QrFGmdDhqOX4WkhSUbQpx16f15NgSMfBta++jsH/qTE=",
    "log_level": "INFO",
    "enable_syslog": true,
    "leave_on_terminate": true,
    "start_join": [
        "172.16.0.17",
		    "172.16.0.18",
		    "172.16.0.19"
    ]
}
EOF
sudo cat <<EOF > /etc/systemd/system/consul-client.service
[Unit]
Description=Consul Startup process
After=network.target
 
[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/bin/consul agent -config-dir /etc/consul.d/client'
TimeoutStartSec=0
 
[Install]
WantedBy=default.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now consul-client
sudo systemctl restart consul-client
