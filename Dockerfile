FROM debian:bookworm

WORKDIR /app

# 基础依赖
RUN apt update && apt install -y \
    firefox-esr \
    xvfb \
    x11vnc \
    openbox \
    dbus-x11 \
    fonts-noto-cjk \
    wget unzip python3 python3-pip supervisor \
    cron \
    python3-dev libffi-dev build-essential

# Install noVNC stable release + websockify
RUN mkdir -p /app/novnc && \
    wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.zip -O /tmp/novnc.zip && \
    unzip /tmp/novnc.zip -d /app/ && \
    mv /app/noVNC-1.4.0 /app/novnc/web && \
    wget https://github.com/novnc/websockify/archive/refs/tags/v0.11.0.zip -O /tmp/ws.zip && \
    unzip /tmp/ws.zip -d /app/ && \
    mv /app/websockify-0.11.0 /app/novnc/websockify && \
    pip3 install websockify

COPY start.sh /app/start.sh
COPY supervisord.conf /app/supervisord.conf

RUN chmod +x /app/start.sh

EXPOSE 8080

CMD ["supervisord", "-c", "/app/supervisord.conf"]
