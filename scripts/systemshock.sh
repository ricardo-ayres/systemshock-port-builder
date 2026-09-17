#!/bin/env bash
echo "BUILDING SYSTEMSHOCK"
cd /src/systemshock &&
cmake . \
	-DENABLE_OPENGL=ON \
	-DENABLE_FLUIDSYNTH=OFF \
	-DENABLE_SDL2=ON &&
make -j $(nproc) &&
echo "SYSTEMSHOCK BUILT"
