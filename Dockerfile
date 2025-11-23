FROM debian:bookworm

WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
    firefox-esr \
    xvfb \
    x11vnc \
    openbox \
    dbus-x11 \
    fonts-noto-cjk \
    wget unzip python3 python3-pip supervisor cron ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# 安装 noVNC（web 前端）并通过 pip 安装 websockify（可靠）
RUN mkdir -p /app/novnc \
 && wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.zip -O /tmp/novnc.zip \
 && unzip /tmp/novnc.zip -d /app/ \
 && mv /app/noVNC-1.4.0 /app/novnc/web \
 && pip3 install --no-cache-dir websockify==0.11.0

COPY start.sh /app/start.sh
COPY supervisord.conf /app/supervisord.conf

RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["supervisord", "-c", "/app/supervisord.conf"]
