# vim-compile
Scripts for compiling vim with huge features and all language interpreters, to
provide the same feature set as what is available in the commonly used
`vim-nox` build available on Debian distributions of Linux.

## Scripts

### `install-debian.sh`

Works for me on Debian Stretch (9) and Buster (10).

```
git clone https://github.com/leighmcculloch/vim-compile \
  && git clone https://github.com/vim/vim \
  && cd vim
  && sudo ../vim-compile/install-debian.sh <install-path-prefix>
```

Where:

- `<install-path-prefix>` = `/usr/local` or your custom path.

Known issues:

- The only feature missing in the `--version` readout when compared to `vim-nox`
is `farsi`. If you happen to know how to fix that please open an issue or pull
request.

## Contributing

If you happen to know how to compile vim with the same feature set for other
linux distributions, you're welcome to open a pull request adding a script
named `install-<distribution>.sh`.
