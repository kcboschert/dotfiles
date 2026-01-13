return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          exclude = { "*.cs.uid" },
        },
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { "*.cs.uid" },
        },
        grep = { hidden = true, ignored = true },
      },
    },
  },
}
