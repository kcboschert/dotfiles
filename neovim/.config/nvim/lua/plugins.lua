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
    "terrortylor/nvim-comment",
    keys = {
      { "<leader>cc", "<cmd>CommentToggle<cr>", desc = "Comment/Uncomment selection", mode = { "n", "v" } },
    },
    config = function()
      require("nvim_comment").setup()
    end,
  },
}
