local map = require("util").map

map("n", "<leader>F", "<cmd>TerraformFmt<cr>", { desc = "Apply formatting (buffer)" })
vim.api.nvim_create_autocmd({"BufWritePre", "InsertLeave"}, { pattern = { "*.tf" }, command = "TerraformFmt" })
