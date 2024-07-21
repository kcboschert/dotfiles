# Dotfiles

## Quick Start

Activate modules:

- `./activate.sh all` - activate all modules
- `./activate.sh neovim` - example for activating a specific module. In this case, neovim

## Manual Steps (required)

### nvim+jdtls

1. Install Java JDK
2. Install jdtls via `:Mason`
3. Modify variables in `neovim/.config/nvim/ftplugin/java.lua` so `java_17_jdk_path` points to the JDK and the `jdtls_dir` points to the installation directory of eclipse.jdt.ls.

### Windows

1. Download and install FiraCode Nerd Font from [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)
2. Copy `alacritty/.alacritty.yml` to `%AppData%\alacritty\alacritty.yml` and uncomment everything under the `shell` top-level key.

## Local Configurations

You may have some configurations you'd only like present on certain machines. The following are loaded if present.

- `~/.aliases.local`
- `~/.env.local`
- `~/.gitconfig.local`

## TODO

1. [fix] codelens doesn't show up for Lombok private fields
2. [feat] [nvim-dap](https://github.com/mfussenegger/nvim-dap) for debugging
3. [feat] shortcut for formatting visual selection instead of entire file
4. [fix] strange interaction where tab key after a newline will jump to a seemingly-random line in insert mode. Seems related to LSP setup or lsp_signature
5. [feat] shortcuts for toggling indentlines for nicer copy/paste
