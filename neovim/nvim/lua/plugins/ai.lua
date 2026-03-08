return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        auto_fim = false,
        keymap_fim_trigger = "<C-f>",
        keymap_fim_accept_line = "<C-n>",
        keymap_fim_accept_full = "<C-s>",
        keymap_fim_accept_word = nil,
        keymap_inst_trigger = nil,
        keymap_inst_rerun = nil,
        keymap_inst_continue = nil,
        keymap_inst_accept = nil,
        keymap_inst_cancel = nil,
        keymap_debug_toggle = "<leader>ad",
      }
    end,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<leader>aoa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<leader>aox", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>aot", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>aoo", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })
      vim.keymap.set("n", "<leader>aoo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "opencode half page up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "opencode half page down" })
    end,
  },
}
