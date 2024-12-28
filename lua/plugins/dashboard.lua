return {
    'echasnovski/mini.starter',
    version = '*',
    config = function()
        local starter = require 'mini.starter'
        starter.setup {
            silent = true,
            evaluate_single = true,
            -- items = {
            --     starter.sections.telescope(),
            -- },
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
                    -- harpoon.ui:toggle_quick_menu(harpoon:list())
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
                starter.gen_hook.aligning('center', 'center'),
            },
        }
    end,
}
