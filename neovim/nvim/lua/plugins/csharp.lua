return {
  {
    "stevearc/conform.nvim",
    opts = {
      format = {
        timeout_ms = 3000,
      },
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      log_level = vim.log.levels.TRACE,
    },
  },
}
