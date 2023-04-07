return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          }
        },
        inactive_sections = {
          lualine_c = {
            { "filename", path = 1 },
          }
        },
      })
    end,
  },
}
