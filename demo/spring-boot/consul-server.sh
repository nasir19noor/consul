docker pull consul:1.15.4
docker run -d -p 8500:8500 -p 8600:8600/udp --name=consul-container consul:1.15.4 agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0
