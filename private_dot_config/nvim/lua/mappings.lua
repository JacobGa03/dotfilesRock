require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("i", "jj", "<ESC>")

map("i", "<c-d>", "<c-d zz>")
map("i", "<c-u>", "<c-u zz>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
