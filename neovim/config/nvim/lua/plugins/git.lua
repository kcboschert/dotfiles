return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>ga", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame line (virtual)" },
      { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Blame file" },
    },
  },
  {
    "pgr0ss/vim-github-url",
    keys = {
      { "<leader>gu", "<cmd>:GitHubURL<cr>", desc = "Generate GitHub Link" },
    },
  },
}
