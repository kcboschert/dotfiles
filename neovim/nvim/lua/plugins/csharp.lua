return {
  {
    "stevearc/conform.nvim",
    opts = {
      format = {
        timeout_ms = 3000,
      },
      -- formatters_by_ft = { cs = {} },
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = vim.fn.expand("~/.local/share/nvim/mason/bin/") .. "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
      log_level = vim.log.levels.TRACE,
    },
  },
}
