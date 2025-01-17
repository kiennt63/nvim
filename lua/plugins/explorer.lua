return {
    {
        'stevearc/oil.nvim',
        dependencies = {
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
        },
        config = function()
            require('oil').setup {
                columns = { 'icon' },
                keymaps = {
                    ['g?'] = { 'actions.show_help', mode = 'n' },
                    ['<CR>'] = 'actions.select',
                    ['l'] = 'actions.select',
                    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
                    ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
                    ['<C-t>'] = { 'actions.select', opts = { tab = true } },
                    ['<C-p>'] = 'actions.preview',
                    ['<C-c>'] = { 'actions.close', mode = 'n' },
                    ['q'] = { 'actions.close', mode = 'n' },
                    ['<C-l>'] = 'actions.refresh',
                    ['-'] = { 'actions.parent', mode = 'n' },
                    ['h'] = { 'actions.parent', mode = 'n' },
                    ['_'] = { 'actions.open_cwd', mode = 'n' },
                    ['`'] = { 'actions.cd', mode = 'n' },
                    ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
                    ['gs'] = { 'actions.change_sort', mode = 'n' },
                    ['gx'] = 'actions.open_external',
                    ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
                    ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
                },
                view_options = {
                    show_hidden = true,
                },
                float = {
                    max_width = 100,
                    max_height = 60,
                },
            }
        end,
    },
    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     lazy = false,
    --     pin = true,
    --     dependencies = {
    --         {
    --             'nvim-tree/nvim-web-devicons',
    --             opts = {
    --                 override_by_extension = {
    --                     ['cu'] = {
    --                         icon = '',
    --                         color = '#76b900',
    --                         name = 'Cuda',
    --                     },
    --                     ['log'] = {
    --                         icon = '󱂅',
    --                         name = 'Log',
    --                     },
    --                 },
    --                 override_by_filename = {
    --                     ['.dockerignore'] = {
    --                         icon = '',
    --                         name = 'DOCKERFILE',
    --                     },
    --                     ['dockerfile'] = {
    --                         icon = '',
    --                         name = 'DOCKERFILE',
    --                     },
    --                 },
    --             },
    --         },
    --     },
    --     config = function()
    --         local status_ok, nvim_tree = pcall(require, 'nvim-tree')
    --         if not status_ok then
    --             return
    --         end
    --
    --         local function on_attach(bufnr)
    --             local api = require 'nvim-tree.api'
    --
    --             local function opts(desc)
    --                 return {
    --                     desc = 'nvim-tree: ' .. desc,
    --                     buffer = bufnr,
    --                     noremap = true,
    --                     silent = true,
    --                     nowait = true,
    --                 }
    --             end
    --
    --             -- Default mappings. Feel free to modify or remove as you wish.
    --             --
    --             -- BEGIN_DEFAULT_ON_ATTACH
    --             vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts 'CD')
    --             vim.keymap.set(
    --                 'n',
    --                 '<C-e>',
    --                 api.node.open.replace_tree_buffer,
    --                 opts 'Open: In Place'
    --             )
    --             vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts 'Info')
    --             vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts 'Rename: Omit Filename')
    --             vim.keymap.set('n', '<C-t>', api.node.open.tab, opts 'Open: New Tab')
    --             vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts 'Open: Vertical Split')
    --             vim.keymap.set(
    --                 'n',
    --                 '<C-x>',
    --                 api.node.open.horizontal,
    --                 opts 'Open: Horizontal Split'
    --             )
    --             vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts 'Close Directory')
    --             vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
    --             vim.keymap.set('n', '<Tab>', api.node.open.preview, opts 'Open Preview')
    --             vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts 'Next Sibling')
    --             vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts 'Previous Sibling')
    --             vim.keymap.set('n', '.', api.node.run.cmd, opts 'Run Command')
    --             vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Up')
    --             vim.keymap.set('n', 'a', api.fs.create, opts 'Create')
    --             vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts 'Move Bookmarked')
    --             vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts 'Toggle No Buffer')
    --             vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
    --             vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts 'Toggle Git Clean')
    --             vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'Prev Git')
    --             vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'Next Git')
    --             vim.keymap.set('n', 'd', api.fs.remove, opts 'Delete')
    --             vim.keymap.set('n', 'D', api.fs.trash, opts 'Trash')
    --             vim.keymap.set('n', 'E', api.tree.expand_all, opts 'Expand All')
    --             vim.keymap.set('n', 'e', api.fs.rename_basename, opts 'Rename: Basename')
    --             vim.keymap.set(
    --                 'n',
    --                 ']e',
    --                 api.node.navigate.diagnostics.next,
    --                 opts 'Next Diagnostic'
    --             )
    --             vim.keymap.set(
    --                 'n',
    --                 '[e',
    --                 api.node.navigate.diagnostics.prev,
    --                 opts 'Prev Diagnostic'
    --             )
    --             vim.keymap.set('n', 'F', api.live_filter.clear, opts 'Clean Filter')
    --             vim.keymap.set('n', 'f', api.live_filter.start, opts 'Filter')
    --             vim.keymap.set('n', 'g?', api.tree.toggle_help, opts 'Help')
    --             vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
    --             vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts 'Toggle Dotfiles')
    --             vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts 'Toggle Git Ignore')
    --             vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts 'Last Sibling')
    --             vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts 'First Sibling')
    --             vim.keymap.set('n', 'm', api.marks.toggle, opts 'Toggle Bookmark')
    --             vim.keymap.set('n', 'o', api.node.open.edit, opts 'Open')
    --             vim.keymap.set(
    --                 'n',
    --                 'O',
    --                 api.node.open.no_window_picker,
    --                 opts 'Open: No Window Picker'
    --             )
    --             vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
    --             vim.keymap.set('n', 'P', api.node.navigate.parent, opts 'Parent Directory')
    --             vim.keymap.set('n', 'q', api.tree.close, opts 'Close')
    --             vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
    --             vim.keymap.set('n', 'R', api.tree.reload, opts 'Refresh')
    --             vim.keymap.set('n', 's', api.node.run.system, opts 'Run System')
    --             vim.keymap.set('n', 'S', api.tree.search_node, opts 'Search')
    --             vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts 'Toggle Hidden')
    --             vim.keymap.set('n', 'W', api.tree.collapse_all, opts 'Collapse')
    --             vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
    --             vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
    --             vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts 'Copy Relative Path')
    --             vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts 'Open')
    --             vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts 'CD')
    --             -- END_DEFAULT_ON_ATTACH
    --
    --             -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    --             vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
    --             vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
    --             vim.keymap.set('n', 'o', api.node.open.edit, opts 'Open')
    --             vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
    --             vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
    --         end
    --
    --         nvim_tree.setup {
    --             on_attach = on_attach,
    --             actions = {
    --                 open_file = {
    --                     resize_window = false,
    --                 },
    --             },
    --             update_focused_file = {
    --                 enable = true,
    --                 update_cwd = false,
    --             },
    --             renderer = {
    --                 root_folder_label = false,
    --                 indent_markers = {
    --                     enable = false,
    --                     inline_arrows = false,
    --                 },
    --                 icons = {
    --                     glyphs = {
    --                         default = '',
    --                         symlink = '',
    --                         folder = {
    --                             default = '',
    --                             open = '',
    --                             symlink = '',
    --                             symlink_open = '',
    --                         },
    --                         git = {
    --                             unstaged = '',
    --                             staged = '✓',
    --                             unmerged = '',
    --                             renamed = '➜',
    --                             untracked = '',
    --                             deleted = '',
    --                             ignored = '◌',
    --                         },
    --                     },
    --                     show = {
    --                         folder_arrow = false,
    --                     },
    --                 },
    --             },
    --             diagnostics = {
    --                 enable = true,
    --                 show_on_dirs = true,
    --                 icons = {
    --                     -- hint = "",
    --                     -- info = "",
    --                     -- warning = "",
    --                     -- error = "",
    --                     hint = '',
    --                     info = '',
    --                     warning = '',
    --                     error = '',
    --                 },
    --             },
    --             view = {
    --                 width = 45,
    --                 side = 'left',
    --             },
    --             git = {
    --                 enable = true,
    --                 ignore = false,
    --                 timeout = 500,
    --             },
    --         }
    --
    --         vim.keymap.set('n', '<leader>e', ':NvimTreeOpen<cr>', { noremap = true, silent = true })
    --         -- vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<cr>', { noremap = true, silent = true })
    --
    --         -- vim.api.nvim_create_autocmd('FileType', {
    --         --     pattern = 'NvimTree',
    --         --     callback = function()
    --         --         vim.opt_local.cursorline = false
    --         --         vim.g.mapleader = ' '
    --         --         vim.g.maplocalleader = ' '
    --         --         vim.keymap.set('n', '<leader>e', ':NvimTreeClose<cr>', { noremap = true, silent = true })
    --         --     end,
    --         -- })
    --
    --         local ag = vim.api.nvim_create_augroup
    --         local au = vim.api.nvim_create_autocmd
    --
    --         au('FileType', {
    --             group = ag('NvimTreeCloseOnFocus', {}),
    --             pattern = 'NvimTree',
    --             callback = function()
    --                 vim.keymap.set(
    --                     'n',
    --                     '<leader>e',
    --                     '<cmd>NvimTreeClose<cr>',
    --                     { silent = true, buffer = true }
    --                 )
    --             end,
    --         })
    --     end,
    -- },

    {
        'ThePrimeagen/harpoon',
        branch = 'master',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require 'harpoon'
            local ag = vim.api.nvim_create_augroup
            local au = vim.api.nvim_create_autocmd

            -- REQUIRED
            harpoon:setup()

            au('FileType', {
                group = ag('HarpoonMenu', {}),
                pattern = 'harpoon',
                callback = function()
                    vim.keymap.set('n', '1', function()
                        harpoon:list():select(1)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '2', function()
                        harpoon:list():select(2)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '3', function()
                        harpoon:list():select(3)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '4', function()
                        harpoon:list():select(4)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '5', function()
                        harpoon:list():select(5)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '6', function()
                        harpoon:list():select(6)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '7', function()
                        harpoon:list():select(7)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '8', function()
                        harpoon:list():select(8)
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '9', function()
                        harpoon:list():select(9)
                    end, { silent = true, buffer = true })
                end,
            })
        end,
    },
    {
        'stevearc/aerial.nvim',
        opts = {
            layout = {
                default_direction = 'left',
                resize_to_content = false,
                preserve_equality = true,
                max_width = { 40, 0.2 },
                min_width = { 35, 0.25 },
            },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },
}
