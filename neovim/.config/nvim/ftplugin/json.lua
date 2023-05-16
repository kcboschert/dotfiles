local map = require("util").map

map("n", "<leader>F", "<cmd>%!jq .<cr>", { desc = "Apply formatting (buffer)" })
