# Dotfiles

## Quick Start

Activate modules:

- `./activate.sh all` - activate all modules
- `./activate.sh neovim` - example for activating a specific module. In this case, neovim

## Manual Steps (required)

### Java

1. Ensure the runtime variables in `neovim/nvim/lua/plugins/java.lua` all point to the correct paths.

### Windows

1. Download and install FiraCode/CaskaydiaMono Nerd Font from [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)
2. Copy `alacritty/.alacritty.toml` to `%AppData%\alacritty\alacritty.toml` and uncomment everything under the `shell` top-level key.

## Local Configurations

You may have some configurations you'd only like present on certain machines. The following are loaded if present.

- `~/.aliases.local`
- `~/.env.local`
- `~/.gitconfig.local`

## TODO

1. [feat] [nvim-dap](https://github.com/mfussenegger/nvim-dap) for debugging

## Resources

- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet) - Find nerd font icons
