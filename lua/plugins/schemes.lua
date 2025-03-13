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
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_enable_bold = 0
        end,
        priority = 1000,
    },

    {
        'thesimonho/kanagawa-paper.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            -- undercurl = true,
            transparent = true,
            gutter = false,
            dimInactive = false, -- disabled when transparent
            terminalColors = true,
            commentStyle = { italic = true },
            functionStyle = { italic = false, bold = true, },
            keywordStyle = { italic = true, bold = false },
            statementStyle = { italic = false, bold = false },
            typeStyle = { italic = false },
            colors = {
                theme = {
                },
                palette = {
                    roninYellow = '#FFA066',
                    samuraiRed = '#FF5D62',
                }
            },
            overrides = function () -- override highlight groups
                return {}
            end,
        },
    },
}
