return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		config = function()
			require("configs.treesitter")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("configs.mason-lspconfig")
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lint")
		end,
	},

	{
		"rshkarin/mason-nvim-lint",
		event = "VeryLazy",
		dependencies = { "nvim-lint" },
		config = function()
			require("configs.mason-lint")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},

	{
		"zapling/mason-conform.nvim",
		event = "VeryLazy",
		dependencies = { "conform.nvim" },
		config = function()
			require("configs.mason-conform")
		end,
	},
	{
		"alexremstedt/go-template-lsp.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		ft = "gotmpl",
		opts = {},
		config = function()
			require("configs.go-template-lsp")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"kylechui/nvim-surround",
		version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		-- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
		-- config = function()
		--     require("nvim-surround").setup({
		--         -- Put your configuration here
		--     })
		-- end
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	},

	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("configs.neogit")
		end,
	},

	{
		"nickjvandyke/opencode.nvim",
		enabled = function()
			return vim.fn.executable("opencode") == 1
		end,
		version = "*",
		event = "VeryLazy",
		config = function()
			vim.g.opencode_opts = {
				server = {
					start = function()
						vim.fn.system("tmux split-window -h -d 'opencode --port'")
					end,
				},
			}

			vim.keymap.set({ "n", "x" }, "<leader>oca", function()
				require("opencode").ask("@this: ")
			end, { desc = "Ask OpenCode" })
			vim.keymap.set({ "n", "x" }, "<leader>ocs", function()
				require("opencode").select()
			end, { desc = "Select OpenCode" })
			vim.keymap.set({ "n", "x" }, "<leader>oco", function()
				return require("opencode").operator("@this ")
			end, { desc = "Append range to OpenCode", expr = true })
			vim.keymap.set({ "n" }, "<leader>ocO", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Append line to OpenCode", expr = true })
			vim.keymap.set({ "n" }, "<leader>ocu", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll OpenCode up" })
			vim.keymap.set({ "n" }, "<leader>ocd", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll OpenCode down" })
		end,
	},

	{
		"coder/claudecode.nvim",
		enabled = function()
			return vim.fn.executable("claude") == 1
		end,
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("configs.claudecode")
		end,
		cmd = {
			"ClaudeCodeAdd",
			"ClaudeCodeSend",
			"ClaudeCodeTreeAdd",
			"ClaudeCodeStatus",
			"ClaudeCodeStart",
			"ClaudeCodeStop",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeCloseAllDiffs",
		},
		keys = {
			{ "<leader>cc", nil, desc = "AI/Claude Code" },
			{ "<leader>ccb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>ccs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>ccs",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
			},
			{ "<leader>cca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ccd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
			{ "<leader>ccq", mode = "v", desc = "Ask Claude about selection" },
		},
	},
}
