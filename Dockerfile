FROM debian:bookworm

WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    firefox-esr xvfb x11vnc openbox dbus-x11 fonts-noto-cjk \
    wget unzip python3 python3-pip supervisor cron

# 安装 noVNC 和 websockify
RUN mkdir -p /app/novnc && \
    wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.zip -O /tmp/no.zip && \
    unzip /tmp/no.zip -d /app/ && mv /app/noVNC-1.4.0 /app/novnc/web && \
    wget https://github.com/novnc/websockify/archive/refs/tags/v0.11.0.zip -O /tmp/ws.zip && \
    unzip /tmp/ws.zip -d /app/ && mv /app/websockify-0.11.0 /app/novnc/websockify && \
    pip3 install -r /app/novnc/websockify/requirements.txt

COPY start.sh /app/start.sh
COPY supervisord.conf /app/supervisord.conf

RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["supervisord", "-c", "/app/supervisord.conf"]
