vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.refresh()
    end
  end,
})

local on_attach_codelens = function(_, bufnr)
  vim.lsp.codelens.refresh()
  -- refresh codelens on TextChanged and InsertLeave as well
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
  })
end

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
    keys = {
      { "<leader>F", vim.lsp.buf.format, desc = "Apply formatting (buffer)" },
    },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.google_java_format,
          -- nls.builtins.diagnostics.checkstyle.with({
          --   extra_args = { "-c", "/google_checks.xml" },
          -- }),
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
      "mason.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    keys = {
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
      { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
      { "<space>d", vim.diagnostic.open_float, desc = "Show diagnostic" },
      { "<leader>n", vim.diagnostic.setloclist, desc = "Show diagnostics pane" },
      { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
    },
    config = function()
      require("neodev").setup({
        library = { plugins = { "neotest" }, types = true },
      })
      local cmp = require('cmp')
      local luasnip = require("luasnip")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = { -- required
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        })
      })

      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach_codelens,
            capabilities = cmp_capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach_codelens,
            capabilities = cmp_capabilities,
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
            on_attach = on_attach_codelens,
            capabilities = cmp_capabilities,
            init_options = {
              completionDisableFilterText = true, -- prevent omni completion from inserting extra period
            },
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            on_attach = on_attach_codelens,
            capabilities = cmp_capabilities,
            settings = {
              yaml = { keyOrdering = false },
            },
          })
        end,
        -- ["jdtls"] = function()
        --   lspconfig.jdtls.setup({
        --     on_attach = on_attach_codelens,
        --     capabilities = cmp_capabilities,
        --     init_options = {
        --       jvm_args = { "-javaagent:/usr/local/share/lombok/lombok.jar" }
        --     }
        --   })
        -- end,
        ["clangd"] = function()
          local compile_commands_path = vim.fn.expand("$HOME/.config/nvim/config/clangd/compile_flags.txt")
          lspconfig.clangd.setup({
            on_attach = on_attach_codelens,
            capabilities = cmp_capabilities,
            cmd = {
              "clangd",
              "-compile-commands-dir=" .. compile_commands_path,
            }
          })
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = { "InsertEnter" },
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "single"   -- double, rounded, single, shadow, none, or a table of borders
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()

    end,
  },
}
