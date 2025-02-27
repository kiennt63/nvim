return {
    {
        'MagicDuck/grug-far.nvim',
        config = function ()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' can be specified
            });
            vim.api.nvim_create_user_command('SearchAndReplace', 'GrugFar', {})
        end
    },

    {
        'ibhagwan/fzf-lua',
        -- optional for icon support
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            -- calling `setup` is optional for customization
            require('fzf-lua').setup {
                fzf_opts = {
                    ['--cycle'] = true,
                },
                fzf_colors = true,
                file_icon_padding = ' ',
                winopts = {
                    title_flags = false,
                    border = 'single',
                    on_create = function ()
                        vim.keymap.set(
                            't',
                            '<C-r>',
                            [['<C-\><C-N>"'.nr2char(getchar()).'pi']],
                            { expr = true, buffer = true }
                        )
                    end,
                    width = 0.9,
                },

                files = {
                    formatter = 'path.filename_first',
                    prompt = 'file ',
                    title = false,
                    cwd_prompt = false,
                    header = false,
                    git_icons = false,
                    winopts = {
                        title = false,
                        height = 0.35,
                        width = 0.35,
                        preview = {
                            hidden = 'hidden',
                        },
                    },
                },
                grep = {
                    header = false,
                    prompt = 'grep ',
                    title = false,
                    rg_glob = true,
                    glob_flag = '--iglob',
                    glob_separator = '%s%-%-',
                    winopts = {
                        title = false,
                    },
                },

                keymap = {
                    builtin = {
                        ['<c-d>'] = 'preview-down',
                        ['<c-u>'] = 'preview-up',
                    }
                }
            }
        end,
    },
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
    --     config = function()
    --         vim.api.nvim_create_autocmd('FileType', {
    --             pattern = 'TelescopeResults',
    --             callback = function(ctx)
    --                 vim.api.nvim_buf_call(ctx.buf, function()
    --                     vim.fn.matchadd('TelescopeParent', '\t\t.*$')
    --                     vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
    --                 end)
    --             end,
    --         })
    --
    --         local function filename_first(_, path)
    --             local tail = vim.fs.basename(path)
    --             local parent = vim.fs.dirname(path)
    --             if parent == '.' then
    --                 return tail
    --             end
    --             return string.format('%s\t\t%s', tail, parent)
    --         end
    --
    --         local lga_actions = require 'telescope-live-grep-args.actions'
    --
    --         require('telescope').setup {
    --             pickers = {
    --                 find_files = {
    --                     hidden = true,
    --                 },
    --                 live_grep = {
    --                     hidden = true,
    --                     path_display = filename_first,
    --                 },
    --                 lsp_definitions = { path_display = filename_first },
    --                 lsp_references = { path_display = filename_first },
    --                 lsp_implementations = { path_display = filename_first },
    --                 lsp_document_symbols = { path_display = filename_first },
    --                 lsp_dynamic_workspace_symbols = { path_display = filename_first },
    --             },
    --             defaults = {
    --                 prompt_prefix = ' ',
    --                 selection_caret = ' ',
    --                 mappings = {
    --                     i = { -- Insert mode mappings
    --                         ['<c-u>'] = false,
    --                         ['<c-d>'] = false,
    --                         ['<C-i>'] = function(prompt_bufnr)
    --                             local opts = require('telescope.actions.state').get_current_picker(
    --                                 prompt_bufnr
    --                             ).finder
    --                             if opts.ignore == true then
    --                                 opts.ignore = false
    --                                 print 'Including ignored files'
    --                             else
    --                                 opts.ignore = true
    --                                 print 'Excluding ignored files'
    --                             end
    --                         end,
    --                     },
    --                 },
    --                 -- layout_strategy = 'vertical',
    --                 layout_config = {
    --                     width = 0.9,
    --                 },
    --                 vimgrep_arguments = {
    --                     'rg',
    --                     '--color=never',
    --                     '--no-heading',
    --                     '--with-filename',
    --                     '--line-number',
    --                     '--column',
    --                     '--smart-case',
    --                     '-u', -- thats the new thing
    --                 },
    --             },
    --             extensions = {
    --                 live_grep_args = {
    --                     auto_quoting = true, -- enable/disable auto-quoting
    --                     vimgrep_arguments = {
    --                         'rg',
    --                         '--hidden',
    --                         '--color=never',
    --                         '--no-heading',
    --                         '--with-filename',
    --                         '--line-number',
    --                         '--column',
    --                         '--smart-case',
    --                     },
    --                     path_display = filename_first,
    --                     mappings = { -- extend mappings
    --                         i = {
    --                             ['<C-k>'] = lga_actions.quote_prompt(),
    --                             ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
    --                             ['<C-e>'] = lga_actions.quote_prompt {
    --                                 postfix = ' -g !doc -g !quartz/kernel -g !*.md',
    --                             },
    --                             -- freeze the current list and start a fuzzy search in the frozen list
    --                             -- ['<C-space>'] = actions.to_fuzzy_refine,
    --                         },
    --                     },
    --                     -- auto_quoting = true, -- enable/disable auto-quoting
    --                     -- define mappings, e.g.
    --                     -- theme = "dropdown", -- use dropdown theme
    --                     -- theme = { }, -- use own theme spec
    --                     -- layout_strategy = 'vertical',
    --                     -- layout_config = { mirror=true }, -- mirror preview pane
    --                 },
    --             },
    --         }
    --
    --         -- Enable telescope fzf native, if installed
    --         pcall(require('telescope').load_extension, 'fzf')
    --         pcall(require('telescope').load_extension, 'harpoon')
    --         pcall(require('telescope').load_extension, 'live_grep_args')
    --         pcall(require('telescope').load_extension, 'noice')
    --         pcall(require('telescope').load_extension, 'git-worktree')
    --     end,
    -- }
}
