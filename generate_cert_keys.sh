#!/bin/bash
#
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <jairomer@protonmail.com> wrote this file. As long as you retain this notice 
# you can do whatever you want with this stuff. If we meet some day, and you 
# think this stuff is worth it, you can buy me a beer in return. 
# Jaime Romero Marín
# ----------------------------------------------------------------------------
# 
# NOTE:
# If attempting to use this script to enable TLS on mosquitto broker, 
# use the .pem files instead of the .crt files. 
# 
# In principle, they should be exact copies, but in some versions of 
# openssl a DER (binary) file might be generated instead. 
# 

KBITS=4096
CA_KEY='ca.key'
CA_CRT='ca.crt'
CA_PEM='ca.pem'
SRV_KEY='srv.key'
SRV_CRT='srv.crt'
SRV_PEM='srv.pem'
SRV_PEM_K='srv_key.pem'

mkdir ca_keys
cd ca_keys 

# Create CA Key Pair
echo " [*] Generating CA key pair. [*]"
openssl genrsa -des3 -out $CA_KEY $KBITS || exit 1

# Create CA Certificate 
echo "[*] Creating CA certificate. [*]"
openssl req -new -x509 -days 3650 -key $CA_KEY -out $CA_CRT || exit 1
cp $CA_CRT $CA_PEM 

# Generate a mosquitto broker key pair.
echo "[*] Generating server key pairs. [*]"

mkdir server_keys 
cd server_keys
openssl genrsa -out $SRV_KEY $KBITS || exit 1

# Create certificate from server key.  
echo "[*] Creating certificate from server key. [*]"
openssl req -new -out $SRV_CRT -key $SRV_KEY || exit 1
cp $SRV_KEY $SRV_PEM_K 
cp $SRV_CRT $SRV_PEM

# Verify and sign certificate with CA
echo "[*] Verify and sign certificate with CA's certificate and private key. [*]"
openssl x509 -req -in $SRV_CRT -CA ../$CA_CRT -CAkey ../$CA_KEY -CAcreateserial -out $SRV_CRT -days 3650

