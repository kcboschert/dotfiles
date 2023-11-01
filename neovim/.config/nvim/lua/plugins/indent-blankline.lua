return {
  {
    "lukas-reineke/indent-blankline.nvim",
    keys = {
      { "<leader>il", "<cmd>IBLToggle<cr>", desc = "Toggle Indentlines"}
    },
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup()
    end,
  },
}
