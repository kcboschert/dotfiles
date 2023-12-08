--stylua: ignore
if true then return {} end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = vim.fn.expand("~/.local/share/nvim/mason/bin/") .. "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
}
