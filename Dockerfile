# Mosquito Docker deployment. 
# 	Mosquitto is a broker for the MQTT protocol version 3.1

FROM gliderlabs/alpine

# Note: If deploying in a raspberry pi, use 
# FROM hypriot/rpi-alpine

RUN apk --no-cache --update add mosquitto

COPY . /etc/mosquitto/ 

WORKDIR /etc/mosquitto

# Enable Mosquitto Username and Password Authentication via "userfile.txt"
# Passwords will be hashed after this command's execution. 
RUN mosquitto_passwd -U userfile.txt

EXPOSE 1883
EXPOSE 8883

# Run mosquitto
ENTRYPOINT mosquitto -v -c /etc/mosquitto/mosquitto.conf
