# docker-compose.yaml
services:
  consul_server:
    image: ubuntu:22.04
    build: .
    privileged: true
    user: root
    ports:
      - 8300:8300
      - 8301:8301
      - 8302:8302
      - 8400:8400
      - 8500:8500
      - 8600:8600
    container_name: consul_server
    volumes:
      - consul_server:/
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
    networks:
      - nasir
networks:
  nasir:
    external: true
    name: nasir
volumes:
  consul_server:
    external: true
    name: consul_server
