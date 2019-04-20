# Dotfiles

## Quick Start

1. Install [stow](https://www.gnu.org/software/stow/). `brew install stow` / `apt-get install stow`
2. Activate modules:
    1. `./activate.sh all` - activate all modules
    2. `./activate.sh neovim` - example for activating a specific module. In this case, neovim

## Manual Steps (required)

### coc-java

Modify `java.home` value in `neovim/.config/nvim/coc-settings.json` to point to JDK required by java language server.

## Local Configurations

You may have some configurations you'd only like present on certain machines. The following are loaded if present.
- `~/.aliases.local`
- `~/.env.local`
- `~/.gitconfig.local`
