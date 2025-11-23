[supervisord]
nodaemon=true
logfile=/dev/null

[program:startscript]
command=/app/start.sh
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
