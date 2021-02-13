#!/bin/bash

# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::1/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo ip -6 neigh add fc00::5 lladdr ac:1f:6b:67:06:40 nud permanent dev eth1
sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p

# para habilitar srv6 a partir deste host
ip -6 route add fcf0:12::100 via fc00::2
#ip -6 route add fc00::4 encap seg6 mode encap segs fcf0:12::100,fcf0:23::6006 dev eth1
ip -6 route add fc00::4 encap seg6 mode inline segs fcf0:12::100,fcf0:23::6006 dev eth1
