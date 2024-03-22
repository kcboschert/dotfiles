return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame file" },
    },
  },
  {
    "pgr0ss/vim-github-url",
    keys = {
      { "<leader>gu", "<cmd>:GitHubURL<cr>", desc = "Generate GitHub Link" },
    },
  },
}
