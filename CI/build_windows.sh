#!/bin/bash
if [[ ! -d "/root/obs-gstreamer" ]]; then
    echo "Local QGC not found, cloning master!"
    git clone --recursive https://github.com/williangalvani/obs-gstreamer/
    cloned=true
fi
cd /root/obs-gstreamer
rm -R linux
rm -R windows
rm cross.txt
wget -nc https://cdn-fastly.obsproject.com/downloads/OBS-Studio-23.1-Full-x64.zip
wget -nc https://github.com/obsproject/obs-studio/archive/23.1.0.tar.gz

unzip -u OBS-Studio-23.1-Full-x64.zip
tar xzvf 23.1.0.tar.gz

ln -s obs-studio-23.1.0/libobs/ obs

wget -nc https://gstreamer.freedesktop.org/data/pkg/windows/1.14.4/gstreamer-1.0-devel-x86_64-1.14.4.msi
wget -nc https://gstreamer.freedesktop.org/data/pkg/windows/1.14.4/gstreamer-1.0-x86_64-1.14.4.msi

msiexec -passive -i gstreamer-1.0-x86_64-1.14.4.msi
msiexec -passive -i gstreamer-1.0-devel-x86_64-1.14.4.msi

ln -s ~/.wine/drive_c/ /c

export PKG_CONFIG_PATH=/c/gstreamer/1.0/x86_64/lib/pkgconfig/

echo "[binaries]" >> cross.txt
echo "c = 'x86_64-w64-mingw32-gcc'" >> cross.txt
echo "cpp = 'x86_64-w64-mingw32-g++'" >> cross.txt
echo "ar = 'x86_64-w64-mingw32-ar'" >> cross.txt
echo "strip = 'x86_64-w64-mingw32-strip'" >> cross.txt
echo "pkgconfig = 'x86_64-w64-mingw32-pkg-config'" >> cross.txt
echo "windres = 'x86_64-w64-mingw32-windres'" >> cross.txt

echo "[host_machine]" >> cross.txt
echo "system = 'windows'" >> cross.txt
echo "cpu_family = 'x86_64'" >> cross.txt
echo "cpu = 'x86_64'" >> cross.txt
echo "endian = 'little'" >> cross.txt

meson --buildtype release --cross-file cross.txt windows
ninja -C windows