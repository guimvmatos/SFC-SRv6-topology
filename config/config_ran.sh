#!/bin/bash

# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::1/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p

# Configure Branches (BR1 and BR2)
#cd ~/
#rm -rf SR-snort-demo
#git clone https://github.com/SRouting/SR-Snort-demo
#cd SR-Snort-demo/config/
#sh deploy-term.sh add site_a veth0 inet6 A::1/64 A::2/64

# Configure SR SFC policies
#ip -6 route add B::/64 encap seg6 mode encap segs 2::f1,2::f2,3::D6 dev eth1
#tudo o que for para b:: sai com as SIDs acima pela interface eth1

# Configure Routing
#ip -6 route add 2::/64 via 12::2

# Configure SRv6 End.D6 behaviour for reverse traffic (B-->A)
#ip -6 route add local 1::d6/128 dev lo
