return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
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
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {},
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup({
        transparent = true, -- Set transparent background.
        fluo_color = "pink", -- Color used as fluo. Available values are pink, yellow, orange, or green.
        mode = "desaturate", -- Mode of the colors. Available values are: dark, bright, desaturate, or base.
        dark_theme = true, -- Set the theme with dark background.
        high_contrast = false, -- Make the dark background darker or the light background lighter.
        aggressive_spell = false, -- Use colors for spell check.
      })
    end,
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
        italics = true,
        disable_italic_comments = false,
        on_highlights = function(hl, _)
          hl["@string.special.symbol.ruby"] = { link = "@field" }
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
