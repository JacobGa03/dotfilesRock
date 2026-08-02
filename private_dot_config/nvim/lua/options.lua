require("nvchad.options")

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
-- Better indenting
o.smartindent = true
o.autoindent = true

-- Give all relative number lines expect the line you are on
o.relativenumber = true
o.number = true

o.wrap = false

-- Never open Neovim on these kinds of documents
o.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
-- o.cursorlineopt ='both' -- to enable cursorline!

-- set filetype for .CBL COBOL files.
-- vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=cobol ]])

-- tell neovim to treat these files as shell
vim.filetype.add({
	filename = {
		[".bashrc"] = "sh",
		[".bash_profile"] = "sh",
		[".zshrc"] = "zsh",
		[".env"] = "conf",
	},

	pattern = {
		[".*%.env.*"] = "conf",
		[".*%.conf"] = "conf",
	},
})
