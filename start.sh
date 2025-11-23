#!/bin/bash

export DISPLAY=:0
export PASSWD="qVXe%B;LF,m/h7j"

# Start X virtual framebuffer
Xvfb :0 -screen 0 1280x800x16 &

# Wait for Xvfb
sleep 2

# Start Openbox
openbox &

# Start x11vnc
x11vnc -display :0 -nopw -forever -shared -rfbauth /app/vncpass &

# Set VNC password
x11vnc -storepasswd "$PASSWD" /app/vncpass

# Start noVNC (fixed websocket port!)
/app/novnc/websockify/run  --web /app/novnc/web  8080 localhost:5900 &

# Auto memory cleaner (every 5 min)
while true; do
  echo 3 > /proc/sys/vm/drop_caches
  sleep 300
done
