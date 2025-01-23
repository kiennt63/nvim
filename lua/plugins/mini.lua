return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function ()
            require('mini.comment').setup()
            require('mini.pairs').setup()
            require('mini.surround').setup {
                mappings = {
                    add = 'co',          -- Add surrounding in Normal and Visual modes
                    delete = 'ds',       -- Delete surrounding
                    find = '',           -- Find surrounding (to the right)
                    find_left = '',      -- Find surrounding (to the left)
                    highlight = '',      -- Highlight surrounding
                    replace = 'cs',      -- Replace surrounding
                    update_n_lines = '', -- Update `n_lines`

                    suffix_last = 'l',   -- Suffix to search with "prev" method
                    suffix_next = 'n',   -- Suffix to search with "next" method
                },
            }
            require('mini.files').setup {
                mappings = {
                    close = 'q',
                    synchronize = 'w'
                }
            }
            local starter = require 'mini.starter'
            starter.setup {
                silent = true,
                evaluate_single = true,
                items = {
                    {
                        name = 'git',
                        action = ':FzfLua git_files',
                        section = '',
                    },
                    {
                        name = 'todo',
                        action = ':TodoFzfLua',
                        section = '',
                    },
                    {
                        name = 'files',
                        action = 'FzfLua files',
                        section = '',
                    },
                    {
                        name = 'pinned',
                        action = 'lua require("harpoon.ui"):toggle_quick_menu(require("harpoon"):list())',
                        section = '',
                    },
                    {
                        name = 'explore',
                        action = ':NvimTreeOpen',
                        section = '',
                    },
                    {
                        name = 'quit',
                        action = ':q',
                        section = ' ',
                    },
                },
                header = '',
                footer = '',
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    -- starter.gen_hook.adding_bullet('', false),
                    starter.gen_hook.aligning('center', 'center'),
                },
            }
        end,
    },
}
