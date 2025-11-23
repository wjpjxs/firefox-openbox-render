#!/bin/bash
export DISPLAY=:0

# 启动 Xvfb 和 Openbox
Xvfb :0 -screen 0 1280x800x24 &
openbox &

# 设置 noVNC 密码
echo "qVXe%B;LF,m/h7j" > /app/novnc/passwd

# 启动 x11vnc
x11vnc -display :0 -forever -rfbauth /app/novnc/passwd -shared -rfbport 5900 &

# 启动 noVNC
/app/novnc/websockify/run 8080 localhost:5900 --web /app/novnc/web
