[supervisord]
nodaemon=true

[program:startscript]
command=/app/start.sh
autostart=true
autorestart=true
startsecs=2
redirect_stderr=true

; 输出到 stdout/stderr，不做轮转以避免 Illegal seek 问题
stdout_logfile=/dev/stdout
stderr_logfile=/dev/stderr
stdout_logfile_maxbytes=0
stderr_logfile_maxbytes=0

# 启动 Firefox（无头可视化环境已有 Xvfb）
firefox-esr &

# 保持前台（supervisord 管理 start.sh；这里用 sleep loop）
while true; do sleep 3600; done
