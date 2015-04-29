# Docker Forwarder
Docker container that create DNATs between host network and containers internal network (Weave). 

Running:
docker pull drecchia/forwarder:latest
docker run -e LISTEN_PORT=80,81,82 -e LISTEN_PROTO=tcp,tcp -e TARGET=192.168.1.1,192.168.1.1 -e TARGET_PORT=80,80,80 -d drecchia/forwarder:latest
