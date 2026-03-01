FROM ubuntu:18.04

RUN apt update -y
RUN apt install -y autotools-dev autoconf build-essential libtool

RUN apt install -y libfftw3-dev libsamplerate0-dev libeigen3-dev python3
RUN ln -s /usr/bin/python3 /usr/bin/python

COPY . /opt/artifastring

WORKDIR /opt/artifastring

RUN ./autogen.sh \
  && mkdir -p build \
  && cd build \
  && ../configure \
  && make \
  && make install
