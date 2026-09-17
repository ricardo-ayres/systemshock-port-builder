#FROM ubuntu:22.04
FROM ubuntu:19.10 AS builddeps

ENV DEBIAN_FRONTEND=noninteractive

COPY <<EOF /etc/apt/sources.list
deb http://old-releases.ubuntu.com/ubuntu/ eoan main restricted
deb http://old-releases.ubuntu.com/ubuntu/ eoan-updates main restricted
deb http://old-releases.ubuntu.com/ubuntu/ eoan universe
deb http://old-releases.ubuntu.com/ubuntu/ eoan-updates universe
EOF

RUN <<EOF
apt update
apt install -y git build-essential cmake \
	libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev \
	libgbm-dev
EOF

RUN useradd -u 1000 -U -m builder
RUN mkdir /src
RUN chown builder:builder /src
RUN chmod 0755 /src

FROM builddeps
WORKDIR /src
USER 1000:1000
CMD ["/scripts/build-all.sh"]
