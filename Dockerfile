FROM freebsd/freebsd-runtime:14.2

ENV ASSUME_ALWAYS_YES=yes
ENV PACKAGESITE="https://pkg.freebsd.org/FreeBSD:14:amd64/quarterly/"

COPY hosts /etc/hosts
RUN pkg bootstrap -f && pkg update && (pkg upgrade || true)

ENV ASSUME_ALWAYS_YES=no

# Update pkg and bootstrap if necessary
CMD ["/bin/sh" ]
