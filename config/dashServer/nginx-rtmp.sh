
cd /vagrant/host-setup/dashServer/
sudo git clone https://github.com/ut0mt8/nginx-rtmp-module/
sudo git clone https://github.com/nginx/nginx.git
cd nginx
sudo ./auto/configure --add-module=../nginx-rtmp-module
sudo make
sudo make install
sudo wget https://isrv.pw/html5-live-streaming-with-mpeg-dash/nginx.service.txt -O /lib/systemd/system/nginx.service
sudo systemctl daemon-reload
sudo systemctl enable nginx.service