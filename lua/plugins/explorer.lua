return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
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
