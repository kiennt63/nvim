return {
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            indent = {
                enabled = false,
                indent = {

                    enabled = false,
                    hl = 'IblIndent',
                },
                scope = {
                    enabled = true,
                    hl = 'IblIndent',
                },
                animate = {
                    enabled = false,
                },
            },
            input = {
                enabled = true,
            },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            -- zen = {
            --     toggles = {
            --         dim = false,
            --         git_signs = true,
            --         mini_diff_signs = false,
            --         -- diagnostics = false,
            --         -- inlay_hints = false,
            --     },
            --     show = {
            --         statusline = true, -- can only be shown when using the global statusline
            --         tabline = true,
            --     },
            --     ---@type snacks.win.Config
            --     win = { style = 'zen' },
            --     --- Callback when the window is opened.
            --     ---@param win snacks.win
            --     on_open = function(win) end,
            --     --- Callback when the window is closed.
            --     ---@param win snacks.win
            --     on_close = function(win) end,
            --     --- Options for the `Snacks.zen.zoom()`
            --     ---@type snacks.zen.Config
            --     zoom = {
            --         toggles = {},
            --         show = { statusline = true, tabline = true },
            --         win = {
            --             backdrop = false,
            --             width = 0, -- full width
            --         },
            --     },
            -- },
        },
    },
    {
        'shortcuts/no-neck-pain.nvim',
        version = '*',
        opts = {
            integrations = {
                NvimTree = {
                    position = 'left',
                    reopen = true,
                },
            },
        },
    },
    {
        'Aasim-A/scrollEOF.nvim',
        event = { 'CursorMoved', 'WinScrolled' },
        opts = {},
    },
    {
        'catgoose/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'classic',
            delay = function (ctx)
                return ctx.plugin and 0 or 500
            end,
            triggers = {
                { '\"',    mode = 'nv' },
                { '<c-r>', mode = 'i' },
            },
            plugins = {
                marks = false,
                registers = true,
                spelling = false,
                presets = false,
            }
        },
        keys = {
            {
                '<leader>?',
                function ()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    }
}
