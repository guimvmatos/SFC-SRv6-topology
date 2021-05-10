#!/bin/bash

# Install required packages 
sudo apt-get update
apt-get -y install net-tools

# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc10::3/64 dev eth1
sudo ip link set dev eth1 up

sudo ip -6 neigh add fc10::1 lladdr 08:00:27:bb:bb:bb nud permanent dev enp0s9 #ran
sudo ip -6 neigh add fc20::2 lladdr 08:00:27:dd:dd:dd nud permanent dev enp0s9 #dashServer
sudo ip -6 route add fc20::2 via fc10::1 #rota para dashServer saindo de link secundário direto pra RAN

sudo ip -6 route add fcf0:23::9009 encap seg6local action End dev eth1

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 
