# Mosquitto Auth + Docker.

Mosquitto is a broker for the MQTT protocol version 3.1. Docker is a computer program that performs operating-system-level virtualization also known as containerization.

## Client Authentication

This Dockerfile will spawn a Mosquitto container that requires authentication with the users and passwords on file "userfile.txt". 

Insert new users into "userfile.txt" as: `<user>:<password>`

The password will be hashed during image build using `mosquitto_passwd` so that there will not be on clear text on the container. However, you are still required to manage and generate strong passwords for your clients. 

Undertand that while your users need to be authenticated, **TLS will not enabled on this container, the credentials will be sent over the network in clear text.** 

Be sure to enable TLS and manage the required certificates if your threat model requires it.

To build it:
```
docker build -t mosquitto-auth .
```

To run it on port 1883 of your machine: 
```
docker run -p 1883:1883 mosquitto-auth 
``` 
