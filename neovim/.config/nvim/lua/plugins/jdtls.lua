return {
  {
    "mfussenegger/nvim-jdtls",
    -- TODO: is this correct, given we already have an ftplugin configuration?
    -- is this doing more than loading the plugin?
    ft = "java",
    keys = {
      { "<leader>df", "<cmd>lua require('jdtls').test_nearest_method()<cr>", desc = "Debug focused (nearest) test" },
      { "<leader>db", "<cmd>lua require('jdtls').test_class()<cr>", desc = "Debug tests in buffer" },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
}
