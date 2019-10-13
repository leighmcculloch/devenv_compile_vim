#!/usr/bin/env bash

set -e

sourcelist=/etc/apt/sources.list
sourcelistd=/etc/apt/sources.list.d
filename=deb-src.list

cat $sourcelist | sed 's/^deb /deb-src /' | tee $sourcelistd/$filename
apt-get update
apt-get build-dep -y vim
rm $sourcelistd/$filename
