local function lsp_setup(server, opts)
    -- Use legacy setup
    if vim.fn.has("nvim-0.11") == 0 then
        require("lspconfig")[server].setup(opts)
        return
    end

    -- Use new setup
    if not vim.tbl_isempty(opts) then
        vim.lsp.config(server, opts)
    end

    vim.lsp.enable(server)
end

return {
    "neovim/nvim-lspconfig",
    version = "1.8.0", -- This specific verison needed to be compatabile w/ Neovim <=0.9.5
    config = function()
        -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Jank, but set up language servers here
        lsp_setup("lua_ls", {capabilities = capabilities})
        lsp_setup("ts_ls", {capabilities = capabilities})
    end,
}
