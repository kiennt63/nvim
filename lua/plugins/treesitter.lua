return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function ()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c', 'cpp', 'go', 'lua', 'python',
                'rust', 'zig', 'javascript', 'vimdoc', 'vim', 'glsl',
            },
            auto_install = false,
            highlight = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = '<a-s>',
                    node_incremental  = '<a-s>',
                    node_decremental  = '<a-S>',
                    scope_incremental = '<c-space>',
                },
            },
            textobjects = {
                select = {
                    enable    = true,
                    lookahead = true,
                    keymaps = {
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                    selection_modes = {
                        ['@function.outer'] = 'V',
                    },
                },
            },
        }
    end,
}
