#!/bin/bash

sudo apt-get update

sudo apt-get -y install scapy net-tools nmap build-essential git libpcre3-dev libssl-dev zlib1g-dev ffmpeg

sudo ip link set dev lo up
sudo ip -6 addr add fc00::8/64 dev eth1
sudo ip link set dev eth1 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1
sudo ip -6 neigh add fc00::5 lladdr ac:1f:6b:67:06:40 nud permanent dev eth1
sudo ip -6 neigh add fc00::9 lladdr 00:15:4d:00:00:05 nud permanent dev eth1
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

