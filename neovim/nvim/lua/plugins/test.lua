return {
  {
    "vim-test/vim-test",
    dependencies = {
      "preservim/vimux",
    },
    keys = {
      { "<leader>rf", "<cmd>wa<cr><cmd>TestNearest<cr>", desc = "Run focused (nearest) test" },
      { "<leader>rb", "<cmd>wa<cr><cmd>TestFile<cr>", desc = "Run tests in buffer" },
      { "<leader>ra", "<cmd>wa<cr><cmd>TestNearest<cr>", desc = "Run all tests" },
      { "<leader>rl", "<cmd>wa<cr><cmd>TestLast<cr>", desc = "Run previous test" },
    },
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.g["test#python#runner"] = "pytest"
      if vim.fn.executable("mvnd") == 1 then
        vim.g["test#java#maventest#executable"] = "mvnd"
      end
      vim.g["test#java#maventest#options"] = "-DtrimStackTrace=false"
    end,
  },
}
