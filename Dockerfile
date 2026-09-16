FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
apt update
apt install -y git build-essential cmake libsdl2-dev libsdl2-image-dev \
	libsdl2-mixer-dev
EOF

COPY --chmod=755 <<EOF /root/entrypoint.sh
#!/bin/env bash
cd /root/ &&
git clone https://github.com/Interrupt/systemshock

cd /root/systemshock &&
git pull &&
cmake . \\
	-DENABLE_OPENGL=OFF \\
	-DENABLE_FLUIDSYNTH=OFF \\
	-DENABLE_SDL2=ON &&
make -j $(nproc) &&
mkdir -p outputs/libs.aarch64
cp -v systemshock outputs/sshock.aarch64
cp -v /lib/aarch64-linux-gnu/libGLU.so.1 outputs/libs.aarch64/
EOF

# Run command
CMD ["/root/entrypoint.sh"]
