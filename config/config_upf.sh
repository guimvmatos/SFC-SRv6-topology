#!/bin/bash

# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::4/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 

# Configure External network (ext)
#cd ~/
#rm -rf SR-snort-demo
#git clone https://github.com/SRouting/SR-Snort-demo
#cd SR-Snort-demo/config/
#sh deploy-term.sh add site_b veth0 inet6 B::1/64 B::2/64

# Configure Routing
#ip -6 route add 2::/64 via 23::2

# Configure SRv6 End.D6 behaviour for traffic going to Ext
#ip -6 route add local 3::d6/128 dev lo

# Configure SR SFC policies for reverse traffic
#ip -6 route add A::/64 encap seg6 mode encap segs 2::f2,2::f1,1::D6 dev eth1
