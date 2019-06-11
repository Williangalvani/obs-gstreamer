#!/bin/bash
if [[ ! -d "/root/obs-gstreamer" ]]; then
    echo "Local QGC not found, cloning master!"
    git clone --recursive https://github.com/williangalvani/obs-gstreamer/
    cloned=true
fi
cd /root/obs-gstreamer
rm -R linux
ninja clean
CFLAGS=-DOLD_OBS_API meson --buildtype release linux
ninja -C linux
