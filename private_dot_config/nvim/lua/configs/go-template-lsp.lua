return {
	cmd = { "go-template-lsp" }, -- command to start the server
	filetypes = { "gotmpl" }, -- filetypes to attach to
	root_markers = { "go.mod", ".git" }, -- project root detection
	settings = {}, -- LSP server settings
	on_attach = nil, -- callback after LSP attaches
	mason = true, -- use Mason-installed binary if available
}
