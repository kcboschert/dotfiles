return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        auto_fim = false,
        keymap_accept_line = "<C-n>",
        keymap_accept_full = "<C-s>",
        keymap_accept_word = nil,
      }
    end,
  },
}
