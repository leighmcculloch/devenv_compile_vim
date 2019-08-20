#!/usr/bin/env bash

set -e

apt-get -y install \
  build-essential \
  libncurses5-dev \
  libacl1-dev \
  libc6-dev \
  libselinux1-dev \
  libtinfo-dev \
  libgpm-dev \
  gettext \
  liblua5.2-dev \
  libperl-dev \
  python3-dev \
  ruby-dev \
  tcl-dev
apt-get -y autoremove
apt-get -y clean

ln -sf /usr/include/lua5.2/* /usr/include/
ln -sf /usr/lib/x86_64-linux-gnu/liblua5.2.so.0.0.0 /usr/lib/liblua.so
