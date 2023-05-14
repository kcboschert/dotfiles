return {
  {
    "kaplanz/nvim-retrail",
    event = "VeryLazy",
    keys = {
      { "<leader>ws", "<cmd>RetrailTrimWhitespace<cr>", desc = "Trim trailing whitespace"},
    },
    config = function()
      require("retrail").setup({
        trim = {
          -- Auto trim on BufWritePre
          auto = true,
          -- Highlight trailing whitespace
          whitespace = true,
          -- Final blank (i.e. whitespace only) lines.
          blanklines = false,
        }
      })
    end,
  },
}
