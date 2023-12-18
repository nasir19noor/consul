docker pull arm64v8/consul:latest
docker run -d -p 8500:8500 -p 8600:8600/udp --name=consul-container consul agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0