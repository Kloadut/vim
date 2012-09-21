# Installation 

## Linux, \*nix, Mac OSX Installation

Dependencies : git, ctags

```bash

    curl http://kload.fr/vim | sh

```

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

```bash
    echo colorscheme ir_black  >> ~/.vimrc.local
```

## Adding new plugins

Create `~/.vimrc.bundles.local` for any additional bundles.

To add a new bundle

```bash
    echo Bundle \'spf13/vim-colors\' >> ~/.vimrc.bundles.local
```
