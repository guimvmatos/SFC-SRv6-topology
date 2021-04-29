#!/bin/bash
sudo apt-get update
sudo apt-get -y install scapy net-tools

sudo ip link set dev lo up

sudo ip -6 addr add fc00::9/64 dev enp0s8 #link primário
sudo ip link set dev enp0s8 up
sudo ip link set enp0s8 mtu 10000

sudo ip -6 addr add fc10::2/64 dev enp0s9 #link secundário
sudo ip link set dev enp0s9 up
sudo ip link set enp0s9 mtu 8000

sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev enp0s8 #nfv1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev enp0s8 #nfv2
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev enp0s8 #nfv3
sudo ip -6 neigh add fc00::5 lladdr 00:15:4d:00:00:04 nud permanent dev enp0s8 #upf

sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev enp0s8 #ran
sudo ip -6 neigh add fc10::1 lladdr 08:00:27:bb:bb:bb nud permanent dev enp0s9 #ran

sudo ip -6 neigh add fc00::8 lladdr 00:15:4d:00:00:05 nud permanent dev enp0s8 #dashServer
sudo ip -6 neigh add fc20::2 lladdr 08:00:27:dd:dd:dd nud permanent dev enp0s9 #dashServer

sudo ip -6 route add fc00::8 via fc10::1 #rota para dashServer saindo de link secundário direto pra RAN
sudo ip -6 route add fc20::2 via fc10::1 #rota para dashServer saindo de link secundário direto pra RAN

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.enp0s8.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.enp0s8.seg6_enabled=1
sudo sysctl -p 