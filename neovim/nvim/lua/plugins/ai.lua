return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "ai", mode = { "n", "v" } },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/snacks.nvim",
      "echasnovski/mini.diff",
      -- { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Action" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat Toggle" },
      { "<leader>as", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Send to AI Chat" },
    },
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
          slash_commands = {
            ["buffer"] = { opts = { provider = "snacks" } },
            ["file"] = { opts = { provider = "snacks" } },
            ["help"] = { opts = { provider = "snacks" } },
            ["symbols"] = { opts = { provider = "snacks" } },
          },
        },
        inline = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "qwen2.5-coder:7b" },
              num_ctx = { default = 32768 },
            },
          })
        end,
      },
      display = {
        chat = {
          auto_scroll = true,
          show_header_separator = true,
          show_references = true,
        },
        diff = {
          provider = "mini_diff",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local M = require("lualine.component"):extend()

      do
        M.processing = false
        M.spinner_index = 1

        local spinner_symbols = {
          "⠋",
          "⠙",
          "⠹",
          "⠸",
          "⠼",
          "⠴",
          "⠦",
          "⠧",
          "⠇",
          "⠏",
        }
        local spinner_symbols_len = 10

        -- Initializer
        function M:init(options)
          M.super.init(self, options)

          local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

          vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "CodeCompanionRequest*",
            group = group,
            callback = function(request)
              if request.match == "CodeCompanionRequestStarted" then
                self.processing = true
              elseif request.match == "CodeCompanionRequestFinished" then
                self.processing = false
              end
            end,
          })
        end

        -- Function that runs every time statusline is updated
        function M:update_status()
          if self.processing then
            self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
            return spinner_symbols[self.spinner_index]
          else
            return nil
          end
        end
      end

      require("lualine").setup({
        options = { section_separators = "", component_separators = "" },
        -- options = { section_separators = '', component_separators = '│' },
        sections = {
          lualine_x = { M },
        },
      })
    end,
  },
}
