return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 999,
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  --formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 998,
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    branch = "master",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim"
    },
    keys = {
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
      { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
      { "<space>d", vim.diagnostic.open_float, desc = "Show diagnostic" },
      { "<leader>d", vim.diagnostic.setloclist, desc = "Show diagnostics pane" },
      { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
    },
    config = function()
      require("neodev").setup()

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name) lspconfig[server_name].setup({}) end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                completion = { callSnippet = "Replace" },
                workspace = { checkThirdParty = false },
              },
            },
          })
        end,
        ["tsserver"] = function()
          lspconfig.tsserver.setup({
            init_options = {
              completionDisableFilterText = true, -- prevent omni completion from inserting extra period
            },
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            settings = {
              yaml = { keyOrdering = false },
            },
          })
        end,
        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            init_options = {
              jvm_args = { "-javaagent:/usr/local/share/lombok/lombok.jar" }
            }
          })
        end,
      })
    end,
  }
}
