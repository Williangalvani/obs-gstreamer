FROM ubuntu:18.04
MAINTAINER Willian Galvani <williangalvani@gmail.com>

RUN apt update && apt -y install gcc ninja-build python3-pip libobs-dev libgstreamer-plugins-base1.0-dev mingw-w64 mingw-w64-tools ninja-build python3-pip unzip wget wine-stable git && pip3 install meson

COPY CI/* /root/

CMD ["/root/build.sh"]
CMD ["/root/build_windows.sh"]


