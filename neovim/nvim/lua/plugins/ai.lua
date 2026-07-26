return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        auto_fim = false,
        endpoint_fim = "http://127.0.0.1:8080/infill",
        endpoint_inst = "http://127.0.0.1:8080/v1/chat/completions",
        keymap_fim_trigger = "<C-f>",
        keymap_fim_accept_line = "<C-n>",
        keymap_fim_accept_full = "<C-s>",
        keymap_fim_accept_word = "",
        keymap_inst_trigger = "",
        keymap_inst_retry = "",
        keymap_inst_rerun = "",
        keymap_inst_continue = "",
        keymap_inst_accept = "",
        keymap_inst_cancel = "",
        keymap_debug_toggle = "<leader>ad",
      }
    end,
  },
}
