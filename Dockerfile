FROM ubuntu:18.04
MAINTAINER Willian Galvani <williangalvani@gmail.com>

RUN apt update && apt -y install gcc ninja-build python3-pip libobs-dev libgstreamer-plugins-base1.0-dev git && pip3 install meson

COPY CI/build.sh /root/

CMD ["/root/build.sh"]


