FROM debian:buster

COPY deb-src.list /etc/apt/sources.list.d/deb-src.list
RUN apt-get update
RUN apt-get install -y curl build-essential fakeroot devscripts

RUN apt-get build-dep -y vim
ARG VIM_COMMIT
RUN curl https://codeload.github.com/vim/vim/tar.gz/$VIM_COMMIT | tar xz

WORKDIR /vim-$VIM_COMMIT
ENV INSTALL_PREFIX=/vim-$VIM_COMMIT-out
RUN ./configure \
  --prefix=$INSTALL_PREFIX \
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
  --with-compiledby="https://github.com/leighmcculloch/vim-compile"
RUN make
RUN make install
RUN cd $INSTALL_PREFIX \
  && tar zcvf /vim-$VIM_COMMIT.tar.gz .
