#!/usr/bin/env bash

# Accepts as arguments:
#  - prefix: installation location

set -e

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
