-- https://cmp.saghen.dev/configuration/general.html
return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        auto_show = function()
          return vim.bo.filetype ~= "markdown"
        end,
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          treesitter = { "lsp" },
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
  },
}
