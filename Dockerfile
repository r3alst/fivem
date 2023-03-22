FROM ubuntu:22.04

# Removing breaking apt source file
RUN mv /etc/apt/apt.conf.d/docker-clean /srv

RUN apt-get update && \
    apt-get install -y curl libatomic1 libcurl4-gnutls-dev lib32gcc-s1 lib32stdc++6 lib32z1 libssl3 xz-utils

# Downloading Fivem Server
RUN mkdir /home/fivem && \
    curl -fsSL https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6356-231521cc6e614f417c792fac672477f624895563/fx.tar.xz | tar xJvf - -C /home/fivem/

WORKDIR /home/fivem/

# /home/fivem/txData, resources, cache needs to be mounted externally

# Set environment variables
ENV SERVER_NAME="Ukasha V Server"
ENV SERVER_PORT="30120"

# Expose ports
EXPOSE 30120/tcp
EXPOSE 30120/udp
# txAdmin
EXPOSE 40120/tcp

# Define startup command
CMD ["/home/fivem/run.sh"]