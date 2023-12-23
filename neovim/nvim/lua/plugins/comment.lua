return {
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
          eol = "<leader>cA",
        },
      })
    end,
  },
}
