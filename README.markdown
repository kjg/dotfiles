# My dotfiles

## Install

Checkout this repo into `~/.dotfiles`. Then install the dotfiles:

    rake install

This rake task will not replace existing files, but it will replace existing symlinks.

The dotfiles will be symlinked, e.g. `~/.bash_profile` symlinked to `~/.dotfiles/bash_profile`.
