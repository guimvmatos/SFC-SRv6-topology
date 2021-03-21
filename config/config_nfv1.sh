#!/bin/bash

DAQ_VERSION="2.0.7"

# Install required packages 
sudo apt-get update
apt-get -y install net-tools libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0 bison flex libpcap-dev libdumbnet-dev autoconf m4 perl automake gcc

cd ~/
autoreconf -f -i
wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
tar xvfz daq-2.0.7.tar.gz && cd daq-2.0.7
./configure --enable-nfq=yes
make
sudo make install

apt install scapy
# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::2/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo ip -6 neigh add fc00::5 lladdr ac:1f:6b:67:06:40 nud permanent dev eth1
sudo ip -6 neigh add fc00::8 lladdr 00:15:4d:00:00:04 nud permanent dev eth1
sudo ip -6 neigh add fc00::9 lladdr 00:15:4d:00:00:05 nud permanent dev eth1
sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 
sudo ip -6 route add fcf0:23::6006 via fc00::3
sudo ip -6 route add fcf0:12::100 encap seg6local action End dev eth1


# configure Snort (IDS)
cd ~/
sudo mkdir -p /etc/snort/ /etc/snort/rules/ /var/log/snort
touch /etc/snort/snort.ids.conf /etc/snort/rules/local.ids.rule
echo 'var RULE_PATH rules' >> /etc/snort/snort.ids.conf
echo 'include $RULE_PATH/local.ids.rule' >> /etc/snort/snort.ids.conf
echo 'alert udp fc00::1 any -> fc00::2 any (msg:"ALERT !!! UDP packet src=A::2 dst=B::2 dport= 5000 "; sid:5000)' >> /etc/snort/rules/local.ids.rule
echo 'alert icmp any any -> any any (msg:"PACOTE ICMP DETECTADO"; sid: 1)' >> /etc/snort/rules/local.ids.rule
echo 'config enable_gtp' >> /etc/snort/snort.ids.conf
echo 'preprocessor arpspoof' >> /etc/snort/snort.ids.conf
