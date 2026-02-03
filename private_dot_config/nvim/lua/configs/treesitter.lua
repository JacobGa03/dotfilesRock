local options = {
	ensure_installed = {
		"bash",
		-- "c",
		-- "cmake",
		-- "cpp",
		"fish",
		-- "go",
		-- "gomod",
		-- "gosum",
		-- "gotmpl",
		-- "gowork",
		-- "haskell",
		"javascript",
		"typescript",
		"lua",
		"luadoc",
		-- "make",
		"markdown",
		-- "odin",
		"printf",
		"python",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
	},
	sync_install = false,
	auto_intstall = true,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
