# Docker Forwarder
Docker container that create DNATs between host network and containers internal network (Weave). 

Internal docker hostnames are resolved in runtime, just link containers when running.

Cenario
-------
    Network1 - Host1 - D1,D2,D3  -----------------> Network2 - Host2 - D4
    You can inject traffic into D4 and it will be routed to target on Network1.

Running
-------
    docker pull drecchia/forwarder:latest
    docker run --privileged -e LISTEN_PORT=80,81,82 -e LISTEN_PROTO=tcp,tcp -e TARGET=192.168.1.1,192.168.1.1 -e TARGET_PORT=80,80,80 -d drecchia/forwarder:latest

Running with hostnames
----------------------
    docker pull drecchia/forwarder:latest
    docker run --privileged -e LISTEN_PORT=80,81 -e LISTEN_PROTO=tcp,tcp -e TARGET=internalName,internalName -e TARGET_PORT=80,80 -link parentContainer:internalName -d drecchia/forwarder:latest
    
