return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    keys = {
      { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
      { "<leader>nf", "<cmd>NvimTreeFindFile<cr>", desc = "Find in nvim-tree" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        actions = {
          open_file = { 
            window_picker = { enable = false },
          },
        },
        renderer = {
          icons = {
            show = {
              git = true,
              file = true,
              folder = true,
              folder_arrow = true,
            },
            glyphs = {
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "⌥",
                renamed = "➜",
                untracked = "★",
                deleted = "⊖",
                ignored = "◌",
              },
            },
          },
        },
        on_attach = function(bufnr)
          local bufmap = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
          end

          -- See :help nvim-tree.api
          local api = require('nvim-tree.api')

          api.config.mappings.default_on_attach(bufnr)
          bufmap('?', api.tree.toggle_help, 'Help')
        end,
      })
    end,
  },
}
