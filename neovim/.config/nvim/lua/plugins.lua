return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '│' },
          delete       = { text = '-' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        }
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        opleader = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        extra = {
          above = "<leader>cO",
          below = "<leader>co",
          eol = "<leader>cA"
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
      -- insert `(` after select completion item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
}
