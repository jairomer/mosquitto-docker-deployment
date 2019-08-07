# Mosquitto Broker Auth + Docker.

Mosquitto is a broker for the MQTT protocol version 3.1. Docker is a computer program that performs operating-system-level virtualization also known as containerization.

## Client Authentication

This Dockerfile will spawn a Mosquitto container that requires authentication with the users and passwords on file "userfile.txt". 

Insert new users into "userfile.txt" as: `<user>:<password>`

The password will be hashed during image build using `mosquitto_passwd` so that there will not be on clear text on the container. However, you are still required to manage and generate strong passwords for your clients. 

Understand that while your users need to be authenticated, **TLS will not enabled on this container, the credentials will be sent over the network in clear text.** 

Be sure to enable TLS and manage the required certificates if your threat model requires it.

To build it:
```
docker build -t mosquitto-auth .
```

To run it on port 1883 of your machine: 
```
docker run -p 1883:1883 mosquitto-auth 
``` 

## Client Authentication + TLS support 

To enable TLS support, the required files must be generated, signed, loaded into the broker final deployment and setup in the `mosquitto.conf` file. 

Read the mosquitto documentation for more details on how to edit this file. 

On the broker we need to provide at least: 
- CA certificate, self-generated or not. 
- Server certificate 
- Server private key 

To help with dealing with the certificate generation process, the script `generate_cert_keys.sh` to guide on the creation of a self signed certificate for the server. 


I was only able to make TLS work on the broker having the termination '.pem' on all these files.

In principle, they should be exact copies, but in some versions of openssl a DER (binary) file might be generated instead. 

