# Dotfiles

## Quick Start

1. Install [stow](https://www.gnu.org/software/stow/). `brew install stow` / `apt-get install stow`
2. Activate modules:
    1. `./activate.sh all` - activate all modules
    2. `./activate.sh neovim` - example for activating a specific module. In this case, neovim

## Manual Steps (required)

### nvim+jdtls

1. Install Java JDK
2. Install jdtls via `:Mason`
3. Modify variables in `neovim/.config/nvim/ftplugin/java.lua` so `java_17_jdk_path` points to the JDK and the `jdtls_dir` points to the installation directory of eclipse.jdt.ls.

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
