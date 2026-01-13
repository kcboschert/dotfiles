return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      style = "night",
      on_colors = function(colors)
        colors.border = "#0a0b12" -- Darker for clearer separation
      end,
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
    },
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = {
        transparent = true,
      },
      colors = {
        mode = "default",
        fluo = "pink",
      },
      ui = {
        borders = "fluo",
      },
    },
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        bg = true,
      },
    },
  },
  {
    "neanias/everforest-nvim",
    lazy = false,
    version = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 1,
        ui_contrast = "low",
        diagnostic_text_highlight = true,
        diagnostic_line_highlight = true,
        on_highlights = function(hl, _)
          hl["@string.special.symbol.ruby"] = { link = "@field" }
        end,
      })
    end,
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        style = "vulgaris",
        transparent = true,
      })
      -- require("bamboo").load()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
