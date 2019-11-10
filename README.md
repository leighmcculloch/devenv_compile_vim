# devenv_compile_vim

Docker image and Makefile for building vim from source on Debian Buster.

The resulting build is relatively close to what you get with a `vim-nox`
variant available on Debia Vim is built with huge features and all language
interpreters, and so the build is similar to the `vim-nox` variant available in
Debian distributions.

This is intended for use with `leighmcculloch/devenv`.

## Usage

Download the binary from bintray:

https://dl.bintray.com/leighmcculloch/vim_compile/

Extract it to your install prefix. You'll also need to set the `VIM`
environment variable to point to the location of the `share/vim` folder within
your install prefix, e.g. `/usr/local/share/vim`.

You may also need to install library dependencies of vim-nox. To grab them:

```
sudo apt-get install $(apt-cache depends vim-nox | awk '/Depends: lib/{print$2}')
```

## Building

```
make build
```

At the end of building a file `vim-*.tar.gz` will be present. It contains all
the files that are written to the install prefix, e.g. `/usr/local/`. 
