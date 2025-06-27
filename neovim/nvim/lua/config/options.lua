-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false

opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

opt.clipboard = ""
opt.mouse = ""
opt.relativenumber = false
opt.wrap = true
opt.ruler = true
opt.showmatch = true
opt.wrap = true

vim.g.lazyvim_ruby_lsp = "ruby_lsp" -- "solargraph"/"ruby_lsp"
vim.g.root_spec = { "cwd" }
