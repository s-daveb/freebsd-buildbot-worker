FROM freebsd/freebsd-runtime:14.3

ENV ASSUME_ALWAYS_YES="yes"
ENV PACKAGESITE="https://pkg.freebsd.org/FreeBSD:14:amd64/latest/"

COPY files/hosts /etc/hosts
RUN pkg bootstrap -f
RUN pkg install doas py311-buildbot-worker fastfetch

COPY files/usr-local-etc-doas.conf /usr/local/etc/doas.conf
COPY files/etc-rc.conf.local /etc/rc.conf.local

COPY files/credentials.txt /tmp/podman-build/creds
COPY files/setup_worker.sh /tmp/podman-build/setup_worker.sh

WORKDIR "/var/db/buildbot"
RUN mkdir -pv "$PWD/worker"
RUN sh /tmp/podman-build/setup_worker.sh

COPY files/worker-info /var/db/buildbot/worker/info/
RUN chown -R buildbot:buildbot /var/db/buildbot

COPY files/hosts /etc/hosts
USER buildbot
CMD [ "/bin/sh" ]
#CMD ["/usr/local/bin/buildbot-worker", "start", "worker"]
