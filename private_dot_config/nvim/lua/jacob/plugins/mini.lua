-- For autocomplete 
return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.snippets').setup({})
        require('mini.completion').setup({})
    end
}
