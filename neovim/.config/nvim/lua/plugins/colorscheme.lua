return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "moon",
    },
  },

  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
