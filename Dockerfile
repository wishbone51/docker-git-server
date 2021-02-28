FROM alpine:3.13.2

RUN apk add --no-cache \
  openssh=8.4_p1-r2 \
  git=2.30.1-r0

RUN ssh-keygen -A

WORKDIR /home/git

RUN mkdir -p /home/git/keys \
 && adduser -D -s /usr/bin/git-shell git \
 && echo git:12345 | chpasswd \
 && mkdir /home/git/.ssh

COPY git-shell-commands /home/git/git-shell-commands
COPY sshd_config /etc/ssh/sshd_config

COPY start.sh /usr/local/bin/start.sh

EXPOSE 22

# the entrypoint script ends with ssh -D .. You can append to this with a CMD

ENTRYPOINT ["sh", "/usr/local/bin/start.sh"]
