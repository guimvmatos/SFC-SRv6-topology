#!/bin/bash

DAQ_VERSION="2.0.7"

# Install required packages 
sudo apt-get update
apt-get -y install net-tools libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0 bison flex libpcap-dev libdumbnet-dev autoconf m4 perl automake gcc

cd ~/
autoreconf -f -i
wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz && tar xvfz daq-2.0.7.tar.gz && cd daq-2.0.7 && ./configure --enable-nfq=yes && make && sudo make install


# Configure Interfaces
sudo ip link set dev lo up
sudo ip -6 addr add fc00::3/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 
sudo ip -6 route add fcf0:23::6006 encap seg6local action End.DT6 table 254 dev eth1
sudo ip6tables -t mangle -A POSTROUTING -p icmpv6 --icmpv6-type redirect -j DROP



# configure Snort (IPS)

cd ~/
sudo mkdir -p /etc/snort/ /etc/snort/rules/ /var/log/snort
touch /etc/snort/snort.ips.conf /etc/snort/rules/local.ips.rule
echo 'var RULE_PATH rules' >> /etc/snort/snort.ips.conf
echo 'include $RULE_PATH/local.ips.rule' >> /etc/snort/snort.ips.conf
echo 'drop udp fc00::1 any -> fc00::2 6000 (msg:"UDP packet src= A::2 dst=B::2 dport= 6000 "; sid:6000)' >> /etc/snort/rules/local.ips.rule
echo 'preprocessor arpspoof' >> /etc/snort/snort.ips.conf
echo 'config daq: nfq' >> /etc/snort/snort.ips.conf 
echo 'config daq_dir: /usr/local/lib/daq' >> /etc/snort/snort.ips.conf 
echo 'config daq_mode: inline' >> /etc/snort/snort.ips.conf
echo 'config daq_var: queue=0' >> /etc/snort/snort.ips.conf
echo 'config daq_var: proto=ip6' >> /etc/snort/snort.ips.conf
echo 'config enable_gtp' >> /etc/snort/snort.ips.conf
#ip6tables -I INPUT -d 2::f2 -j NFQUEUE --queue-num=0
