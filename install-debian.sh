#!/usr/bin/env bash

# Confirmed to work with Debian 9 (Stretch) and Debian 10 (Buster).

# Accepts as arguments:
#  - prefix: installation location

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

./configure \
  --prefix=$1 \
  --enable-fail-if-missing \
  --with-features=huge \
  \
  --without-x \
  --without-local-dir \
  --enable-acl \
  --enable-terminal \
  --enable-gpm \
  --enable-selinux \
  --disable-smack \
  --enable-gui=no \
  --enable-multibyte \
  \
  --enable-luainterp \
  --disable-mzschemeinterp \
  --enable-perlinterp \
  --enable-python3interp --with-python3-config-dir=$(python3-config --configdir) \
  --disable-pythoninterp \
  --enable-rubyinterp \
  --enable-tclinterp \
  \
  --with-compiledby="https://github.com/leighmcculloch/vim-compile install-debian.sh"

make install
