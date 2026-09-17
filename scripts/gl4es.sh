#!/bin/env bash
echo "BUILDING GL4ES"
cd /src/gl4es &&
mkdir -pv build && cd build &&
cmake .. \
	-DNOX11=1 \
	-DGLX_STUBS=1 \
	-DEGL_WRAPPER=1 \
	-DGBM=1 &&
make -j $(nproc) &&
#cp -v /usr/lib/aarch64-linux-gnu/libGLU.so.1 /src/gl4es/lib/
echo "GL4ES BUILT"
