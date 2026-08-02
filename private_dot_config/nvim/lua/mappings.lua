require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("i", "jj", "<ESC>")

map("i", "<c-d>", "<c-d zz>")
map("i", "<c-u>", "<c-u zz>")
map("n", "<leader>gb", require("gitsigns").toggle_current_line_blame, { desc = "Toggle Git blame (current line)" })
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })

-- vim-tmux-navigator: override NvChad's default <C-h/j/k/l> (vim window switch,
-- which does nothing at a split edge) with tmux-aware pane navigation.
-- This file runs after nvchad.mappings and lazy.nvim's keys handlers, so
-- these mappings win and forwarding to adjacent tmux panes works.
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "navigate left (tmux-aware)" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "navigate down (tmux-aware)" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "navigate up (tmux-aware)" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "navigate right (tmux-aware)" })
map("t", "<C-h>", "<C-\\><C-N><cmd>TmuxNavigateLeft<cr>", { desc = "navigate left (tmux-aware)" })
map("t", "<C-j>", "<C-\\><C-N><cmd>TmuxNavigateDown<cr>", { desc = "navigate down (tmux-aware)" })
map("t", "<C-k>", "<C-\\><C-N><cmd>TmuxNavigateUp<cr>", { desc = "navigate up (tmux-aware)" })
map("t", "<C-l>", "<C-\\><C-N><cmd>TmuxNavigateRight<cr>", { desc = "navigate right (tmux-aware)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
