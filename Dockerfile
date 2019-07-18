# Mosquito Docker deployment. 
# 	Mosquitto is a broker for the MQTT protocol version 3.1

FROM gliderlabs/alpine

ENV CA_DIR=/etc/mosquitto/ca_certificates
ENV CRTS_DIR=/etc/mosquitto/certs
ENV KEY_DIR=/etc/mosquitto/server_keys 
ENV DETAILS='/CN=mqtt.broker.org'

RUN apk --no-cache --update add openssl-dev openssl mosquitto

COPY . /etc/mosquitto/ 

WORKDIR /etc/mosquitto

# Enable Mosquitto Username and Password Authentication via "userfile.txt"
# Passwords will be hashed after this command's execution. 
RUN mosquitto_passwd -U userfile.txt

EXPOSE 1883

# Run mosquitto
ENTRYPOINT mosquitto -v -c /etc/mosquitto/mosquitto.conf
