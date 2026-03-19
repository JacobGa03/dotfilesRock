require("gitsigns").setup({
	current_line_blame = true, -- enable inline blame by default

	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- show at end of line
		delay = 150, -- ms before showing blame
		ignore_whitespace = true,
	},

	current_line_blame_formatter = "<author>, <abbrev_sha>, <author_time:%Y-%m-%d>",
})
