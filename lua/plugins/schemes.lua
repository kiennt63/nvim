return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            no_italic = true,
            background = { -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            transparent_background = true, -- disables setting the background color.
            no_bold = false,               -- Force no bold
            no_underline = true,           -- Force no underline
        },
    },

    {
        -- Theme inspired by Atom
        'kiennt63/nightfox.nvim',
        opts = {
            options = {
                transparent = true,
            },
        },
    },

    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function ()
            vim.g.everforest_enable_italic = false
            vim.g.everforest_transparent_background = 1
        end,
    },

    {
        'sainnhe/gruvbox-material',
        config = function ()
            vim.g.gruvbox_material_background = 'medium'
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_better_performance = 1
        end,
        priority = 1000,
    },

    {
        'ellisonleao/gruvbox.nvim',
    },
}
