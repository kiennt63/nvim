return {
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {}
    },

    -- doc generator
    {
        'kkoomen/vim-doge',
        build = function ()
            vim.fn['doge#install']() -- Installs the required binaries for vim-doge
        end,
        config = function ()
            -- Configure Doge for Python docstrings
            vim.g.doge_doc_standard_python = 'doxygen'
        end,
        lazy = false, -- Ensure it's loaded for all file types (set to true if you only want it for specific types)
    },
}
