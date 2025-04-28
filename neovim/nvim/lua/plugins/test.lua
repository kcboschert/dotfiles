return {
  {
    {
      "folke/which-key.nvim",
      opts = {
        spec = {
          { "<leader>r", group = "run tests" },
        },
      },
    },
  },
  {
    "vim-test/vim-test",
    dependencies = {
      "preservim/vimux",
    },
    keys = {
      { "<leader>rf", "<cmd>wa<cr><cmd>TestNearest<cr>", desc = "Run focused (nearest) test" },
      { "<leader>rb", "<cmd>wa<cr><cmd>TestFile<cr>", desc = "Run tests in buffer" },
      { "<leader>ra", "<cmd>wa<cr><cmd>TestSuite<cr>", desc = "Run all tests" },
      { "<leader>rl", "<cmd>wa<cr><cmd>TestLast<cr>", desc = "Run previous test" },
    },
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.g["test#python#runner"] = "pytest"
      if vim.fn.executable("mvnd") == 1 then
        vim.g["test#java#maventest#executable"] = "mvnd"
      end
      -- if project has addons/gdunit4 directory, make it the dotnet test executable
      if vim.fn.findfile("addons/gdUnit4/runtest.sh") ~= "" then
        vim.g["test#custom_runners"] = { ["csharp"] = { "Gdunit4" } }

        if vim.fn.findfile("Makefile") ~= "" then
          vim.g["test#custom_transformations"] = {
            ["makefile"] = function(cmd)
              return "make build && " .. cmd
            end,
          }
          vim.g["test#transformation"] = "makefile"
        end
      end
      vim.g["test#java#maventest#options"] = "-DtrimStackTrace=false"
    end,
  },
}
