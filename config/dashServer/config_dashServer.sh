#!/bin/bash
sudo apt-get update
sudo apt-get -y install scapy net-tools nmap build-essential git libpcre3-dev libssl-dev zlib1g-dev ffmpeg
# Configure Interfaces
sudo ip link set dev lo up

sudo ip -6 addr add fc00::8/64 dev eth1 #link primário
sudo ip link set dev eth1 up

sudo ip -6 addr add fc20::2/64 dev eth2 #link secundário
sudo ip link set dev eth2 up

sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1 #ran
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1 #nfv1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1 #nfv2
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1 #nfv3

sudo ip -6 neigh add fc00::5 lladdr 00:15:4d:00:00:04 nud permanent dev eth1 #upf
sudo ip -6 neigh add fc20::1 lladdr 08:00:27:cc:cc:cc nud permanent dev eth2 #upf

sudo ip -6 neigh add fc00::9 lladdr 00:15:4d:00:00:06 nud permanent dev eth1 #clientVlc
sudo ip -6 neigh add fc10::1 lladdr 08:00:27:aa:aa:aa nud permanent dev eth2 #clientVlc

sudo ip -6 route add fc00::9 via fc20::1 #rota para clientVlc saindo de link secundário direto pra UPF
sudo ip -6 route add fc10::2 via fc20::1 #rota para clientVlc saindo de link secundário direto pra UPF

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 

cd ~/
sudo git clone https://github.com/ut0mt8/nginx-rtmp-module/
sudo git clone https://github.com/nginx/nginx.git
cd nginx
sudo ./auto/configure --add-module=../nginx-rtmp-module
sudo make
sudo make install
sudo wget https://isrv.pw/html5-live-streaming-with-mpeg-dash/nginx.service.txt -O /lib/systemd/system/nginx.service
sudo systemctl daemon-reload
sudo systemctl enable nginx.service

