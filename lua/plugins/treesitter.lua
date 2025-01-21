return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    pin = true,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function ()
        require('nvim-treesitter.configs').setup {
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
                'c',
                'cpp',
                'go',
                'lua',
                'python',
                'rust',
                'javascript',
                'vimdoc',
                'vim',
                'glsl',
            },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = false,

            highlight = { enable = true },
            textobjects = { enable = false },
            -- indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<a-s>',
                    node_incremental = '<a-s>',
                    node_decremental = '<a-S>',
                    scope_incremental = '<c-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                    selection_modes = {
                        ['@function.outer'] = 'V'
                    }
                },

                -- move = {
                --     enable = true,
                --     set_jumps = true, -- whether to set jumps in the jumplist
                --     goto_next_start = {
                --         [']m'] = '@function.outer',
                --         [']]'] = '@class.outer',
                --     },
                --     goto_next_end = {
                --         [']M'] = '@function.outer',
                --         [']['] = '@class.outer',
                --     },
                --     goto_previous_start = {
                --         ['[m'] = '@function.outer',
                --         ['[['] = '@class.outer',
                --     },
                --     goto_previous_end = {
                --         ['[M'] = '@function.outer',
                --         ['[]'] = '@class.outer',
                --     },
                -- },
                -- swap = {
                --     enable = true,
                --     swap_next = {
                --         ['<leader>a'] = '@parameter.inner',
                --     },
                --     swap_previous = {
                --         ['<leader>A'] = '@parameter.inner',
                --     },
                -- },
            },
        }

    end,
}
