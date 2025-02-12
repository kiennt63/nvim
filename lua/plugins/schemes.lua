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
    {
        'rebelot/kanagawa.nvim',
        config = function ()
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                terminalColors = true,
                colors = {
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function (colors) -- add/modify highlights
                    return {}
                end,
                theme = 'dragon', -- Load "wave" theme when 'background' option is not set
                background = {    -- map the value of 'background' option to a theme
                    dark = 'dragon',
                    light = 'lotus'
                },
            })
        end
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
            colors = { theme = {}, palette = {} }, -- override default palette and theme colors
            overrides = function ()      -- override highlight groups
                return {}
            end,
        },
    },
}
