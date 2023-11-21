return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 998,
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "yamlls", "jdtls", "clangd", "omnisharp" }
      })
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
      { "<leader>cl", vim.lsp.codelens.refresh, desc = "Refresh Code Lens" },
      { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
      { "<space>d", vim.diagnostic.open_float, desc = "Show diagnostic" },
      { "<leader>d", vim.diagnostic.setloclist, desc = "Show diagnostics pane" },
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
            capabilities = cmp_capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
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
            capabilities = cmp_capabilities,
            init_options = {
              completionDisableFilterText = true, -- prevent omni completion from inserting extra period
            },
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            capabilities = cmp_capabilities,
            settings = {
              yaml = { keyOrdering = false },
            },
          })
        end,
        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            capabilities = cmp_capabilities,
            init_options = {
              jvm_args = { "-javaagent:/usr/local/share/lombok/lombok.jar" }
            },
            autostart = false,
          })
        end,
        ["clangd"] = function()
          local compile_commands_path = vim.fn.expand("$HOME/.config/nvim/config/clangd/compile_flags.txt")
          lspconfig.clangd.setup({
            capabilities = cmp_capabilities,
            cmd = { "clangd", "-compile-commands-dir=" .. compile_commands_path },
          })
        end,
        ["omnisharp"] = function()
          local omnisharp_path = vim.fn.expand('$HOME/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll')
          lspconfig.omnisharp.setup({
            capabilities = cmp_capabilities,
            cmd = { "dotnet", omnisharp_path },
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
    "hashivim/vim-terraform",
    ft = { "terraform" },
  }
}
