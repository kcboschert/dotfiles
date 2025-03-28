return {
  {
    {
      "folke/which-key.nvim",
      opts = {
        spec = {
          { "<leader>a", group = "ai" },
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
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
            ["buffer"] = { opts = { provider = "fzf_lua" } },
            ["file"] = { opts = { provider = "fzf_lua" } },
            ["help"] = { opts = { provider = "fzf_lua" } },
            ["symbols"] = { opts = { provider = "fzf_lua" } },
          },
        },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "llama3.2" },
            },
          })
        end,
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
