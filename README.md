# Docker Forwarder
Docker container that create DNATs between host network and containers internal network (Weave). 

Internal docker hostnames are resolved in runtime, just link containers when running.

Cenario
-------
NOTE: This cenario/container suppose that all docker are in a common private network ( the under technologies are made transparent by Weave tunnel). Ex: D3 can ping D4 before using the FORWARDER.
    
    D1,D2,D3 - Host1 - Network AWS ----------- NET --------- Network Company A - Host2 - D4,D5,FORWARDER
    You can inject traffic into D4 and it will be routed to D1.
    You can inject traffic into D1 and it will be routed to D4.
    You dont need to public expose ports on Network AWS if your customers are inside Company A.
    Company A has a direct link with Company B and dockers from AWS Network cant access it.
    

Running
-------

NOTE: Every variable must receive the same number of parameters, use comma as delimiter.

    docker pull drecchia/forwarder:latest
    docker run --privileged -e LISTEN_PORT=80,81,82 -e LISTEN_PROTO=tcp,tcp -e TARGET=192.168.1.1,192.168.1.1 -e TARGET_PORT=80,80,80 -d drecchia/forwarder:latest

Running with hostnames
----------------------
    docker pull drecchia/forwarder:latest
    docker run --privileged -e LISTEN_PORT=80,81 -e LISTEN_PROTO=tcp,tcp -e TARGET=internalName,internalName -e TARGET_PORT=80,80 -link parentContainer:internalName -d drecchia/forwarder:latest
    
