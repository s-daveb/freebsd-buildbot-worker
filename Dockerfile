FROM freebsd/freebsd-runtime:14.3

ENV ASSUME_ALWAYS_YES=yes
ENV PACKAGESITE="https://pkg.freebsd.org/FreeBSD:14:amd64/latest/"

COPY hosts /etc/hosts

RUN pkg bootstrap -f && pkg update && pkg upgrade -f 
RUN pkg install fastfetch 

CMD ["/bin/sh", "-c", "fastfetch; sh -l"]
