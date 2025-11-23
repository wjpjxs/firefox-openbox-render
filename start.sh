#!/bin/bash
set -e

# 使用 :0 显示
export DISPLAY=:0
export NO_AT_BRIDGE=1

# 启动 Xvfb
Xvfb :0 -screen 0 1280x800x24 &

# 启动 Openbox（轻量窗口管理器）
openbox &

# 设置固定 noVNC/VNC 密码（你提供的）
VNC_PASSWORD='qVXe%B;LF,m/h7j'
# 使用 x11vnc 存储密码文件（storepasswd 会创建可用的 /tmp/vncpasswd 文件）
printf "%s\n%s\n" "$VNC_PASSWORD" "$VNC_PASSWORD" | x11vnc -storepasswd - /tmp/vncpasswd

# 启动 x11vnc，使用密码文件
x11vnc -display :0 -rfbport 5900 -rfbauth /tmp/vncpasswd -forever -shared -noxdamage &

# 启动 websockify（noVNC web 前端目录在 /app/novnc/web）
# websockify 模块已通过 pip 安装为可执行命令 websockify
# 将 websocket 代理到本地 5900
websockify --web=/app/novnc/web 8080 localhost:5900 &

# 启动 Firefox（无头可视化环境已有 Xvfb）
firefox-esr &

# 保持前台（supervisord 管理 start.sh；这里用 sleep loop）
while true; do sleep 3600; done
