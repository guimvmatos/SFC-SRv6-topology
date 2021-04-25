#!/bin/bash
apt install scapy
# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::5/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo ip -6 neigh add fc00::8 lladdr 00:15:4d:00:00:05 nud permanent dev eth1
sudo ip -6 neigh add fc00::9 lladdr 00:15:4d:00:00:06 nud permanent dev eth1

sudo ip -6 addr add fc20::1/64 dev eth2
sudo ip link set dev eth2 up
ip -6 neigh add fc20::2 lladdr 08:00:27:dd:dd:dd nud permanent dev eth2

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 

ip -6 route add fc00::100 via fc00::2