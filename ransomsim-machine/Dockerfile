FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server inotify-tools supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash student \
    && echo "student:student" | chpasswd

COPY ssh/sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /opt/mayajal/entrypoint.sh
COPY watcher/watcher.sh /opt/mayajal/watcher.sh
COPY watcher/supervisord.conf /etc/supervisor/conf.d/mayajal.conf
RUN chmod 0755 /opt/mayajal/entrypoint.sh /opt/mayajal/watcher.sh \
    && mkdir -p /run/sshd

EXPOSE 22
ENTRYPOINT ["/opt/mayajal/entrypoint.sh"]
