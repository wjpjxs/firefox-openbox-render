#!/bin/bash
export DISPLAY=:99
export NO_AT_BRIDGE=1

# 启动 Xvfb
Xvfb :99 -screen 0 1280x720x24 &

# 启动 openbox
openbox &

# 启动 VNC，并设置固定密码
VNC_PASSWORD='qVXe%B;LF,m/h7j'
echo $VNC_PASSWORD > /tmp/vncpass.txt
x11vnc -display :99 -rfbauth /tmp/vncpass.txt -forever -shared -rfbport 5900 &

# 启动 noVNC
/app/novnc/websockify/run 8080 localhost:5900 --web /app/novnc/web &

# 启动 Firefox
firefox-esr &

# 定时清理内存（每 5 分钟）
(crontab -l 2>/dev/null; echo "*/5 * * * * sync; echo 3 > /proc/sys/vm/drop_caches") | crontab -
service cron start

# 保持容器运行
tail -f /dev/null
