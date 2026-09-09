# Dotfiles

## Quick Start

```zsh
mise bootstrap # setup
mise run activate neovim # install single module
mise run all # install all modules
mise run deactivate neovim # stop using a module
mise run deactivateall # stop using all modules
```

## Manual Steps (required)

### Java

1. Ensure the runtime variables in `neovim/nvim/lua/plugins/java.lua` all point to the correct paths.

## Local Configurations

You may have some configurations you'd only like present on certain machines. The following are loaded if present.

- `~/.aliases.local`
- `~/.env.local`
- `~/.gitconfig.local`

## TODO

1. [feat] [nvim-dap](https://github.com/mfussenegger/nvim-dap) for debugging

## Resources

- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet) - Find nerd font icons
