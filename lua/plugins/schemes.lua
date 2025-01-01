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
            no_bold = false, -- Force no bold
            no_underline = true, -- Force no underline
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
    },

    {
        'kiennt63/gruvbox-material',
    },
}
