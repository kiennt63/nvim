local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- lazy loading stuff
require('lazy').setup({
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
            'saghen/blink.cmp',
        },
    },

    -- symbols tree
    {
        'stevearc/aerial.nvim',
        opts = {
            layout = {
                resize_to_content = false,
                preserve_equality = true,
            },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },

    -- linter, formater
    {
        'nvimtools/none-ls.nvim',
    },

    -- better clangd
    {
        'p00f/clangd_extensions.nvim',
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = '',
                    declaration = '',
                    expression = '',
                    specifier = '',
                    statement = '',
                    ['template argument'] = '',
                },
                kind_icons = {
                    Compound = '',
                    Recovery = '',
                    TranslationUnit = '',
                    PackExpansion = '',
                    TemplateTypeParm = '',
                    TemplateTemplateParm = '',
                    TemplateParamObject = '',
                },
            },
        },
    },

    -- rust
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },

    -- debugger
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        -- config = function(_, opts)
        --     local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
        --     require('dap-python').setup(path)
        --     -- require('core.utils').load_mappings 'dap_python'
        -- end,
    },

    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
            'TmuxNavigatePrevious',
        },
        keys = {
            { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },

    {
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
    },

    -- auto completion
    {
        'saghen/blink.cmp',
        dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
        version = '*',
        opts_extend = { 'sources.default' },
    },

    -- change surround char
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },

    -- keep some line after eof
    {
        'Aasim-A/scrollEOF.nvim',
        event = { 'CursorMoved', 'WinScrolled' },
        opts = {},
    },

    -- lsp progress bar
    {
        'linrongbin16/lsp-progress.nvim',
        config = function()
            require('lsp-progress').setup {}
        end,
    },

    -- quality of life
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
            indent = { enabled = false },
            input = {
                enabled = true,
                win = {
                    keys = {
                        i_del_word = { '<C-w>', 'delete_word', mode = 'i' },
                    },
                    actions = {
                        delete_word = function()
                            return '<cmd>normal! diw<cr><right>'
                        end,
                    },
                },
            },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            -- zen = {
            --    toggles = {
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
        'nvim-tree/nvim-web-devicons',
        opts = {
            override_by_extension = {
                ['cu'] = {
                    icon = '',
                    color = '#76b900',
                    name = 'Cuda',
                },
                ['log'] = {
                    icon = '󱂅',
                    name = 'Log',
                },
            },
            override_by_filename = {
                ['.dockerignore'] = {
                    icon = '',
                    name = 'DOCKERFILE',
                },
                ['dockerfile'] = {
                    icon = '',
                    name = 'DOCKERFILE',
                },
            },
        },
    },

    {
        'nvim-tree/nvim-tree.lua',
        lazy = false,
        pin = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '┃' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '╏' },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    'n',
                    '<leader>hp',
                    require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' }
                )

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
            end,
        },
    },

    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            no_italic = false,
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

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },

    -- Diagnostics
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            position = 'right',
        },
    },

    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    {
        'ThePrimeagen/harpoon',
        commit = 'e76cb03',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- doc generator
    {
        'kkoomen/vim-doge',
        build = function()
            vim.fn['doge#install']() -- Installs the required binaries for vim-doge
        end,
        config = function()
            -- Configure Doge for Python docstrings
            vim.g.doge_doc_standard_python = 'doxygen'
        end,
        lazy = false, -- Ensure it's loaded for all file types (set to true if you only want it for specific types)
    },

    -- Fuzzy Finder (files, lsp, etc)
    -- {
    --     'nvim-telescope/telescope.nvim',
    --     branch = '0.1.x',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         {
    --             'nvim-telescope/telescope-fzf-native.nvim',
    --             build = 'make',
    --             cond = function()
    --                 return vim.fn.executable 'make' == 1
    --             end,
    --         },
    --         {
    --             'nvim-telescope/telescope-live-grep-args.nvim',
    --             -- This will not install any breaking changes.
    --             -- For major updates, this must be adjusted manually.
    --             version = '^1.0.0',
    --         },
    --     },
    -- },

    {
        'ibhagwan/fzf-lua',
        -- optional for icon support
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            -- calling `setup` is optional for customization
            require('fzf-lua').setup {}
        end,
    },

    {
        'kiennt63/harpoon-files.nvim',
        dependencies = {
            { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
        },
        opts = {
            icon = '',
            max_length = 20,
        },
    },

    {
        'utilyre/barbecue.nvim',
        name = 'barbecue',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons', -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        pin = true,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- {
    --     'nvim-treesitter/nvim-treesitter-context'
    -- }
}, {})

-- custom configurations
-- require 'plugins/config/telescope'
require 'plugins/config/treesitter'
require 'plugins/config/lsp'
require 'plugins/config/dap'
-- require 'plugins/config/cmp'
require 'plugins/config/blink'
require 'plugins/config/lualine'
require 'plugins/config/nvim-tree'
require 'plugins/config/snippet'
require 'plugins/config/scheme'
require 'plugins/config/bbq'
require 'plugins/config/nonels'
require 'plugins/config/harpoon'
-- require('plugins/config/colorizer')
-- require('plugins/config/neotree')
-- require('plugins/config/bufferline')
-- require('plugins/config/leap')
-- require('plugins/config/startify')
-- require('plugins/config/noice')
-- require('plugins/config/fidget')
