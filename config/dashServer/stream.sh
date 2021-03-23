ffmpeg -re -i /vagrant/host-setup/dashServer/worldcup2002.mp4 \
    -filter:v fps=25 -c:a aac -strict -2 -ac 2 -b:a 128k -c:v h264 -pix_fmt yuv420p -profile:v baseline -preset ultrafast -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 2.5M -maxrate 2.5M  -bufsize 5M -g 60 -s 384x216 -f flv rtmp://192.168.50.50/dash/bbb_low \
    -filter:v fps=30 -c:a aac -strict -2 -ac 2 -b:a 160k -c:v h264 -pix_fmt yuv420p -profile:v baseline -preset ultrafast -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 4M -maxrate 4M  -bufsize 8M -g 60 -s 512x288 -f flv rtmp://192.168.50.50/dash/bbb_med \
    -filter:v fps=60 -c:a aac -strict -2 -ac 2 -b:a 192k -c:v h264 -pix_fmt yuv420p -profile:v baseline -preset ultrafast -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 9M -maxrate 9M  -bufsize 9M -g 60 -s 640x360 -f flv rtmp://192.168.50.50/dash/bbb_high 


